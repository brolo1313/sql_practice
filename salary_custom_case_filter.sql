SELECT 
	COUNT(*) AS cnt_all
	, COUNT(exp_level) AS cnt_lvl
	, COUNT(DISTINCT exp_level)
FROM salaries
	

LIMIT 10;


SELECT
	AVG(salary_in_usd) AS salary_avg
	, MIN(salary_in_usd) AS salary_min
	, MAX(salary_in_usd) AS salary_max
FROM salaries
WHERE 
	year = '2023'
LIMIT 10;

SELECT 
	year
	, salary_in_usd
	, salary_in_usd * 38 AS salary_in_uah
	-- 'SE' - senior
	-- 'ME' - Middle
	-- 'Other'
	,CASE
		WHEN exp_level = 'SE'
		THEN 'Senior'
		WHEN exp_level = 'MI'
		THEN 'Middle'
		ELSE 'Other' END AS full_level
FROM salaries
WHERE 
	year = '2020'
LIMIT 10;