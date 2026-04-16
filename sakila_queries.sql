USE sakila; 

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT title AS nombres_peliculas -- Alias más descriptivo
  FROM film;

-- 2.Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT* -- Comprobar si el dato que necesito está en la tabla
  FROM film;

-- Query final:
SELECT title AS "películas_PG-1"  -- Comillas para poder poner el -
  FROM film 
  WHERE rating = "PG-13";

-- 3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT title, `description`
  FROM film 
  WHERE `description` LIKE "%amazing%";
  
-- 4.Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT title, length -- Query de comprobación 
  FROM film 
  WHERE length > 120;

-- Query final: 
SELECT title AS título_películas
  FROM film 
  WHERE length > 120;

-- 5.Recupera los nombres de todos los actores.
SELECT * 
  FROM actor;

-- Query final: 
SELECT first_name AS Nombre, last_name AS Apellido
  FROM actor;

-- 6.Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT first_name AS Nombre, last_name AS Apellido
  FROM actor
  WHERE last_name LIKE "%Gibson%"; -- He usado Like porque el enunciado dice que el apellido TENGA no que SEA. Usando WHERE last_name = "Gibson" obtenemos la misma respuesta.

-- 7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT first_name AS Nombre, actor_id -- comprobación
  FROM actor
  WHERE actor_id >= 10 AND actor_id <= 20;

-- Query final: 
SELECT first_name AS Nombre
  FROM actor
  WHERE actor_id >= 10 AND actor_id <= 20;
-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT title, rating -- comprobar rating
  FROM film 
  WHERE rating NOT IN ("R", "PG-13");

-- Query final:
SELECT title AS Título -- Esta sería la mejor opción porque es la más fácil de leer.
  FROM film 
  WHERE rating NOT IN ("R", "PG-13");
  
-- Otra opción válida:
SELECT title AS Título
 FROM film
 WHERE rating <> "R" AND rating <> "PG-13";  -- Es AND y no OR porque se tienen que cumplir las DOS condiciones. 
  
-- 9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT *
  FROM film;

-- Query 1:
SELECT * 
  FROM category AS c              -- La información que queremos está en esta tabla 
  INNER JOIN film_category AS fc  -- Esta es la intermediaria entre Category y Film 
    ON c.category_id = fc.category_id
  INNER JOIN film AS f
    ON f.film_id = fc.film_id;

-- Query 2:
SELECT c.category_id, c.`name`, f.title -- Limpiamos select con los datos que nos interesan 
  FROM category AS c              
  INNER JOIN film_category AS fc  
    ON c.category_id = fc.category_id
  INNER JOIN film AS f
    ON f.film_id = fc.film_id;

-- Query final: 
SELECT COUNT(c.category_id) AS Recuento, c.`name` AS Clasificación
  FROM category AS c              
  INNER JOIN film_category AS fc  
    ON c.category_id = fc.category_id
  INNER JOIN film AS f
    ON f.film_id = fc.film_id
  GROUP BY c.`name`;

-- 10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT *    -- Ver datos de las dos tablas juntos
  FROM rental AS r 
  INNER JOIN customer AS c
  ON c.customer_id = r.customer_id;

-- Query final: 
SELECT c.customer_id AS ID_cliente, c.first_name AS Nombre, c.last_name AS Apellido,  COUNT(r.rental_id) AS Películas_Alquiladas
  FROM rental AS r 
  INNER JOIN customer AS c
  ON c.customer_id = r.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name;


-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT *               -- Unimos tablas
  FROM rental AS r
  INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
  INNER JOIN film AS f
    ON f.film_id = i.film_id
  INNER JOIN film_category AS fc
    ON fc.film_id = f.film_id
  INNER JOIN category AS c
    ON c.category_id = fc.category_id;


