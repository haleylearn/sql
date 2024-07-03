/*
LINK REFERENCES: Salary Report Generator - SQL Interview Query 5 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=DKYg8JahHI0


DATASET:

drop table if exists salary;
create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);


drop table if exists income;
create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);


drop table if exists deduction;
create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


drop table if exists emp_transaction;
create table emp_transaction
(
	emp_id		int,
	emp_name	varchar(50),
	trns_type	varchar(20),
	amount		numeric
);
insert into emp_transaction
select s.emp_id, s.emp_name, x.trns_type
, case when x.trns_type = 'Basic' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Allowance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Others' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Insurance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Health' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'House' then round(base_salary * (cast(x.percentage as decimal)/100),2) end as amount	   
from salary s
cross join (select income as trns_type, percentage from income
			union
			select deduction as trns_type, percentage from deduction) x;


-- SOLUTION 2: Instead of case when above
SELECT salary.emp_id   AS Emp_id,
       salary.emp_name AS Emp_name,
       trns_type,
       base_salary * percentage / 100
FROM   salary
CROSS JOIN (SELECT  id,
					income AS trns_type,
					percentage
			FROM	income i
			UNION
			SELECT  id,
					deduction AS trns_type,
					percentage
			FROM   deduction) x;

PROBLEM STATEMENT: Using the given Salary, Incom and Deduction tables, 
first write an sql query to populate the Emp_Transaction table as shown below and then generate a salary report as shown.
*/

-- GENERAL COMMAND 
SELECT * FROM salary;
SELECT * FROM income;
SELECT * FROM deduction;
SELECT * FROM emp_transaction; 

-- SOLUTION 1: Using PIVOT
SELECT [Basic], [Allowance], [Others]
	, Basic + Allowance + Others AS Gross
	,[Insurance], [Health], [House]
	,[Insurance] + [Health] + [House] AS Total_Deduction
FROM (
	SELECT emp_id, emp_name, trns_type, amount
	FROM emp_transaction 
) AS SourceTable
PIVOT
(
	MAX(amount)
	FOR trns_type IN ([Basic], [Allowance], [Others], [Insurance], [Health], [House])
) AS pivot_table
WHERE Allowance IS NOT NULL AND Basic IS NOT NULL;


-- SOLUTION 2: Using MAX(), GROUP BY and CTE
WITH cte AS (
	SELECT emp_name, 
		MAX(CASE WHEN trns_type = 'Basic' THEN amount END) AS Basic,
		MAX(CASE WHEN trns_type = 'Allowance' THEN amount END) AS Allowance,
		MAX(CASE WHEN trns_type = 'Others' THEN amount END) AS Others,
		MAX(CASE WHEN trns_type = 'Insurance' THEN amount END) AS Insurance,
		MAX(CASE WHEN trns_type = 'Health' THEN amount END) AS Health,
		MAX(CASE WHEN trns_type = 'House' THEN amount END) AS House
	FROM emp_transaction
	GROUP BY emp_name
)

SELECT emp_name,
	Basic, Allowance, Others,
	Basic + Allowance + Others  AS Gross,
	Insurance, Health, House,
	Insurance + Health + House AS Total_Deduction
FROM cte;


-- SOLUTION 3: Using CROSS APPLY
SELECT emp_name, 
		MAX(CASE WHEN trns_type = 'Basic' THEN amount END) AS Basic,
		MAX(CASE WHEN trns_type = 'Allowance' THEN amount END) AS Allowance,
		MAX(CASE WHEN trns_type = 'Others' THEN amount END) AS Others,
		MAX(CASE WHEN trns_type = 'Insurance' THEN amount END) AS Insurance,
		MAX(CASE WHEN trns_type = 'Health' THEN amount END) AS Health,
		MAX(CASE WHEN trns_type = 'House' THEN amount END) AS House
FROM emp_transaction
CROSS APPLY 
	(
		SELECT emp_name AS name
		FROM emp_transaction
	) x
GROUP BY emp_name;


-- SOLUTION 4: DYNAMIC SQL
-- STEP 1: Generate column list dynamically
DECLARE @cols NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

SELECT @cols = STRING_AGG(QUOTENAME(trns_type), (',')) 
FROM (SELECT DISTINCT trns_type FROM emp_transaction) x;
PRINT @cols;
/* HOW TO CHECK RESULT OF VARIABLES
PRINT @cols; -- SOTLUTION 1: Using PRINT
SELECT @cols AS Columns; -- SOTLUTION 2: Using SELECT
*/
-- STEP 2: Build the dynamic SQL query
SET @sql = N' SELECT emp_name, ' + @cols + 
	N' FROM (
		SELECT emp_id, emp_name, trns_type, amount
		FROM emp_transaction 
	) AS SourceTable
	PIVOT
	(
		MAX(amount)
		FOR trns_type IN (' + @cols + N')
	) AS pivot_table ';

/* HOW TO CHECK COMMAND RIGHT OR NOT: 
	SOLUTION 1: PRINT @sql;
	SOLUTION 2: SELECT @sql AS GeneratedSQL;
*/
-- Execute the dynamic SQL query
EXEC sp_executesql @sql;

