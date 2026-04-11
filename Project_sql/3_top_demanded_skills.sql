/*
 WHAT ARE THE TOP DEMANDED skills FOR DATA ANALYST
*/



-- WITH SKILL_SETS AS
-- (SELECT 
--     DISTINCT SD.skills AS SKILLS, SD.skill_id
--     --STRING_AGG(SD.skills,',') AS SKILLS
--     FROM skills_dim SD
-- INNER JOIN skills_job_dim SJD ON SJD.skill_id = SD.skill_id
-- --GROUP BY SD.skill_id
-- ORDER BY SD.skill_id ASC
-- LIMIT 10)



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
GROUP BY SKILLS
ORDER BY DEMAND_COUNT DESC
LIMIT 10