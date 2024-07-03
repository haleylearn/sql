/*
LINK REFERENCES: Employee Attendance - SQL Interview Query 18 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=Oz8uzN_7MuM

USE tech_tfq
CREATE TABLE employees
(
    id      INT,
    name    VARCHAR(50)
);
INSERT INTO employees VALUES (1, 'Lewis');
INSERT INTO employees VALUES (2, 'Max');
INSERT INTO employees VALUES (3, 'Charles');
INSERT INTO employees VALUES (4, 'Sainz');

SELECT * FROM employees;

CREATE TABLE events
(
    event_name   VARCHAR(50),
    emp_id       INT,
    dates        DATE
);
INSERT INTO events VALUES ('Product launch', 1, '2024-03-01');
INSERT INTO events VALUES ('Product launch', 3, '2024-03-01');
INSERT INTO events VALUES ('Product launch', 4, '2024-03-01');
INSERT INTO events VALUES ('Conference', 2, '2024-03-02');
INSERT INTO events VALUES ('Conference', 2, '2024-03-03');
INSERT INTO events VALUES ('Conference', 3, '2024-03-02');
INSERT INTO events VALUES ('Conference', 4, '2024-03-02');
INSERT INTO events VALUES ('Training', 3, '2024-03-04');
INSERT INTO events VALUES ('Training', 2, '2024-03-04');
INSERT INTO events VALUES ('Training', 4, '2024-03-04');
INSERT INTO events VALUES ('Training', 4, '2024-03-05');

PROBLEM STATEMENT: Find out the employees who attended all the company events.
*/

-- SOLUTION 1: 
WITH CountTotalEvent AS (
    SELECT COUNT(DISTINCT event_name) AS total_event FROM events
)
, CountEventByEmp AS (
    SELECT 
        e.emp_id
        , emp.name
        , COUNT(DISTINCT event_name) AS no_of_event
    FROM events e
    JOIN employees emp
        ON e.emp_id = emp.id
    GROUP BY emp_id, emp.name
)
SELECT emp_id, name
FROM CountEventByEmp
WHERE no_of_event = (SELECT total_event FROM CountTotalEvent);


-- SOLUTION 2: 
SELECT 
    emp_id
    , emp.name
    , COUNT(DISTINCT event_name) AS total_event 
FROM events e 
JOIN employees emp 
    ON e.emp_id = emp.id
GROUP BY emp_id, emp.name
HAVING COUNT(DISTINCT event_name) = (SELECT COUNT(DISTINCT event_name) FROM events);