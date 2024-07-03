
/*
--BÀI TẬP VỀ DẠNG LIÊN TIẾP
Q29.SQL

MORE EXERCISE

CREATE TABLE StatusTable (
    id INT,
    status CHAR(1)
);

INSERT INTO StatusTable (id, status) VALUES 
(1, 'Y'),
(2, 'Y'),
(3, 'N'),
(4, 'N'),
(5, 'N'),
(6, 'Y'),
(7, 'Y'),
(8, 'Y');

WITH NumberedStatus AS (
    SELECT 
        id,
        status,
        ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM StatusTable
),
GroupedStatus AS (
    SELECT 
        id,
        status,
        rn,
        ROW_NUMBER() OVER (PARTITION BY status ORDER BY rn) AS test,
        rn - ROW_NUMBER() OVER (PARTITION BY status ORDER BY rn) AS grp
    FROM NumberedStatus
)

SELECT 
    MIN(id) AS StartID,
    MAX(id) AS EndID,
    status
FROM GroupedStatus
GROUP BY status, grp
ORDER BY StartID;


-- SOLUTION 2:
WITH NumberedStatus AS (
    SELECT 
        id,
        status,
        ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM StatusTable
),
StatusChange AS (
    SELECT 
        id,
        status,
        rn,
        LAG(status) OVER (ORDER BY id) as lag,
        CASE 
            WHEN status = LAG(status) OVER (ORDER BY id) THEN 0 
            ELSE 1 
        END AS status_change
    FROM NumberedStatus
),
GroupedStatus AS (
    SELECT 
        id,
        status,
        lag,
        rn,
        status_change,
        SUM(status_change) OVER (ORDER BY rn) AS grp
    FROM StatusChange
)
SELECT * from GroupedStatus

*/

