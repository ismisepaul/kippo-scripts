/*
*	Script that interacts with Kippo DB
*
*/
USE kippo;

/* total login attempts */
SELECT COUNT(*) AS total_login_attempts from auth;

/* list login sucess */
SELECT geo.city, geo.country, auth.username, auth.password, auth.timestamp, sessions.ip FROM auth, sessions, geo WHERE success = '1' AND sessions.id=auth.session AND sessions.ip=geo.ip;

/* loging attempts by ip */
SELECT COUNT(*) AS login_attempts, geo.country, geo.city, sessions.ip from auth, geo, sessions WHERE sessions.id=auth.session AND sessions.ip=geo.ip GROUP BY sessions.ip;

/* date of login attempts */
/*SELECT auth.timestamp, geo.country, geo.city, sessions.ip FROM auth, geo, sessions WHERE auth.session=sessions.id AND sessions.ip=geo.ip GROUP BY sessions.id ORDER BY sessions.ip;*/


/* top 10 usernames */
SELECT COUNT(*) as count, auth.username, auth.password FROM auth GROUP BY auth.username, auth.password ORDER BY count DESC LIMIT 10;


/*SELECT * from auth where password='123123';*/

/*Top 3 usernames */
SELECT COUNT(*) as count, auth.username FROM auth GROUP BY auth.username ORDER BY count DESC LIMIT 3;

/* top 3 most commonly used passwords */
SELECT COUNT(*) as count, auth.password FROM auth GROUP BY auth.password ORDER BY count DESC LIMIT 3;
