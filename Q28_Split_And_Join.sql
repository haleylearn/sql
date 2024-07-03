/*
SPLIT & JOIN - SQL Interview Problem - 28 | #30DaySQLQueryChallenge
https://www.youtube.com/watch?v=cXpIWgBW1mU

-- Find length of comma seperated values in items field

drop table if exists item;
create table item
(
	id		int,
	items	varchar(50)
);
insert into item values(1, '22,122,1022');
insert into item values(2, ',6,0,9999');
insert into item values(3, '100,2000,2');
insert into item values(4, '4,44,444,4444');

select * from item;

*/
WITH split_by_row AS (
    SELECT id, s.value AS value
        , ROW_NUMBER() OVER (PARTITION BY i.id ORDER BY (SELECT NULL)) AS rn
    FROM item i
    CROSS APPLY STRING_SPLIT(i.items, ',') s
)
, get_lengths AS (
    SELECT *
        , CASE 
            WHEN value = '' THEN 0
            ELSE LEN([value]) 
        END AS lengths
    FROM split_by_row
)
SELECT id
    , STRING_AGG(lengths, ',') WITHIN GROUP (ORDER BY rn) AS result_lengths
FROM get_lengths
GROUP BY id;