-- JOINS
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal          -- join employee_dempgraphics table and employee_salary table in one frame
     ON dem.employee_id = sal.employee_id;
     
SELECT dem.employee_id, age, occupation 
FROM employee_demographics As dem
INNER JOIN employee_salary AS sal
     ON dem.employee_id = sal.employee_id;
     
SELECT dem.employee_id, age, occupation, salary, dem.first_name
FROM employee_demographics As dem
INNER JOIN employee_salary AS sal
     ON dem.employee_id = sal.employee_id;
     
-- OUTER join
SELECT*
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
    ON dem.employee_id=sal.employee_id;
    
SELECT*
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal   -- Right join take everything if there is no match
     ON dem.employee_id=sal.employee_id;
		
-- SELF JOIN
SELECT *
FROM employee_salary as emp1
 JOIN employee_salary as emp2
      ON emp1.employee_id = emp2.employee_id;

SELECT*
FROM employee_salary as emp1
JOIN employee_salary as emp2
    ON emp1.employee_id + 1 = emp2.employee_id;
    
SELECT emp1.employee_id AS emp_park,
emp1.first_name AS first_name_park,
emp1.last_name AS last_name_park,
emp2.first_name AS first_name_park,
emp2.last_name AS last_name_park
FROM employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id +1 = emp2.employee_id;

-- joining Multiple Table Together
SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
    ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments as pd
    ON sal.dept_id = pd.department_id;




    
    