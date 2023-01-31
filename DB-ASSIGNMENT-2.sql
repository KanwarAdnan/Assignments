-- Find the Employee names And their related Department Names.
SELECT Employee.Name, Department.Name 
FROM Employee 
JOIN Department 
ON Employee.DepartmentID = Department.ID;

-- Find the Departmant Name, Departmant Location and which Project is Handling By Department.
SELECT Department.Name, Department.Location, Project.Name 
FROM Department 
JOIN Project 
ON Department.ProjectID = Project.ID;

-- Show The Names and Salary as "Increased SALARY AFTER giving increment of 15 percent to each Employee.
SELECT Employee.Name, Employee.Salary*1.15 AS "Increased Salary" 
FROM Employee;

-- Find only those department names which are working without any 'MANAGER'.
SELECT Name FROM Department WHERE ManagerID IS NULL;

-- Find The Names of Those Employees Which Names are not starting with character    A  ,  Q  and S
SELECT Name FROM Employee WHERE Name NOT LIKE 'A%' AND Name NOT LIKE 'Q%' AND Name NOT LIKE 'S%';
