-- Выбрать максимальную зарплату у сотрудника.

SELECT 
    concat(e.name, ' ', e.lastname) as `Employee`, e.salary as `Salary`
FROM
    `employees` e
ORDER BY e.salary DESC
LIMIT 1

-- Другой вариант с MAX
SELECT MAX(e.salary) as `Max salary` from `employees` e
