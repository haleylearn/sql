/*
LINK REFERENCES: Find Missing Data - SQL Interview Query 14 | SQL Problem Level "MEDIUM"
https://www.youtube.com/watch?v=WBqTj-FYux8


drop table if exists invoice;
create table invoice
(
	serial_no		int,
	invoice_date	date
);
INSERT INTO invoice VALUES (330115, CONVERT(DATE, '2024-03-01', 120));
INSERT INTO invoice VALUES (330120, CONVERT(DATE, '2024-03-01', 120));
INSERT INTO invoice VALUES (330121, CONVERT(DATE, '2024-03-01', 120));
INSERT INTO invoice VALUES (330122, CONVERT(DATE, '2024-03-02', 120));
INSERT INTO invoice VALUES (330125, CONVERT(DATE, '2024-03-02', 120));

select * from invoice;

PROBLEM STATEMENT: Some of the invoice are missing, write a sql query to indentify the missing serial no.
As an assumption, consider the serial no with the lowest value to be the first generated invoice
and the highest serial no value to be the last generated invoice.
*/

DECLARE @min_serial INT, @max_serial INT;

SELECT 
    @min_serial = MIN(serial_no)
    , @max_serial = MAX(serial_no) 
FROM invoice;

SELECT value
FROM GENERATE_SERIES(@min_serial, @max_serial)
WHERE [value] NOT IN (SELECT serial_no FROM invoice);

