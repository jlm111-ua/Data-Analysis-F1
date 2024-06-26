-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ingp_formula1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ingp_formula1` ;

-- -----------------------------------------------------
-- Schema ingp_formula1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ingp_formula1` DEFAULT CHARACTER SET utf8 ;
USE `ingp_formula1` ;

-- -----------------------------------------------------
-- Table `ingp_formula1`.`Driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Driver` (
  `idDriver` INT NOT NULL,
  `Broadcast_Name` VARCHAR(8) NULL,
  `Name` VARCHAR(45) NULL,
  `Last_Name` VARCHAR(45) NULL,
  `Born_Date` DATE NULL,
  `Nationality` VARCHAR(45) NULL,
  PRIMARY KEY (`idDriver`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Team` (
  `idTeam` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Nationality` VARCHAR(45) NULL,
  PRIMARY KEY (`idTeam`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Grand_Prix`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Grand_Prix` (
  `idGrand_Prix` INT NOT NULL,
  `Name` VARCHAR(60) NULL,
  `Circuit_Name` VARCHAR(60) NULL,
  `Country` VARCHAR(45) NULL,
  `Location` VARCHAR(45) NULL,
  `Total_Distance` INT NULL,
  `Total_laps` INT NULL,
  PRIMARY KEY (`idGrand_Prix`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Schedule` (
  `idSchedule` INT NOT NULL,
  `Day` INT NULL,
  `Month` INT NULL,
  `Year` INT NULL,
  PRIMARY KEY (`idSchedule`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Tyre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Tyre` (
  `idTyre` INT NOT NULL,
  `Compound` VARCHAR(45) NULL,
  PRIMARY KEY (`idTyre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Track_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Track_status` (
  `idTrack_status` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  PRIMARY KEY (`idTrack_status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Lap_deleted`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Lap_deleted` (
  `idLap_deleted` INT NOT NULL,
  `is_deleted` VARCHAR(20) NULL,
  `Reason` VARCHAR(45) NULL,
  PRIMARY KEY (`idLap_deleted`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Pit_stop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Pit_stop` (
  `idPit_stop` INT NOT NULL,
  `Lap_Stop` VARCHAR(20) NULL,
  PRIMARY KEY (`idPit_stop`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Weather`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Weather` (
  `idWeather` INT NOT NULL,
  `Weather_Condition` VARCHAR(45) NULL,
  PRIMARY KEY (`idWeather`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Format`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Format` (
  `idFormat` INT NOT NULL,
  `GP_Format` VARCHAR(45) NULL,
  PRIMARY KEY (`idFormat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`Lap_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`Lap_number` (
  `idLap_number` INT NOT NULL,
  `Number` INT NULL,
  PRIMARY KEY (`idLap_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingp_formula1`.`tabla_hechos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingp_formula1`.`tabla_hechos` (
  `id` INT NOT NULL,
  `idDriver` INT NOT NULL,
  `idTeam` INT NOT NULL,
  `idFormat` INT NOT NULL,
  `idGrand_Prix` INT NOT NULL,
  `idLap_number` INT NOT NULL,
  `idWeather` INT NOT NULL,
  `idPit_stop` INT NOT NULL,
  `idTyre` INT NOT NULL,
  `idLap_deleted` INT NOT NULL,
  `idTrack_status` INT NOT NULL,
  `idSchedule` INT NOT NULL,
  `Lap_time` FLOAT NULL,
  `Sector1` FLOAT NULL,
  `Sector2` FLOAT NULL,
  `Sector3` FLOAT NULL,
  `SpeedTrap_S1` INT NULL,
  `SpeedTrap_S2` INT NULL,
  `SpeedTrap_FL` INT NULL,
  `SpeedTrap_LS` INT NULL,
  `Avg_RPM` FLOAT NULL,
  `Avg_Speed` FLOAT NULL,
  `Avg_Gear` FLOAT NULL,
  `Brake_lap` FLOAT NULL,
  `DRS_on` FLOAT NULL,
  `LapDifference_teammate` FLOAT NULL,
  `Sec1Difference_teammate` FLOAT NULL,
  `Sec2Difference_teammate` FLOAT NULL,
  `Sec3Difference_teammate` FLOAT NULL,
  `Pit_time` FLOAT NULL,
  `Tyrelife` INT NULL,
  `Track_Temp` FLOAT NULL,
  `nLaps` INT NULL,
  PRIMARY KEY (`id`, `idDriver`, `idTeam`, `idFormat`, `idGrand_Prix`, `idLap_number`, `idWeather`, `idPit_stop`, `idTyre`, `idLap_deleted`, `idTrack_status`, `idSchedule`),
  INDEX `fk_tabla_hechos_Diver_idx` (`idDriver` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Grand_Prix1_idx` (`idGrand_Prix` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Fomat1_idx` (`idFormat` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Lap_number1_idx` (`idLap_number` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Weather1_idx` (`idWeather` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Pit_stop1_idx` (`idPit_stop` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Lap_deleted1_idx` (`idLap_deleted` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Track_status1_idx` (`idTrack_status` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Tyre1_idx` (`idTyre` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Schedule1_idx` (`idSchedule` ASC) VISIBLE,
  INDEX `fk_tabla_hechos_Team1_idx` (`idTeam` ASC) VISIBLE,
  CONSTRAINT `fk_tabla_hechos_Diver`
    FOREIGN KEY (`idDriver`)
    REFERENCES `ingp_formula1`.`Driver` (`idDriver`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Grand_Prix1`
    FOREIGN KEY (`idGrand_Prix`)
    REFERENCES `ingp_formula1`.`Grand_Prix` (`idGrand_Prix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Fomat1`
    FOREIGN KEY (`idFormat`)
    REFERENCES `ingp_formula1`.`Format` (`idFormat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Lap_number1`
    FOREIGN KEY (`idLap_number`)
    REFERENCES `ingp_formula1`.`Lap_number` (`idLap_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Weather1`
    FOREIGN KEY (`idWeather`)
    REFERENCES `ingp_formula1`.`Weather` (`idWeather`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Pit_stop1`
    FOREIGN KEY (`idPit_stop`)
    REFERENCES `ingp_formula1`.`Pit_stop` (`idPit_stop`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Lap_deleted1`
    FOREIGN KEY (`idLap_deleted`)
    REFERENCES `ingp_formula1`.`Lap_deleted` (`idLap_deleted`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Track_status1`
    FOREIGN KEY (`idTrack_status`)
    REFERENCES `ingp_formula1`.`Track_status` (`idTrack_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Tyre1`
    FOREIGN KEY (`idTyre`)
    REFERENCES `ingp_formula1`.`Tyre` (`idTyre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Schedule1`
    FOREIGN KEY (`idSchedule`)
    REFERENCES `ingp_formula1`.`Schedule` (`idSchedule`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabla_hechos_Team1`
    FOREIGN KEY (`idTeam`)
    REFERENCES `ingp_formula1`.`Team` (`idTeam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
