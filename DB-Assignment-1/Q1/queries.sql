SELECT * FROM user;
SELECT * FROM role;

/* List all the editors */

SELECT name AS "Editors" FROM user u
INNER JOIN role r ON u.rid = r.rid
WHERE r.title = 'editor';


/* Count all the commentators */

SELECT COUNT(DISTINCT uid) AS "Commentators" FROM user u
INNER JOIN role r ON u.rid = r.rid
WHERE r.title = 'commentator';


/* List all the gmail users */

SELECT name as "Gmail Users" FROM user
WHERE email LIKE '%gmail.com';