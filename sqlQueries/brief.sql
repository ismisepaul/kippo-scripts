/*
*	Script that interacts with Kippo DB
*
*/
USE kippo;

/*honeypot details*/
/*SELECT sensors.ip as Honeypot,COUNT(*) as total_interactions FROM sessions JOIN sensors ON sessions.sensor=sensors.id;*/
SELECT COUNT(*) as total_attacks From sessions;

/*top5 cities interacting with the server */
/*SELECT COUNT(*) as Sessions,ip as from_ip FROM sessions GROUP BY ip HAVING COUNT(*) > 1 ORDER BY Sessions DESC;*/
SELECT COUNT(*) as top_cities, geo.city, geo.country FROM sessions JOIN geo ON sessions.ip=geo.ip GROUP BY geo.city ORDER BY top_cities DESC LIMIT 3;

/*top 5 countries*/
SELECT COUNT(*) top_countries, geo.country FROM sessions JOIN geo ON sessions.ip=geo.ip GROUP BY country ORDER BY top_countries DESC LIMIT 3;

/*top5 ips*/
SELECT COUNT(*) as top_ips, sessions.ip, geo.city, geo.country FROM sessions LEFT JOIN geo ON sessions.ip=geo.ip GROUP BY sessions.ip ORDER BY top_ips DESC LIMIT 3;

/*list the interations with the server that happened today */
SELECT TIME(starttime) as today,endtime,sessions.ip,client,geo.country,geo.city FROM sessions LEFT JOIN geo ON sessions.ip=geo.ip WHERE DATE(starttime) = CURDATE() ORDER BY starttime ASC;
