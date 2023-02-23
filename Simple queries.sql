USE employees;

-- Exploring the data in some of the tables in the employees schema.

SELECT *
FROM employees;

SELECT * 
FROM departments; 

SELECT *
FROM employees
WHERE first_name = 'Christian';

SELECT *
FROM employees
WHERE first_name LIKE 'Mark%'; 

SELECT *
FROM employees 
WHERE hire_date LIKE('%1992%'); 

SELECT *
FROM employees
WHERE emp_no LIKE('1002_');

SELECT *
FROM employees
WHERE first_name NOT LIKE('%Jack%');

SELECT *
FROM salaries
WHERE salary BETWEEN 75000 AND 80000;

SELECT *
FROM salaries 
WHERE emp_no NOT BETWEEN '10005' AND '10015';

SELECT *
FROM departments
WHERE dept_no IS NULL;  

SELECT *
FROM employees
WHERE gender = 'F' AND hire_date >= '2000-01-01';

-- Exploring aggregations in MYSQL

SELECT COUNT(*)
FROM salaries
WHERE salary >=100000;

SELECT DISTINCT hire_date
FROM employees; 

SELECT SUM(salary)
FROM salaries;

SELECT SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01';

SELECT MAX(salary)
FROM salaries;

SELECT FLOOR(AVG(salary))
FROM salaries
WHERE from_date > '1997-01-01';

-- Taking the count of all employees in the employees table. 

SELECT first_name, COUNT(first_name) AS names_count
FROM employees
GROUP BY first_name
ORDER BY first_name;

-- Count of the number of employees that have the same salary over $120,000.

SELECT salary, COUNT(emp_no) AS 'emps_with_same_salary' 
FROM salaries
WHERE salary > 120000
GROUP BY salary
ORDER BY salary;

-- Employees who have an average salary higher than $120,000 annual. 

SELECT emp_no, ROUND(AVG(salary),2) AS avg_salary
FROM salaries
GROUP BY emp_no
HAVING ROUND(AVG(salary),2) > 120000
ORDER BY emp_no;

/* Qerying the employee numbers of all individuals 
who have signed more than 1 contract after January 1, 2000. */

SELECT emp_no, COUNT(from_date) AS count
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no
LIMIT 10;