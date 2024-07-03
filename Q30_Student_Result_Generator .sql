/*
Student Result Generator SQL Interview Query - 30 | #30DaySQLQueryChallenge
https://www.youtube.com/watch?v=r2QbEueaFR8&t=361s

/*
PROBLEM STATEMENT: Given tables represent the marks scored by engineering students.
Create a report to display the following results for each student.
  - Student_id, Student name
  - Total Percentage of all marks
  - Failed subjects (must be comma seperated values in case of multiple failed subjects)
  - Result (if percentage >= 70% then 'First Class', if >= 50% & <=70% then 'Second class', if <=50% then 'Third class' else 'Fail'.
  			The result should be Fail if a students fails in any subject irrespective of the percentage marks)
	
	*** The sequence of subjects in student_marks table match with the sequential id from subjects table.
	*** Students have the option to choose either 4 or 5 subjects only.
*/


drop table if exists student_marks;
drop table if exists students;
drop table if exists subjects;

create table students
(
	roll_no		varchar(20) primary key,
	name		varchar(30)		
);
insert into students values('2GR5CS011', 'Maryam');
insert into students values('2GR5CS012', 'Rose');
insert into students values('2GR5CS013', 'Alice');
insert into students values('2GR5CS014', 'Lilly');
insert into students values('2GR5CS015', 'Anna');
insert into students values('2GR5CS016', 'Zoya');


create table student_marks
(
	student_id		varchar(20) primary key references students(roll_no),
	subject1		int,
	subject2		int,
	subject3		int,
	subject4		int,
	subject5		int,
	subject6		int
);
insert into student_marks values('2GR5CS011', 75, NULL, 56, 69, 82, NULL);
insert into student_marks values('2GR5CS012', 57, 46, 32, 30, NULL, NULL);
insert into student_marks values('2GR5CS013', 40, 52, 56, NULL, 31, 40);
insert into student_marks values('2GR5CS014', 65, 73, NULL, 81, 33, 41);
insert into student_marks values('2GR5CS015', 98, NULL, 94, NULL, 90, 20);
insert into student_marks values('2GR5CS016', NULL, 98, 98, 81, 84, 89);


create table subjects
(
	id				varchar(20) primary key,
	name			varchar(30),
	pass_marks  	int check (pass_marks>=30)
);
insert into subjects values('S1', 'Mathematics', 40);
insert into subjects values('S2', 'Algorithms', 35);
insert into subjects values('S3', 'Computer Networks', 35);
insert into subjects values('S4', 'Data Structure', 40);
insert into subjects values('S5', 'Artificial Intelligence', 30);
insert into subjects values('S6', 'Object Oriented Programming', 35);


select * from students;
select * from student_marks;
select * from subjects;

SELECT 
	student_id,
	subject_name,
	score
FROM student_marks
UNPIVOT
(
	score FOR subject_name IN (subject1, subject2, subject3, subject4, subject5, subject6)
) AS unpivot_table
*/

WITH unpivot_table AS (
	SELECT 
		student_id
		, unpivot_table.subject
		, unpivot_table.score
	FROM student_marks
	OUTER APPLY (
		SELECT 'S1' AS subject, subject1 AS score
		UNION ALL 
		SELECT 'S2', subject2 AS score
		UNION ALL
		SELECT 'S3', subject3 AS score
		UNION ALL
		SELECT 'S4', subject4 AS score
		UNION ALL
		SELECT 'S5', subject5 AS score
		UNION ALL
		SELECT 'S6', subject6 AS score
	) AS unpivot_table
) 
, handle_score AS (
	SELECT 
		student_id, score, name, pass_marks
		, CASE WHEN score < pass_marks THEN name ELSE NULL END AS failed
	FROM unpivot_table unv
	JOIN subjects s 
		ON unv.subject = s.id 
	WHERE score is NOT NULL
)
, handle_percentage_mark AS (
	SELECT 
		student_id
		, CASE 
			WHEN STRING_AGG(failed, ', ') WITHIN GROUP (ORDER by student_id) IS NOT NULL
				THEN STRING_AGG(failed, ', ') WITHIN GROUP (ORDER by student_id)
				ELSE '-' 
				END 
			AS failed_subjects
		, CONVERT(
			DECIMAL(10,2)
			, CAST(SUM(score) AS DECIMAL(10, 2)) / CAST(COUNT(score) AS DECIMAL(10, 2))
		) AS percentage_marks
	FROM handle_score
	GROUP BY student_id
)
SELECT *
	, CASE
		WHEN failed_subjects NOT LIKE '-' THEN 'Fail'
		WHEN percentage_marks >= 70.00 THEN 'First Class'
		WHEN percentage_marks BETWEEN 50.00 AND 70.00 THEN 'Second Class'
		WHEN percentage_marks <= 50.00 THEN 'Third Class'
		ELSE 'Fail'
		END AS test
FROM handle_percentage_mark h
JOIN students s
	ON s.roll_no = h.student_id;

