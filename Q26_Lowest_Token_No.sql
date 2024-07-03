/*
Lowest Token No - SQL Interview Query 26 | SQL Problem Level "EASY"
https://www.youtube.com/watch?v=WumXyCh8U4g&t=49s

PROBLEM STATEMENT: Write a SQL query to return the lowest token number which is unique to a customer
(making token should be allocated to just a single customer)
*/
SELECT TOP(1) token_num
    FROM (
        SELECT DISTINCT token_num, customer
        FROM tokens
    ) x
GROUP BY token_num
HAVING COUNT(token_num) = 1