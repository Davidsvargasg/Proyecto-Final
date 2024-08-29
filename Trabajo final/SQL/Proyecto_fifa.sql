-- Active: 1721290975934@@127.0.0.1@3306@Trabajo_fifa

-- Usar la base de datos de Trabajo_fifa
USE Trabajo_fifa

--Buscar solo los 'foot' de la tabla caracteristicas_jugadores
SELECT foot FROM caracteristicas_jugadores

--Unir las dos tabla a traves de player_id
SELECT *
FROM Trabajo_fifa.info_jugadores AS i
JOIN Trabajo_fifa.caracteristicas_jugadores AS c
ON i.player_id = c.player_id

--Ver varios datos de una tabla, nombre, altura (mayor a 180), y de pie derecho e izquierdo
SELECT i.name, c.altura , c.foot
FROM Trabajo_fifa.info_jugadores AS i
JOIN Trabajo_fifa.caracteristicas_jugadores AS c
ON i.player_id = c.player_id
WHERE c.altura > 180 AND c.foot = 'right';

SELECT i.name, c.altura , c.foot
FROM Trabajo_fifa.info_jugadores AS i
JOIN Trabajo_fifa.caracteristicas_jugadores AS c
ON i.player_id = c.player_id
WHERE c.altura > 180 AND c.foot = 'left';

--Escoger la suma de precio por paises
SELECT nation , SUM (cost) AS total_cost
FROM info_jugadores
GROUP BY nation
HAVING SUM (cost)
ORDER BY total_cost DESC

--Tener los jugadores que su potencial sea mayor a 85
SELECT i.name, e.potential
FROM info_jugadores AS i
JOIN estadisticas_jugadores AS e
ON i.player_id = e.player_id
WHERE e.potential > 85;

--Tener los jugadores cuyo tiro sea mayor a 80
SELECT i.name, e.shooting
FROM info_jugadores AS i
JOIN estadisticas_jugadores AS e
ON i.player_id = e.player_id
WHERE e.shooting > 80;

-- Cuenta el numero de paises que tenga jugadores cuyo valor supere los 50
SELECT nation, COUNT(*) AS num_players
FROM info_jugadores
WHERE cost > 50
GROUP BY nation
ORDER BY num_players DESC;

--Unir las tres tablas
SELECT *
FROM info_jugadores as i
JOIN estadisticas_jugadores as e
ON i.player_id = e.player_id
JOIN caracteristicas_jugadores AS c
ON e.player_id = c.player_id