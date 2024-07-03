/*
LINK REFERENCES: Mountain Huts & Trails - SQL Interview Query 2 | SQL Problem Level "HARD" https://www.youtube.com/watch?v=rM1BVoBke04&t=83s

DESCRIPTION: A ski resort company is planning to construct a new ski slope using a pre-existing network of mountain huts and trails between them. 
A new slope has to begin at one of the mountain huts, have a middle station at another hut connected with the first one by a direct trail, 
and end at the third mountain hut which is also connected by a direct trail to the second hut. 
The altitude of the three huts chosen for constructing the ski slope has to be strictly decreasing.
*/
/*
DATASET:

drop table if exists mountain_huts;
create table mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;
create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);
*/

-- GENERAL COMMAND
SELECT * FROM mountain_huts;
SELECT * FROM trails;


-- SOLUTION:
WITH cte AS (
	SELECT t.hut1, t.hut2,
	CASE 
		WHEN m1.altitude > m2.altitude THEN m1.name ELSE m2.name
		END AS start_point,
	CASE 
		WHEN m1.altitude > m2.altitude THEN m2.name ELSE m1.name
		END AS middle_point,
	CASE 
		WHEN m1.altitude > m2.altitude THEN t.hut2 ELSE t.hut1
		END AS middle_point_id,
	CASE 
		WHEN m1.altitude > m2.altitude THEN m2.altitude ELSE m1.altitude
		END AS middle_point_altitude
	FROM trails t 
	JOIN mountain_huts m1
		ON t.hut1 = m1.id
	JOIN mountain_huts m2
		ON t.hut2 = m2.id
)
SELECT c1.start_point, c1.middle_point, c2.middle_point AS third_point
FROM cte c1 
JOIN cte c2
	ON (c1.middle_point_id = c2.hut1 OR c1.middle_point_id = c2.hut2) AND (c1.middle_point_altitude > c2.middle_point_altitude)
ORDER BY c1.start_point;