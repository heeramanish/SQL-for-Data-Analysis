#  Introduction
Dive into the data job market, focusing on data analyst roles, ths project explores top-paying jobs, in-demand skills, and where high demand meets high salry in data analytics
SQL queries [Project_sql folder](/Project_sql/)
# Background
This project analyzes job postings to identify high-paying roles and the most in-demand skills.
Key questions explored:

- What are the top-paying data analyst roles?
- Which skills are required for these roles?
- What skills are most in demand?
- Which skills are linked to higher salaries?
- What are the most optimal skills to learn (balancing demand and pay)?
# Tools I Used
- **SQL:** used for querying the database
- **PostgresSQL:** The chosen DBMS
- **VSCode:** for database management and running SQL queries
- **Git & GitHub:** Essential for versions control and sharing, collaboratoin and to track work progress
# The Analysis
### 1. Top paying Data Analyst Jobs
```
SELECT 
    job_title_short AS JOB_NAME,
    CD.NAME AS EMPLOYER,
    salary_year_avg AS SALARY,
    job_schedule_type,
    job_posted_date::DATE AS JOB_POST_DATE 
FROM 
    job_postings_fact JPF   
LEFT JOIN company_dim CD ON CD.company_id = JPF.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_work_from_home = 'TRUE' AND 
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```
 ### 2. Skills for Top Paying Jobs
 ```
 WITH highest_paying_jobs AS
(SELECT 
    job_id,
    job_title_short AS JOB_NAME,
    CD.NAME AS EMPLOYER,
    salary_year_avg AS SALARY
    --job_schedule_type,
    --job_posted_date::DATE AS JOB_POST_DATE -- FETCHING ONLY DATES WITHOUT TIMESTAMP
FROM 
    job_postings_fact JPF   
LEFT JOIN company_dim CD ON CD.company_id = JPF.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_work_from_home = 'TRUE' AND 
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
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
GROUP BY 
    JOB_NAME, SALARY, EMPLOYER,highest_paying_jobs.job_id
ORDER BY 
    highest_paying_jobs.SALARY DESC
```
### 3. In-Demand Skills for Data Analysts
```
SELECT 
    --JPF.job_title_short AS JOB_NAME,
    SD.skills AS SKILLS,
    COUNT(SJD.job_id) AS DEMAND_COUNT
    --JPF.job_location AS JOB_LOCATION,
    --JPF.salary_year_avg AS SALARY
    FROM job_postings_fact JPF 
LEFT JOIN skills_job_dim SJD ON SJD.job_id = JPF.job_id
LEFT JOIN skills_dim SD on SD.skill_id = SJD.skill_id
WHERE JPF.job_title_short = 'Data Analyst'
GROUP BY 
    SKILLS
ORDER BY 
    DEMAND_COUNT DESC
LIMIT 10
```
Rest of the queries can be explored here in this project folder: [project_sql](/Project_sql/)