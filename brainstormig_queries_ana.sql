-- ¿Cuál es la peli de IMDB con mejor nota?

SELECT `titulo`, `calificacion_imdb`
FROM `detalles_peliculas`
WHERE `calificacion_imdb` != 'desconocido'  
AND `calificacion_imdb` = (
    SELECT MAX(`calificacion_imdb`) FROM `detalles_peliculas`
    WHERE `calificacion_imdb` != 'desconocido');

-- ¿Cuál es la peli de IMDB con peor nota? 

SELECT `titulo`, `calificacion_imdb`
FROM `detalles_peliculas`
WHERE `calificacion_imdb` != 'desconocido'  
AND `calificacion_imdb` = (
    SELECT MIN(`calificacion_imdb`) FROM `detalles_peliculas`
    WHERE `calificacion_imdb` != 'desconocido');

-- ¿En que año se estrenaron más películas?
SELECT `año`, COUNT(`titulo`) AS cantidad_peliculas
FROM `peliculas`
WHERE `año` NOT IN ('9999')
GROUP BY `año`
ORDER BY cantidad_peliculas
LIMIT 1; 

--  ¿que pelicula tiene el porcentaje mas pequeño en el tomatometro?

SELECT `titulo`, `tomatometro`
FROM `tomatometro`
WHERE `tomatometro` = (
    SELECT MIN(`tomatometro`) 
    FROM `tomatometro`
);

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

-- ¿Cuál es el genero que tiene una calificación más baja en IMDB?

SELECT genero, AVG(calificacion_imdb) AS calificacion_media
FROM peliculas p
JOIN detalles_peliculas dp ON p.id = dp.id
WHERE calificacion_imdb != 'desconocido'
GROUP BY genero
ORDER BY calificacion_media ASC
LIMIT 1;

-- ¿Cuál es la duración promedio de las películas por género?

SELECT genero, AVG(duracion) AS duracion_promedio
FROM peliculas p
JOIN detalles_peliculas dp ON p.id = dp.id
GROUP BY genero
ORDER BY duracion_promedio DESC;

-- ¿Algún directo ha dirigido más de una pelicula? 

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
LIMIT 1;


