-- Посчитать количество сотрудников во всех отделах.

SELECT COUNT(*) as `Total employees`, d.name as `department` from `employees` e
JOIN `departments` d ON d.id = e.department_id
GROUP BY e.department_id