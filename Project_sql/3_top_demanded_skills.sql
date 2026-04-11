/*
 WHAT ARE THE TOP DEMANDED SKILLS
*/



WITH SKILL_SETS AS
(SELECT 
    DISTINCT SD.skills AS SKILLS, SD.skill_id
    --STRING_AGG(SD.skills,',') AS SKILLS
    FROM skills_dim SD
INNER JOIN skills_job_dim SJD ON SJD.skill_id = SD.skill_id
--GROUP BY SD.skill_id
ORDER BY SD.skill_id ASC
LIMIT 10)

SELECT *
    FROM SKILL_SETS