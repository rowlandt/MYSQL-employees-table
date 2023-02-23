USE employees;

/* Exploring how to query stored procedures in the database*/

-- This procedure whenever applied will return the first 1000 rows from the employees table. 

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT *
    FROM employees
    LIMIT 1000;
END$$
DELIMITER ; 

CALL employees.select_employees(); -- This executes the procedure. 

/*This procedure when applied will provide the average salary of all employees. */

DROP PROCEDURE IF EXISTS avg_salary;

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
	SELECT emp_no, ROUND(AVG(salary),2)
    FROM salaries;
END$$
DELIMITER ;

CALL employees.avg_salary();

/*This procedure when applied will allow you to input employee number and
their average salary will be the output.*/

DROP PROCEDURE IF EXISTS emp_avg_salary_out;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
SELECT AVG(s.salary) INTO p_avg_salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
END $$
DELIMITER ; 