/*
LINK REFERENCES: COVID Cases - SQL Interview Query 16 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=60MJSk56MZs

drop table if exists covid_cases;
create table covid_cases
(
	cases_reported	int,
	dates			date	
);

INSERT INTO covid_cases VALUES (20124, CAST('2020-01-10' AS DATE));
INSERT INTO covid_cases VALUES (40133, CAST('2020-01-15' AS DATE));
INSERT INTO covid_cases VALUES (65005, CAST('2020-01-20' AS DATE));
INSERT INTO covid_cases VALUES (30005, CAST('2020-02-08' AS DATE));
INSERT INTO covid_cases VALUES (35015, CAST('2020-02-19' AS DATE));
INSERT INTO covid_cases VALUES (15015, CAST('2020-03-03' AS DATE));
INSERT INTO covid_cases VALUES (35035, CAST('2020-03-10' AS DATE));
INSERT INTO covid_cases VALUES (49099, CAST('2020-03-14' AS DATE));
INSERT INTO covid_cases VALUES (84045, CAST('2020-03-20' AS DATE));
INSERT INTO covid_cases VALUES (100106, CAST('2020-03-31' AS DATE));
INSERT INTO covid_cases VALUES (17015, CAST('2020-04-04' AS DATE));
INSERT INTO covid_cases VALUES (36035, CAST('2020-04-11' AS DATE));
INSERT INTO covid_cases VALUES (50099, CAST('2020-04-13' AS DATE));
INSERT INTO covid_cases VALUES (87045, CAST('2020-04-22' AS DATE));
INSERT INTO covid_cases VALUES (101101, CAST('2020-04-30' AS DATE));
INSERT INTO covid_cases VALUES (40015, CAST('2020-05-01' AS DATE));
INSERT INTO covid_cases VALUES (54035, CAST('2020-05-09' AS DATE));
INSERT INTO covid_cases VALUES (71099, CAST('2020-05-14' AS DATE));
INSERT INTO covid_cases VALUES (82045, CAST('2020-05-21' AS DATE));
INSERT INTO covid_cases VALUES (90103, CAST('2020-05-25' AS DATE));
INSERT INTO covid_cases VALUES (99103, CAST('2020-05-31' AS DATE));
INSERT INTO covid_cases VALUES (11015, CAST('2020-06-03' AS DATE));
INSERT INTO covid_cases VALUES (28035, CAST('2020-06-10' AS DATE));
INSERT INTO covid_cases VALUES (38099, CAST('2020-06-14' AS DATE));
INSERT INTO covid_cases VALUES (45045, CAST('2020-06-20' AS DATE));
INSERT INTO covid_cases VALUES (36033, CAST('2020-07-09' AS DATE));
INSERT INTO covid_cases VALUES (40011, CAST('2020-07-23' AS DATE));
INSERT INTO covid_cases VALUES (25001, CAST('2020-08-12' AS DATE));
INSERT INTO covid_cases VALUES (29990, CAST('2020-08-26' AS DATE));
INSERT INTO covid_cases VALUES (20112, CAST('2020-09-04' AS DATE));
INSERT INTO covid_cases VALUES (43991, CAST('2020-09-18' AS DATE));
INSERT INTO covid_cases VALUES (51002, CAST('2020-09-29' AS DATE));
INSERT INTO covid_cases VALUES (26587, CAST('2020-10-25' AS DATE));
INSERT INTO covid_cases VALUES (11000, CAST('2020-11-07' AS DATE));
INSERT INTO covid_cases VALUES (35002, CAST('2020-11-16' AS DATE));
INSERT INTO covid_cases VALUES (56010, CAST('2020-11-28' AS DATE));
INSERT INTO covid_cases VALUES (15099, CAST('2020-12-02' AS DATE));
INSERT INTO covid_cases VALUES (38042, CAST('2020-12-11' AS DATE));
INSERT INTO covid_cases VALUES (73030, CAST('2020-12-26' AS DATE));

-- Given table contains reported covid cases in 2020. 
-- Calculate the percentage increase in covid cases each month versus cumulative cases as of the prior month.
-- Return the month number, and the percentage increase rounded to one decimal. Order the result by the month.
-- */

-- WITH MonthlyCases AS (
--     SELECT 
--         YEAR(dates) AS Year,
--         MONTH(dates) AS Month,
--         SUM(cases_reported) AS MonthlyTotal
--     FROM covid_cases
--     GROUP BY YEAR(dates), MONTH(dates)
-- ),
-- CumulativeCases AS (
--     SELECT 
--         Year,
--         Month,
--         MonthlyTotal,
--         SUM(MonthlyTotal) OVER (ORDER BY Year, Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeTotal
--     FROM MonthlyCases
-- )
-- SELECT 
--     Year,
--     Month,
--     MonthlyTotal,
--     CumulativeTotal,
--     LAG(CumulativeTotal, 1, 0) OVER (ORDER BY Year, Month) AS PriorMonthCumulative,
--     CASE 
--         WHEN LAG(CumulativeTotal, 1, 0) OVER (ORDER BY Year, Month) = 0 THEN 0
--         ELSE (CAST(MonthlyTotal AS FLOAT) / LAG(CumulativeTotal, 1, 0) OVER (ORDER BY Year, Month)) * 100
--     END AS PercentageIncrease
-- FROM CumulativeCases
-- ORDER BY Year, Month;


WITH MonthlyCases AS (
	SELECT 
		YEAR(dates) AS 'Year'
		, MONTH(dates) AS 'Month'
		, SUM(cases_reported) AS MonthlyTotal
	FROM covid_cases
	GROUP BY YEAR(dates), MONTH(dates)
)
, CumulativeCases AS (
	SELECT [Year], [Month], MonthlyTotal
		, SUM(MonthlyTotal) 
			OVER(ORDER BY Year, Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
			AS CumulativeTotal
	FROM MonthlyCases
)
SELECT 
    Year,
    Month,
    MonthlyTotal,
    CumulativeTotal,
    LAG(CumulativeTotal, 1, 0) OVER (ORDER BY Year, Month) AS PriorMonthCumulative,
    CASE 
        WHEN LAG(CumulativeTotal, 1, 0) OVER (ORDER BY Year, Month) = 0 THEN 0
        ELSE ROUND((CAST(MonthlyTotal AS FLOAT) / LAG(CumulativeTotal, 1, 0) OVER (ORDER BY Year, Month)) * 100, 2)
    END AS PercentageIncrease
FROM CumulativeCases
ORDER BY Year, Month;