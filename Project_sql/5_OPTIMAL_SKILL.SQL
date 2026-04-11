/*

WHATS THE OPTIMAL SKILL
FOCUS ON CTE ON TOP DEMANDED SKILLS & TOP SALARY QUERY
*/

/*

WHATS HAPPENIGN IN THE QUERY

/*
LOGIC EXPLANATION:

CTE 1 (DEMAND_SKILL) = Set A
→ Contains all skills related to Data Analyst roles along with how frequently they appear (demand count)

CTE 2 (AVERAGE_SALARY) = Set B
→ Contains only skills from Data Analyst roles where salary data is available, along with their average salary

FINAL STEP (INNER JOIN):
→ We take the intersection of Set A and Set B

IN SIMPLE TERMS:
→ Only skills that exist in BOTH datasets are returned
→ That means:
   - The skill must appear in job postings (from CTE 1)
   - AND must also have salary data available (from CTE 2)

FINAL OUTPUT:
→ Skills that are BOTH in demand AND have salary information
→ This helps identify relevant skills where we can compare demand vs compensation

FOR CALRITY:
CTE JOIN type -->	What goes into each set
Final INNER JOIN -->	What survives
*/

WITH DEMAND_SKILL AS
(SELECT 
    --JPF.job_title_short AS JOB_NAME,
    SD.skill_id,
    SD.skills AS SKILL,
    COUNT(SJD.job_id) AS DEMAND_COUNT
    --JPF.job_location AS JOB_LOCATION,
    --JPF.salary_year_avg AS SALARY
    FROM job_postings_fact JPF 
LEFT JOIN skills_job_dim SJD ON SJD.job_id = JPF.job_id
LEFT JOIN skills_dim SD on SD.skill_id = SJD.skill_id
WHERE JPF.job_title_short = 'Data Analyst'
GROUP BY SD.skill_id
ORDER BY DEMAND_COUNT DESC
), AVERAGE_SALARY AS
(SELECT 
    --COUNT(SJD.job_id) AS DEMAND_COUNT,
    SJD.skill_id,
    ROUND(AVG(JPF.salary_year_avg),0) AS SALARY,
    SD.skills AS SKILL
    FROM job_postings_fact JPF
LEFT JOIN skills_job_dim SJD ON SJD.job_id = JPF.job_id
LEFT JOIN skills_dim SD ON SD.skill_id = SJD.skill_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY SKILL,  SJD.skill_id
ORDER BY  SALARY DESC
)

SELECT 
    DEMAND_SKILL.skill_id,
    AVERAGE_SALARY.skill,
    DEMAND_COUNT,
    SALARY
FROM DEMAND_SKILL
INNER JOIN AVERAGE_SALARY ON DEMAND_SKILL.skill_id = AVERAGE_SALARY.skill_id -- THIS DEFINE WHAT SURIVEIVES FROM THOSE 2 CTE
--ORDER BY