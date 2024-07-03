/*
LINK REFERENCES: Footer Values - SQL Interview Query 3 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=w67I_aPKygE

PROBLEM STATEMENT: Write a sql query to return the footer values from input table
, meaning all the last non nul values from each field as shown in expected output.
*/

/*
DROP TABLE IF EXISTS FOOTER;
CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;
*/
-- GENERAL COMMAND
SELECT * FROM FOOTER;


-- SOLUTION 1: Using CROSSJOIN
SELECT * 
FROM (SELECT TOP 1 car from FOOTER WHERE car IS NOT NULL ORDER BY id DESC) t1
CROSS JOIN (SELECT TOP 1 length from FOOTER WHERE length IS NOT NULL ORDER BY id DESC) t2
CROSS JOIN (SELECT TOP 1 height from FOOTER WHERE height IS NOT NULL ORDER BY id DESC) t3
CROSS JOIN (SELECT TOP 1 width from FOOTER WHERE width IS NOT NULL ORDER BY id DESC) t4;

-- SOLUTION 2: 
WITH cte_partition AS (
	SELECT id, car, length, height, width,
		SUM(CASE WHEN car IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY id) AS car_segment,
		SUM(CASE WHEN length IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY id) AS length_segment,
		SUM(CASE WHEN height IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY id) AS height_segment,
		SUM(CASE WHEN width IS NOT NULL THEN 1 ELSE 0 END) OVER(ORDER BY id) AS width_segment
	FROM FOOTER
)

SELECT TOP 1 id,
	FIRST_VALUE(car) OVER(PARTITION BY car_segment ORDER BY id) AS new_car,
	FIRST_VALUE(length) OVER(PARTITION BY length_segment ORDER BY id) AS new_length,
	FIRST_VALUE(height) OVER(PARTITION BY height_segment ORDER BY id) AS new_height,
	FIRST_VALUE(width) OVER(PARTITION BY width_segment ORDER BY id) AS new_width
FROM cte_partition
ORDER BY id DESC;
