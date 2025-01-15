SELECT 
	year
	, exp_level AS level
	, emp_type  AS type
FROM salaries
WHERE 
	year != 2022
	AND exp_level ='SE'

ORDER BY year ASC

LIMIT 20;

SELECT 
	year
	, job_title
	, salary_in_usd
FROM salaries
WHERE 
	year = 2023
	AND job_title = 'Data Scientist'
ORDER BY salary_in_usd DESC
LIMIT 5;
