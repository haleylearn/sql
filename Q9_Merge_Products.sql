/*
LINK REFERENCES: Merge Products - SQL Interview Query 9 | SQL Problem Level "EASY"
https://www.youtube.com/watch?v=o5W-iAK21ws

PROBLEM STATEMENT: 
Write an sql query to merge products per customer for each day as shown in expected output.

drop TABLE if exists orders;
CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 

*/


WITH get_product_combine AS (
    SELECT dates, customer_id
        , STRING_AGG(product_id, ',') AS product_combine
    FROM 
        orders
    GROUP BY dates, customer_id
)
SELECT dates, CAST(product_combine AS VARCHAR) AS products
FROM get_product_combine g

UNION 

SELECT dates, CAST(product_id AS VARCHAR) AS products
FROM orders;



