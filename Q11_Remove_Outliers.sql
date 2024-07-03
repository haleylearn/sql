/*
LINK REFERENCES: Remove Outliers - SQL Interview Query 11 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=LBWXjtLNauQ


drop table if exists hotel_ratings;
create table hotel_ratings
(
	hotel 		varchar(30),
	year		int,
	rating 		decimal(10, 2)
);
insert into hotel_ratings values('Radisson Blu', 2020, 4.8);
insert into hotel_ratings values('Radisson Blu', 2021, 3.5);
insert into hotel_ratings values('Radisson Blu', 2022, 3.2);
insert into hotel_ratings values('Radisson Blu', 2023, 3.8);
insert into hotel_ratings values('InterContinental', 2020, 4.2);
insert into hotel_ratings values('InterContinental', 2021, 4.5);
insert into hotel_ratings values('InterContinental', 2022, 1.5);
insert into hotel_ratings values('InterContinental', 2023, 3.8);

select * from hotel_ratings;

PROBLEM STATEMENT: In the given input table, there are hotel ratings which are either too high or too low
compared to the standard ratings the hotel receives each year. Write a query to indentify and exclude thse outlier
records as shown in expected output below.

*/
SELECT * 
FROM
(
    SELECT *
        , CASE WHEN ABS(avg_rating - rating) < avg_rating*0.3 THEN 1 ELSE 0 END AS flag
    FROM
    (
        SELECT *
            , ROUND(AVG(rating) OVER(PARTITION BY hotel), 2) AS avg_rating
        FROM hotel_ratings
    ) x
) a 
WHERE flag = 1;

