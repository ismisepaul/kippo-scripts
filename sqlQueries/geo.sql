/* 
*	A script to output all the ip addresses that interacted with honeypot
*
*/

use kippo;
SELECT ip as unique_ip, country, city, logitude, latitude FROM geo ORDER BY country, city;
SELECT DISTINCT country FROM geo ORDER BY country;
SELECT COUNT(*) as top5_uniqueIPs, country FROM geo GROUP BY country ORDER BY top5_uniqueIPs DESC LIMIT 5;
SELECT COUNT(*) as top5_uniqueIPs, city, country FROM geo GROUP BY city ORDER BY top5_uniqueIPs DESC, country LIMIT 5;

/*all sessions with countries and cities*/
SELECT COUNT(*) as top5_sessions, geo.country FROM sessions JOIN geo ON sessions.ip=geo.ip GROUP BY geo.country ORDER BY top5_sessions DESC, geo.country LIMIT 5;
SELECT COUNT(*) as top5_sessions, geo.country, geo.city, sessions.ip FROM sessions JOIN geo ON sessions.ip=geo.ip GROUP BY sessions.ip ORDER BY top5_sessions DESC, geo.city LIMIT 5;
