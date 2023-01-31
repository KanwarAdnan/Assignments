SELECT * FROM user;
SELECT * FROM phone;

/* List all the users who have more than two phones */

SELECT name AS "Two Plus" FROM user u
INNER JOIN phone p ON u.uid = p.uid
GROUP BY u.uid
HAVING COUNT(p.pid) > 2;


/* List all the Users of Ufone */

SELECT name AS "Ufone Users" FROM user u
INNER JOIN phone p ON u.uid = p.uid
WHERE p.service_provider = 'Ufone';

