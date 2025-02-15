/*
LINK REFERENCES: Segregate Data - SQL Interview Query 4 | SQL Problem Level "EASY"
https://www.youtube.com/watch?v=RjZFC6NVUMc


drop table if exists Q4_data;
create table Q4_data
(
	id			int,
	name		varchar(20),
	location	varchar(20)
);
insert into Q4_data values(1,null,null);
insert into Q4_data values(2,'David',null);
insert into Q4_data values(3,null,'London');
insert into Q4_data values(4,null,null);
insert into Q4_data values(5,'David',null);

select * from Q4_data;
*/

-- SOLUTION 1: Using MIN()
SELECT MIN(id) AS id, MIN(name) AS name, MIN(location) AS location
FROM Q4_data;

-- SOLUTION 2: Using MIN() and MAX()
SELECT MAX(id) AS id, MIN(name) AS name, MIN(location) AS location
FROM Q4_data;
