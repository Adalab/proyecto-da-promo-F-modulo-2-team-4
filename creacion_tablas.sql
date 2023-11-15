CREATE SCHEMA `whatflix`;
USE `whatflix`;

CREATE TABLE `peliculas` (
  `tipo` VARCHAR(100),
  `titulo` VARCHAR(120),
  `año` INT(4),
  `mes` INT(2),
  `id` VARCHAR(12),
  `genero` VARCHAR(10),
  PRIMARY KEY (`id`, `titulo`)
);

CREATE TABLE `detalles_peliculas` (
  `titulo` VARCHAR(120),
  `calificacion_imdb` VARCHAR(10),
  `director` VARCHAR(100),
  `guionista` VARCHAR(100),
  `argumento` VARCHAR(2000),
  `duracion` VARCHAR(15),
  `id` VARCHAR(12),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_detalles_peliculas`
    FOREIGN KEY (`id`, `titulo`)
    REFERENCES `peliculas`(`id`, `titulo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE `tomatometro` (
  `titulo` VARCHAR(120),
  `tomatometro` VARCHAR(10),
  `id` VARCHAR(12),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tomatometro`
    FOREIGN KEY (`id`, `titulo`)
    REFERENCES `peliculas`(`id`, `titulo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE `detalles_artistas` (
  `artista` VARCHAR(100),
  `año_nacimiento` INT(4),
  `conocido_por` VARCHAR(300),
  `profesion` VARCHAR(100),
  `premios` VARCHAR(100),
  PRIMARY KEY (`artista`)
);

CREATE TABLE `pelicula_artista` (
  `id` VARCHAR(12),
  `artista` VARCHAR(100),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pelicula_artista_id`
    FOREIGN KEY (`id`)
    REFERENCES `peliculas`(`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pelicula_artista_artista`
    FOREIGN KEY (`artista`)
    REFERENCES `detalles_artistas`(`artista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE `oscars` (
  `año_ceremonia` INT(4),
  `mejor_pelicula` VARCHAR(100),
  `mejor_director` VARCHAR(100),
  `mejor_actor` VARCHAR(100),
  `mejor_actriz` VARCHAR(100),
  PRIMARY KEY (`mejor_pelicula`));