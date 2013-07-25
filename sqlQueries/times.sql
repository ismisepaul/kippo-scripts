/*
*	Script that interacts with Kippo DB
*
*/
USE kippo;

SELECT COUNT(*) AS count, geo.country as top_country FROM geo JOIN sessions ON geo.ip=sessions.ip WHERE HOUR(TIME(starttime)) BETWEEN '00' AND '05:59:59' GROUP BY geo.country ORDER BY count DESC LIMIT 1;
/*sort by time 12am-6am*/
SELECT DATE(starttime) as date, TIME(starttime) as 12am_6am, geo.country, geo.city, sessions.ip FROM sessions LEFT JOIN geo ON sessions.ip=geo.ip WHERE HOUR(TIME(starttime)) BETWEEN '00' AND '05:59:59' ORDER BY 12am_6am, sessions.ip LIMIT 10;


SELECT COUNT(*) AS count, geo.country as top_country FROM geo JOIN sessions ON geo.ip=sessions.ip WHERE HOUR(TIME(starttime)) BETWEEN '06' AND '11:59:59' GROUP BY geo.country ORDER BY count DESC LIMIT 1;
/*sort by time 6am-12pm*/
SELECT TIME(starttime) as 6am_12pm, geo.country, geo.city, sessions.ip FROM sessions LEFT JOIN geo ON sessions.ip=geo.ip WHERE HOUR(TIME(starttime)) BETWEEN '06' AND '11:59:59' ORDER BY 6am_12pm, sessions.ip LIMIT 10;


SELECT COUNT(*) AS count, geo.country as top_country FROM geo JOIN sessions ON geo.ip=sessions.ip WHERE HOUR(TIME(starttime)) BETWEEN '12' AND '17:59:59' GROUP BY geo.country ORDER BY count DESC LIMIT 1;
SELECT TIME(starttime) as 12pm_6pm, geo.country, geo.city, sessions.ip FROM sessions LEFT JOIN geo ON sessions.ip=geo.ip WHERE HOUR(TIME(starttime)) BETWEEN '12' AND '17:59:59' ORDER BY 12pm_6pm, sessions.ip LIMIT 10;


SELECT COUNT(*) AS count, geo.country as top_country FROM geo JOIN sessions ON geo.ip=sessions.ip WHERE HOUR(TIME(starttime)) BETWEEN '18' AND '23:59:59' GROUP BY geo.country ORDER BY count DESC LIMIT 1;
SELECT TIME(starttime) as 6pm_12am, geo.country, geo.city, sessions.ip FROM sessions LEFT JOIN geo ON sessions.ip=geo.ip WHERE HOUR(TIME(starttime)) BETWEEN '18' AND '23:59:59' ORDER BY 6pm_12am, sessions.ip LIMIT 10;


/*sort by country*/
/*SELECT TIME(starttime) as time, geo.country, geo.city, sessions.ip FROM sessions LEFT JOIN geo ON sessions.ip=geo.ip ORDER BY country, time, sessions.ip;*/

/*All the times*/
/*SELECT TIME(sessions.starttime) as time, geo.country, geo.city, sessions.ip FROM sessions JOIN geo ON sessions.ip=geo.ip ORDER BY time ASC;
/*All the times sorted by country
SELECT TIME(sessions.starttime) as time, sessions.ip, geo.country, geo.city FROM sessions JOIN geo ON sessions.ip=geo.ip ORDER BY country, sessions.ip, time ASC;*/

SELECT COUNT(*) as total_sessions, HOUR(sessions.starttime) as hour FROM sessions GROUP BY hour ORDER BY total_sessions DESC;

/* Show a pattern between an ip that connects at what time - rounds the time to 10mins*/
/*SELECT COUNT(*) as count, SEC_TO_TIME((TIME_TO_SEC(starttime) DIV 600) * 600) AS aprox_time, geo.country, geo.city, sessions.ip FROM sessions JOIN geo ON sessions.ip=geo.ip GROUP BY ip, HOUR(sessions.starttime) ORDER BY count DESC, HOUR(sessions.starttime);*/

/*Show a pattern if an IP connects to the honeypot at the same time*/
SELECT COUNT(*) as count, SEC_TO_TIME(AVG(TIME_TO_SEC(starttime))) AS avg_time, geo.country, geo.city, sessions.ip FROM sessions JOIN geo ON sessions.ip=geo.ip GROUP BY HOUR(sessions.starttime), ip HAVING COUNT(*) > 1 ORDER BY count DESC, HOUR(sessions.starttime);
