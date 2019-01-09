FROM mysql:latest
COPY ./conf/master.cnf /etc/mysql/conf.d/master.cnf
# RUN mysql -u root -e "GRANT REPLICATION SLAVE ON *.* TO 'mydb_slave_user'@'%' IDENTIFIED BY 'mydb_slave_pwd'; FLUSH PRIVILEGES;"
