
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

SET @@global.sql_mode= '';

-- -----------------------------------------------------
-- Schema starcup22
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `starcup22` DEFAULT CHARACTER SET utf8 ;

USE `starcup22` ;

-- -----------------------------------------------------
-- Table `starcup22`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Persona` (
  `IdPersona` INT(11) NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NOT NULL,
  `Sesso` CHAR(1) NOT NULL,
  `LuogoNascita` VARCHAR(45) NULL DEFAULT NULL,
  `DataNascita` DATE NULL DEFAULT NULL,
  `Indirizzo` VARCHAR(45) NULL DEFAULT NULL COMMENT 'non per tutti',
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Foto` VARCHAR(45) NULL DEFAULT NULL,
  `Documento` VARCHAR(45) NULL DEFAULT NULL,
  `Telefono` VARCHAR(45) NULL DEFAULT NULL,
  `CodFiscale` VARCHAR(20) NULL DEFAULT NULL,
  `Città` VARCHAR(45) NULL DEFAULT NULL,
  `Provincia` VARCHAR(45) NULL DEFAULT NULL,
  `CAP` VARCHAR(5) NULL DEFAULT NULL,
  `Patentino` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`IdPersona`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `starcup22`.`Arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Arbitro` (
  `IdArbitro` INT(11) NOT NULL AUTO_INCREMENT,
  `CodPersona` INT(11) NOT NULL,
  PRIMARY KEY (`IdArbitro`),
  INDEX `CodPersona_idx` (`CodPersona` ASC),
  CONSTRAINT `CodPersonaAR`
    FOREIGN KEY (`CodPersona`)
    REFERENCES `starcup22`.`Persona` (`IdPersona`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `starcup22`.`Campo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Campo` (
  `IdCampo` INT(11) NOT NULL AUTO_INCREMENT,
  `Denominazione` VARCHAR(45) NULL DEFAULT NULL,
  `Foto` VARCHAR(45) NULL DEFAULT NULL,
  `GPSLat` DECIMAL(10,0) NULL DEFAULT NULL,
  `GPSLon` DECIMAL(10,0) NULL DEFAULT NULL,
  PRIMARY KEY (`IdCampo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `starcup22`.`Ruolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Ruolo` (
  `IdRuolo` INT(11) NOT NULL AUTO_INCREMENT,
  `Descrizione` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`IdRuolo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `starcup22`.`Gruppo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Gruppo` (
  `IdGruppo` INT(11) NOT NULL AUTO_INCREMENT,
  `Denominazione` VARCHAR(60) NULL DEFAULT NULL,
  `UP` INT(11) NULL DEFAULT NULL,
  `ZP` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`IdGruppo`))
ENGINE = InnoDB
AUTO_INCREMENT = 85
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `starcup22`.`Torneo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Torneo` (
  `IdTorneo` INT(11) NOT NULL AUTO_INCREMENT,
  `NomeTorneo` VARCHAR(45) NOT NULL,
  `Tipologia` CHAR(1) NULL DEFAULT NULL COMMENT 'Contiene il sesso',
  `Fase` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Gir|Eli',
  `Stemma` VARCHAR(45) NULL DEFAULT NULL COMMENT 'URL con immagine',
  `ColoreRGB` VARCHAR(7) NULL DEFAULT NULL,
  PRIMARY KEY (`IdTorneo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `starcup22`.`Utente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Utente` (
  `IdUtente` INT(11) NOT NULL AUTO_INCREMENT,
  `CodPersona` INT(11) NOT NULL,
  `Incarico` VARCHAR(45) NULL DEFAULT NULL,
  `NomeUtente` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NULL DEFAULT NULL,
  `CodGruppo` INT(11) NULL DEFAULT NULL,
  `Amministratore` TINYINT(4) NOT NULL DEFAULT '0',
  `Approvato` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`IdUtente`),
  INDEX `CodPersona_idx` (`CodPersona` ASC),
  INDEX `CodGruppo_idx` (`CodGruppo` ASC),
  CONSTRAINT `CodGruppoU`
    FOREIGN KEY (`CodGruppo`)
    REFERENCES `starcup22`.`Gruppo` (`IdGruppo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodPersonaU`
    FOREIGN KEY (`CodPersona`)
    REFERENCES `starcup22`.`Persona` (`IdPersona`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `starcup22`.`Squadra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Squadra` (
  `IdSquadra` INT(11) NOT NULL AUTO_INCREMENT,
  `NomeSquadra` VARCHAR(50) NOT NULL,
  `Tipologia` CHAR(1) NULL DEFAULT NULL COMMENT 'Femminile o Maschile',
  `CodGruppo` INT(11) NULL DEFAULT NULL,
  `CodUtente` INT(11) NULL DEFAULT NULL,
  `Stemma` VARCHAR(50) NULL DEFAULT NULL,
  `CodiceSquadra` VARCHAR(10) NULL DEFAULT NULL,
  `NomeParroco` VARCHAR(45) NULL DEFAULT NULL,
  `CognomeParroco` VARCHAR(45) NULL DEFAULT NULL,
  `TelefonoParroco` VARCHAR(45) NULL DEFAULT NULL,
  `Note` VARCHAR(100) NULL DEFAULT NULL,
  `ColoreDivise` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`IdSquadra`),
  INDEX `CodGruppo_idx` (`CodGruppo` ASC),
  INDEX `CodUtente_idx` (`CodUtente` ASC),
  CONSTRAINT `CodGruppoSQ`
    FOREIGN KEY (`CodGruppo`)
    REFERENCES `starcup22`.`Gruppo` (`IdGruppo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodUtenteSQ`
    FOREIGN KEY (`CodUtente`)
    REFERENCES `starcup22`.`Utente` (`IdUtente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `starcup22`.`RuoloInSquadra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`RuoloInSquadra` (
  `IdRuoloInSquadra` INT(11) NOT NULL AUTO_INCREMENT,
  `CodPersona` INT(11) NOT NULL,
  `CodSquadra` INT(11) NULL DEFAULT NULL,
  `CodRuolo` INT(11) NOT NULL,
  PRIMARY KEY (`IdRuoloInSquadra`),
  INDEX `CodPersona_idx` (`CodPersona` ASC),
  INDEX `CodSquadra_idx` (`CodSquadra` ASC),
  INDEX `CodRuolo_idx` (`CodRuolo` ASC),
  CONSTRAINT `CodPersonaRU`
    FOREIGN KEY (`CodPersona`)
    REFERENCES `starcup22`.`Persona` (`IdPersona`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodRuoloRU`
    FOREIGN KEY (`CodRuolo`)
    REFERENCES `starcup22`.`Ruolo` (`IdRuolo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodSquadraRU`
    FOREIGN KEY (`CodSquadra`)
    REFERENCES `starcup22`.`Squadra` (`IdSquadra`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `starcup22`.`Partita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Partita` (
  `IdPartita` INT(11) NOT NULL AUTO_INCREMENT,
  `CodCampo` INT(11) NULL DEFAULT NULL,
  `CodArbitro` INT(11) NULL DEFAULT NULL,
  `CodSquadra1` INT(11) NULL DEFAULT NULL,
  `CodSquadra2` INT(11) NULL DEFAULT NULL,
  `Stato` VARCHAR(10) NOT NULL DEFAULT 'cal|cor|fin',
  `Note` VARCHAR(50) NULL DEFAULT NULL,
  `Commento` VARCHAR(50) NULL DEFAULT NULL,
  `CodTorneo` INT(11) NULL DEFAULT NULL,
  `Posizione` CHAR(1) NULL DEFAULT NULL,
  `DataPartita` DATE NULL DEFAULT NULL,
  `OraPartita` TIME NULL DEFAULT NULL,
  `BonusMalus1` INT(11) NULL DEFAULT '0',
  `BonusMalus2` INT(11) NULL DEFAULT '0',
  `Nascosta` TINYINT(4) NULL DEFAULT '0',
  PRIMARY KEY (`IdPartita`),
  INDEX `CodCampo_idx` (`CodCampo` ASC),
  INDEX `CodArbitro_idx` (`CodArbitro` ASC),
  INDEX `CodSquadra1_idx` (`CodSquadra1` ASC),
  INDEX `CodSquadra2_idx` (`CodSquadra2` ASC),
  INDEX `CodTorneo_idx` (`CodTorneo` ASC),
  CONSTRAINT `CodArbitroPA`
    FOREIGN KEY (`CodArbitro`)
    REFERENCES `starcup22`.`Arbitro` (`IdArbitro`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodCampoPA`
    FOREIGN KEY (`CodCampo`)
    REFERENCES `starcup22`.`Campo` (`IdCampo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodSquadra1PA`
    FOREIGN KEY (`CodSquadra1`)
    REFERENCES `starcup22`.`Squadra` (`IdSquadra`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodSquadra2PA`
    FOREIGN KEY (`CodSquadra2`)
    REFERENCES `starcup22`.`Squadra` (`IdSquadra`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodTorneoPA`
    FOREIGN KEY (`CodTorneo`)
    REFERENCES `starcup22`.`Torneo` (`IdTorneo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `starcup22`.`Goal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Goal` (
  `IdGoal` INT(11) NOT NULL AUTO_INCREMENT,
  `CodPartita` INT(11) NULL DEFAULT NULL,
  `CodGiocatore` INT(11) NOT NULL,
  `Minuto` INT(11) NULL DEFAULT NULL,
  `Rigore` TINYINT(4) NULL DEFAULT '0',
  `Autogoal` TINYINT(4) NULL DEFAULT '0',
  `Note` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`IdGoal`),
  INDEX `CodPartita_idx` (`CodPartita` ASC),
  INDEX `CodGiocatore_idx` (`CodGiocatore` ASC),
  CONSTRAINT `CodGiocatoreGO`
    FOREIGN KEY (`CodGiocatore`)
    REFERENCES `starcup22`.`RuoloInSquadra` (`IdRuoloInSquadra`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodPartitaGO`
    FOREIGN KEY (`CodPartita`)
    REFERENCES `starcup22`.`Partita` (`IdPartita`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `starcup22`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Pagamento` (
  `IdPagamento` INT(11) NOT NULL AUTO_INCREMENT,
  `CodSquadra` INT(11) NOT NULL,
  `Importo` DECIMAL(10,2) NOT NULL,
  `DataPagamento` DATE NOT NULL,
  `NomePagante` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`IdPagamento`),
  INDEX `CodSquadra_idx` (`CodSquadra` ASC),
  CONSTRAINT `CodSquadraPAG`
    FOREIGN KEY (`CodSquadra`)
    REFERENCES `starcup22`.`Squadra` (`IdSquadra`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `starcup22`.`Posizione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Posizione` (
  `IdPosizione` INT(11) NOT NULL AUTO_INCREMENT,
  `CodTorneo` INT(11) NOT NULL,
  `CodSquadra` INT(11) NOT NULL,
  `GironePosizione` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`IdPosizione`),
  INDEX `CodTorneo_idx` (`CodTorneo` ASC),
  INDEX `CodSquadra_idx` (`CodSquadra` ASC),
  CONSTRAINT `CodSquadraPO`
    FOREIGN KEY (`CodSquadra`)
    REFERENCES `starcup22`.`Squadra` (`IdSquadra`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `CodTorneoPO`
    FOREIGN KEY (`CodTorneo`)
    REFERENCES `starcup22`.`Torneo` (`IdTorneo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `starcup22`.`Log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `starcup22`.`Log` (
  `IdLog` INT(11) NOT NULL AUTO_INCREMENT,
  `IndirizzoIP` VARCHAR(30) NULL DEFAULT NULL,
  `Livello` VARCHAR(10) NULL DEFAULT NULL,
  `CodUtente` INT(11) NULL DEFAULT NULL,
  `Browser` VARCHAR(100) NULL DEFAULT NULL,
  `Data` DATETIME NULL DEFAULT NULL,
  `Azione` VARCHAR(20) NULL DEFAULT NULL,
  `Oggetto` VARCHAR(45) NULL DEFAULT NULL,
  `Dump` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`IdLog`),
  INDEX `CodUtenteLO_idx` (`CodUtente` ASC),
  CONSTRAINT `CodUtenteLO`
    FOREIGN KEY (`CodUtente`)
    REFERENCES `starcup22`.`Utente` (`IdUtente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 45
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

