-- CONSULTAS A LA BBDD WHATFLIX
-- Calificaciones en IMBD
SELECT COUNT(calificacion_imdb) AS total_peliculas_con_valoracion
FROM detalles_peliculas
WHERE calificacion_imdb = 'Desconocido';

-- Calificaciones en Rotten Tomatoes
SELECT COUNT(tomatometro) AS total_peliculas_con_valoracion
FROM tomatometro
WHERE tomatometro = 'Desconocido';

-- Calificación media por género
SELECT genero, AVG(calificacion_imdb) AS calificacion_media
FROM peliculas p
JOIN detalles_peliculas dp ON p.id = dp.id
WHERE calificacion_imdb != 'desconocido'
GROUP BY genero
ORDER BY calificacion_media ASC;


-- CONSULTAS RECOMENDACIONES AL CLIENTE SOBRE CATÁLOGO ACTUAL:
-- Tarde de cinezzz: películas con mejor nota:
SELECT `id`, `titulo`, `calificacion_imdb`
	FROM `detalles_peliculas`
    WHERE `calificacion_imdb` != 'desconocido' 
	ORDER BY `calificacion_imdb` DESC
    LIMIT 225;

-- Maratón con amigos: películas con peor nota
SELECT `id`, `titulo`, `calificacion_imdb`
	FROM `detalles_peliculas`
    WHERE `calificacion_imdb` != 'desconocido' 
	ORDER BY `calificacion_imdb` ASC
    LIMIT 100;

-- Halloween de terror: Películas de terror con peor nota
SELECT `d`.`id`, `d`.`titulo`, `d`.`calificacion_imdb`, `p`.`genero`
	FROM `detalles_peliculas` AS `d`
    INNER JOIN `peliculas` AS `p`
    ON `d`.`id` = `p`.`id`
	WHERE `p`.`genero` = 'Horror' 
	ORDER BY `calificacion_imdb` ASC
	LIMIT 50;
    
-- Todos tenemos comienzos: Actores y actrices ganadores de un oscar
SELECT artista
	FROM detalles_artistas
    WHERE premios LIKE '%oscar%';
    

-- RECOMENDACIONES AUMENTO DE CATÁLOGO:
-- Directores que más aparecen:
WITH DirectoresMultiplePeliculas AS (
    SELECT director, COUNT(*) AS cantidad_peliculas
    FROM detalles_peliculas
    WHERE director != 'desconocido'
    GROUP BY director
    HAVING COUNT(*) > 1
)

SELECT director, cantidad_peliculas
FROM DirectoresMultiplePeliculas
ORDER BY cantidad_peliculas DESC
LIMIT 50;

-- Guionistas que más aparecen:
SELECT `guionista`, COUNT(`id`) AS `numero_peliculas`
	FROM `detalles_peliculas`
	GROUP BY `guionista`
	ORDER BY COUNT(`id`) DESC;

-- Actores y actrices que más aparecen:
SELECT `artista`, COUNT(`id`) AS `numero_peliculas`
	FROM `pelicula_artista`
	GROUP BY `artista`
	ORDER BY COUNT(`id`) DESC;
    
-- Géneros con mejor nota (para añadir a Tarde de siesta):
SELECT p.genero, COUNT(p.id) AS total_mejor_nota
FROM peliculas p
INNER JOIN (
    SELECT d.id
    FROM detalles_peliculas d
    WHERE d.calificacion_imdb != 'desconocido'
    ORDER BY d.calificacion_imdb DESC
    LIMIT 300
) AS sub
ON p.id = sub.id
GROUP BY p.genero
ORDER BY total_mejor_nota DESC;

-- Géneros con peor nota (para añadir a Maratón con amigos):
SELECT p.genero, COUNT(p.id) AS total_peor_nota
FROM peliculas p
INNER JOIN (
    SELECT d.id
    FROM detalles_peliculas d
    WHERE d.calificacion_imdb != 'desconocido'
    ORDER BY d.calificacion_imdb ASC
    LIMIT 300
) AS sub
ON p.id = sub.id
GROUP BY p.genero
ORDER BY total_peor_nota ASC;


-- OTRAS CONSULTAS:
-- ¿En que año se estrenaron más películas?
SELECT `año`, COUNT(`titulo`) AS cantidad_peliculas
FROM `peliculas`
WHERE `año` NOT IN ('9999')
GROUP BY `año`
ORDER BY cantidad_peliculas
LIMIT 1; 

-- ¿Qué actores protagonizaron la peor pelicula?

SELECT `artista`, `dp`.`titulo` AS nombre_pelicula
FROM `pelicula_artista` AS pa
INNER JOIN `detalles_peliculas` dp 
ON pa.id = dp.id
WHERE `dp.calificacion_imdb` = (
    SELECT MIN(`calificacion_imdb`) 
    FROM `detalles_peliculas` 
    WHERE `calificacion_imdb` IS NOT NULL
);


