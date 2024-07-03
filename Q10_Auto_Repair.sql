/*
LINK REFERENCES: Auto Repair - SQL Interview Query 10 | SQL Problem Level "HARD"
https://www.youtube.com/watch?v=oU8fhP17ozk

drop table if exists auto_repair;
create table auto_repair
(
	client			varchar(20),
	auto			varchar(20),
	repair_date		int,
	indicator		varchar(20),
	value			varchar(20)
);
insert into auto_repair values('c1','a1',2022,'level','good');
insert into auto_repair values('c1','a1',2022,'velocity','90');
insert into auto_repair values('c1','a1',2023,'level','regular');
insert into auto_repair values('c1','a1',2023,'velocity','80');
insert into auto_repair values('c1','a1',2024,'level','wrong');
insert into auto_repair values('c1','a1',2024,'velocity','70');
insert into auto_repair values('c2','a1',2022,'level','good');
insert into auto_repair values('c2','a1',2022,'velocity','90');
insert into auto_repair values('c2','a1',2023,'level','wrong');
insert into auto_repair values('c2','a1',2023,'velocity','50');
insert into auto_repair values('c2','a2',2024,'level','good');
insert into auto_repair values('c2','a2',2024,'velocity','80');

select * from auto_repair;

*/
-- SOLUTION 1: Using GROUPBY, MAX(), SUM()
SELECT velocity
	, SUM(CASE WHEN [level] = 'good' THEN 1 ELSE 0 END) AS 'good'
	, SUM(CASE WHEN [level] = 'wrong' THEN 1 ELSE 0 END ) AS 'wrong'  
	, SUM(CASE WHEN [level] = 'regular' THEN 1 ELSE 0 END ) AS 'regular' 
FROM 
(
	SELECT client, auto, repair_date
		, MAX(CASE WHEN indicator = 'level' THEN value END) AS level
		, MAX(CASE WHEN indicator = 'velocity' THEN value END) AS velocity
	FROM auto_repair
	GROUP BY client, auto, repair_date
) subquery
GROUP BY velocity;



-- SOLUTION 2: Using INNER JOIN and SUM(CASE WHEN), GROUPBY
SELECT v.[value]
	, SUM(CASE WHEN l.[value] = 'good' THEN 1 ELSE 0 END) AS 'good'
	, SUM(CASE WHEN l.[value] = 'wrong' THEN 1 ELSE 0 END) AS 'wrong'
	, SUM(CASE WHEN l.[value] = 'regular' THEN 1 ELSE 0 END) AS 'regular'
FROM auto_repair l 
JOIN auto_repair v 
	ON l.client = v.client AND l.[auto] = v.[auto] AND l.repair_date = v.repair_date
WHERE l.indicator = 'level' AND v.indicator = 'velocity'
GROUP BY v.[value];


-- SOLUTION 3: Using ROW_NUMBER
WITH row_number_w_level AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY client) AS row_number 
		, value
	FROM auto_repair
	WHERE indicator = 'level'
)
, row_number_w_value AS (
	SELECT 
		ROW_NUMBER() OVER(ORDER BY client) AS row_number 
		, value
	FROM auto_repair
	WHERE indicator = 'velocity'
)

SELECT 
	v.[value]
	, COUNT(CASE WHEN l.value = 'good' THEN 1 END) AS 'good'
	, COUNT(CASE WHEN l.value = 'wrong' THEN 1 END) AS 'wrong'
	, COUNT(CASE WHEN l.value = 'regular' THEN 1 END) AS 'regular'
FROM row_number_w_level l
JOIN row_number_w_value v
	ON l.row_number = v.row_number
GROUP BY v.[value];


-- SOLUTION 4: Using LEAD(), ROW_NUMBER(), COUNT()
SELECT value_lead
	, COUNT(CASE WHEN value = 'good' THEN 1 END) AS 'good'
	, COUNT(CASE WHEN value = 'wrong' THEN 1 END) AS 'wrong'
	, COUNT(CASE WHEN value = 'regular' THEN 1 END) AS 'regular'
FROM
(
	SELECT *
		, LEAD(value) OVER(PARTITION BY client, auto, repair_date ORDER BY client) AS value_lead
		, ROW_NUMBER() OVER( PARTITION BY client, auto, repair_date ORDER BY client) AS rn
	FROM auto_repair
) x
WHERE rn = 1
GROUP BY value_lead;
