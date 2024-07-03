/*
LINK REFERENCES: Student Performance - SQL Interview Query 6 | SQL Problem Level "EASY"
https://www.youtube.com/watch?v=dgIYeUAOzbM

DATASET:
drop table if exists  student_tests;
create table student_tests
(
	test_id		int,
	marks		int
);
insert into student_tests values(100, 55);
insert into student_tests values(101, 55);
insert into student_tests values(102, 60);
insert into student_tests values(103, 58);
insert into student_tests values(104, 40);
insert into student_tests values(105, 50);

PROBLEM STATEMENT: You are given a table having the marks of one student in every test.
You have to output the tests in wich the student has improved his performance
For a student to improve his performance he has to score more than the previous test.
Provide 2 solutions, one including the first test score and second excluding it.

*/

-- INCLUDE THE FIRST TEST
SELECT TOP 1 * FROM student_tests
UNION ALL
SELECT s1.test_id, s1.marks
FROM student_tests s1
JOIN (SELECT TOP 1 marks FROM student_tests) s2
    ON s1.marks > s2.marks;

-- EXCLUDING THE FIRST TEST
SELECT s1.test_id, s1.marks
FROM student_tests s1
JOIN (SELECT TOP 1 marks FROM student_tests) s2
    ON s1.marks > s2.marks;

