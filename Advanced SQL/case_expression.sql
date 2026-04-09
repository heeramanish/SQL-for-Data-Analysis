
/*
The CASE expression goes through the conditions and stops at the first match (like an if-then-else statement). 
So, once a condition is true, it will stop processing and return the result. If no conditions are true, it returns the value in the ELSE clause. If there is no ELSE clause and no conditions are true, it returns NULL.
CASE Syntax
CASE
  WHEN condition1 THEN result1
  WHEN condition2 THEN result2
  WHEN conditionN THEN resultN
  ELSE default_result
END;

*/

SELECT 
    job_title_short AS JOB_TITLE,
    salary_year_avg AS YEARLY_SALARY,
CASE
    WHEN salary_year_avg BETWEEN 80000 AND 90000 THEN 'OKAY SALARY'
    WHEN salary_year_avg > 90000 THEN 'GOOD SALARY'
    ELSE 'WASTE SALARY'
END AS SALARY_CATEGORY --THIS IS THE COLUMN NAME THE OUTPUT OF CASE GOES UNDER THIS
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
--GROUP BY SALARY_CATEGORY
LIMIT 100;

select * from job_postings_fact
limit 10;

SELECT * FROM company_dim
LIMIT 10;

-- LIST OF COMPANIES THAT ARE OFFERING JOBS THAT DONT HAVE ANY REWUIREMNT FOR DEGREE
-- CAN BE DONE VIA JOINT 
SELECT
    CD.NAME AS EMPLOYER,
    JP.job_title_short AS JOB_TITLE,
    JP.job_no_degree_mention AS DEGREE_YN
FROM job_postings_fact JP 
LEFT JOIN company_dim CD ON CD.company_id = JP.company_id
WHERE JP.job_no_degree_mention IS TRUE
LIMIT 100;

-- FINDING ANSWER USING SUBQUERY, MATCHING ON COMMON PK-FK REALTIONS

SELECT NAME AS COMPANIES
FROM company_dim
WHERE company_id IN (SELECT company_id 
    FROM job_postings_fact
    WHERE job_no_degree_mention IS TRUE
    ORDER BY job_id)
LIMIT 100



-- CTE SQL
/*
Find the companies that have the most job openings
- Get the total numbre of jobs postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

WITH company_names
SELECT 
    company_id,
    COUNT(*)
    FROM job_postings_fact
GROUP BY company_id

SELECT


SELECT
    *
FROM skills_job_dim 
LIMIT 100

/*
top 5 skills order by most jobs
*/
select skills, count(*) as skill_count
from skills_dim
where skill_id in (
        select skill_id
        from skills_job_dim
    )
GROUP BY skills 
ORDER BY skill_count desc
LIMIT 5


/*
find the number of job possting
*/

SELECT
    COUNT(*)
FROM

SELECT 
    job_title_short as job_title 
FROM job_postings_fact
WHERE job_work_from_home = 'TRUE';