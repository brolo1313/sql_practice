SELECT
	*
FROM
	SALARIES
WHERE
	EXP_LEVEL = 'MI'
	AND EXP_LEVEL != 'MI'
	OR EXP_LEVEL != 'MI'
LIMIT
	10;

SELECT DISTINCT
	YEAR
FROM
	SALARIES
WHERE
	YEAR BETWEEN 2020 AND 2023
LIMIT
	10;

SELECT DISTINCT
	JOB_TITLE
FROM
	SALARIES
WHERE
	1 = 1
	AND JOB_TITLE ILIKE ('data_%')
LIMIT
	10;

SELECT
	*
FROM
	SALARIES
WHERE
	1 = 1
	-- AND year is not NUll
	-- AND job_title iLIKE ('data_%')
LIMIT
	10;

--PRACTICE
/*
Для кожної професії та відповідного рівня досвіду навести:

- кількість в таблиці
- середню заробітну плату
*/
SELECT
	JOB_TITLE,
	EXP_LEVEL,
	COUNT(*) AS JOBS_NUM,
	ROUND(AVG(SALARY_IN_USD), 0) AS AVG_SALARY_USD,
	ROUND(AVG(SALARY_IN_USD * 43), 0) AS AVG_SALARY_UAH
FROM
	SALARIES
WHERE
	YEAR = 2023
GROUP BY
	JOB_TITLE,
	EXP_LEVEL
ORDER BY
	1,
	2 DESC;

/*
Для професії що зустрічаються лише 1 раз, навести заробітну плату
*/
SELECT
	JOB_TITLE,
	COUNT(*) AS JOBS_NUM,
	ROUND(AVG(SALARY_IN_USD), 0) AS AVG_SALARY_USD,
	ROUND(AVG(SALARY_IN_USD * 43), 0) AS AVG_SALARY_UAH
FROM
	SALARIES
WHERE
	YEAR = 2023
GROUP BY
	JOB_TITLE
HAVING
	COUNT(*) = 1
	AND ROUND(AVG(SALARY_IN_USD), 0) > 50000
ORDER BY
	2 ASC;

/*
Вивести всіх спеціалістів, в яких зп вище середньої в таблиці 
*/
SELECT
	*
FROM
	SALARIES
WHERE
	SALARY_IN_USD >= (
		SELECT
			ROUND(AVG(SALARY_IN_USD), 0)
		FROM
			SALARIES
		WHERE
			YEAR = 2023
	)
	AND YEAR = 2023
LIMIT
	10;

/*
Вивести всіх спеціалістів pf 2022, які живуть в країнах , де середня зп вища за середню серед усіх країн 
*/
--1. Пошук середньої зп
--2. По кожній країні - середня зп
--3. Порівнюємо, виводимо перелік країн
--4. Спеціалісти, що проживають в цих країнах
--1.
SELECT
	ROUND(AVG(SALARY_IN_USD), 0)
FROM
	SALARIES;

-- 2/3.
SELECT
	COMPANY_LOCATION
FROM
	SALARIES
WHERE
	YEAR = 2022
GROUP BY
	1
HAVING
	ROUND(AVG(SALARY_IN_USD), 0) > (
		SELECT
			ROUND(AVG(SALARY_IN_USD), 0)
		FROM
			SALARIES
		WHERE
			YEAR = 2022
	);

--4. 
SELECT
	*
FROM
	SALARIES
WHERE
	EMP_LOCATION IN (
		SELECT
			COMPANY_LOCATION
		FROM
			SALARIES
		WHERE
			YEAR = 2022
		GROUP BY
			1
		HAVING
			ROUND(AVG(SALARY_IN_USD), 0) > (
				SELECT
					ROUND(AVG(SALARY_IN_USD), 0)
				FROM
					SALARIES
				WHERE
					YEAR = 2022
			)
	)
	AND YEAR = 2022
LIMIT
	10;

/*
Знайти мінімальну зп, серед максимальних зп по країнах за 2022/23
*/
--1. Максимальна зп серед країн
--2. Мінімальна зп серед максимальних
--1
SELECT
	COMPANY_LOCATION,
	MAX(SALARY_IN_USD)
