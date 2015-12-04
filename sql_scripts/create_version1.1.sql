-- version 1.1

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ebook_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ebook_db` ;

-- -----------------------------------------------------
-- Schema ebook_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ebook_db` DEFAULT CHARACTER SET utf8 ;
USE `ebook_db` ;

-- -----------------------------------------------------
-- Table `ebook_db`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`author` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`author` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL DEFAULT NULL,
  `bio` VARCHAR(1000) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ebook_db`.`author` (`id` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`publisher` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`publisher` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `publisher_id_UNIQUE` ON `ebook_db`.`publisher` (`id` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`books` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`books` (
  `isbn` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `pub_date` DATE NOT NULL,
  `image` BLOB NULL DEFAULT NULL,
  `edition` VARCHAR(10) NULL DEFAULT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `publisher_id` INT(11) NOT NULL,
  PRIMARY KEY (`isbn`),
  CONSTRAINT `fk_books_publisher`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `ebook_db`.`publisher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `ISBN_UNIQUE` ON `ebook_db`.`books` (`isbn` ASC);

CREATE INDEX `fk_books_publisher_idx` ON `ebook_db`.`books` (`publisher_id` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`books_has_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`books_has_author` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`books_has_author` (
  `books_isbn` VARCHAR(20) NOT NULL,
  `author_id` INT(11) NOT NULL,
  PRIMARY KEY (`books_isbn`, `author_id`),
  CONSTRAINT `fk_books_has_author_author`
    FOREIGN KEY (`author_id`)
    REFERENCES `ebook_db`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_author_books3`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `ebook_db`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_books_has_books_idx` ON `ebook_db`.`books_has_author` (`books_isbn` ASC);

CREATE INDEX `fk_books_has_author_author_idx` ON `ebook_db`.`books_has_author` (`author_id` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`category` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`category` (
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `category_name_UNIQUE` ON `ebook_db`.`category` (`name` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`books_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`books_has_category` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`books_has_category` (
  `books_isbn` VARCHAR(20) NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`books_isbn`, `category_name`),
  CONSTRAINT `fk_books_has_category_books1`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `ebook_db`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_category_category1`
    FOREIGN KEY (`category_name`)
    REFERENCES `ebook_db`.`category` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_books_has_category_category1_idx` ON `ebook_db`.`books_has_category` (`category_name` ASC);

CREATE INDEX `fk_books_has_category_books1_idx` ON `ebook_db`.`books_has_category` (`books_isbn` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`status` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`status` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ebook_db`.`shopping_cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`shopping_cart` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`shopping_cart` (
  `transaction_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NOT NULL,
  `status_id` INT(11) NOT NULL,
  PRIMARY KEY (`transaction_id`),
  CONSTRAINT `fk_shopping_cart_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `ebook_db`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `transaction_id_UNIQUE` ON `ebook_db`.`shopping_cart` (`transaction_id` ASC);

CREATE INDEX `fk_shopping_cart_status1_idx` ON `ebook_db`.`shopping_cart` (`status_id` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`cart_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`cart_item` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`cart_item` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `discount` DECIMAL(5,2) NULL DEFAULT NULL,
  `books_isbn` VARCHAR(20) NOT NULL,
  `shopping_cart_transaction_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cart_item_books1`
    FOREIGN KEY (`books_isbn`)
    REFERENCES `ebook_db`.`books` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_item_shopping_cart1`
    FOREIGN KEY (`shopping_cart_transaction_id`)
    REFERENCES `ebook_db`.`shopping_cart` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ebook_db`.`cart_item` (`id` ASC);

CREATE INDEX `fk_cart_item_books1_idx` ON `ebook_db`.`cart_item` (`books_isbn` ASC);

CREATE INDEX `fk_cart_item_shopping_cart1_idx` ON `ebook_db`.`cart_item` (`shopping_cart_transaction_id` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`payments` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`payments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `total_payment` DECIMAL(10,0) NOT NULL,
  `date_paid` DATETIME NOT NULL,
  `credit_card_number` VARCHAR(100) NOT NULL,
  `cardholder_name` VARCHAR(100) NULL DEFAULT NULL,
  `cardholder_billing_address` VARCHAR(1000) NULL DEFAULT NULL,
  `cardholder_expiration` DATE NULL DEFAULT NULL,
  `shopping_cart_transaction_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_payments_shopping_cart1`
    FOREIGN KEY (`shopping_cart_transaction_id`)
    REFERENCES `ebook_db`.`shopping_cart` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ebook_db`.`payments` (`id` ASC);

CREATE INDEX `fk_payments_shopping_cart1_idx` ON `ebook_db`.`payments` (`shopping_cart_transaction_id` ASC);


-- -----------------------------------------------------
-- Table `ebook_db`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ebook_db`.`user` ;

CREATE TABLE IF NOT EXISTS `ebook_db`.`user` (
  `username` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `middle_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `address` VARCHAR(100) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `shopping_cart_transaction_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `fk_user_shopping_cart1`
    FOREIGN KEY (`shopping_cart_transaction_id`)
    REFERENCES `ebook_db`.`shopping_cart` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `username_UNIQUE` ON `ebook_db`.`user` (`username` ASC);

CREATE INDEX `fk_user_shopping_cart1_idx` ON `ebook_db`.`user` (`shopping_cart_transaction_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
