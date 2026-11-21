-- SPDX-License-Identifier: GPL-3.0-only
-- Copyright (C) 2022-2026 ESX Framework
-- Adaptado para la base nueva única de ZENTRIKA RP: zentirka_rp.
-- Se conserva el esquema original del recurso es_extended.

CREATE DATABASE IF NOT EXISTS `zentirka_rp`;
ALTER DATABASE `zentirka_rp`
  DEFAULT CHARACTER SET UTF8MB4;
ALTER DATABASE `zentirka_rp`
  DEFAULT COLLATE UTF8MB4_UNICODE_CI;
USE `zentirka_rp`;

CREATE TABLE `users` (
  `identifier` VARCHAR(60) NOT NULL,
  `ssn` VARCHAR(11) NOT NULL,
  `accounts` LONGTEXT NULL DEFAULT NULL,
  `group` VARCHAR(50) NULL DEFAULT 'user',
  `inventory` LONGTEXT NULL DEFAULT NULL,
  `job` VARCHAR(20) NULL DEFAULT 'unemployed',
  `job_grade` INT NULL DEFAULT 0,
  `loadout` LONGTEXT NULL DEFAULT NULL,
  `metadata` LONGTEXT NULL DEFAULT NULL,
  `position` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `unique_ssn` (`ssn`)
) ENGINE=InnoDB;

CREATE TABLE `items` (
  `name` VARCHAR(50) NOT NULL,
  `label` VARCHAR(50) NOT NULL,
  `weight` INT NOT NULL DEFAULT 1,
  `rare` TINYINT NOT NULL DEFAULT 0,
  `can_remove` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB;

CREATE TABLE `job_grades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `job_name` VARCHAR(50) DEFAULT NULL,
  `grade` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `label` VARCHAR(50) NOT NULL,
  `salary` INT NOT NULL,
  `skin_male` LONGTEXT NOT NULL,
  `skin_female` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

INSERT INTO `job_grades` VALUES (1,'unemployed',0,'unemployed','Desempleado',200,'{}','{}');

CREATE TABLE `jobs` (
  `name` VARCHAR(50) NOT NULL,
  `label` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB;

INSERT INTO `jobs` VALUES ('unemployed','Desempleado');
