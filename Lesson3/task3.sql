-- Выбрать среднюю зарплату по отделам.
SELECT 
    AVG(e.salary) AS `Average salary`, d.name AS department
FROM
    `employees` e
        JOIN
    `departments` d ON d.id = e.department_id
GROUP BY e.department_id
