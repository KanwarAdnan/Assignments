SELECT * FROM user;
SELECT * FROM follow;

/* List all those users who have more than 10 followers */

SELECT name AS "10Plus followers" FROM user u
JOIN follow f ON u.uid = f.uid
GROUP BY u.uid
HAVING COUNT(f.follows_uid) > 10;


/* List all those users who are not followed by any one */

SELECT name AS "Not Followed" FROM user
WHERE uid NOT IN (SELECT follows_uid FROM Follow);


/* List all those users who follow less than 5 (let say k) users but they are followed by 50 (let say m) users */

SELECT name AS "k and m" FROM user u
JOIN Follow f ON u.uid = f.uid
GROUP BY u.uid
HAVING COUNT(f.follows_uid) < 5 AND COUNT(f.uid) > 50;