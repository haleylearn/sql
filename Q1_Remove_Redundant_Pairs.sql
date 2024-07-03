/*
LINK REFERENCES: Remove Redundant Pairs - SQL Interview Query 1 | SQL Problem Level "HARD" https://www.youtube.com/watch?v=FRzbOb3jdLg

DESCRIPTION: "Problem Statement:
- For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
      - if custom1 = custom3 and custom2 = custom4 : then keep only one pair
- For pairs of brands in the same year 
      - if custom1 != custom3 OR custom2 != custom4 : then keep both pairs
- For brands that do not have pairs in the same year : keep those rows as well"						
 
*/

/*
DATASET:

DROP TABLE IF EXISTS brands;
CREATE TABLE brands 
(
    brand1      VARCHAR(20),
    brand2      VARCHAR(20),
    year        INT,
    custom1     INT,
    custom2     INT,
    custom3     INT,
    custom4     INT
);
INSERT INTO brands VALUES ('apple', 'samsung', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('samsung', 'apple', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('apple', 'samsung', 2021, 1, 2, 5, 3);
INSERT INTO brands VALUES ('samsung', 'apple', 2021, 5, 3, 1, 2);
INSERT INTO brands VALUES ('google', NULL, 2020, 5, 9, NULL, NULL);
INSERT INTO brands VALUES ('oneplus', 'nothing', 2020, 5, 9, 6, 3);
*/

-- GENERAL COMMAND
SELECT * FROM brands;


-- SOLUTION 1: 
/*
S1: Using ROW_NUMBER() to take ID for each row 
S2: Test which ID should be keep or not 
S3: UNION ALL row just found
*/
-- S1: Using ROW_NUMBER() to take ID for each row 
WITH cte_row_number AS (
    SELECT  
        ROW_NUMBER() OVER(ORDER BY brand1) AS 'id'
        , *
    FROM brands
)
-- S2: Test which ID should be keep or not 
, cte_take_id AS (
    SELECT t1.id AS ori_id, t2.id AS id_test_keep,
        CASE 
            WHEN t1.custom1 = t1.custom3 AND t1.custom2 = t2.custom4 THEN 'keep only' 
            ELSE 'keep both'
        END AS 'test_keep'
    FROM cte_row_number t1
    JOIN cte_row_number t2
        ON t1.brand1 = t2.brand2 AND t1.year = t2.year AND t1.id < t2.id
)
-- S3: UNION ALL row just found
SELECT * FROM cte_row_number WHERE id IN (SELECT id_test_keep FROM cte_take_id WHERE test_keep = 'keep both') 
UNION ALL
SELECT * FROM cte_row_number WHERE id NOT IN (select id_test_keep FROM cte_take_id)
ORDER BY year, brand1, brand2;


-- SOLUTION 2: Using LEAST() and GREATEST()
SELECT DISTINCT 
    LEAST(brand1, brand2) AS brand1,
    GREATEST(brand1, brand2) AS brand2,
    custom1, custom2, custom3, custom4, year
FROM brands;


-- SOLUTION 3: Using STRCMP not have in SQL SEVER, can try in MYSQL
/*
WITH rm AS (
    SELECT *,
        IIF(STRCMP(brand1, brand2) > 0, CONCAT(UPPER(brand1), UPPER(brand2), year), CONCAT(UPPER(brand2), UPPER(brand1), year)) AS con
    FROM brands
),
rm1 AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY con ORDER BY con) AS id
    FROM rm
)
SELECT brand1, brand2, year
FROM rm1
WHERE id = 1 OR (custom1 <> custom3 AND custom2 <> custom4);
*/


-- SOLUTION 4: Using CONCAT and ROW_NUMBER()
WITH cte_s4 AS (
    SELECT *
    , CONCAT(brand1,'-',brand2,'-',year) AS concat_name
    , CASE 
        WHEN brand1 < brand2 THEN CONCAT(brand1,brand2,year) 
        ELSE CONCAT(brand2,brand1,year)
        END AS concat_pair_id
    FROM brands
)
, cte_rn AS (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY concat_pair_id ORDER BY concat_pair_id) AS id
    FROM cte_s4
)

SELECT * FROM cte_rn WHERE (id = 1) OR (custom1 <> custom3 OR custom2 <> custom4)
