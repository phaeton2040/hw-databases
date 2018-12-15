-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema world
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `world` ;

-- -----------------------------------------------------
-- Schema world
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `world` DEFAULT CHARACTER SET utf8 ;
USE `world` ;

-- -----------------------------------------------------
-- Table `world`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `world`.`Country` ;

CREATE TABLE IF NOT EXISTS `world`.`Country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `world`.`Region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `world`.`Region` ;

CREATE TABLE IF NOT EXISTS `world`.`Region` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Region_Country_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_Region_Country`
    FOREIGN KEY (`country_id`)
    REFERENCES `world`.`Country` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `world`.`District`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `world`.`District` ;

CREATE TABLE IF NOT EXISTS `world`.`District` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `region_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_District_Region1_idx` (`region_id` ASC) VISIBLE,
  CONSTRAINT `fk_District_Region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `world`.`Region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `world`.`Town`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `world`.`Town` ;

CREATE TABLE IF NOT EXISTS `world`.`Town` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `district_id` INT NULL,
  `region_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Town_District1_idx` (`district_id` ASC) VISIBLE,
  INDEX `fk_Town_Region1_idx` (`region_id` ASC) VISIBLE,
  CONSTRAINT `fk_Town_District1`
    FOREIGN KEY (`district_id`)
    REFERENCES `world`.`District` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Town_Region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `world`.`Region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
