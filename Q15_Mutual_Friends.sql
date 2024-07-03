/*
LINK REFERENCES: Mutual Friends - SQL Interview Query 15 | SQL Problem Level "HARD"
https://www.youtube.com/watch?v=ka9kDqkITX4

DROP TABLE IF EXISTS Friends;

CREATE TABLE Friends
(
Friend1 	VARCHAR(10),
Friend2 	VARCHAR(10)
);
INSERT INTO Friends VALUES ('Jason','Mary');
INSERT INTO Friends VALUES ('Mike','Mary');
INSERT INTO Friends VALUES ('Mike','Jason');
INSERT INTO Friends VALUES ('Susan','Jason');
INSERT INTO Friends VALUES ('John','Mary');
INSERT INTO Friends VALUES ('Susan','Mary');

select * from Friends;
*/
 

WITH AllFriends AS (
        SELECT Friend1, Friend2
        FROM Friends
        UNION ALL
        SELECT Friend2, Friend1
        FROM Friends
)
, CntFriend AS (
    SELECT f.Friend1, f.Friend2 
        , CASE WHEN af.Friend1 IS NULL THEN 0 ELSE 1 END AS Friends
    FROM Friends f
    LEFT JOIN AllFriends af
        ON f.Friend1 = af.Friend1
        AND af.Friend2 IN 
            (
                SELECT af2.Friend2
                FROM AllFriends af2
                WHERE af2.Friend1 = f.Friend2
            )
)
SELECT 
    DISTINCT Friend1, Friend2
    , SUM(Friends) OVER(PARTITION BY Friend1, Friend2) AS Multal_Friend
FROM CntFriend;
 