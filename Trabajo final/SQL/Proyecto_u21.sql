-- Active: 1721290975934@@127.0.0.1@3306@Trabajo_final
USE Trabajo_final

--Buscar solo la suma de los goles de la tabla estadisticas_jugadores
SELECT SUM (goals) FROM estadisticas_jugadores

--Unir las dos tabla a traves de player_id
SELECT *
FROM Trabajo_final.info_jugadores AS i
JOIN Trabajo_final.caracteristicas_jugadores AS c
ON i.player_id = c.player_id

--Ver varios datos de una tabla, nombre, altura (menor a 190/200), y del Real Madrid/Barcelona
SELECT i.Player, c.height_in_cm , i.Club
FROM Trabajo_final.info_jugadores AS i
JOIN Trabajo_final.caracteristicas_jugadores AS c
ON i.player_id = c.player_id
WHERE c. height_in_cm <190 AND i.Club = 'Real Madrid';

SELECT i.Player, c.height_in_cm , i.Club
FROM Trabajo_final.info_jugadores AS i
JOIN Trabajo_final.caracteristicas_jugadores AS c
ON i.player_id = c.player_id
WHERE c. height_in_cm <200 AND i.Club = 'FC Barcelona';

--Escoger la suma de precio por paises
SELECT `Nat.` , SUM (`Market Value`) AS total_cost
FROM info_jugadores
GROUP BY `Nat.`
HAVING SUM (`Market Value`)
ORDER BY total_cost DESC

--Tener los jugadores que sus minutos jugados sean mahyor a 9000 (100 partidos)
SELECT i.Player, e.minutes_played
FROM info_jugadores AS i
JOIN estadisticas_jugadores AS e
ON i.player_id = e.player_id
WHERE e.minutes_played > 9000
ORDER BY e.minutes_played DESC;

--Tener los jugadores cuyos goles sean mayores a 30
SELECT i.Player, e.goals
FROM info_jugadores AS i
JOIN estadisticas_jugadores AS e
ON i.player_id = e.player_id
WHERE e.goals > 30;

-- Cuenta el numero de paises que tenga jugadores cuyo valor supere los 50
SELECT `Nat.`, COUNT(*) AS num_players
FROM info_jugadores
WHERE `Market value` > 50
GROUP BY `Nat.`
ORDER BY num_players DESC;

--Unir las tres tablas
SELECT *
FROM info_jugadores as i
JOIN estadisticas_jugadores as e
ON i.player_id = e.player_id
JOIN caracteristicas_jugadores AS c
ON e.player_id = c.player_id