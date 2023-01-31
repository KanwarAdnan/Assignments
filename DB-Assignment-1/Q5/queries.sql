SELECT * FROM person;
SELECT * FROM children;


/* Name a person who has most sons */

SELECT p.name, COUNT(*) as 'Number of Sons'
FROM person p
INNER JOIN children c
on p.pid = c.pid
WHERE c.gender = 1
GROUP BY p.pid
ORDER BY COUNT(*) DESC
LIMIT 1;

/* Name a person who has most children */

SELECT p.name, COUNT(*) as 'Number of Children'
FROM children c
INNER JOIN person p
ON p.pid = c.pid
GROUP BY p.pid
ORDER BY COUNT(*) DESC
LIMIT 1;


/* Name  persons who are widowed or divorced  such that females are above 30 and men are above 40 */

SELECT p.name, p.marital_status, p.age
FROM person p
WHERE (p.marital_status = 'widowed' OR p.marital_status= 'divorced')
AND (p.gender = 0 AND p.Age > 30) OR (p.gender = 1 AND p.Age > 40);
