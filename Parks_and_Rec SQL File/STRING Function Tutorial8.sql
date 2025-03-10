-- String function

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
order by 2;

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

-- TRIMS: LEFT TRIMS, RIGHT TRIMS
-- to take the white space on the front or the end to get rid of it
SELECT  RTRIM('   sky   ');


SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name,4),
SUBSTRING(first_name, 3,2), -- 3,2: 3 position 2 character
birth_date, SUBSTRING(birth_date,1,4) AS birth_year
FROM employee_demographics;

-- Replace the replace the character
SELECT first_name, REPLACE(first_name, 'A', 'z')
FROM employee_demographics;

-- LOCATE
SELECT LOCATE('A', 'ZIA');

SELECT first_name, LOCATE('A', first_name)
FROM employee_demographics;

-- CONCAT: multiple column in to one single column
SELECT first_name, last_name,
CONCAT(first_name,'  ', last_name) AS Full_Name
FROM employee_demographics;


-- [numeric function, time function, date function, converting different data types]






