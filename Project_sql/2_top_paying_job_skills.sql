
WITH highest_paying_jobs AS
(SELECT 
    job_id,
    job_title_short AS JOB_NAME,
    CD.NAME AS EMPLOYER,
    salary_year_avg AS SALARY
    --job_schedule_type,
    --job_posted_date::DATE AS JOB_POST_DATE -- FETCHING ONLY DATES WITHOUT TIMESTAMP
FROM job_postings_fact JPF   
LEFT JOIN company_dim CD ON CD.company_id = JPF.company_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = 'TRUE' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10)

SELECT
    highest_paying_jobs.job_id,
    highest_paying_jobs.EMPLOYER,
    highest_paying_jobs.JOB_NAME,
    highest_paying_jobs.SALARY, 
    STRING_AGG(SD.skills, ', ') AS SKILLS
    --SD.skills as Skill_name
FROM highest_paying_jobs
LEFT JOIN skills_job_dim SJD ON SJD.job_id = highest_paying_jobs.job_id
LEFT JOIN skills_dim SD on SD.skill_id = SJD.skill_id
--WHERE skills IS NOT NULL
GROUP BY JOB_NAME, SALARY, EMPLOYER,highest_paying_jobs.job_id
ORDER BY highest_paying_jobs.SALARY DESC
--