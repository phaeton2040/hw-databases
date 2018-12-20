USE `world`;

-- Исправляем таблицу стран
ALTER TABLE `world`.`country` 
CHANGE COLUMN `name` `title` VARCHAR(45) NOT NULL ,
ADD INDEX `title_idx` (`title` ASC),
RENAME TO  `world`.`_countries`;

-- Исправляем таблицу областей
ALTER TABLE `world`.`region` 
DROP FOREIGN KEY `fk_Region_Country`;
ALTER TABLE `world`.`region` 
CHANGE COLUMN `name` `title` VARCHAR(255) NOT NULL ,
ADD INDEX `title_idx` (`title` ASC),
RENAME TO  `world`.`_regions`;

-- Исправляем триггеры ON DELETE & ON UPDATE 
ALTER TABLE `world`.`_regions` 
ADD CONSTRAINT `fk_Region_Country`
  FOREIGN KEY (`country_id`)
  REFERENCES `world`.`_countries` (`id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

-- Изменяем таблицу городов
ALTER TABLE `world`.`town` 
DROP FOREIGN KEY `fk_Town_Region1`,
DROP FOREIGN KEY `fk_Town_District1`;
ALTER TABLE `world`.`town` 
DROP COLUMN `district_id`,
ADD COLUMN `country_id` INT(11) NOT NULL AFTER `region_id`,
ADD COLUMN `important` TINYINT(1) NOT NULL AFTER `country_id`,
CHANGE COLUMN `name` `title` VARCHAR(255) NOT NULL ,
ADD INDEX `title_idx` (`title` ASC),
ADD INDEX `fk_City_Country_idx` (`country_id` ASC),
DROP INDEX `fk_Town_District1_idx`,
RENAME TO  `world`.`_cities` ;
ALTER TABLE `world`.`_cities` 
ADD CONSTRAINT `fk_City_Region`
  FOREIGN KEY (`region_id`)
  REFERENCES `world`.`_regions` (`id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_City_Country`
  FOREIGN KEY (`country_id`)
  REFERENCES `world`.`_countries` (`id`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  

--  Удаляем таблицу районов
DROP TABLE `world`.`district`;
