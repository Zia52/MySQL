-- Data Cleaning Project

SELECT *
FROM layoffs;

-- 1.Remove Duplicates
-- 2.Standardize the Data
-- 3.Null Values or Blank values
-- 4.Remove Any Columns

-- first we create a staging table. WE work on this table, because we want the table with the raw data, in case something happens.

CREATE TABLE layoffs_staging  -- create a table name layoffs_staging like our row data name layoffs
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


-- 1. Remove Duplicates
# First let's check the duplicates

SELECT *
FROM world_layoffs.layoffs_staging;

WITH duplicate_cte As
(
SELECT *,
ROW_NUMBER() OVER(
			PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
	FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

DELETE 
FROM duplicate_cte 
WHERE row_num > 1; -- can't delete

-- add the row_number in database create staging2 database than we can delete it because we can filter on these row number and we can delete those which are equal to two. Creating some type of table and then just deleting the actual column.
-- so it is essentially just creating another table that has this extra row and then deleting it where that row is equal to two.


	CREATE TABLE `layoffs_staging2`(
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_numd` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


ALTER TABLE layoffs_staging2 RENAME COLUMN row_numd TO row_numb;

SELECT *
FROM layoffs_staging2;



-- we have create a empty table, now we want insert our layoffs_staging information into layoffs_staging2 database

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
		PARTITION BY company,location,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging; 
-- we just insarted, basically a copy of all these columns but in ihis new table we added one more the row num so now we can filter.

-- NOW AGAIN CHECK THE DUPLICATE
SELECT *
FROM layoffs_staging2
WHERE row_numb>1;


SELECT *
FROM layoffs_staging2
WHERE company = '&Open';
 
SELECT *
FROM layoffs_staging2
WHERE company = 'Casper';

-- Now we are going to delete these duplicate
DELETE 
FROM layoffs_staging2
WHERE row_numb > 1;

SELECT *
FROM layoffs_staging2
WHERE row_numb>1; -- now they are gone

SELECT *
FROM layoffs_staging2;

-- 2.Standardizing data

-- So Standardizing data is finding issues in your data and than fixing it.

SELECT *
FROM layoffs_staging2;

-- we find some issues like in company column the name of the data have a space at the begining. so we just trim on this column.

SELECT company, TRIM(company)
FROM layoffs_staging2;

-- so we are going update now
UPDATE layoffs_staging2
SET company = TRIM(company);

-- TRIM is just takes white space off the end so it took the white space out in the right hand side

-- Now look at the industry column finds any issues we can correct it 
SELECT industry
From layoffs_staging2;

SELECT industry
From layoffs_staging2
ORDER BY 1;

-- we find an issue in data name crypto , crypto currency these are all the same thing these should all be on or labeled the exact same thing. The reason we need to change this because when we start doing the explotary data analysis visualizing it all these would all be their own rows or own unique thing which we don't want we want them all to be grouped togther so we can accurately look at the data.







SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- now look at location 
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1; -- It seems like this column doesn't have any issues
 
 -- now look at the country column
 SELECT DISTINCT country
 FROM layoffs_staging2
ORDER BY 1;

 SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
 FROM layoffs_staging2
 ORDER BY 1;

-- we can do tralling from the country and looking for something that not white space and we are looking for a period (TRALING means coming at the end)
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- here our `DATE` data are in text data type we convert it into `DATE` data type
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE ;

-- 3.NULL & BLANK VALUES
SELECT *
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL;

-- here we see in  our data set we find some data have both null value in total_laid.. and percentage_laid... now check it.
SELECT total_laid_off, percentage_laid_off
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- The industry have some missing values. let's check them
 SELECT DISTINCT industry
 FROM layoffs_staging2; 
     -- we find a missing values and null here 
     
 SELECT *
 FROM layoffs_staging2
 WHERE industry IS NULL
 OR industry = '';
 
 SELECT *
 FROM layoffs_staging2
 WHERE company = 'Airbnb';
 -- look at airbnb this one has travel so we know this is the travel industry. We want this data to be same.
 
 -- now we are changing it to null where it is blank
 UPDATE layoffs_staging2
 SET industry = null
 WHERE industry = '';
 
 -- we are no try to do join here. layoffs_stagin2 join itself to check where the blank and not blank. In join t1 industry show the null or blank and t2 industry show the not null. And we are going to check in this table doest it have one that is blank not if so update it with the non-blank that's essentially 
 SELECT *
 FROM layoffs_staging2 t1
 JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t2.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


-- updating the table t1 we are joining on t2 or the company is exact same. We are setting t1 industry equal to t2 industry. So t1 should be the blank one so where t1 industry is null or blank and t2 industry is not null.
-- set statement- we all set the t1.industry = t2.industry
 UPDATE layoffs_staging2 t1
 JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL )
AND t2.industry IS NOT NULL;

SELECT *
 FROM layoffs_staging2
 WHERE company = 'Airbnb';
 
 SELECT *
 FROM layoffs_staging2
 WHERE company LIKE 'Bally%';

SELECT *
FROM layoffs_staging2;
 
SELECT total_laid_off, percentage_laid_off
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; -- check the null values 

-- we delete the ones where the total total_laid_off is blank and percentage_laid_off is blank 
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- now delete the extra row that we have add for checking duplicates. We want to drop the column
ALTER TABLE  layoffs_staging2
DROP COLUMN row_numb;

-- -- --- --- --- --- ----- This is our finalized clean data now -- --- --- --- --- ---
SELECT *
FROM layoffs_staging2; 
-- we have some populated row where it's not null actually populate the null row














	








