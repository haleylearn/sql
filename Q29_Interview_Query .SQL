/*
Solving an INTERMEDIATE SQL Interview Query - 29 | #30DaySQLQueryChallenge
https://www.youtube.com/watch?v=cdTzo1eZZ50
*/

/*
PROBLEM STATEMENT: Given table provides login and logoff details of one user.
Generate a report to reqpresent the different periods (in mins) when user was logged in.


drop table if exists login_details;
create table login_details
(
	times	time,
	status	varchar(3)
);
insert into login_details values('10:00:00', 'on');
insert into login_details values('10:01:00', 'on');
insert into login_details values('10:02:00', 'on');
insert into login_details values('10:03:00', 'off');
insert into login_details values('10:04:00', 'on');
insert into login_details values('10:05:00', 'on');
insert into login_details values('10:06:00', 'off');
insert into login_details values('10:07:00', 'off');
insert into login_details values('10:08:00', 'off');
insert into login_details values('10:09:00', 'on');
insert into login_details values('10:10:00', 'on');
insert into login_details values('10:11:00', 'on');
insert into login_details values('10:12:00', 'on');
insert into login_details values('10:13:00', 'off');
insert into login_details values('10:14:00', 'off');
insert into login_details values('10:15:00', 'on');
insert into login_details values('10:16:00', 'off');
insert into login_details values('10:17:00', 'off');

select * from login_details;

*/
-- SOLUTION 1:
-- WITH cte_get_lead AS (
--     SELECT *
--         , LAG(status, 1, status) OVER(ORDER BY times) AS lead_status
--         , ROW_NUMBER() OVER(ORDER BY times) AS rn
--     FROM login_details
-- )
-- , cte_get_group AS (
--     SELECT *
--         , rn - ROW_NUMBER() OVER(ORDER BY times) AS grp
--     FROM cte_get_lead
--     WHERE status = 'on'
-- )
-- , cte_get_log_on_off AS (
--     SELECT *
--         , MIN(times) OVER(PARTITION BY grp ORDER BY times) AS log_on
--         , MAX(times) OVER(PARTITION BY grp ORDER BY times 
--             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS log_off
--     FROM cte_get_group
-- )
-- , cte_get_max_min AS (
--     SELECT MIN(times) AS log_on, MAX(times) AS last_log_on
--     FROM cte_get_group
--     GROUP BY grp
-- )
-- , cte_finnal AS (
--     SELECT 
--         log_on
--         , LEAD(times) OVER(ORDER BY times) AS log_off
--     FROM login_details l 
--     LEFT JOIN cte_get_max_min c 
--         ON l.times = c.last_log_on
-- )
-- SELECT *,
--     DATEDIFF(MINUTE, log_on, log_off) AS duration
-- FROM cte_finnal
-- WHERE log_on is not NULL;

-- SOLUTION 2:
WITH get_rn AS (
    SELECT *
            , ROW_NUMBER() OVER(ORDER BY times) AS rn
    FROM login_details
)
, get_info_status_change AS (
    SELECT *
        , LAG([status]) OVER(ORDER BY times) AS lag_status
        , LEAD([times]) OVER(ORDER BY times) AS lead_times
        , CASE WHEN (LAG([status]) OVER(ORDER BY times) = [status]) THEN 0 ELSE 1 END AS status_change
    FROM get_rn
)
, cte_finnal AS (
    SELECT * 
        , SUM(status_change) OVER(ORDER BY rn) AS grp
    FROM get_info_status_change
    WHERE [status] = 'on'
)
SELECT 
    MIN(times) AS log_on
    , MAX(lead_times) AS log_off
    , COUNT(grp) AS duration
FROM cte_finnal
GROUP BY grp;


-- SOLUTION 3:
SELECT 
    MIN(times) AS log_on
	, MAX(times) AS log_off
	, COUNT(grp) - 1 AS duration
FROM (
	SELECT *
		, SUM(CASE WHEN lag_status = 'off' THEN 1 ELSE 0 END) OVER (ORDER BY times) AS grp
	FROM (
		SELECT *
			,LAG(STATUS, 1, 'on') OVER (ORDER BY times) AS lag_status
		FROM login_details
		) x
	) x
GROUP BY grp
HAVING COUNT(1) > 1;
