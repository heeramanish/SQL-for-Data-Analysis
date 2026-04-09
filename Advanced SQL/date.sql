SELECT 
    job_title_short AS TITLE,
    job_location AS LOCATION,
    job_posted_date::DATE AS DATE --::DATE = TO ONLY SEE DATE , WITHOTU TIMESTAMP
FROM job_postings_fact
LIMIT 100;

/*
EXTRACT 
Extract - gets field (eg., year, month, day) from a date/time value

SELECT 
EXTRACT(MONTH FROM column_name) AS column_month
FROM
    table_name
*/

SELECT 
    job_title_short AS TITLE,
    job_location AS LOCATION,
    job_posted_date::DATE AS DATE, --::DATE = TO ONLY SEE DATE , WITHOTU TIMESTAMP
    EXTRACT(MONTH from job_posted_date) AS month_job
FROM job_postings_fact
LIMIT 10;

--Q
--Write a query to find the avg salary both yearly and hourly for job postings
-- that were posted after Hun 1, 2023, Group the result by job schedule type

SELECT
    job_schedule_type,
    salary_year_avg,
    salary_hour_avg
FROM job_postings_fact
WHERE job_posted_date > '2023-06-1'
GROUP BY job_schedule_type


-- following will create tables named january_jobs, feb_jobs etc..
-- based on the month setting in the where clause

CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1; -- =1 MEANS JAN MONTH 

CREATE TABLE february_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


select * from january_jobs
limit 100;
