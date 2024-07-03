/*
IPL Winning Streak - SQL Interview Query 22 | SQL Problem Level "HARD"
https://www.youtube.com/watch?v=xY2622VV7jM&t=121s


drop table if exists ipl_results;
create table ipl_results
(
	match_no		int,
	round_number	varchar(50),
	dates			date,
	location		varchar(50),
	home_team		varchar(50),
	away_team		varchar(50),
	result			varchar(50)
);



insert into ipl_results values(1 , '1', '2023-03-31', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Chennai Super Kings','Gujarat Titans');
insert into ipl_results values(2 , '1', '2023-04-01', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Kolkata Knight Riders','Punjab Kings');
insert into ipl_results values(3 , '1', '2023-04-01', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Delhi Capitals','Lucknow Super Giants');
insert into ipl_results values(4 , '1', '2023-04-02', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Rajasthan Royals','Rajasthan Royals');
insert into ipl_results values(5 , '1', '2023-04-02', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Mumbai Indians','Royal Challengers Bangalore');
insert into ipl_results values(6 , '1', '2023-04-03', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Lucknow Super Giants','Chennai Super Kings');
insert into ipl_results values(7 , '1', '2023-04-04', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Gujarat Titans','Gujarat Titans');
insert into ipl_results values(8 , '1', '2023-04-05', 'Barsapara Cricket Stadium, Guwahati','Rajasthan Royals','Punjab Kings','Punjab Kings');
insert into ipl_results values(9 , '1', '2023-04-06', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Royal Challengers Bangalore','Kolkata Knight Riders');
insert into ipl_results values(10 , '1', '2023-04-07', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Sunrisers Hyderabad','Lucknow Super Giants');
insert into ipl_results values(11 , '2', '2023-04-08', 'Barsapara Cricket Stadium, Guwahati','Rajasthan Royals','Delhi Capitals','Rajasthan Royals');
insert into ipl_results values(12 , '2', '2023-04-08', 'Wankhede Stadium, Mumbai','Mumbai Indians','Chennai Super Kings','Chennai Super Kings');
insert into ipl_results values(13 , '2', '2023-04-09', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Kolkata Knight Riders','Kolkata Knight Riders');
insert into ipl_results values(14 , '2', '2023-04-09', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Punjab Kings','Sunrisers Hyderabad');
insert into ipl_results values(15 , '2', '2023-04-10', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Lucknow Super Giants','Lucknow Super Giants');
insert into ipl_results values(16 , '2', '2023-04-11', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Mumbai Indians','Mumbai Indians');
insert into ipl_results values(17 , '2', '2023-04-12', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Rajasthan Royals','Rajasthan Royals');
insert into ipl_results values(18 , '2', '2023-04-13', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Gujarat Titans','Gujarat Titans');
insert into ipl_results values(19 , '2', '2023-04-14', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Sunrisers Hyderabad','Sunrisers Hyderabad');
insert into ipl_results values(20 , '3', '2023-04-15', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Delhi Capitals','Royal Challengers Bangalore');
insert into ipl_results values(21 , '3', '2023-04-15', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Punjab Kings','Punjab Kings');
insert into ipl_results values(22 , '3', '2023-04-16', 'Wankhede Stadium, Mumbai','Mumbai Indians','Kolkata Knight Riders','Mumbai Indians');
insert into ipl_results values(23 , '3', '2023-04-16', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Rajasthan Royals','Rajasthan Royals');
insert into ipl_results values(24 , '3', '2023-04-17', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Chennai Super Kings','Chennai Super Kings');
insert into ipl_results values(25 , '3', '2023-04-18', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Mumbai Indians','Mumbai Indians');
insert into ipl_results values(26 , '3', '2023-04-19', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Lucknow Super Giants','Lucknow Super Giants');
insert into ipl_results values(27 , '3', '2023-04-20', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Royal Challengers Bangalore','Royal Challengers Bangalore');
insert into ipl_results values(28 , '3', '2023-04-20', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Kolkata Knight Riders','Delhi Capitals');
insert into ipl_results values(29 , '3', '2023-04-21', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Sunrisers Hyderabad','Chennai Super Kings');
insert into ipl_results values(30 , '4', '2023-04-22', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Gujarat Titans','Gujarat Titans');
insert into ipl_results values(31 , '4', '2023-04-22', 'Wankhede Stadium, Mumbai','Mumbai Indians','Punjab Kings','Punjab Kings');
insert into ipl_results values(32 , '4', '2023-04-23', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Rajasthan Royals','Royal Challengers Bangalore');
insert into ipl_results values(33 , '4', '2023-04-23', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Chennai Super Kings','Chennai Super Kings');
insert into ipl_results values(34 , '4', '2023-04-24', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Delhi Capitals','Delhi Capitals');
insert into ipl_results values(35 , '4', '2023-04-25', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Mumbai Indians','Gujarat Titans');
insert into ipl_results values(36 , '4', '2023-04-26', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Kolkata Knight Riders','Kolkata Knight Riders');
insert into ipl_results values(37 , '4', '2023-04-27', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Chennai Super Kings','Rajasthan Royals');
insert into ipl_results values(38 , '4', '2023-04-28', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Lucknow Super Giants','Lucknow Super Giants');
insert into ipl_results values(39 , '4', '2023-04-29', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Gujarat Titans','Gujarat Titans');
insert into ipl_results values(40 , '4', '2023-04-29', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Sunrisers Hyderabad','Sunrisers Hyderabad');
insert into ipl_results values(41 , '5', '2023-04-30', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Punjab Kings','Punjab Kings');
insert into ipl_results values(42 , '5', '2023-04-30', 'Wankhede Stadium, Mumbai','Mumbai Indians','Rajasthan Royals','Mumbai Indians');
insert into ipl_results values(43 , '5', '2023-05-01', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Royal Challengers Bangalore','Royal Challengers Bangalore');
insert into ipl_results values(44 , '5', '2023-05-02', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Delhi Capitals','Delhi Capitals');
insert into ipl_results values(46 , '5', '2023-05-03', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Chennai Super Kings','No Result');
insert into ipl_results values(45 , '5', '2023-05-03', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Mumbai Indians','Mumbai Indians');
insert into ipl_results values(47 , '5', '2023-05-04', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Kolkata Knight Riders','Kolkata Knight Riders');
insert into ipl_results values(48 , '5', '2023-05-05', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Gujarat Titans','Gujarat Titans');
insert into ipl_results values(49 , '5', '2023-05-06', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Mumbai Indians','Chennai Super Kings');
insert into ipl_results values(50 , '5', '2023-05-06', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Royal Challengers Bangalore','Delhi Capitals');
insert into ipl_results values(51 , '6', '2023-05-07', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Lucknow Super Giants','Gujarat Titans');
insert into ipl_results values(52 , '6', '2023-05-07', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Sunrisers Hyderabad','Sunrisers Hyderabad');
insert into ipl_results values(53 , '6', '2023-05-08', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Punjab Kings','Kolkata Knight Riders');
insert into ipl_results values(54 , '6', '2023-05-09', 'Wankhede Stadium, Mumbai','Mumbai Indians','Royal Challengers Bangalore','Mumbai Indians');
insert into ipl_results values(55 , '6', '2023-05-10', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Delhi Capitals','Chennai Super Kings');
insert into ipl_results values(56 , '6', '2023-05-11', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Rajasthan Royals','Rajasthan Royals');
insert into ipl_results values(57 , '6', '2023-05-12', 'Wankhede Stadium, Mumbai','Mumbai Indians','Gujarat Titans','Mumbai Indians');
insert into ipl_results values(58 , '6', '2023-05-13', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Lucknow Super Giants','Lucknow Super Giants');
insert into ipl_results values(59 , '6', '2023-05-13', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Punjab Kings','Punjab Kings');
insert into ipl_results values(60 , '7', '2023-05-14', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Royal Challengers Bangalore','Royal Challengers Bangalore');
insert into ipl_results values(61 , '7', '2023-05-14', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Kolkata Knight Riders','Kolkata Knight Riders');
insert into ipl_results values(62 , '7', '2023-05-15', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Sunrisers Hyderabad','Gujarat Titans');
insert into ipl_results values(63 , '7', '2023-05-16', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Mumbai Indians','Lucknow Super Giants');
insert into ipl_results values(64 , '7', '2023-05-17', 'Himachal Pradesh Cricket Association Stadium, Dhar','Punjab Kings','Delhi Capitals','Delhi Capitals');
insert into ipl_results values(65 , '7', '2023-05-18', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Royal Challengers Bangalore','Royal Challengers Bangalore');
insert into ipl_results values(66 , '7', '2023-05-19', 'Himachal Pradesh Cricket Association Stadium, Dhar','Punjab Kings','Rajasthan Royals','Rajasthan Royals');
insert into ipl_results values(67 , '7', '2023-05-20', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Chennai Super Kings','Chennai Super Kings');
insert into ipl_results values(68 , '7', '2023-05-20', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Lucknow Super Giants','Lucknow Super Giants');
insert into ipl_results values(69 , '7', '2023-05-21', 'Wankhede Stadium, Mumbai','Mumbai Indians','Sunrisers Hyderabad','Mumbai Indians');
insert into ipl_results values(70 , '7', '2023-05-21', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Gujarat Titans','Gujarat Titans');
insert into ipl_results values(71 , 'Qualifier 1' ,'2023-05-23', 'MA Chidambaram Stadium, Chennai','Gujarat Titans','Chennai Super Kings','Chennai Super Kings');
insert into ipl_results values(72 , 'Eliminator' ,'2023-05-24', 'MA Chidambaram Stadium, Chennai','Lucknow Super Giants','Mumbai Indians','Mumbai Indians');
insert into ipl_results values(73 , 'Qualifier 2' ,'2023-05-26', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Mumbai Indians','Gujarat Titans');
insert into ipl_results values(74 , 'Final' ,'2023-05-29', 'Narendra Modi Stadium, Ahmedabad','Chennai Super Kings','Gujarat Titans','Chennai Super Kings');



Given table has details of every IPL 2023 matches. Identify the maximum winning streak for each team.
Additional test cases: 
1: Update the dataset sucj that when Chennai Super Kings with no match no 17, your query shows the updated streak.
2. Update the dataset such that Royal Challengers Bangalore loose all match ang your query should populate the winning streak as 0


WITH AllTeams AS (
    SELECT home_team AS teams FROM ipl_results
    UNION 
    SELECT away_team AS teams FROM ipl_results
)
, AllMatch AS (
    SELECT 
        dates
        , CONCAT(home_team, ' VS ', away_team) AS match
        , teams
        , result
        , ROW_NUMBER() OVER(PARTITION BY teams ORDER BY teams, dates) AS id
    FROM AllTeams a 
    JOIN ipl_results i
        ON a.teams = i.home_team OR a.teams = i.away_team
    -- WHERE teams = 'Chennai Super Kings'
)
, GetDiff AS
(
    SELECT *
        , id - ROW_NUMBER() OVER(PARTITION BY teams ORDER BY teams, dates) AS diff
    FROM AllMatch
    WHERE result = teams
)
, CteFinnal AS (
    SELECT *
        , COUNT(diff) OVER(PARTITION BY teams, diff ORDER BY teams, diff) AS streak
    FROM GetDiff
)

SELECT a.teams, COALESCE(MAX(streak), 0) AS max_streak
FROM AllTeams a
LEFT JOIN CteFinnal f
    ON a.teams = f.teams
GROUP BY a.teams;


-- UPDATE QUERY
/*
UPDATE ipl_results
SET result = 'Chennai Super Kings'
WHERE match_no = 17
UPDATE ipl_results
SET result='Mumbai Indians'
WHERE match_no=5;

UPDATE ipl_results
set result='Delhi Capitals'
WHERE match_no=20;

UPDATE ipl_results
SET result='Punjab Kings'
WHERE match_no=27;

UPDATE ipl_results
SET result='Rajasthan Royals'
WHERE match_no=32;

UPDATE ipl_results
SET result='Lucknow Super Giants'
WHERE match_no=43;

UPDATE ipl_results
SET result='Rajasthan Royals'
WHERE match_no=60;

UPDATE ipl_results
SET result='Sunrisers Hyderabad'
WHERE match_no=65;
*/
*/

