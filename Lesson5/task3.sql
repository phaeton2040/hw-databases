EXPLAIN SELECT * FROM `employees` WHERE `name` LIKE 'jo'

# До добавления индекса на поле 'name'
#  id, select_type, table,       partitions, type,  possible_keys, key,  key_len, ref,  rows, filtered, Extra
#  '1', 'SIMPLE',   'employees', NULL,       'ALL', NULL,          NULL, NULL,    NULL, '9',  '11.11',  'Using where'

# После добавления индекса на поле 'name'
# id,  select_type, table,       partitions, type,    possible_keys, key,        key_len, ref,  rows, filtered, Extra
# '1', 'SIMPLE',    'employees', NULL,       'range', 'name_idx',    'name_idx', '402',   NULL, '1',  '100.00', 'Using index condition'

# Ищем сотрудников в отделах по части названия отдела
# Было бы круто, если бы мы на каком-нибудь уроке рассмотрели тему полнотекстового индекса (поиска)
EXPLAIN SELECT e.name, e.lastname, d.name as `Department` FROM `employees` e
JOIN `departments` d ON e.department_id = d.id 
WHERE MATCH(d.name) AGAINST ('Dev*' IN BOOLEAN MODE)

# id,  select_type, table, partitions, type,       possible_keys,          key,            key_len, ref,     rows, filtered, Extra
# '1', 'SIMPLE',    'd',   NULL,       'fulltext', 'PRIMARY,dep_name_idx', 'dep_name_idx', '0',     'const', '1',  '100.00', 'Using where; Ft_hints: no_ranking'


