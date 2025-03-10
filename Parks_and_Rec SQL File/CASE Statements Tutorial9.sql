-- Case statements allows you to logic in your select statements like if else

SELECT first_name, last_name, age,
CASE
   WHEN age <=30 THEN 'Young'
   WHEN age BETWEEN 31 and 50 THEN 'Old'
   WHEN age >=60 THEN'Time to retire'
   
END as Age_Bracket
FROM employee_demographics;

-- pay increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10%

SELECT first_name, last_name, salary,
CASE
   WHEN salary < 50000 THEN salary + (salary * 0.05)
   WHEN salary > 50000 THEN salary + (salary * 0.07)
   END as Bonus,
CASE
     WHEN dept_id = 6 THEN salary * .10
END As Bonus
FROM employee_salary;



select *
from parks_departments;