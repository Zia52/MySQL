-- LIMIT
SELECT*
FROM employee_demographics
LIMIT 2;

-- Aliasing
SELECT gender, AVG(age) As avg_age
FROM employee_demographics       -- use group by to group gender and avage column, and having use to filter the column, Aliasing use to change the column name
GROUP BY gender
Having AVG(age)>40;
