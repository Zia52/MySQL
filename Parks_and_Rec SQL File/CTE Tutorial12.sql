-- CTEs
-- simple CTE
WITH HighSalaryEmployees AS(
SELECT employee_id, first_name,  salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM HighSalaryEmployees;

-- CTEs for Aggregations
-- Find the average salary per depertment and then select only department with an average salary above 50000
WITH AverageSalary AS (
SELECT employee_id, first_name, salary, AVG(salary) AS AvgSalary 
FROM employee_salary 
GROUP BY employee_id, first_name, salary
)
SELECT employee_id, first_name, salary
FROM AverageSalary
WHERE salary > 70000;


-- CTE : subqueries, refrences with main queris

WITH GenderandSalary (Gender, AVG_sal, MAX_sal, MIN_sal, COUNT_sal) AS (
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal,COUNT(salary) count_sal
FROM employee_demographics as dem
JOIN employee_salary as sal                               -- join statement use to join two table
  ON dem.employee_id = sal.employee_id                            -- join two table (on) using common id (employee_id)
GROUP BY gender                                                                 -- grouping only the common column between two table
)
SELECT *
FROM GenderandSalary;    


-- Multiple CTE: joining multiple quries

WITH Demographics AS (
SELECT  employee_id, gender, birth_date
FROM employee_demographics
),
Salary AS (
SELECT employee_id, salary
FROM employee_salary
)
SELECT *
FROM Demographics
JOIN salary
  ON Demographics.employee_id = salary.employee_id;










                                                 















