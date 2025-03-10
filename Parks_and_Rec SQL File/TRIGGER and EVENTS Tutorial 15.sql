-- Triggers and Events: Triggers is a stored database object that is automatically executed when certain events occur on a specified table.

DELIMITER $$
CREATE TRIGGER employee_insart
	AFTER INSERT ON employee_salary -- After Triggers: execute after the specified events occur
    FOR EACH ROW 
BEGIN
    INSERT INTO employee_demographics (employee_id,first_name,last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Elon', 'Musk', 'Spece X CEO', 10000000, NULL);

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;


-- Events
-- retire people who are more than 60

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 second
DO
BEGIN
	DELETE
	FROM employee_demographics
	WHERE age>=60;
END $$
DELIMITER ;

SELECT *
FROM employee_demographics;

SHOW VARIABLES LIKE 'event%';




