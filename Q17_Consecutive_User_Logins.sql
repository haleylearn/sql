/*
LINK REFERENCES: Consecutive User Logins - SQL Interview Query 17 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=F-gETvj-oN0&t=73s

drop table if exists user_login;
create table user_login
(
	user_id		int,
	login_date	date
);
INSERT INTO user_login VALUES (1, '2024-03-01');
INSERT INTO user_login VALUES (1, '2024-03-02');
INSERT INTO user_login VALUES (1, '2024-03-03');
INSERT INTO user_login VALUES (1, '2024-03-04');
INSERT INTO user_login VALUES (1, '2024-03-06');
INSERT INTO user_login VALUES (1, '2024-03-10');
INSERT INTO user_login VALUES (1, '2024-03-11');
INSERT INTO user_login VALUES (1, '2024-03-12');
INSERT INTO user_login VALUES (1, '2024-03-13');
INSERT INTO user_login VALUES (1, '2024-03-14');

INSERT INTO user_login VALUES (1, '2024-03-20');
INSERT INTO user_login VALUES (1, '2024-03-25');
INSERT INTO user_login VALUES (1, '2024-03-26');
INSERT INTO user_login VALUES (1, '2024-03-27');
INSERT INTO user_login VALUES (1, '2024-03-28');
INSERT INTO user_login VALUES (1, '2024-03-29');
INSERT INTO user_login VALUES (1, '2024-03-30');

INSERT INTO user_login VALUES (2, '2024-03-01');
INSERT INTO user_login VALUES (2, '2024-03-02');
INSERT INTO user_login VALUES (2, '2024-03-03');
INSERT INTO user_login VALUES (2, '2024-03-04');

INSERT INTO user_login VALUES (3, '2024-03-01');
INSERT INTO user_login VALUES (3, '2024-03-02');
INSERT INTO user_login VALUES (3, '2024-03-03');
INSERT INTO user_login VALUES (3, '2024-03-04');
INSERT INTO user_login VALUES (3, '2024-03-04');
INSERT INTO user_login VALUES (3, '2024-03-04');
INSERT INTO user_login VALUES (3, '2024-03-05');

INSERT INTO user_login VALUES (4, '2024-03-01');
INSERT INTO user_login VALUES (4, '2024-03-02');
INSERT INTO user_login VALUES (4, '2024-03-03');
INSERT INTO user_login VALUES (4, '2024-03-04');
INSERT INTO user_login VALUES (4, '2024-03-04');

Problem Statement: User login table shows the date when each user logged into the system. Indentify the users who logged in for 5 or more consecutive days.
Return the user id, start date, end date and no of consecutive days.
Please remember a user can login multiple times during a day but only consider users whose consicuteive logins spanned 5 days or more.
*/

-- SOLUTION 1: Using RowNumber to get different and then count them
WITH GetDistinctRow AS (
    SELECT DISTINCT user_id, login_date 
    FROM user_login
)
, GetDifferWithRowNumber AS (
    SELECT *
        , DATEADD(DAY, rn*(-1), login_date) AS after_differ
    FROM (
        SELECT *
            , ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY user_id, login_date ) AS rn
        FROM GetDistinctRow 
    ) X
)
, CountConsicutive AS (
    SELECT user_id, after_differ
        , MIN(login_date) AS login_date
        , COUNT(after_differ) AS cnt
    FROM GetDifferWithRowNumber
    GROUP BY user_id, after_differ
)

SELECT * FROM CountConsicutive WHERE cnt >= 5;

 