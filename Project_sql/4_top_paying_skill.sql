/*
WHAT ARE TOP SKILLS BASED ON SALARY
*/

SELECT 
    --COUNT(SJD.job_id) AS DEMAND_COUNT,
    ROUND(AVG(JPF.salary_year_avg),0) AS SALARY,
    SD.skills AS SKILL
    FROM job_postings_fact JPF
LEFT JOIN skills_job_dim SJD ON SJD.job_id = JPF.job_id
LEFT JOIN skills_dim SD ON SD.skill_id = SJD.skill_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY SKILL
ORDER BY  SALARY DESC
LIMIT 10