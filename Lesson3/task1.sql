-- Сделать запрос, в котором мы выберем все данные о городе – регион, страна.

SELECT c.title as city, r.title as region, c.important
FROM `_cities` c
JOIN `_regions` r on c.region_id = r.id