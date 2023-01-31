SELECT * FROM user;
SELECT * FROM login;

/* Check whether a user exists in the login system: */

SELECT uid AS "Existing Users" FROM user
WHERE name = 'john' OR email = 'john@hotmail.com';

/* Check if the password is correct */

SELECT uid as "Correct Key" FROM user
WHERE uid = 1 AND password = 'mykey';
