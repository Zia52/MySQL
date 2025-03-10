-- Window Function

SELECT dem.first_name, dem.last_name, gender, AVG(salary) as avg_salary
FROM employee_demographics as dem
JOIN employee_salary as sal
   ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender;

-- OVER
SELECT dem.first_name, dem.last_name, gender, AVG(salary) 
OVER (PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
   ON dem.employee_id = sal.employee_id;
   

-- Rolling total

SELECT dem.first_name, dem.last_name, gender, salary, AVG(salary) 
 OVER (PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
   ON dem.employee_id = sal.employee_id;


-- ROW Number

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER () OVER ()
FROM employee_demographics as dem
JOIN employee_salary as sal
   ON dem.employee_id = sal.employee_id;
   
SELECT dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER () OVER (PARTITION BY gender ORDER BY salary DESC) as row_num
FROM employee_demographics as dem
JOIN employee_salary as sal
  ON dem.employee_id = sal.employee_id;
  
-- Rank
   SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
   ROW_NUMBER () OVER (PARTITION BY gender ORDER BY salary DESC) AS row_num,
   Rank () OVER (PARTITION BY gender ORDER BY salary DESC) as rank_num,
   DENSE_RANK () OVER (PARTITION BY gender ORDER BY salary DESC) as dense_num
   FROM employee_demographics as dem
   JOIN employee_salary as sal
     ON dem.employee_id = sal.employee_id;
     
SELECT dem.employee_id, dem.first_name, dem.last_name, salary,gender,
ROW_NUMBER () OVER (PARTITION BY gender ORDER BY salary) 
FROM employee_demographics as dem 
JOIN employee_salary as sal
  ON dem.employee_id = sal.employee_id;
 
   
   
   
   
   
   