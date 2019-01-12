#!/bin/bash

ROOT_PASSWORD="123456"
docker-compose down
rm -rf ./master/data/*
rm -rf ./slave/data/*
docker-compose build
docker-compose up -d

echo "Checking master..."
until docker exec mysql_master sh -c "mysql -u root -p"${ROOT_PASSWORD}" -e ';'" 2> /dev/null
do
    echo "Waiting for mysql_master database connection..."
    sleep 4
done

echo "Master OK!"

priv_stmt='GRANT REPLICATION SLAVE ON *.* TO "root"@"%"; FLUSH PRIVILEGES;'
docker exec mysql_master sh -c "mysql -u root -p${ROOT_PASSWORD} -e '$priv_stmt'"
echo "Replication permissions granted!"

echo "Checking slave..."
until docker exec mysql_slave sh -c "mysql -u root -p${ROOT_PASSWORD} -e ';'" 2> /dev/null
do
    echo "Waiting for mysql_slave database connection..."
    sleep 4
done

echo "Slave OK!"

docker-ip() {
    docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}

MS_STATUS=`docker exec mysql_master sh -c "mysql -u root -p${ROOT_PASSWORD} -e 'SHOW MASTER STATUS'"`
CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`

echo "$CURRENT_LOG"
echo "$CURRENT_POS"

start_slave_stmt="CHANGE MASTER TO MASTER_HOST='$(docker-ip mysql_master)',MASTER_USER='root',MASTER_PASSWORD='123456',MASTER_LOG_FILE='$CURRENT_LOG',MASTER_LOG_POS=$CURRENT_POS; START SLAVE;"
start_slave_cmd="mysql -u root -p${ROOT_PASSWORD} -e \""
start_slave_cmd+="$start_slave_stmt"
start_slave_cmd+='"'

echo "Starting slave..."
docker exec mysql_slave sh -c "$start_slave_cmd"
echo "Slave started!"

docker exec mysql_slave sh -c "mysql -u root -p${ROOT_PASSWORD} -e 'SHOW SLAVE STATUS \G'"
