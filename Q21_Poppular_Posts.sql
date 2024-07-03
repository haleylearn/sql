/*
Popular Posts - SQL Interview Query 21 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=cpelgvGwHcA&list=PLavw5C92dz9Hxz0YhttDniNgKejQlPoAn&index=21

drop table if exists user_sessions;
create table user_sessions
(
	session_id				int,
	user_id					varchar(10),
	session_starttime		DATETIME, -- In MSSQL replace DATETIME with datetime2
	session_endtime			DATETIME, -- In MSSQL replace DATETIME with datetime2
	platform				varchar(20)
);

-- Insert values into the user_sessions table
INSERT INTO user_sessions VALUES (1, 'U1', '2020-01-01 12:14:28', '2020-01-01 12:16:08', 'Windows');
INSERT INTO user_sessions VALUES (2, 'U1', '2020-01-01 18:23:50', '2020-01-01 18:24:00', 'Windows');
INSERT INTO user_sessions VALUES (3, 'U1', '2020-01-01 08:15:00', '2020-01-01 08:20:00', 'IPhone');
INSERT INTO user_sessions VALUES (4, 'U2', '2020-01-01 10:53:10', '2020-01-01 10:53:30', 'IPhone');
INSERT INTO user_sessions VALUES (5, 'U2', '2020-01-01 18:25:14', '2020-01-01 18:27:53', 'IPhone');
INSERT INTO user_sessions VALUES (6, 'U2', '2020-01-01 11:28:13', '2020-01-01 11:31:33', 'Windows');
INSERT INTO user_sessions VALUES (7, 'U3', '2020-01-01 06:46:20', '2020-01-01 06:58:13', 'Android');
INSERT INTO user_sessions VALUES (8, 'U3', '2020-01-01 10:53:10', '2020-01-01 10:53:50', 'Android');
INSERT INTO user_sessions VALUES (9, 'U3', '2020-01-01 13:13:13', '2020-01-01 13:34:34', 'Windows');
INSERT INTO user_sessions VALUES (10, 'U4', '2020-01-01 08:12:00', '2020-01-01 12:23:11', 'Windows');
INSERT INTO user_sessions VALUES (11, 'U4', '2020-01-01 21:54:03', '2020-01-01 21:54:04', 'IPad');


drop table if exists post_views;
create table post_views
(
	session_id 		int,
	post_id			int,
	perc_viewed		float
);
insert into post_views values(1,1,2);
insert into post_views values(1,2,4);
insert into post_views values(1,3,1);
insert into post_views values(2,1,20);
insert into post_views values(2,2,10);
insert into post_views values(2,3,10);
insert into post_views values(2,4,21);
insert into post_views values(3,2,1);
insert into post_views values(3,4,1);
insert into post_views values(4,2,50);
insert into post_views values(4,3,10);
insert into post_views values(6,2,2);
insert into post_views values(8,2,5);
insert into post_views values(8,3,2.5);


select * from user_sessions;
select * from post_views;
*/
/* -- Popular Posts (From Stratascratch):
The column 'perc_viewed' in the table 'post_views' denotes the percentage of the session 
duration time the user spent viewing a post. Using it, calculate the total time that each 
post was viewed by users. Output post ID and the total viewing time in seconds, 
but only for posts with a total viewing time of over 5 seconds. */

WITH cte AS (
    SELECT p.*
        , session_starttime
        , session_endtime
        , DATEDIFF(SECOND, session_starttime, session_endtime) AS total_second
    FROM user_sessions s 
    JOIN post_views p 
        ON p.session_id = s.session_id
)

SELECT 
    post_id
    , SUM((perc_viewed/100)*total_second) AS total_view
FROM cte
GROUP BY post_id 
HAVING SUM((perc_viewed/100)*total_second)  > 5;

