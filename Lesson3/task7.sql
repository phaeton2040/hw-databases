-- Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.

SELECT
    COUNT(*) as `Total employees`,
    SUM(e.salary) as `Money spent`,
    d.name as `department`
FROM `employees` e
JOIN `departments` d ON d.id = e.department_id
GROUP BY e.department_id