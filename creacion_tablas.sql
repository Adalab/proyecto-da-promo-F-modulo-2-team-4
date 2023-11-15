CREATE SCHEMA `whatflix`;

USE `whatflix`;

CREATE TABLE `peliculas`(
`tipo` VARCHAR(100),
`titulo` VARCHAR(120), 
`año` INT(4), 
`mes` INT (2), 
`id` VARCHAR (12),
`genero` VARCHAR(10),
PRIMARY KEY (`id`));

CREATE TABLE `detalles_peliculas` (
`titulo` VARCHAR(120),
`calificacion_imdb` VARCHAR(10),
`director` VARCHAR(100),
`guionista` VARCHAR(100),
`argumento` VARCHAR(2000),
`duracion` VARCHAR(15),
`id` VARCHAR(12),
PRIMARY KEY (`id`),
CONSTRAINT `fK_detalles_peliculas`
FOREIGN KEY (`id`)
	REFERENCES `peliculas`(`id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE);
