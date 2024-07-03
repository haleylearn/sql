/*
Super Interesting SQL Problem | Practice SQL Queries
https://www.youtube.com/watch?v=4Z67GTTWuzc\

DATASET:

-- CREATE TABLE
CREATE TABLE abitrary_values (
    id INT IDENTITY(1,1) PRIMARY KEY,
    value VARCHAR(10)
);

-- INSERT VALUES INTO TABLE a1,...,a21
DECLARE @i INT = 1;
WHILE @i <= 21
BEGIN
    INSERT INTO abitrary_values (value)
    VALUES ('a' + CAST(@i AS VARCHAR(2)));
    SET @i = @i + 1;
END;

-- CHECK DATA
SELECT * FROM abitrary_values;
*/

-- SOLUTION 1: Using CEILING((SQRT(8 * RowNum + 1) - 1) / 2) AS grp
WITH NumberedRows AS (
    SELECT
        value,
        ROW_NUMBER() OVER(ORDER BY id) AS RowNum
    FROM abitrary_values
),
Groups AS (
    SELECT
        RowNum,
        value,
        CEILING((SQRT(8 * RowNum + 1) - 1) / 2) AS grp
    FROM NumberedRows
)
SELECT
    grp AS [Group],
    STRING_AGG(value, ', ') AS 'Values'
FROM Groups
GROUP BY grp
ORDER BY grp;



-- SOLUTION 2: 
WITH cte AS (
    SELECT id, value
        , 1 AS iter
        , MAX(id) OVER() AS max_id
    FROM abitrary_values 
    WHERE id = 1

    UNION ALL

    SELECT cv.id , cv.value
        , iter + 1 AS iter
        , MAX(cte.id) OVER() AS max_id
    FROM cte 
    JOIN abitrary_values cv
        ON cv.id BETWEEN max_id + 1 AND max_id + 1 + iter
)

SELECT id, value FROM cte



    SELECT cv.id , cv.value
        , iter + 1 AS iter
        , MAX(cte.id) OVER() AS max_id
    FROM 
    (
        SELECT id, value
        , 1 AS iter
        , MAX(id) OVER() AS max_id
    FROM abitrary_values 
    WHERE id = 1
    ) cte
    JOIN abitrary_values cv
        ON cv.id BETWEEN max_id + 1 AND max_id + 1 + iter