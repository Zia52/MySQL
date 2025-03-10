-- Temporary Table

CREATE TEMPORARY TABLE temp_table(
first_name varchar(50),                                 -- create a temporaray table, which are not add our main database
last_name varchar (50),
favorite_movie varchar (100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES 
('Samira Hossain', 'Nipa', 'The Dark Night'),
('Zia Ul Hassan', 'Chowdhury', 'Dabba');

SELECT*
FROM temp_table;








