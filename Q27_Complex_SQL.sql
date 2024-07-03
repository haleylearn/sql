/*
Solving a Complex SQL Interview Problem - 27 | #30DaySQLQueryChallenge
https://www.youtube.com/watch?v=kLSWP5zJAN8
*/

/*
PROBLEM STATEMENT: 
Given vacation_plans tables shows the vacations applied by each employee during the year 2024. 
Leave_balance table has the available leaves for each employee.
Write an SQL query to determine if the vacations applied by each employee can be approved or not based on the available leave balance. 
If an employee has enough available leaves then mention the status as "Approved" else mention "Insufficient Leave Balance".
Assume there are no public holidays during 2024. weekends (sat & sun) should be excluded while calculating vacation days. 
*/

/*DATASET:

drop table if exists vacation_plans;
create table vacation_plans
(
	id 			int primary key,
	emp_id		int,
	from_dt		date,
	to_dt		date
);
insert into vacation_plans values(1,1, '2024-02-12', '2024-02-16');
insert into vacation_plans values(2,2, '2024-02-20', '2024-02-29');
insert into vacation_plans values(3,3, '2024-03-01', '2024-03-31');
insert into vacation_plans values(4,1, '2024-04-11', '2024-04-23');
insert into vacation_plans values(5,4, '2024-06-01', '2024-06-30');
insert into vacation_plans values(6,3, '2024-07-05', '2024-07-15');
insert into vacation_plans values(7,3, '2024-08-28', '2024-09-15');


drop table if exists leave_balance;
create table leave_balance
(
	emp_id			int,
	balance			int
);
insert into leave_balance values (1, 12);
insert into leave_balance values (2, 10);
insert into leave_balance values (3, 26);
insert into leave_balance values (4, 20);
insert into leave_balance values (5, 14);

select * from vacation_plans;
select * from leave_balance;
*/

/*
NOTE GENERATE_SERIES FOR DATE CAN NOT USE NORMAL IN SQL SEVER
TRY STH LIKE THIS

SELECT DATEADD(DAY,value,'2022-01-01')
FROM GENERATE_SERIES(0,4,1);

SELECT DATEADD(day, value, '2022-01-01') AS Date
FROM GENERATE_SERIES(0, DATEDIFF(day, '2022-01-01', '2022-01-10'))

*/


WITH DateSeries AS (
    SELECT id, emp_id, from_dt, to_dt, from_dt AS DateValue
    FROM vacation_plans
    UNION ALL
    SELECT ds.id, ds.emp_id, ds.from_dt, ds.to_dt, DATEADD(DAY, 1, ds.DateValue)
    FROM DateSeries ds
    WHERE DATEADD(DAY, 1, ds.DateValue) <= ds.to_dt
)
, check_holiday AS (
    SELECT id, emp_id, to_dt, from_dt
        , CASE WHEN DATENAME(WEEKDAY, DateValue) IN ('Saturday', 'Sunday') THEN 'YES' ELSE 'NO' END AS holiday
    FROM DateSeries
)
, cnt_request AS (
    SELECT id, emp_id, to_dt, from_dt, COUNT(id) AS vacation_days
    FROM check_holiday c
    WHERE holiday NOT LIKE 'YES'
    GROUP BY id, emp_id, to_dt, from_dt
)
SELECT id, c.emp_id, to_dt, from_dt
    , vacation_days
    , CASE 
        WHEN c.vacation_days <= l.balance THEN 'Approved' 
        WHEN c.vacation_days IS NULL THEN 'Insufficient Leave Balance' 
        ELSE 'Insufficient Leave Balance' 
    END AS 'STATUS'
FROM cnt_request c 
LEFT JOIN leave_balance l 
    ON c.id = l.emp_id;





 