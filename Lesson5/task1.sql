# Посчитаем зарплату сотруднику

SET autocommit = 0;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SET @current_employee_id := 1;
SET @date_after := '2019-01-01';
SET @date_before := '2019-01-31';

# Предварительно обнуляем переменные перед транзакцией, так как они могут быть заполнены в текущей сессии
SET @bonus := 0;
SET @salary := 0;

START TRANSACTION;

# Получаем зарплату сотрудника
SELECT @salary := `salary`
FROM `employees`
	WHERE id = @current_employee_id;

# Проверяем, есть ли у сотрудника бонусы
SELECT @bonus := `value`
FROM `bonuses`
	WHERE (`date` BETWEEN @date_after AND @date_before) AND employee_id = @current_employee_id
LIMIT 1;

# Начисляем зарплату (оклад + бонус)
INSERT INTO `salary`
(`amount`,          `employee_id`,      `date`) VALUES
(@salary + @bonus, @current_employee_id, NOW());

COMMIT;