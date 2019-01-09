# Посчитаем бонус продажнику за проданный софт
# Есть таблица orders, в которой перечислены заказы
# Поле completed отвечает за то, совершена ли сделка
# Данная транзакция ставит поле completed = 1
# И добавляет 5% стоимости сделки к бонусу сотруднику за следующий месяц

SET autocommit = 0;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SET @employee_id := 11;
SET @order_id := 4;
SET @bonus_id := NULL;
SET @bonus_date_after := '2019-01-01';
SET @bonus_date_before := '2019-01-31';

# Предварительно обнуляем переменные перед транзакцией, так как они могут быть заполнены в текущей сессии
SET @bonus := 0;
SET @current_bonus := 0;

START TRANSACTION;

# Получаем бонус от сделки сотрудника
SELECT @bonus := `price` * 0.05 FROM `orders` WHERE `id` = @order_id;

# Закрываем сделку
UPDATE `company`.`orders` SET `completed` = 1 WHERE (`id` = @order_id);

# Получаем текущий бонус сотрудника за будущий месяц
SELECT @current_bonus := `value`, @bonus_id := `id`
FROM `bonuses`
	WHERE (`date` BETWEEN @bonus_date_after AND @bonus_date_before) AND employee_id = @employee_id
LIMIT 1;

# Начисляем новый бонус (старый бонус + процент от сделки)
INSERT INTO `bonuses`
(`id`,      `employee_id`,      `value`, `date`) VALUES
# Это длинное заклинание с датами берет первый день след. месяца. Можно вынести в функцию, но мне лень:(
(@bonus_id, @employee_id,       @bonus,   DATE_ADD(DATE_ADD(LAST_DAY(NOW() + INTERVAL 1 MONTH),INTERVAL 1 DAY),INTERVAL - 1 MONTH))
ON DUPLICATE KEY UPDATE `value` = @current_bonus + @bonus;

COMMIT;