SELECT r.rental_id, f.film_id, fc.category_id, c.`name`    -- Limpieza de select y comprobaciones           
  FROM rental AS r
  INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
  INNER JOIN film AS f
    ON f.film_id = i.film_id
  INNER JOIN film_category AS fc
    ON fc.film_id = f.film_id
    INNER JOIN category AS c
    ON c.category_id = fc.category_id;

-- Query final:

SELECT c.`name` AS Nombre_categoría, COUNT(f.film_id) AS Recuento_alquileres 
  FROM rental AS r
  INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
  INNER JOIN film AS f
    ON f.film_id = i.film_id
  INNER JOIN film_category AS fc
    ON fc.film_id = f.film_id
    INNER JOIN category AS c
    ON c.category_id = fc.category_id
GROUP BY c.`name`;

-- 12.Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT *
FROM film;

-- Query final:

SELECT rating AS Clasificación, AVG(length) AS Promedio_duración 
  FROM film
  GROUP BY rating;
  
-- 13.Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT *
  FROM actor AS a
  INNER JOIN film_actor AS fa
    ON fa.actor_id = a.actor_id
  INNER JOIN film AS f
    ON f.film_id = fa.film_id;
 

SELECT a.first_name AS Nombre, a.last_name AS Apellido, f.title -- Limpio el select y comprobación de title
  FROM actor AS a
  INNER JOIN film_actor AS fa
    ON fa.actor_id = a.actor_id
  INNER JOIN film AS f
    ON f.film_id = fa.film_id
WHERE f.title = "Indian Love";

-- Query final:
SELECT a.first_name AS Nombre, a.last_name AS Apellido
  FROM actor AS a
  INNER JOIN film_actor AS fa
    ON fa.actor_id = a.actor_id
  INNER JOIN film AS f
    ON f.film_id = fa.film_id
WHERE f.title = "Indian Love";
 
-- 14.Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title, `description`
  FROM film 
  WHERE `description` LIKE "%dog%" OR `description` LIKE "%cat%";

-- Query final: 
SELECT title
  FROM film 
  WHERE `description` LIKE "%dog%" OR `description` LIKE "%cat%";

-- 15.Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.

SELECT *                  -- Left Join para que me muestre todos los resultados, no solo las coincidencias. 
  FROM actor AS a
  LEFT JOIN film_actor AS fa
    ON fa.actor_id = a.actor_id
  WHERE fa.film_id IS NULL;   

/* No da resultados, por tanto no hay ningún actor o actriz que cumpla esa condición. 
No obstante, la Query definitiva sería: */

SELECT first_name AS nombre, last_name AS apellido
  FROM actor AS a
  LEFT JOIN film_actor AS fa
	ON fa.actor_id = a.actor_id
  WHERE fa.film_id IS NULL;

-- 16.Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
SELECT *
FROM film;

-- Query final:
SELECT title, release_year
  FROM film 
  WHERE release_year >= 2005 AND release_year <= 2010;

-- Opción 2 (más limpia):
SELECT title, release_year
  FROM film 
  WHERE release_year BETWEEN 2005 AND 2010;

-- 17.Encuentra el título de todas las películas que son de la misma categoría que "Family".
SELECT * 
  FROM film AS f
  INNER JOIN film_category AS fc
    ON fc.film_id = f.film_id
  INNER JOIN category AS c
    ON c.category_id = fc.category_id
  WHERE c.`name` = "Family";
  
-- Comprobación: 
SELECT f.title AS Títulos, c.name
  FROM film AS f
  INNER JOIN film_category AS fc
    ON fc.film_id = f.film_id
  INNER JOIN category AS c
    ON c.category_id = fc.category_id
  WHERE c.`name` = "Family";
  
-- Query final:

SELECT f.title AS Títulos 
  FROM film AS f
  INNER JOIN film_category AS fc
    ON fc.film_id = f.film_id
  INNER JOIN category AS c
    ON c.category_id = fc.category_id
  WHERE c.`name` = "Family";

