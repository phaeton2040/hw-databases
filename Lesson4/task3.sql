-- Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.

-- В моем случае у меня есть таблица bonuses, куда я заношу информацию о премии при добавлении нового сотрудника  
DROP TRIGGER IF EXISTS `company`.`employees_AFTER_INSERT`;

DELIMITER $$
USE `company`$$
CREATE TRIGGER `company`.`employees_AFTER_INSERT_ADD_BONUS` AFTER INSERT ON `employees` FOR EACH ROW
BEGIN
	INSERT INTO `bonuses` (`employee_id`, `date`, `value`)
	VALUES (NEW.id, last_day(now()) + INTERVAL 1 DAY, 5000);
END$$
DELIMITER ;
