SELECT * FROM user;
SELECT * FROM project;


/* All those projects whose budget is between   $ and $$ */

SELECT title AS "Budget Between" FROM project
WHERE budget BETWEEN 100 AND 200;

/* Total Number of Employees who work in a project with a title of 'abc' */

SELECT COUNT(DISTINCT uid) AS "ABC" FROM user_project up
INNER JOIN project p ON up.pid = p.pid
WHERE p.title = 'abc';