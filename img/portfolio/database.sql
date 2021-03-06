-- MySQL Script generated by MySQL Workbench
-- Thu Sep 28 10:47:46 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BitPlatform
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BitPlatform` ;

-- -----------------------------------------------------
-- Schema BitPlatform
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BitPlatform` DEFAULT CHARACTER SET utf8 ;
USE `BitPlatform` ;

-- -----------------------------------------------------
-- Table `BitPlatform`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`Course` (
  `courseID` VARCHAR(6) NOT NULL,
  `courseName` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`courseID`),
  UNIQUE INDEX `courserID_UNIQUE` (`courseID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BitPlatform`.`Assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`Assignment` (
  `assignmentID` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `courseID` VARCHAR(6) NOT NULL,
  `weekDue` INT(6) NOT NULL,
  `dayDue` VARCHAR(10) NOT NULL,
  `duration` INT(6) NOT NULL,
  PRIMARY KEY (`assignmentID`),
  INDEX `courseID_idx` (`courseID` ASC),
  CONSTRAINT `Assignment_courseID`
    FOREIGN KEY (`courseID`)
    REFERENCES `BitPlatform`.`Course` (`courseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BitPlatform`.`PubHol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`PubHol` (
  `pubHolID` INT NOT NULL,
  `holName` VARCHAR(30) NOT NULL,
  `holDate` DATE NOT NULL,
  `PubHolcol` VARCHAR(45) NULL,
  PRIMARY KEY (`pubHolID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BitPlatform`.`Semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`Semester` (
  `semID` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  `breakStart` DATE NOT NULL,
  `breakEnd` DATE NOT NULL,
  `semNum` INT(2) NOT NULL,
  PRIMARY KEY (`semID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BitPlatform`.`CourseSem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`CourseSem` (
  `courseSemID` INT NOT NULL AUTO_INCREMENT,
  `courseID` VARCHAR(6) NOT NULL,
  `semID` INT NOT NULL,
  PRIMARY KEY (`courseSemID`),
  INDEX `courseID_idx` (`courseID` ASC),
  INDEX `semID_idx` (`semID` ASC),
  CONSTRAINT `CourseSem_courseID`
    FOREIGN KEY (`courseID`)
    REFERENCES `BitPlatform`.`Course` (`courseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CourseSem_semID`
    FOREIGN KEY (`semID`)
    REFERENCES `BitPlatform`.`Semester` (`semID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BitPlatform`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`User` (
  `userID` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BitPlatform`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`Role` (
  `roleID` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`roleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BitPlatform`.`UserRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`UserRole` (
  `userRolesID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `roleID` INT NOT NULL,
  PRIMARY KEY (`userRolesID`),
  INDEX `roleID_idx` (`roleID` ASC),
  INDEX `userID_idx` (`userID` ASC),
  CONSTRAINT `UserRole_roleID`
    FOREIGN KEY (`roleID`)
    REFERENCES `BitPlatform`.`Role` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `UserRole_userID`
    FOREIGN KEY (`userID`)
    REFERENCES `BitPlatform`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BitPlatform`.`Class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BitPlatform`.`Class` (
  `classID` INT NOT NULL AUTO_INCREMENT,
  `courseSemID` INT NOT NULL,
  `UserRoleID` INT NOT NULL,
  PRIMARY KEY (`classID`),
  INDEX `courseID_idx` (`courseSemID` ASC),
  INDEX `UserRoleID_idx` (`UserRoleID` ASC),
  CONSTRAINT `Class_courseSemID`
    FOREIGN KEY (`courseSemID`)
    REFERENCES `BitPlatform`.`CourseSem` (`courseSemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `UserRoleID`
    FOREIGN KEY (`UserRoleID`)
    REFERENCES `BitPlatform`.`UserRole` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
