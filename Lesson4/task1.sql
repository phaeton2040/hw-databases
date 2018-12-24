-- Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.

CREATE VIEW 'cities' AS
    SELECT c.title as city, r.title as region, c.important
    FROM `_cities` c
    JOIN `_regions` r on c.region_id = r.id