-- Stored Procedures: is a reusable set of sql statements that are stored in database
CREATE PROCEDURE High_salaries ()
SELECT *
FROM employee_salary
WHERE salary > 50000;

CALL High_salaries;


DELIMITER $$
CREATE PROCEDURE High_salaries2 ()
BEGIN
	SELECT*
	FROM employee_salary
	WHERE salary>50000;
	SELECT*
	FROM employee_salary
	WHERE salary>10000;
END $$
DELIMITER ;

CALL High_salaries2() ;


DELIMITER $$
CREATE PROCEDURE High_salaries5(p_employee_id INT)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = P_employee_id
;
END $$
DELIMITER ;

CALL High_salaries5(2);






