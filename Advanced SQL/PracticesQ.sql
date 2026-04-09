/*
USE CTE TO SOLVE

FIND THE COUNT OF THE NUMBER OF REMOTE JOB POSTINGS PER SKILL
    - DISPLAY THE TOP 5 SKILLS BY THEIR DEMAND IN REMOTE JOBS
    - INCLUDE SKILL ID, NAME AND COUNT OF POSTINGS REQUIRING THE SKILL
*/

-- FOLLOWING ARE THE REMOTE JOB COUNT ORDERED BY JOB NAM
--

SELECT
    job_title_short AS JOB_NAME,
    COUNT(*) AS JOB_COUNT
FROM job_postings_fact
WHERE job_work_from_home = 'TRUE'
GROUP BY JOB_NAME
ORDER BY JOB_COUNT ASC

---- ********

WITH REMOTE_JOB_SKILLS AS (
    SELECT 
    SJD.skill_id,
    --JPF.job_title_short AS JOB_NAME,
    COUNT(*) AS SKILL_COUNT
    FROM skills_job_dim SJD
INNER JOIN job_postings_fact JPF ON JPF.job_id = SJD.job_id 
WHERE job_work_from_home = 'TRUE'
GROUP BY skill_id
)

SELECT 
    SKILLS.skill_id,
    SKILLS.SKILLS AS SKILLS_NAME,
    SKILL_COUNT
    FROM REMOTE_JOB_SKILLS
INNER JOIN skills_dim AS SKILLS ON SKILLS.skill_id = REMOTE_JOB_SKILLS.skill_id

---************


/*
FIND JOB POSTING FORM THE FIRST QUARTER THAT HAVE A SALARY GREATER THAN 70K
- COMBINE JOB POSTING TABLES FROM THE FIRST QUATER OF 2023 (JAN-MAR)
- GETS JOB POSTINGS WITH AN AVERAGE YEARLY SLALARY > 70K
*/

SELECT
    job_title_short AS JOB_NAME,
    EXTRACT(MONTH FROM job_posted_date) AS MONTH_OF_POSTING
FROM job_postings_fact
WHERE (salary_year_avg > 70000) AND (EXTRACT(MONTH FROM job_posted_date)<= 3)

-- UNION

SELECT 
    job_title_short AS JOB_NAME
    FROM january_jobs
WHERE (salary_year_avg > 70000)
UNION ALL
SELECT 
    job_title_short AS JOB_NAME
    FROM february_jobs
WHERE (salary_year_avg > 70000)
UNION ALL
SELECT 
    job_title_short AS JOB_NAME
    FROM march_jobs
WHERE (salary_year_avg > 70000) 

-- ABOVE CAN BE MADE MORE COMPREHENSIVE BETTER SQL


SELECT 
    QUATERLY_JOBS.job_title_short AS JOB_NAME,
    QUATERLY_JOBS.job_posted_date::DATE AS JOB_POST_DATE,
    QUATERLY_JOBS.salary_year_avg AS SALARY
FROM
(SELECT 
    *
    FROM january_jobs
UNION ALL
SELECT 
    *
    FROM february_jobs
UNION ALL
SELECT 
    *
    FROM march_jobs
    ) AS QUATERLY_JOBS
WHERE (salary_year_avg > 70000) 
ORDER BY SALARY desc
