/*
LINK REFERENCES: Find Relevant Dates - SQL Interview Query 7 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=0w5mx6lfx1Y

DATASET: 

drop table if exists Day_Indicator;
create table Day_Indicator
(
	Product_ID 		varchar(10),	
	Day_Indicator 	varchar(7),
	Dates			date
); 
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', CAST('2024-03-04' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', CAST('2024-03-05' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', CAST('2024-03-06' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', CAST('2024-03-07' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', CAST('2024-03-08' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', CAST('2024-03-09' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('AP755', '1010101', CAST('2024-03-10' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', CAST('2024-03-04' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', CAST('2024-03-05' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', CAST('2024-03-06' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', CAST('2024-03-07' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', CAST('2024-03-08' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', CAST('2024-03-09' AS DATETIME));
INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', CAST('2024-03-10' AS DATETIME));

PROBLEM STATEMENT: 
In the given input table DAY_INDICATOR feild indicates the day of the week with the first character being Monday, 
followed by Tuesday and so on.
Write a query to filter the dates column to showcase only those days where day_indicator character for thar day of the week is 1

*/ 

-- SOLUTION 1: Using SUBSTRING and ROW_NUMBER()
SET DATEFIRST 1;

WITH ori_table AS (
        SELECT DISTINCT product_id, day_indicator FROM Day_Indicator
    )
, numbers AS (
    SELECT TOP 7 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
, finding_position AS (
    SELECT 
        ori.product_id, 
        ori.day_indicator,
        n.n AS position 
    FROM ori_table ori CROSS APPLY numbers n 
    WHERE 
        n.n <= LEN(ori.day_indicator) 
        AND SUBSTRING(ori.day_indicator, n.n, 1) = '1' 
)

SELECT f.product_id, f.day_indicator, df.dates
FROM finding_position f 
JOIN (SELECT product_id, dates, DATEPART(WEEKDAY, dates) AS DayOfWeek FROM Day_Indicator) AS df
    ON f.product_id = df.product_id AND f.[position] = df.DayOfWeek
ORDER BY f.product_id;


-- SOSLUTION 2: Using SUBSTRING
WITH get_day_number AS (
    SELECT *,
        DATEPART(WEEKDAY, dates) AS day_number
    FROM Day_Indicator
)

SELECT * 
FROM 
    (
        SELECT *,
            SUBSTRING(Day_Indicator, day_number, 1) AS flag
        FROM get_day_number
    ) x
WHERE flag = 1;
