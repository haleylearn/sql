/*
LINK REFERENCES: Split Hierarchy - SQL Interview Query 12 | SQL Problem Level "HARD"
https://www.youtube.com/watch?v=KrUIQAcFptY


DROP TABLE IF EXISTS company;
CREATE TABLE company
(
	employee	varchar(10) primary key,
	manager		varchar(10)
);

INSERT INTO company values ('Elon', null);
INSERT INTO company values ('Ira', 'Elon');
INSERT INTO company values ('Bret', 'Elon');
INSERT INTO company values ('Earl', 'Elon');
INSERT INTO company values ('James', 'Ira');
INSERT INTO company values ('Drew', 'Ira');
INSERT INTO company values ('Mark', 'Bret');
INSERT INTO company values ('Phil', 'Mark');
INSERT INTO company values ('Jon', 'Mark');
INSERT INTO company values ('Omid', 'Earl');

SELECT * FROM company;

*/ 

WITH cte AS (
	SELECT manager, employee   
		, CONCAT('Team ', ROW_NUMBER() OVER(ORDER BY employee)) AS teams
	FROM company 
	WHERE manager = (SELECT employee FROM company WHERE manager IS NULL)
)
,cte2 AS (
	SELECT teams, manager, employee
	FROM cte
	UNION ALL
	SELECT cte2.teams
		,cte2.manager
		,c.employee AS employee
	FROM cte2
	INNER JOIN company c ON cte2.employee = c.manager
)
,cte3 AS (
	SELECT teams
		,manager
		,STRING_AGG(employee, ',') AS members
	FROM cte2
	GROUP BY teams,manager
)
SELECT 
    teams
	, manager + ',' + members AS team
FROM cte3
ORDER BY teams;
 