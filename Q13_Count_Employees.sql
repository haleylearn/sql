/*
LINK REFERENCES: Count Employees - SQL Interview Query 13 | SQL Problem Level "EASY"
https://www.youtube.com/watch?v=78DNY36XxQw


drop table if exists employee_managers;
create table employee_managers
(
	id			int,
	name		varchar(20),
	manager 	int
);
insert into employee_managers values (1, 'Sundar', null);
insert into employee_managers values (2, 'Kent', 1);
insert into employee_managers values (3, 'Ruth', 1);
insert into employee_managers values (4, 'Alison', 1);
insert into employee_managers values (5, 'Clay', 2);
insert into employee_managers values (6, 'Ana', 2);
insert into employee_managers values (7, 'Philipp', 3);
insert into employee_managers values (8, 'Prabhakar', 4);
insert into employee_managers values (9, 'Hiroshi', 4);
insert into employee_managers values (10, 'Jeff', 4);
insert into employee_managers values (11, 'Thomas', 1);
insert into employee_managers values (12, 'John', 15);
insert into employee_managers values (13, 'Susan', 15);
insert into employee_managers values (14, 'Lorraine', 15);
insert into employee_managers values (15, 'Larry', 1);

select * from employee_managers;

-- Find out the no of employees managed by each manager.
*/

WITH cnt_by_manager AS (
    SELECT manager AS managerId, COUNT(manager) AS No_Of_Emp
    FROM employee_managers
    WHERE manager IS NOT NULL
    GROUP BY manager
)
SELECT x.name, No_Of_Emp
FROM cnt_by_manager c
JOIN (SELECT DISTINCT id, name FROM employee_managers) AS x
    ON c.managerId = x.id;


 