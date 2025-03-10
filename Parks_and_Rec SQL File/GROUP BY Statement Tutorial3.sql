-- GROUP BY 
SELECT*
FROM employee_demographics;

SELECT gender, AVG(age), max(age), min(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

SELECT *
FROM employee_demographics
ORDER BY gender , age DESC;





SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;