-- Exploratory Data Analysis

-- In the first project we worked with exact data set and we cleaned up the entire thing. Now we explore the data with all that clean data we all able to look at our data much better and find better insights.
-- Normally when we do the EDA process you have some idea of what you are looking for sometimes not always . sometimes when you explor the data you also find issues with the data that you have to clean so. exploring and cleaning it at the same time .

SELECT *
FROM layoffs_staging2;

-- now we are going to working with total_laid_off and percentage_laid_off 

SELECT MAX(total_laid_off)
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2; -- one represents 100 because it is percentage_laid_off that means 100 of the company was laid off

-- let see is their any company i can recognize
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1; -- this is the company that lost all their employees

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC ; -- order by total_laid_off it in descending. We will see which company have the largest.
-- in the katerra construction company there are 2434 pepole laid_off (who lost their job).
 
-- And there are another column over here called funds_raised_millions let's look that one.
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off =1
ORDER BY funds_raised_millions DESC; -- these company had lot of funding. First one (Britishvolt) has 2.4 billion dollars funding.

-- we want to look at the sum of total_laid_off in company and that for we need to use group by the company and order by 2 in descending

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;
-- Amazon have 18150 people, Google have 12000 people, Meta have 11000 people lost their job, and there are lot of company here. The result was the max we looked at earlier. 

select company, total_laid_off
from layoffs_staging2
where company = 'Amazon';

-- we want to look at our date ranges. 
SELECT MIN(`date`), Max(`date`)
FROM layoffs_staging2;
-- it looks like it starts in 2020 of 3-11 later 2023

-- look at the industry. Which have the most laid_off (which company most of the people lost their job) 
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT *
FROM layoffs_staging2;

-- look at the country. Which countries at least from this dataset.
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
-- United States had the most people lost their job.

SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

-- let's it by the year
SELECT YEAR (`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR (`date`)
ORDER BY 1 DESC;
-- IN 2022 MOST OF THE PEOPLE LOST THEIR JOBS AROUND THE WORLD

-- now look at the stage. It show stage of the company
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC; 

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- percentages refer to a percent of the company
SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`,1,7) as `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_laid
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_laid, 
SUM(total_laid) OVER (ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;
-- This work: it start with 9628 then it adds on the next month which is 26710 which is equal 36338. Then it adds on the next month and we get 62142. On the next month the it add previous month and get the rolling_total is 69769. 
-- This show the month by month progession. In 2020 month 3 we had 9628 by the end of 2020 month 12 we had about 80998

-- let check the company how much they were laying off per year 

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- We are looking at the company by the year and how many people they laid_off
SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;














-- With the Company_Year we change the column. This is our CTE
WITH Company_Year (company, years, total_laid_off) AS 
(
			SELECT company, YEAR(`date`), SUM(total_laid_off)
			FROM layoffs_staging2
			GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS -- We create our first CTE than we gave it a rank and we want to filter on that rank 
(SELECT *,
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking -- we did this rank as another CTE. 
FROM Company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5;

-- THE FIRST CTE IS Company_Year AND THE SECOND CTE IS Company_Year_Rank. WE USE FIRST CTE TO MAKE SECOND CTE
-- We find the top 5 companies.




