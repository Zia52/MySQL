-- UNIONS
SELECT first_name, last_name
FROM employee_demographics
UNION 
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, age, 'OLD' AS Label
FROM employee_demographics        -- old employee in the company 
WHERE age>50;

SELECT first_name, last_name, 'Old Man' as label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' as label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT first_name, last_name, 'Highly paid salary' as label
FROM employee_salary
WHERE salary>70000
ORDER BY first_name, last_name;
