/*
LINK REFERENCES: Add Missing Values - SQL Interview Query 8 | SQL Problem Level "MEDIUM"

https://www.youtube.com/watch?v=Xx09nRpwEtU&t=126s

PROBLEM STATEMENT: 
In the given input table, there are rows with missing JOB_ROLE values. Write a query to fill in those blank fields
with appropriate values. Assume row_id is always in sequence and job_role field is populated only for the first skill
Provide two difference solutions to the problem.


DATASET: 

drop table if exists job_skills;
create table job_skills
(
	row_id		int,
	job_role	varchar(20),
	skills		varchar(20)
);
insert into job_skills values (1, 'Data Engineer', 'SQL');
insert into job_skills values (2, null, 'Python');
insert into job_skills values (3, null, 'AWS');
insert into job_skills values (4, null, 'Snowflake');
insert into job_skills values (5, null, 'Apache Spark');
insert into job_skills values (6, 'Web Developer', 'Java');
insert into job_skills values (7, null, 'HTML');
insert into job_skills values (8, null, 'CSS');
insert into job_skills values (9, 'Data Scientist', 'Python');
insert into job_skills values (10, null, 'Machine Learning');
insert into job_skills values (11, null, 'Deep Learning');
insert into job_skills values (12, null, 'Tableau');
*/
 
-- SOLUTION 1: 
-- STEP 1: Using SUM() OVER() to get group 
-- STEP 2: Using MAX() to fill NULL values with max value in group (because with VALUE always > NULL)
WITH get_grp AS (
    SELECT *
        , SUM(CASE WHEN job_role IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY row_id) AS grp
    FROM job_skills
)
SELECT *
    , MAX(job_role) OVER(PARTITION BY grp) AS result
FROM get_grp;


-- SOLUTION 2: Using Recursive
WITH RecursiveCTE AS (
        -- First step: Select the first row as the base query
    SELECT row_id, job_role,skills
    FROM 
        job_skills
    WHERE 
        row_id = 1
    UNION ALL
    -- Recursive step: Select the next row and fill in the non-NULL value from the previous row
    SELECT 
        js.row_id,
        COALESCE(js.job_role, rcte.job_role) AS job_role,
        js.skills
    FROM 
        job_skills js
    JOIN 
        RecursiveCTE rcte ON js.row_id = rcte.row_id + 1
)
SELECT * FROM RecursiveCTE
ORDER BY row_id;
