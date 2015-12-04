-- version 1.0

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`publisher` ;

CREATE TABLE IF NOT EXISTS `mydb`.`publisher` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `publisher_id_UNIQUE` ON `mydb`.`publisher` (`id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`books` ;

CREATE TABLE IF NOT EXISTS `mydb`.`books` (
  `isbn` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `pub_date` DATE NOT NULL,
  `image` BLOB NULL,
  `edition` VARCHAR(10) NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `publisher_id` INT NOT NULL,
  PRIMARY KEY (`isbn`),
  CONSTRAINT `fk_books_publisher`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `mydb`.`publisher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `ISBN_UNIQUE` ON `mydb`.`books` (`isbn` ASC);

CREATE INDEX `fk_books_publisher_idx` ON `mydb`.`books` (`publisher_id` ASC);

-- -----------------------------------------------------
-- Table `mydb`.`books_has_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`books_has_author` ;

CREATE TABLE IF NOT EXISTS `mydb`.`books_has_author` (
  `books_isbn` VARCHAR(20) NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`books_isbn`, `author_id`),
  CONSTRAINT `fk_books_has_author_books2`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `mydb`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_author_author2`
    FOREIGN KEY (`author_id`)
    REFERENCES `mydb`.`author_backup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_books_has_author_author1_idx` ON `mydb`.`books_has_author` (`author_id` ASC);

CREATE INDEX `fk_books_has_author_books1_idx` ON `mydb`.`books_has_author` (`books_isbn` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(1000) NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `category_name_UNIQUE` ON `mydb`.`category` (`name` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`books_has_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`books_has_author` ;

CREATE TABLE IF NOT EXISTS `mydb`.`books_has_author` (
  `books_isbn` VARCHAR(20) NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`books_isbn`, `author_id`),
  CONSTRAINT `fk_books_has_author_books2`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `mydb`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_author_author2`
    FOREIGN KEY (`author_id`)
    REFERENCES `mydb`.`author_backup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_books_has_author_author1_idx` ON `mydb`.`books_has_author` (`author_id` ASC);

CREATE INDEX `fk_books_has_author_books1_idx` ON `mydb`.`books_has_author` (`books_isbn` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`books_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`books_has_category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`books_has_category` (
  `books_isbn` VARCHAR(20) NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`books_isbn`, `category_name`),
  CONSTRAINT `fk_books_has_category_books1`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `mydb`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_category_category1`
    FOREIGN KEY (`category_name`)
    REFERENCES `mydb`.`category` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_books_has_category_category1_idx` ON `mydb`.`books_has_category` (`category_name` ASC);

CREATE INDEX `fk_books_has_category_books1_idx` ON `mydb`.`books_has_category` (`books_isbn` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`status` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shopping_cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`shopping_cart` ;

CREATE TABLE IF NOT EXISTS `mydb`.`shopping_cart` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NOT NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  CONSTRAINT `fk_shopping_cart_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `mydb`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `transaction_id_UNIQUE` ON `mydb`.`shopping_cart` (`transaction_id` ASC);

CREATE INDEX `fk_shopping_cart_status1_idx` ON `mydb`.`shopping_cart` (`status_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`cart_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`cart_item` ;

CREATE TABLE IF NOT EXISTS `mydb`.`cart_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `discount` DECIMAL(5,2) NULL,
  `books_isbn` VARCHAR(20) NOT NULL,
  `shopping_cart_transaction_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cart_item_books1`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `mydb`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_item_shopping_cart1`
    FOREIGN KEY (`shopping_cart_transaction_id`)
    REFERENCES `mydb`.`shopping_cart` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `mydb`.`cart_item` (`id` ASC);

CREATE INDEX `fk_cart_item_books1_idx` ON `mydb`.`cart_item` (`books_isbn` ASC);

CREATE INDEX `fk_cart_item_shopping_cart1_idx` ON `mydb`.`cart_item` (`shopping_cart_transaction_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `username` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `middle_name` VARCHAR(45) NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `address` VARCHAR(100) NULL,
  `phone` VARCHAR(45) NULL,
  `shopping_cart_transaction_id` INT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `fk_user_shopping_cart1`
    FOREIGN KEY (`shopping_cart_transaction_id`)
    REFERENCES `mydb`.`shopping_cart` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE UNIQUE INDEX `username_UNIQUE` ON `mydb`.`user` (`username` ASC);

CREATE INDEX `fk_user_shopping_cart1_idx` ON `mydb`.`user` (`shopping_cart_transaction_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`payments` ;

CREATE TABLE IF NOT EXISTS `mydb`.`payments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `total_payment` DECIMAL NOT NULL,
  `date_paid` DATETIME NOT NULL,
  `credit_card_number` VARCHAR(100) NOT NULL,
  `cardholder_name` VARCHAR(100) NULL,
  `cardholder_billing_address` VARCHAR(1000) NULL,
  `cardholder_expiration` DATE NULL,
  `shopping_cart_transaction_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_payments_shopping_cart1`
    FOREIGN KEY (`shopping_cart_transaction_id`)
    REFERENCES `mydb`.`shopping_cart` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `mydb`.`payments` (`id` ASC);

CREATE INDEX `fk_payments_shopping_cart1_idx` ON `mydb`.`payments` (`shopping_cart_transaction_id` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`books_has_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`books_has_author` ;

CREATE TABLE IF NOT EXISTS `mydb`.`books_has_author` (
  `books_isbn` VARCHAR(20) NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`books_isbn`, `author_id`),
  CONSTRAINT `fk_books_has_author_books2`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `mydb`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_author_author2`
    FOREIGN KEY (`author_id`)
    REFERENCES `mydb`.`author_backup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_books_has_author_author_idx` ON `mydb`.`books_has_author` (`author_id` ASC);

CREATE INDEX `fk_books_has_author_books_idx` ON `mydb`.`books_has_author` (`books_isbn` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`books_has_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`books_has_author` ;

CREATE TABLE IF NOT EXISTS `mydb`.`books_has_author` (
  `books_isbn` VARCHAR(20) NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`books_isbn`, `author_id`),
  CONSTRAINT `fk_books_has_author_books3`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `mydb`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_author_author3`
    FOREIGN KEY (`author_id`)
    REFERENCES `mydb`.`author_backup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_books_has_author_idx` ON `mydb`.`books_has_author` (`author_id` ASC);

CREATE INDEX `fk_books_has_books_idx` ON `mydb`.`books_has_author` (`books_isbn` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`author` ;

CREATE TABLE IF NOT EXISTS `mydb`.`author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `bio` VARCHAR(1000) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `mydb`.`author` (`id` ASC);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
