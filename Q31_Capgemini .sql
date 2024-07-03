/*
REAL SQL Interview PROBLEM by Capgemini | Solving SQL Queries

LINK: https://www.youtube.com/watch?v=jXKGsMPk1Hg&t=6s
------------------ DATASET ------------------ 
CREATE TABLE Lift(
    id INT
    , capacity INT
)
INSERT INTO Lift(id, capacity) VALUES (1, 300), (2, 350)

CREATE TABLE Passengers(
    passenger_name VARCHAR(255)
    , weight_kg INT
    , lift_id INT
)

INSERT INTO Passengers (passenger_name, weight_kg, lift_id)
VALUES
('Rahul', 85, 1)
, ('Adarsh', 71, 1)
, ('Riti', 95, 1)
, ('Dheeraj', 80, 1)
, ('Vimai', 83, 2)
, ('Neha', 77, 2)
, ('Priti', 73, 2)
, ('Himanshi', 85, 2)

PROBLEM STATEMENT:
The relationship between the LIFT and LIFT_PASSENGERS table is such that multiple passengers can attempt to enter the same lift,
but the total of the passengers in a lift cannot exceed the lift's capacity.

Your task is to write a SQL query that produces a comma-separated list of passengers who can be accommodated in each lift withou exceeding 
the lift's capacity. The passengers inthe list should be ordered by their weight in increasing order.

You can assume that the weights of the passengers are unique within each lift.
*/
WITH get_accumulate_weight AS (
    SELECT *
        , SUM(weight_kg) 
            OVER(PARTITION BY lift_id ORDER BY lift_id, weight_kg ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
        AS accumulate_weight
    FROM Passengers
)

SELECT 
    g.lift_id
    , STRING_AGG(passenger_name, ', ') WITHIN GROUP (ORDER BY weight_kg) AS passsengers_name
FROM get_accumulate_weight g 
JOIN lift l
    ON g.lift_id = l.id AND g.accumulate_weight <= l.capacity
GROUP BY g.lift_id;