WITH AllTeams AS (
    SELECT home_team AS teams FROM ipl_results
    UNION 
    SELECT away_team AS teams FROM ipl_results
)
, AllMatch AS (
    SELECT 
        dates
        , CONCAT(home_team, ' VS ', away_team) AS match
        , teams
        , result
        , match_no
        , ROW_NUMBER() OVER(PARTITION BY teams ORDER BY teams, dates) AS id
    FROM AllTeams a 
    JOIN ipl_results i
        ON a.teams = i.home_team OR a.teams = i.away_team
    -- WHERE teams = 'Chennai Super Kings'
)
, GetDiff AS
(
    SELECT *
        , id - ROW_NUMBER() OVER(PARTITION BY teams ORDER BY teams, dates) AS diff
    FROM AllMatch
    WHERE result = teams
)
, CteFinnal AS (
    SELECT *
        , COUNT(diff) OVER(PARTITION BY teams, diff ORDER BY teams, diff) AS streak
    FROM GetDiff
)

SELECT *
FROM GetDiff
 

 

-- SELECT dates, match_no, result
-- FROM ipl_results 
-- -- WHERE result = 'Chennai Super Kings' OR result='Rajasthan Royals'
-- ORDER BY dates


-- -- Drop the table if it already exists
-- DROP TABLE IF EXISTS id_table;

