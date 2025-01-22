select job_title, round(avg(salary_in_usd)) as avg_salary
from salaries s
group by
    1

--OR

-- window functions
with
    cte as (
select
	job_title,
	salary_in_usd,
	avg(salary_in_usd) over (
                partition by
                    job_title
            ) as avg_salary,
	min(salary_in_usd) over (
                partition by
                    job_title
            ) as min_salary,
	max(salary_in_usd) over (
                partition by
                    job_title
            ) as max_salary,
	count(salary_in_usd) over (
                partition by
                    job_title
            ) as job_count,
	sum(salary_in_usd) over (
                partition by
                    job_title
order by
	salary_in_usd
            ) as sum_salary
from
	salaries s
where
	year = 2023
    )

select
	*
	 ,
	salary_in_usd::float / max_salary as ratio_max -- CAST
	,
	salary_in_usd / avg_salary as ratio_avg
from
	cte;