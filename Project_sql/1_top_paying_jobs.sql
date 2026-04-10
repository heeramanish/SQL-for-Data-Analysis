/*
What are top paying jobs for my role - job data analyst
Identifying the top 10 highest-paying data analyst roles that are avaiable remotely
Focuses on job postings with specified salaries (remove nulls)

*/

SELECT 
    job_title_short AS JOB_NAME,
    CD.NAME AS EMPLOYER,
    salary_year_avg AS SALARY,
    job_schedule_type,
    job_posted_date::DATE AS JOB_POST_DATE -- FETCHING ONLY DATES WITHOUT TIMESTAMP
FROM job_postings_fact JPF   
LEFT JOIN company_dim CD ON CD.company_id = JPF.company_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = 'TRUE' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;