FROM
	SALARIES
WHERE
	YEAR = 2023
GROUP BY
	1;

-- 2.
SELECT
	MIN(MIN_COMPANY.SALARY_IN_USD) AS MIN_SALARY_IN_MAX_COMPANIES_SALARY
FROM
	(
		SELECT
			COMPANY_LOCATION,
			MAX(SALARY_IN_USD) AS SALARY_IN_USD
		FROM
			SALARIES
		WHERE
			YEAR = 2023
		GROUP BY
			1
	) AS MIN_COMPANY;

-- OR
SELECT
	COMPANY_LOCATION,
	MAX(SALARY_IN_USD) AS MIN_SALARY_IN_MAX_COMPANIES_SALARY
FROM
	SALARIES
WHERE
	YEAR = 2022
GROUP BY
	1
ORDER BY
	2 ASC
LIMIT
	1;

--3 Додатково вивести країну мінімальної зп з максимальних  зп
SELECT
	MAX_COMPANY.COMPANY_LOCATION,
	MAX_COMPANY.SALARY_IN_USD AS MIN_SALARY_IN_COMPANY_LOCATION
FROM
	(
		SELECT
			COMPANY_LOCATION,
			MAX(SALARY_IN_USD) AS SALARY_IN_USD
		FROM
			SALARIES
		WHERE
			YEAR = 2023
		GROUP BY
			COMPANY_LOCATION
	) AS MAX_COMPANY
WHERE
	MAX_COMPANY.SALARY_IN_USD = (
		SELECT
			MIN(SALARY_IN_USD)
		FROM
			(
				SELECT
					MAX(SALARY_IN_USD) AS SALARY_IN_USD
				FROM
					SALARIES
				WHERE
					YEAR = 2023
				GROUP BY
					COMPANY_LOCATION
			) AS SUBQUERY
	);

/*
По кожній професії вивести різницю між середньою зп та максимальною зп усіх спецуіалістів
*/
-- average salary
SELECT
	JOB_TITLE,
	ROUND(AVG(SALARY_IN_USD), 0) AS AVG_SALARY_USD
FROM
	SALARIES
GROUP BY
	1;

-- max salary
SELECT
	JOB_TITLE,
	ROUND(MAX(SALARY_IN_USD), 0) AS MAX_SALARY_USD
FROM
	SALARIES
GROUP BY
	1
ORDER BY
	2 DESC;

-- SELECT MAX(SALARY_IN_USD)
-- FROM salaries
SELECT
	AVG_SALARY.JOB_TITLE,
	AVG_SALARY.SALARY_IN_USD - (
		SELECT
			MAX(SALARY_IN_USD)
		FROM
			SALARIES
	) AS MAX_DIFF_AVG
FROM
	(
		SELECT
			JOB_TITLE,
			ROUND(AVG(SALARY_IN_USD), 0) AS SALARY_IN_USD
		FROM
			SALARIES
		GROUP BY
			JOB_TITLE
	) AS AVG_SALARY;

-- or without inner SELECT in FROM
SELECT
	JOB_TITLE,
	ROUND(AVG(SALARY_IN_USD), 0) - (
		SELECT
			MAX(SALARY_IN_USD)
		FROM
			SALARIES
	) AS MAX_DIFF_AVG
FROM
	SALARIES
GROUP BY
	1;

/*
Вивести данні по співробітнику, який отримує другу по розміру зп в таблиці
*/
SELECT
	*
FROM
	SALARIES
ORDER BY
	SALARY_IN_USD DESC
LIMIT
	1
OFFSET
	1;

-- or
SELECT
	*
FROM
	(
		SELECT
			*
		FROM
			SALARIES
		ORDER BY
			SALARY_IN_USD DESC
		LIMIT
			1
		OFFSET
			1
	) AS MAX_SALARY
ORDER BY
	MAX_SALARY.SALARY_IN_USD
LIMIT
	1;