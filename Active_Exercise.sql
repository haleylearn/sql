/*
LINK REFERENCES: https://www.youtube.com/watch?v=J_da4WKsrjE&t=826s

DESCRIPTION: The status column in input table depicts the status of child.
If the parent has atleast one child in 'Active' status then we need to report parent as 'Active' status (Ex:parent_id 1,2,4)
If none of the child is 'Active' for a Parent then we need to report the parent as 'Inactive' (Ex: parent_id 3,5)
*/

-- GENERAL COMMAND 
USE techtfq_exercise
SELECT * FROM active_excercise



-- SOLUTION 1: One table has full parent_id LEFT JOIN with table only have 'Active'
SELECT 
    ori.parent_id,
    CASE 
        WHEN active.parent_id is NULL THEN 'InActive'
        ELSE 'Active'
    END AS 'status'
FROM 
    (SELECT DISTINCT parent_id FROM active_excercise) ori
LEFT JOIN 
    (SELECT DISTINCT parent_id 
    FROM active_excercise 
    WHERE status = 'Active') active
ON ori.parent_id = active.parent_id;


-- SOLUTION 2: Using WITH and NOT IN
WITH has_active AS (
    SELECT DISTINCT parent_id, status
    FROM active_excercise
    WHERE status = 'Active'
)
SELECT * FROM has_active
UNION ALL
SELECT DISTINCT parent_id, 'InActive' AS status
FROM active_excercise 
WHERE parent_id NOT IN (SELECT parent_id FROM has_active)
ORDER BY parent_id;


-- SOLUTION 3: Using ROW_NUMBER()
WITH s3_using_rownumber AS (
    SELECT 
        parent_id, 
        status,
        ROW_NUMBER() OVER (PARTITION BY parent_id ORDER BY parent_id) AS rank
    FROM active_excercise
)
SELECT parent_id, status FROM s3_using_rownumber WHERE rank = 1;


-- SOLUTION 4: Using MIN and GROUPBY
SELECT parent_id, MIN(status) AS 'status'
FROM active_excercise
GROUP BY parent_id;