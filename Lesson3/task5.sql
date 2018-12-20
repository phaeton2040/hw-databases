-- Удалить одного сотрудника, у которого максимальная зарплата.
DELETE FROM `employees`
ORDER BY salary DESC
LIMIT 1
