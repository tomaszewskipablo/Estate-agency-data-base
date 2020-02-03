-- MySQL Script generated by MySQL Workbench
-- Sun Nov 10 13:16:18 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`idPerson`),
  UNIQUE INDEX `idperson_UNIQUE` (`idPerson` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `Salary` INT NOT NULL,
  `profession` VARCHAR(45) NOT NULL,
  `personFKCustomer` INT NOT NULL,
  PRIMARY KEY (`idCustomer`),
  UNIQUE INDEX `idCustomer_UNIQUE` (`idCustomer` ASC) VISIBLE,
  INDEX `fk_Customer_person1_idx` (`personFKCustomer` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_person1`
    FOREIGN KEY (`personFKCustomer`)
    REFERENCES `mydb`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Property_owner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Property_owner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` INT NOT NULL,
  `personFkProperty_owner` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Property_owner_person1_idx` (`personFkProperty_owner` ASC) VISIBLE,
  CONSTRAINT `fk_Property_owner_person1`
    FOREIGN KEY (`personFkProperty_owner`)
    REFERENCES `mydb`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estate_agent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estate_agent` (
  `idEstateAgent` INT NOT NULL AUTO_INCREMENT,
  `office_name` VARCHAR(45) NOT NULL,
  `personFKEstate_agent` INT NOT NULL,
  PRIMARY KEY (`idEstateAgent`),
  UNIQUE INDEX `id_UNIQUE` (`idEstateAgent` ASC) VISIBLE,
  INDEX `fk_Estate_agent_person1_idx` (`personFKEstate_agent` ASC) VISIBLE,
  CONSTRAINT `fk_Estate_agent_person1`
    FOREIGN KEY (`personFKEstate_agent`)
    REFERENCES `mydb`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Surrounding_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Surrounding_area` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number_of_parks` INT NULL,
  `number_of_lakes` INT NULL,
  `calm` TINYINT NULL,
  `high_buildings_nearby` TINYINT NULL,
  `metro` TINYINT NULL,
  `description` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `zip-code_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`City` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `City` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_City_country1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_City_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zip_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Zip_code` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `zip_code` VARCHAR(45) NOT NULL,
  `City_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_zip_code_City1_idx` (`City_id` ASC) VISIBLE,
  CONSTRAINT `fk_zip_code_City1`
    FOREIGN KEY (`City_id`)
    REFERENCES `mydb`.`City` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Street`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Street` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `zip_code_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_street_zip_code1_idx` (`zip_code_id` ASC) VISIBLE,
  CONSTRAINT `fk_street_zip_code1`
    FOREIGN KEY (`zip_code_id`)
    REFERENCES `mydb`.`Zip_code` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`House_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`House_number` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `house_number` INT NOT NULL,
  `street_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_house_number_street1_idx` (`street_id` ASC) VISIBLE,
  CONSTRAINT `fk_house_number_street1`
    FOREIGN KEY (`street_id`)
    REFERENCES `mydb`.`Street` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Property`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Property` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `value` INT NOT NULL,
  `number_of_squere_meters` INT NOT NULL,
  `number_of_rooms` INT NOT NULL,
  `number_of_bathrooms` INT NOT NULL,
  `number_of_bedrooms` INT NOT NULL,
  `is_balcony` TINYINT NOT NULL,
  `number_of_storeies` INT NOT NULL,
  `description` LONGTEXT NULL,
  `build_in` DATE NOT NULL,
  `renovated_in` DATE NULL,
  `expected_price` INT NOT NULL,
  `Surrounding_area_id` INT NOT NULL,
  `Property_owner_id` INT NOT NULL,
  `house_number_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Property_Surrounding_area1_idx` (`Surrounding_area_id` ASC) VISIBLE,
  INDEX `fk_Property_Property_owner1_idx` (`Property_owner_id` ASC) VISIBLE,
  INDEX `fk_Property_house_number1_idx` (`house_number_id` ASC) VISIBLE,
  CONSTRAINT `fk_Property_Surrounding_area1`
    FOREIGN KEY (`Surrounding_area_id`)
    REFERENCES `mydb`.`Surrounding_area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Property_Property_owner1`
    FOREIGN KEY (`Property_owner_id`)
    REFERENCES `mydb`.`Property_owner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Property_house_number1`
    FOREIGN KEY (`house_number_id`)
    REFERENCES `mydb`.`House_number` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Visit` (
  `idVisit` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `duration` TIME NULL,
  `Estate_agentFK` INT NOT NULL,
  `CustomerFK` INT NOT NULL,
  `Property_id` INT NOT NULL,
  INDEX `fk_Visit_Estate_agent1_idx` (`Estate_agentFK` ASC) VISIBLE,
  INDEX `fk_Visit_Customer1_idx` (`CustomerFK` ASC) VISIBLE,
  INDEX `fk_Visit_Property1_idx` (`Property_id` ASC) VISIBLE,
  PRIMARY KEY (`idVisit`),
  CONSTRAINT `fk_Visit_Estate_agent1`
    FOREIGN KEY (`Estate_agentFK`)
    REFERENCES `mydb`.`Estate_agent` (`idEstateAgent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Visit_Customer1`
    FOREIGN KEY (`CustomerFK`)
    REFERENCES `mydb`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Visit_Property1`
    FOREIGN KEY (`Property_id`)
    REFERENCES `mydb`.`Property` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sale` (
  `id` INT NOT NULL auto_increment,
  `date` DATE NOT NULL,
  `Price` INT NOT NULL,
  `Customer_id` INT NOT NULL,
  `Estate_agent_id` INT NOT NULL,
  `Property_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Sale_Customer1_idx` (`Customer_id` ASC) VISIBLE,
  INDEX `fk_Sale_Estate_agent1_idx` (`Estate_agent_id` ASC) VISIBLE,
  INDEX `fk_Sale_Property1_idx` (`Property_id` ASC) VISIBLE,
  CONSTRAINT `fk_Sale_Customer1`
    FOREIGN KEY (`Customer_id`)
    REFERENCES `mydb`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Estate_agent1`
    FOREIGN KEY (`Estate_agent_id`)
    REFERENCES `mydb`.`Estate_agent` (`idEstateAgent`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_Property1`
    FOREIGN KEY (`Property_id`)
    REFERENCES `mydb`.`Property` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

delimiter //
CREATE TRIGGER UcheckPersonBirthDate BEFORE UPDATE ON PERSON
       FOR EACH ROW
       BEGIN
           IF NEW.date_of_birth < '1900-01-01' THEN
               SET NEW.date_of_birth = '1900-01-01';
           ELSEIF NEW.date_of_birth > '2001-10-30' THEN
               SET NEW.date_of_birth = '2001-10-30';
           END IF;
       END;//


delimiter //
CREATE TRIGGER PropertyNumberOFRooms BEFORE INSERT ON Property
       FOR EACH ROW
       BEGIN
           IF NEW.number_of_rooms < 0 THEN
               SET NEW.number_of_rooms = 1;
           END IF;
       END; //
       
       delimiter //
CREATE TRIGGER PropertyNumberOFbathrooms BEFORE INSERT ON Property
       FOR EACH ROW
       BEGIN
           IF NEW.number_of_bathrooms < 0 THEN
               SET NEW.number_of_bathrooms = 1;
           END IF;
       END; //
       
 CREATE TRIGGER PropertyNumberOFbedrooms BEFORE INSERT ON Property
       FOR EACH ROW
       BEGIN
           IF NEW.number_of_bedrooms < 0 THEN
               SET NEW.number_of_bedrooms = 1;
           END IF;
       END; //
      
delimiter //
CREATE TRIGGER deletePersonAfterDeleteCustomer BEFORE DELETE ON PERSON
       FOR EACH ROW
       BEGIN
       DECLARE idPerson INT;
       SET idPerson = old.idPerson;
           DELETE FROM Person WHERE Person.idPerson = personFKCustomer;
       END;//
       
       
delimiter //
CREATE TRIGGER deletePersonAfterDeleteEstateAgent BEFORE DELETE ON PERSON
       FOR EACH ROW
       BEGIN
       DECLARE idPerson INT;
       SET idPerson = old.idPerson;
           DELETE FROM Person WHERE Person.idPerson = personFKEstate_agent;
       END;//
       
 delimiter //
CREATE TRIGGER deletePersonAfterDeletePropertyOwner BEFORE DELETE ON PERSON
       FOR EACH ROW
       BEGIN
       DECLARE idPerson INT;
       SET idPerson = old.idPerson;
           DELETE FROM Person WHERE Person.idPerson = personFKEstate_agent;
       END;//      