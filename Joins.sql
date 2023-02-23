USE employees;

/* Exploring data by practicing joins. */

-- Using a query to obtain all dept_no and emp_no from dept_manager table and the dept_name from departments table.

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup AS m
LEFT JOIN departments_dup AS d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

/* Joining both the 'employees' and 'dept_manager' tables together to return a subset of data 
of all employyes whose last name is 'Markovitch' and if there is a manager with that name. */

SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM employees AS e
LEFT JOIN dept_manager_dup AS m
ON e.emp_no = m.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY m.dept_no DESC, e.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

/* Use a CROSS JOIN to return a list with all possible combinations between managers from the 
dept_manager table and department number 9. */

SELECT dept_manager.*, departments.*
FROM dept_manager CROSS JOIN departments
WHERE departments.dept_no = 'd009'
ORDER BY departments.dept_name; 

/* Joining more than two tables to obtain managers name, hire date, title, 
start date, and dept name. */

SELECT e.first_name, e.last_name, e.hire_date, t.title, m.from_date, d.dept_name
FROM employees AS e
JOIN dept_manager AS m
ON e.emp_no = m.emp_no
JOIN departments AS d
ON m.dept_no = d.dept_no
JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.last_name;

-- How many male and female managers do we have in the employees database.

SELECT gender, COUNT(*) AS num_of_gender
FROM employees AS e
JOIN dept_manager AS m 
ON e.emp_no = m.emp_no
JOIN departments AS d
ON m.dept_no = d.dept_no 
GROUP BY gender
ORDER BY num_of_gender;

/*  Querying to see which department managers were hired 
between the 1st of January 1990 and the 1st of January 1995. */

SELECT *
FROM dept_manager AS m
WHERE emp_no IN (
	SELECT emp_no
    FROM employees
    WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
-- Note that this can also be achieved with a join. 
SELECT *
FROM dept_manager AS m
JOIN employees AS e
ON m.emp_no = e.emp_no
WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01';

/* Querying information for all employees that have the 'Assistant Engineer' Job title. */

SELECT *
FROM employees e
WHERE EXISTS (
	SELECT *
    FROM titles t
    WHERE t.emp_no = e.emp_no AND  title = 'Assistant Engineer');
    
SELECT id, last_name, first_name, job_title, manager_id, division_name
FROM employees
ORDER BY id;

/* Common use case for SELF JOINS is to obtain heirachal data from the same table. 
Query to display the employee last name, and his/hers direct manager */

SELECT e.last_name AS employee, m.last_name AS manager
FROM employees AS e
JOIN employees AS m
ON e.manager_id = m.employee_id;
		