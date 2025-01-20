SELECT *
FROM salaries
LIMIT 10;

SELECT COUNT(*)
FROM salaries;

-- перевірка на null в колонці
SELECT 
	COUNT(*) as all_cells
	, COUNT(*) - COUNT(salary_in_usd) as empty_salary
FROM salaries;

-- 10 найбільш популярних посад 
SELECT  
	job_title
	, COUNT(*)
FROM salaries
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

SELECT  
	job_title
	, exp_level
	, MIN(salary_in_usd)
	, MAX(salary_in_usd)
	, ROUND(AVG(salary_in_usd), 0) as avg
	, ROUND(stddev(salary_in_usd), 2)
FROM salaries
GROUP BY 1, 2;
-- LIMIT 10;

-- розбиття на категорії
SELECT 
	-- TRUNC(salary_in_usd, -1)
	CASE
		WHEN salary_in_usd <= 10000 THEN 'A'
		WHEN salary_in_usd <= 20000 THEN 'B'
		WHEN salary_in_usd <= 50000 THEN 'C'
		WHEN salary_in_usd <= 100000 THEN 'D'
		WHEN salary_in_usd <= 200000 THEN 'E'
		ELSE 'F' END as categories_salary
	, COUNT(*)
FROM salaries
GROUP BY 1;


-- corr - це функція, яка обчислює кореляцію Пірсона між двома числовими стовпцями:
SELECT 
	corr(remote_ratio, salary_in_usd)
FROM salaries; 
