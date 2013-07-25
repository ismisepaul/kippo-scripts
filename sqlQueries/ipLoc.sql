/* 
*	A script to output all the ip addresses that interacted with honeypot
*	the script will get distinct ips and then where they are not in the geo table
*/

use kippo;
SELECT DISTINCT sessions.ip FROM sessions WHERE sessions.ip NOT IN (SELECT geo.ip FROM geo);
#doesn't work
#select DISTINCT sessions.ip from sessions join geo on geo.ip where sessions.ip <> geo.ip;

