
SELECT*
FROM parks_and_recreation.employee_demographics
WHERE first_name = 'Tom';

SELECT*
FROM employee_salary
WHERE salary >= 50000
;

SELECT*
FROM employee_salary
WHERE salary <= 50000
;


SELECT*
FROM employee_demographics
WHERE gender = 'Female'
;


SELECT*
FROM employee_demographics
WHERE gender != 'Female'
;

SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;


-- AND OR NOT logical operators
SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male'
;


SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male'
;

SELECT*
FROM employee_demographics
WHERE (first_name = 'Tom' AND age ) OR age > 55
;

-- LIKE statement
-- % means select everything and _ means slect specefic thing
SELECT*
FROM employee_demographics
WHERE first_name LIKE '%r%' -- r% means the name start with r in a word will be slect and %r% means wherever r in the word select it
;

SELECT*
FROM employee_demographics
WHERE first_name LIKE 'a___%' -- a__% means start with a and three character then anything have
;

SELECT*
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;




