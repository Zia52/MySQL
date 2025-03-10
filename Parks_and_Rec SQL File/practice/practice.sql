SELECT*
FROM employee_demographics;

SELECT*
From employee_salary;

SELECT first_name, age
FROM employee_demographics;

SELECT salary, first_name, occupation
FROM employee_salary;

SELECT DISTINCT first_name
FROM employee_demographics;

SELECT DISTINCT first_name
FROM employee_salary;

SELECT first_name, salary,occupation
FROM employee_salary
WHERE salary > 70000;

SELECT*
FROM employee_demographics        
WHERE birth_date > 1985
or gender = 'male';

SELECT*
FROM employee_demographics
WHERE gender = 'Female';

SELECT *
FROM employee_demographics
WHERE (first_name = 'alwx' AND age ) OR age > 55;


SELECT salary, first_name, dept_id
FROM employee_salary
WHERE (first_name = 'leslie' and dept_id) or salary > 80000;



SELECT *
FROM employee_demographics;

SELECT*
FROM employee_demographics
WHERE (age>20 AND gender = 'Female') OR first_name = 'Elon';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';

SELECT * 
from employee_demographics
WHERE first_name LIKE 'b__%';


SELECT gender, AVG (age)
FROM employee_demographics
GROUP BY gender;

select salary, avg (salary)
from employee_salary
group by salary;

select occupation, salary
from employee_salary;

select  avg(salary) as avgsalary
from employee_salary
group by salary;


SELECT gender, avg(age)
FROM employee_demographics
GROUP BY gender;

SELECT gender, avg(age)
FROM employee_demographics
GROUP BY gender;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT salary, avg(salary), max(salary), min(salary), count(salary)
FROM employee_salary
GROUP BY salary;

SELECT gender, avg(age)
FROM employee_demographics
GROUP BY gender
HAVING avg(age) > 20;

SELECT salary, occupation
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY salary, occupation
HAVING salary > 70000
;

SELECT *
FROM employee_demographics;

SELECT age, first_name
FROM employee_demographics
WHERE gender LIKE '%male%'
GROUP BY age, first_name
HAVING age >= 40;

SELECT age, first_name
FROM employee_demographics
WHERE gender LIKE '%female%'
GROUP BY age, first_name
HAVING age >30;

SELECT*
FROM employee_salary;

SELECT *
FROM employee_demographics
LIMIT 5;


SELECT salary, AVG(salary) as avg_salary
FROM employee_salary
GROUP BY salary
LIMIT 3;


SELECT salary, SUM(salary) 
FROM employee_salary
GROUP BY salary
LIMIT 2;

SELECT occupation, age, employee_demographics.first_name, employee_demographics.last_name
FROM employee_demographics
JOIN employee_salary
  ON employee_demographics.employee_id = employee_salary.employee_id;
  
  SELECT employee_salary.first_name, employee_salary.last_name, age, salary, occupation
  FROM employee_demographics
  JOIN employee_salary
    on employee_demographics.employee_id = employee_salary.employee_id;
    
    SELECT *
    FROM employee_demographics
    RIGHT JOIN employee_salary
         on employee_demographics.employee_id = employee_salary.employee_id;


SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
    ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments as pd
    ON pd.department_id = sal.dept_id;
    
    SELECT first_name, 'old' as label
    FROM employee_demographics
    WHERE age > 45
    UNION
    SELECT first_name,  'High paid employee' As label
    From employee_salary
    WHERE salary > 70000;
    SELECT first_name, last_name, 'old' as label
    FROM employee_demographics
    WHERE age > 44
    UNION
    SELECT first_name, last_name, 'High paid employee' as label
    FROM employee_salary
	WHERE salary > 70000;
    
    
    SELECT first_name, last_name, age, 'old' as label
    FROM employee_demographics
    WHERE age > 20
    UNION 
    SELECT first_name, last_name, salary, 'HIGH PAID EMPLOYEE' as label
    FROM employee_salary
    WHERE salary > 70000;
    
    
SELECT first_name, last_name, 'OLD LADY' as label
    FROM employee_demographics
    WHERE age>40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'OLD MAN' as label
	FROM employee_demographics
	WHERE age>40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'HIGH PAID SALARY'
	FROM employee_salary
    WHERE salary>80000
ORDER BY first_name, last_name;


SELECT first_name, last_name, 'young man' as label
	FROM employee_demographics
    WHERE age>20 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'old women' as label
	FROM employee_demographics
	WHERE age>20 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'high paid salary' as label
	FROM employee_salary
    WHERE salary>70000
ORDER BY first_name, last_name;
SELECT first_name, LENGTH(first_name)
	FROM employee_demographics;
    
SELECT first_name, LENGTH(first_name)
	FROM employee_demographics
    order by 2;
    
SELECT first_name, UPPER(first_name)
FROM employee_demographics;

SELECT first_name,
	LEFT(first_name,4),
    RIGHT(first_name,4),
    SUBSTRING(first_name,3,2)
birth_date,SUBSTRING(birth_date,1,4) as birth_year
	FROM employee_demographics;

SELECT first_name, last_name,
	CONCAT(first_name, ' ', last_name) as Full_Name
FROM employee_demographics;

SELECT first_name, last_name,
	CONCAT(first_name,' ', last_name)
