-- Создать функцию (процедуру), которая найдет работника по имени и фамилии.
-- Без индекса, через Like

DELIMITER //
USE `company`//
CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_search`(IN query VARCHAR(100))
BEGIN
	SELECT
			e.id as `ID`,
			concat(e.name, ' ', e.lastname) as `Fullname`,
            d.name as `department`
    FROM `employees` e
    JOIN `departments` d ON d.id = e.department_id  
    where (
		e.lastname like CONCAT('%', query, '%')
			OR
		e.name like CONCAT('%', query, '%')
    );
END//

DELIMITER ;

CALL employee_search('kev');