-- 18.Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT *                  -- Union tablas
  FROM actor AS a
  INNER JOIN film_actor AS fa
    ON fa.actor_id = a.actor_id;


SELECT COUNT(a.actor_id), a.first_name, a.last_name -- Recuento y agrupación
FROM actor AS a
  INNER JOIN film_actor AS fa
    ON fa.actor_id = a.actor_id
GROUP BY a.first_name, a.last_name;

SELECT COUNT(a.actor_id), a.first_name, a.last_name   -- Filtramos con Having porque es una columna que hemos generado 
FROM actor AS a
  INNER JOIN film_actor AS fa
    ON fa.actor_id = a.actor_id
  GROUP BY a.first_name, a.last_name
  HAVING COUNT(a.actor_id) > 10;
  
-- Query final: 
SELECT a.first_name AS Nombre, a.last_name AS Apellido
FROM actor AS a
  INNER JOIN film_actor AS fa
    ON fa.actor_id = a.actor_id
  GROUP BY a.first_name, a.last_name
  HAVING COUNT(a.actor_id) > 10;

-- 19.Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT *
  FROM film;

SELECT title, rating, length -- Compruebo
  FROM film 
  WHERE rating = "R" AND length > 120;

-- Query final: 
SELECT title AS Título
  FROM film 
  WHERE rating = "R" AND length > 120;
  
 -- 20.Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
 
 SELECT c.`name`, f.length             -- Query 1: Union de tablas y seleccionar lo que quiero ver
   FROM category AS c
   INNER JOIN film_category AS fi
     ON fi.category_id = c.category_id
   INNER JOIN film AS f
   ON f.film_id = fi.film_id;
   
SELECT c.`name`, AVG (length)           -- Query 2: Promedio duración y agrupación por categoría
   FROM category AS c
   INNER JOIN film_category AS fi
     ON fi.category_id = c.category_id
   INNER JOIN film AS f
   ON f.film_id = fi.film_id
   GROUP BY c.`name`;
   
-- Query final:

SELECT c.`name` AS nombre_categoria, AVG (length) AS promedio_duración         
   FROM category AS c
   INNER JOIN film_category AS fi
     ON fi.category_id = c.category_id
   INNER JOIN film AS f
     ON f.film_id = fi.film_id
   GROUP BY c.`name`
   HAVING AVG(length) > 120;
   
 
 -- 21.Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
 
SELECT *
  FROM actor AS a
  INNER JOIN film_actor AS fa
  ON fa.actor_id = a.actor_id;

-- Query definitiva: 
SELECT a.first_name AS Nombre, a.last_name AS Apellido, COUNT(a.actor_id) AS Cantidad_pelis_actuado  -- Cuento actor_id porque se repite tantas veces como pelis haya actuado (y es una identificación única, no como nombre o apellido)
  FROM actor AS a
  INNER JOIN film_actor AS fa
  ON fa.actor_id = a.actor_id
  GROUP BY  a.first_name, a.last_name
  HAVING COUNT(a.actor_id) > 5;

-- El ejercicio pide el Nombre y la cantidad de películas. Añadí apellido para poder identificarlos correctamente. No obstante, esta sería la query con solo el nombre + cantidad. 

SELECT a.first_name AS Nombre, COUNT(a.actor_id) AS Cantidad_pelis_actuado  
  FROM actor AS a
  INNER JOIN film_actor AS fa
  ON fa.actor_id = a.actor_id
  GROUP BY  a.first_name, a.last_name
  HAVING COUNT(a.actor_id) > 5;
 