FROM employee_demographics;

-- case satatement allow you to add logic in your select statement
SELECT 	first_name, last_name,age,
	CASE
		WHEN age <=25 THEN 'Youn'
        WHEN age BETWEEN 31 AND 50 THEN 'Old'
        WHEN age >=50 THEN 'retire'
	END AS age_bracket
FROM employee_demographics;

SELECT first_name, last_name, salary,
	CASE
		WHEN salary < 50000 THEN salary + (salary*0.05)
        WHEN salary > 50000 THEN salary + (salary*0.07)
	END AS bonus,
	CASE
		WHEN dept_id = 6 THEN salary * .10
	END AS bonus
FROM employee_salary;

-- subquris basically in another quries 
 SELECT*
 FROM employee_demographics
 WHERE employee_id in
					(SELECT employee_id
                     FROM employee_salary  -- dept_id 4 select this employee_id
                     WHERE dept_id = 4)
                     ;

SELECT *
FROM employee_demographics
WHERE employee_id IN
					(SELECT employee_id
                     FROM employee_salary
					 WHERE dept_id = 6)
;

SELECT AVG (avg_age)
FROM
	(SELECT gender,
    AVG(age) as avg_age,
    MAX(age) as max_age,
    MIN(age) as min_age,
    COUNT(age)
FROM employee_demographics
	GROUP BY gender) as agg_table;
    
SELECT MAX (age)
FROM 
(SELECT gender,
AVG (age),
MAX (age),
MIN (age)
FROM employee_demographics
GROUP BY gender)


-- window function allow us to look at a partion 
SELECT dem.first_name, dem.last_name, gender, AVG(salary)
OVER (PARTITION BY gender)
FROM employee_demographics as dem
JOIN employee_salary as sal
 ON dem.employee_id = sal.employee_id;

SELECT dem.first_name, dem.last_name, gender, AVG(age)
OVER (PARTITION BY gender)
FROM employee_demographics dem
INNER JOIN employee_salary sal
ON dem.employee_id = sal.employee_id;



SELECT dem.first_name, sal.last_name, gender, avg(age)
    OVER (PARTITION BY salary)
FROM employee_demographics dem
INNER JOIN employee_salary sal
ON dem.employee_id = sal.employee_id;

SELECT dem.first_name, Age, Salary, 
 AVG(Salary) OVER( PARTITION BY sal.last_name) AS Avg_Salary
 FROM employee_salary dem
 JOIN employee_demographics sal
   ON dem.employee_id = sal.employee_id;


SELECT dem.first_name, dem.last_name, salary, AVG(age) 
OVER (PARTITION BY salary)
FROM employee_demographics dem
JOIN employee_salary sal
   ON dem.employee_id = sal.employee_id;

    SELECT dem.first_name, sal.last_name, gender, salary, avg(salary)
    OVER (PARTITION BY gender order by dem.employee_id asc) AS Rolling_Total
    FROM employee_demographics dem
    join employee_salary sal
    on dem.employee_id = sal.employee_id;
    
    SELECT dem.first_name, sal.last_name, dem.employee_id, gender, salary,
    ROW_NUMBER () over()
    FROM employee_demographics dem
    join employee_salary sal
    ON dem.employee_id = sal.employee_id;
    
    SELECT dem.first_name, sal.last_name, gender, salary, 
    ROW_NUMBER () OVER (PARTITION BY gender order by salary ) as row_num
    FROM employee_demographics dem
    join employee_salary sal
    on dem.employee_id = sal.employee_id;
    
    
    -- common table expressin: is a tempory name result set 
    -- make queries easy to read 
    -- allow to divided complex queries into smaller logical block
    -- improve qurries reusability
    
    with highsalaryemployee as(
    SELECT employee_id,first_name, salary as 'high paid'
    FROM employee_salary
    WHERE salary> 70000)
    SELECT*
    FROM highsalaryemployee;
    
-- find the average salary per departments and than select only department with an average salary above 50000
with averagesalary as(
					select employee_id, first_name, salary, avg(salary) as avgsalary
					from employee_salary
					group by employee_id, first_name, salary)
select employee_id, first_name, salary
from averagesalary
WHERE salary>70000;

WITH demographics as (
select employee_id, gender, birth_date
from employee_demographics),
salary as (
select employee_id, salary
from employee_salary
)
select*
from demographics
join salary
on demographics.employee_id = salary.employee_id;


with avgsalary as (
select gender, avg(salary), max(salary), min(salary)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by gender)

select*
from avgsalary;

with demographics as (
select employee_id,gender,birth_date
from employee_demographics ),
salary as (
select employee_id, salary
from employee_salary)

select *
from demographics
join salary
on demographics.employee_id = salary.employee_id;

create temporary table temp_table (
first_name varchar (50),
last_name varchar (50),
favorite_movie varchar (100) )

;

 insert into temp_table
 values 
 ('ales','frik', 'dark');
 select *
 from temp_table;
 
    
    
    delimiter $$
    create trigger employee_insart
    after insert on employee_salary
    for each row
    begin
    insert into employee_demographics(employee_id,first_name,last_name)
    values(new.employee_id,new.first_name,new.last_name);
    end $$
    delimiter ;
    
    
   

































    
    
    








    
    
    
    
    
    
    








