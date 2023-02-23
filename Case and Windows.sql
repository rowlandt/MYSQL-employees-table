USE employees;

/* Using a CASE statement to extract a dataset showing the difference 
between the maximum and minimum salary of that employee, 
and another one saying whether this salary raise was higher than $30,000 or NOT. */

SELECT e.emp_no, e.first_name, e.last_name, MAX(s.salary)-MIN(s.salary) AS salary_raise,
	CASE
	WHEN MAX(s.salary)-MIN(s.salary) > 30000 THEN 'Raise greater than $30,000'
    ELSE 'Raise not greater than $30,000'
    END AS raise
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
GROUP BY e.emp_no;

/*Using window functions to order all the managers in the employee table. */

SELECT e.emp_no, ROW_NUMBER()OVER() AS managers
FROM employees AS e
JOIN dept_manager AS m ON e.emp_no = m.emp_no
WHERE m.emp_no IS NOT NULL;

/* Assigning sequential number for each employee. Partitioned by first name and 
ordered by last name is ascending order. */
SELECT emp_no, first_name, last_name,
ROW_NUMBER() OVER(PARTITION BY first_name ORDER BY last_name) AS row_num
FROM employees;

/* Assigning a row number to all managers in the employees database. 
Assigning the values of the manager with the lowest employee count in ascending order. */

SELECT emp_no, dept_no,
ROW_NUMBER() OVER (ORDER BY emp_no) AS row_num
FROM
dept_manager;

/* Return a result set containing the employee #, contract salary, 
start and end dates of the first ever contracts that each employee signed for the company. */

SELECT s1.emp_no, s.salary, s.from_date, s.to_date
FROM salaries s 
JOIN(SELECT emp_no, MIN(from_date) AS from_date
    FROM salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE s.from_date = s1.from_date;