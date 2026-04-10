/*
What are top paying jobs for my role - job data analyst
Identifying the top 10 highest-paying data analyst roles that are avaiable remotely
Focuses on job postings with specified salaries (remove nulls)

*/

SELECT 
    job_title_short AS JOB_NAME,
    salary_year_avg AS SALARY
FROM job_postings_fact 
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = 'TRUE' AND salary_year_avg IS NOT NULL



