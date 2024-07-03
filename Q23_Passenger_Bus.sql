/*
LEETCODE - Passenger Bus Problem - SQL Interview Query 23| SQL Problem Level "HARD"
https://www.youtube.com/watch?v=-23QiFuwt4k&t=81s

2153. LEETCODE The Number of Passengers in Each Bus II


drop table if exists buses;
create table buses
(
	bus_id			int unique,
	arrival_time	int,
	capacity		int
);

drop table if exists Passengers;
create table Passengers
(
	passenger_id	int unique,
	arrival_time	int
);

-- TEST CASE 1:
insert into buses values (1,2,1);
insert into buses values (2,4,10);
insert into buses values (3,7,2);

insert into Passengers values(11,1);
insert into Passengers values(12,1);
insert into Passengers values(13,5);
insert into Passengers values(14,6);
insert into Passengers values(15,7);

select * from buses;
select * from Passengers;

*/
WITH cte_data AS (
    SELECT 
        ROW_NUMBER() OVER(ORDER BY arrival_time) AS rn 
        , *
        , (SELECT COUNT(passenger_id) FROM passengers p WHERE p.arrival_time <= b.arrival_time) total_passengers
    FROM buses b
)
, cte AS (
    SELECT rn, bus_id, arrival_time, capacity, total_passengers
        , LEAST(capacity, total_passengers) AS onboard
        , LEAST(capacity, total_passengers) AS total_passenger_onboarded
    FROM cte_data 
    WHERE rn = 1

    UNION ALL

    SELECT d.rn, d.bus_id, d.arrival_time, d.capacity, d.total_passengers 
        , LEAST(d.capacity, d.total_passengers - cte.total_passenger_onboarded) AS onboard
        , cte.total_passenger_onboarded + LEAST(d.capacity, d.total_passengers - cte.total_passenger_onboarded) AS total_passenger_onboarded
    FROM cte 
    JOIN cte_data d 
    -- BECAREFUL WITH THIS CONDITION NOT SAME d.rn > cte.rn. To ensure not any duplicate rows happen
        ON d.rn = cte.rn + 1
)
SELECT bus_id, total_passenger_onboarded FROM cte 
  
