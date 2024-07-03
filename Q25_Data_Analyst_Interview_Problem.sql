
/* 
Data Analyst Interview Problem - SQL Interview Query 25 | SQL Problem Level "EASY"
https://www.youtube.com/watch?v=vyTMJhHyEtg&t=2s

DATASET:
drop table if exists product_demo;
create table product_demo
(
	store_id	int,
	product_1	varchar(50),
	product_2	varchar(50)
);
insert into product_demo values (1, 'Apple - IPhone', '   Apple - MacBook Pro');
insert into product_demo values (1, 'Apple - AirPods', 'Samsung - Galaxy Phone');
insert into product_demo values (2, 'Apple_IPhone', 'Apple: Phone');
insert into product_demo values (2, 'Google Pixel', ' apple: Laptop');
insert into product_demo values (2, 'Sony: Camera', 'Apple Vision Pro');
insert into product_demo values (3, 'samsung - Galaxy Phone', 'mapple MacBook Pro');
*/

SELECT 
	store_id
	, SUM(cnt_product_1) AS PRODUCT_1
	, SUM(cnt_product_2) AS PRODUCT_2
FROM (
	SELECT *
		, CASE WHEN TRIM(product_1) LIKE 'apple%' THEN 1 ELSE 0 END AS cnt_product_1
		, CASE WHEN TRIM(product_2) LIKE 'apple%' THEN 1 ELSE 0 END AS cnt_product_2
	FROM product_demo
) x
GROUP BY store_id;