/*22.Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/

SELECT *
FROM rental; 

SELECT DATEDIFF (return_date, rental_date) -- DATEDIFF es una función que devuelve los días completos entre dos fechas 
FROM rental;

SELECT rental_id                           -- Obtenemos rental_id de las pelis que fueron alquiladas más de 5 días
FROM rental
WHERE  DATEDIFF (return_date, rental_date) > 5;

SELECT DISTINCT f.title, DATEDIFF (return_date, rental_date) -- Comprobación 
  FROM film AS f
  INNER JOIN inventory AS i
    ON i.film_id = f.film_id
  INNER JOIN rental AS r
    ON r.inventory_id = i.inventory_id
  WHERE  DATEDIFF (return_date, rental_date) > 5;

-- Query definitiva 1:
SELECT DISTINCT f.title
  FROM film AS f
  INNER JOIN inventory AS i
    ON i.film_id = f.film_id
  INNER JOIN rental AS r
    ON r.inventory_id = i.inventory_id
  WHERE  DATEDIFF (return_date, rental_date) > 5;
  
-- Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
SELECT DISTINCT f.title
  FROM film AS f
  INNER JOIN inventory AS i
  ON i.film_id = f.film_id
  WHERE inventory_id IN (SELECT rental_id                           
  FROM rental
  WHERE  DATEDIFF (return_date, rental_date) > 5);

/*23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.*/

SELECT * 
 FROM actor AS a
 INNER JOIN Film_actor AS fa
   ON fa.actor_id = a.actor_id 
 INNER JOIN film AS f
   ON f.film_id = fa.film_id 
INNER JOIN film_category AS fc
  ON fc.film_id = f.film_id
INNER JOIN category AS c
ON c.category_id = fc.category_id;

-- Query actores que NO han actuado en películas de "Horror"
SELECT a.first_name AS nombre, a.last_name AS apellido, c.`name` AS categoría 
 FROM actor AS a
 INNER JOIN Film_actor AS fa
   ON fa.actor_id = a.actor_id 
 INNER JOIN film AS f
   ON f.film_id = fa.film_id 
 INNER JOIN film_category AS fc
   ON fc.film_id = f.film_id 
 INNER JOIN category AS c
    ON c.category_id = fc.category_id
WHERE c.`name` NOT LIKE "Horror"; 

-- Subconsulta. Actores que han actuado en películas de terror.
-- Query actores que han actuado en película de terror:

SELECT DISTINCT a.actor_id, a.first_name AS nombre, a.last_name AS apellido, c.`name` AS categoría 
 FROM actor AS a
 INNER JOIN Film_actor AS fa
   ON fa.actor_id = a.actor_id 
 INNER JOIN film AS f
   ON f.film_id = fa.film_id 
 INNER JOIN film_category AS fc
   ON fc.film_id = f.film_id 
 INNER JOIN category AS c
    ON c.category_id = fc.category_id 
  WHERE c.`name` = "Horror";

-- Query final: 
SELECT a.first_name AS nombre, a.last_name AS apellido
  FROM actor AS a
  WHERE actor_id NOT IN 
  (SELECT DISTINCT a.actor_id 
 FROM actor AS a
 INNER JOIN Film_actor AS fa
   ON fa.actor_id = a.actor_id 
 INNER JOIN film AS f
   ON f.film_id = fa.film_id 
 INNER JOIN film_category AS fc
   ON fc.film_id = f.film_id 
 INNER JOIN category AS c
    ON c.category_id = fc.category_id 
  WHERE c.`name` = "Horror");


-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.

SELECT f.title 
  FROM film AS f
  WHERE length > 180; 
  
SELECT f.title, f.length, c.`name` -- comprobación 
  FROM film AS f
  INNER JOIN film_category AS fc
  ON fc.film_id = f.film_id
  INNER JOIN category AS c
  ON c.category_id = fc.category_id
  WHERE c.`name` =  "Comedy" AND f.length > 180; 

-- Query definitiva: 

SELECT f.title AS título_películas
  FROM film AS f
  INNER JOIN film_category AS fc
    ON fc.film_id = f.film_id
  INNER JOIN category AS c
    ON c.category_id = fc.category_id
  WHERE c.`name` =  "Comedy" AND f.length > 180;
  
  -- 25.Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos
  
  