-- -- Create the table
-- CREATE TABLE id_table (
--     match_no INT,
--     id CHAR(1)
-- );

-- -- Insert the data
-- INSERT INTO id_table (match_no, id) VALUES
-- (1, 'Y'),
-- (2, 'Y'),
-- (3, 'N'),
-- (4, 'N'),
-- (5, 'N'),
-- (6, 'Y'),
-- (7, 'Y'),
-- (8, 'Y');

-- WITH id_groups AS (
--     SELECT 
--         match_no,
--         id,
--         CASE WHEN id = LAG(id) OVER (ORDER BY id) THEN 0 ELSE 1 END AS is_new_group
--     FROM 
--         id_table
-- ),
-- grouped_ids AS (
--     SELECT 
--         match_no,
--         id,
--         SUM(is_new_group) OVER (ORDER BY id) AS group_id
--     FROM 
--         id_groups
-- )
-- SELECT 
--     *,
--     ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY match_no) AS check_
-- FROM 
--     grouped_ids
-- ORDER BY
--     match_no;


-- -- Tạo bảng tạm và điền dữ liệu
-- CREATE TABLE match_results (
--     team VARCHAR(50),
--     result VARCHAR(50)
-- );

-- -- Chèn dữ liệu từ dữ liệu mẫu
-- INSERT INTO match_results (team, result)
-- VALUES
-- ('Chennai Super Kings', 'Gujarat Titans'),
-- ('Chennai Super Kings', 'Chennai Super Kings'),
-- ('Chennai Super Kings', 'Chennai Super Kings'),
-- ('Chennai Super Kings', 'Chennai Super Kings'),
-- ('Chennai Super Kings', 'Chennai Super Kings'),
-- ('Chennai Super Kings', 'Chennai Super Kings'),
-- ('Chennai Super Kings', 'Chennai Super Kings'),
-- ('Chennai Super Kings', 'Rajasthan Royals'),
-- ('Chennai Super Kings', 'Punjab Kings'),
-- ('Chennai Super Kings', 'No Result'),
-- ('Chennai Super Kings', 'Chennai Super Kings'),
-- ('Chennai Super Kings', 'Chennai Super Kings');

-- WITH GetId AS (
--     SELECT *  
--     FROM (
--         SELECT *
--             , ROW_NUMBER() OVER(ORDER BY team) AS id
--         FROM match_results
--     ) x
-- )
-- , GetDiffWithPartition AS (
--     SELECT 
--         team,
--         result,
--         id,
--         ROW_NUMBER() OVER (ORDER BY id) AS rn_id, 
--         ROW_NUMBER() OVER (PARTITION BY result ORDER BY id) AS parti, 
--         ROW_NUMBER() OVER (ORDER BY id) - ROW_NUMBER() OVER (PARTITION BY result ORDER BY id) AS grp
--     FROM GetId
-- )
-- SELECT team, MAX(cnt)
-- FROM (
--     SELECT 
--         team, grp, COUNT(grp) AS cnt
--     FROM GetDiffWithPartition
--     GROUP BY team, grp
-- ) x
-- GROUP BY team;