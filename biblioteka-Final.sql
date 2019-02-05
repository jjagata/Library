-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteka
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteka
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteka` DEFAULT CHARACTER SET utf8 ;
USE `biblioteka` ;

-- -----------------------------------------------------
-- Table `biblioteka`.`autorzy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka`.`autorzy` (
  `id_autorzy` INT(11) NOT NULL,
  `imie` VARCHAR(50) NOT NULL,
  `nazwisko` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_autorzy`),
  UNIQUE INDEX `id_autorzy_UNIQUE` (`id_autorzy` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteka`.`czytelnicy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka`.`czytelnicy` (
  `id_czytelnicy` INT(11) NOT NULL,
  `nazwisko` VARCHAR(150) NOT NULL,
  `imie` VARCHAR(70) NOT NULL,
  `telefon` INT(11) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `data_urodzenia` DATE NOT NULL,
  PRIMARY KEY (`id_czytelnicy`),
  UNIQUE INDEX `id_czytelnicy_UNIQUE` (`id_czytelnicy` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteka`.`kategorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka`.`kategorie` (
  `id_kategorie` INT(11) NOT NULL,
  `nazwa` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_kategorie`),
  UNIQUE INDEX `id_kategorie_UNIQUE` (`id_kategorie` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteka`.`ksiazki`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka`.`ksiazki` (
  `id_ksiazki` INT(11) NOT NULL,
  `tytul` VARCHAR(45) NOT NULL,
  `id_autorzy` INT(11) NOT NULL,
  `ISBN` VARCHAR(80) NOT NULL,
  `dzial` VARCHAR(45) NOT NULL,
  `regal` INT(11) NOT NULL,
  `polka` INT(11) NOT NULL,
  PRIMARY KEY (`id_ksiazki`),
  UNIQUE INDEX `id_ksiazki_UNIQUE` (`id_ksiazki` ASC) VISIBLE,
  INDEX `fk_autorzy_idx` (`id_autorzy` ASC) VISIBLE,
  CONSTRAINT `fk_autorzy`
    FOREIGN KEY (`id_autorzy`)
    REFERENCES `biblioteka`.`autorzy` (`id_autorzy`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteka`.`ksiazki_kategorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka`.`ksiazki_kategorie` (
  `ksiazki_id_ksiazki` INT(11) NOT NULL,
  `kategorie_id_kategorie` INT(11) NOT NULL,
  PRIMARY KEY (`kategorie_id_kategorie`, `ksiazki_id_ksiazki`),
  INDEX `fk_ksiazki_has_kategorie_kategorie1_idx` (`kategorie_id_kategorie` ASC) VISIBLE,
  INDEX `fk_ksiazki_has_kategorie_ksiazki1_idx` (`ksiazki_id_ksiazki` ASC) VISIBLE,
  CONSTRAINT `fk_ksiazki_has_kategorie_kategorie1`
    FOREIGN KEY (`kategorie_id_kategorie`)
    REFERENCES `biblioteka`.`kategorie` (`id_kategorie`),
  CONSTRAINT `fk_ksiazki_has_kategorie_ksiazki1`
    FOREIGN KEY (`ksiazki_id_ksiazki`)
    REFERENCES `biblioteka`.`ksiazki` (`id_ksiazki`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteka`.`pracownicy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka`.`pracownicy` (
  `id_pracownicy` INT(11) NOT NULL,
  `imie` VARCHAR(170) NOT NULL,
  `nazwisko` VARCHAR(145) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `haslo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pracownicy`),
  UNIQUE INDEX `id_pracownicy_UNIQUE` (`id_pracownicy` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteka`.`wypozyczenia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka`.`wypozyczenia` (
  `id_wypozyczenia` INT(11) NOT NULL,
  `id_ksiazki` INT(11) NOT NULL,
  `id_czytelnicy` INT(11) NOT NULL,
  `id_pracownicy_wyp` INT(11) NOT NULL,
  `id_pracownicy_odd` INT(11),
  `data_wyporzyczenia` DATE NOT NULL,
  `data_oddania` DATE,
  PRIMARY KEY (`id_wypozyczenia`, `id_ksiazki`),
  UNIQUE INDEX `id_wypozyczenia_UNIQUE` (`id_wypozyczenia` ASC) VISIBLE,
  UNIQUE INDEX `id_ksiazki_UNIQUE` (`id_ksiazki` ASC) VISIBLE,
  INDEX `fk_wypozyczenia_czytelnicy1_idx` (`id_czytelnicy` ASC) VISIBLE,
  INDEX `fk_id_pracownicy_wyp _idx` (`id_pracownicy_wyp` ASC) VISIBLE,
  INDEX `fk_id_pracownicy_odd_idx` (`id_pracownicy_odd` ASC) VISIBLE,
  INDEX `fk_wypozyczenia_ksiazki1_idx` (`id_ksiazki` ASC) VISIBLE,
  CONSTRAINT `fk_id_pracownicy_odd`
    FOREIGN KEY (`id_pracownicy_odd`)
    REFERENCES `biblioteka`.`pracownicy` (`id_pracownicy`),
  CONSTRAINT `fk_id_pracownicy_wyp `
    FOREIGN KEY (`id_pracownicy_wyp`)
    REFERENCES `biblioteka`.`pracownicy` (`id_pracownicy`),
  CONSTRAINT `fk_wypozyczenia_czytelnicy10`
    FOREIGN KEY (`id_czytelnicy`)
    REFERENCES `biblioteka`.`czytelnicy` (`id_czytelnicy`),
  CONSTRAINT `fk_wypozyczenia_ksiazki1`
    FOREIGN KEY (`id_ksiazki`)
    REFERENCES `biblioteka`.`ksiazki` (`id_ksiazki`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into autorzy values
(1,'Adam','Mickiewicz'),
(2,'Michail','Bulhakow'),
(3,'Franz','Kafka'),
(4,'Fiodor','Dostojewski'),
(5,'Mark','Twain'),
(6,'Ernest','Hemingway');
insert into kategorie values
(1,'historyczne'),
(2,'fantastyka'),
(3,'przygodowe'),
(4,'dramat'),
(5,'kryminal'),
(6,'romans');
insert into pracownicy values
(1,'Anna','Kwiatek','annkw','kwann'),
(2,'Beata','Brzozowska','bea','brzn'),
(3,'Marzena','Piatek','piatek','marzp'),
(4,'Roman','Witkowski','Romwit','witrom'),
(5,'Marcin','Rakowski','rak','rakmar'),
(6,'Jacek','Placek','placek','placekzesmietana');
insert into czytelnicy values
(1,'Kwiatkowski','Roman', 1234567,'kw@gmail.com','1978-02-03'),
(2,'Grzegorczyk','Adam', 1234007,'grz@gmail.com','1972-09-09'),
(3,'Romaniuk','Elrzbieta', 66634567,'rom@gmail.com','1989-02-03'),
(4,'Naklowska','Joanna', 225578567,'jaanna@gmail.com','1989-09-15'),
(5,'Wasilewski','Tomasz', 9934567,'wasiluk@gmail.com','1989-09-03'),
(6,'Dmowski','Roman', 1234567,'dmowski@gmail.com','1899-10-03');
insert into ksiazki values 
(1,'Dziady',1,'PL1234','dramat',1,1),
(2,'Mistrz i Malgorzata',2,'PL12894','fantastyka',1,1),
(3,'Proces',3,'PL123490','dramat',1,2),
(4,'Zbrodnia i kara',4,'PL129834','dramat',1,2),
(5,'Przygody Tomka Sawyera',5,'PL123224','przygodowe',1,1),
(6,'Rajski ogród',6,'PL18903224','przygodowe',1,1);
insert into wypozyczenia values
(1,1,3,2,Null,'2018-07-09',Null);
insert into wypozyczenia values
(2,2,5,1,3,'2018-07-09','2018-08-19'),
(3,3,3,2,Null,'2018-09-09',Null),
(4,4,3,2,Null,'2017-07-09',Null),
(5,6,3,2,Null,'2018-11-09',Null),
(6,5,3,2,4,'2018-03-02','2018-04-01');
insert into ksiazki_kategorie values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6);
insert into ksiazki_kategorie values
(1,2),
(5,3);