-- Find the mean, min, max, stdev for the interval of time (in days) between purchases for each customer, 
-- as a way of measuring purchasing-frequency for each customer. Also calculate the number of orders for each 
-- customer.
-- (See the *hints* and expected results files for ideas)


https://github.com/krispeta21/ttp_D12_warmups.git

Part 1

SELECT 
order_id,
customer_id,
order_date,
order_date - LAG(order_date, 1) OVER
         (PARTITION BY customer_id ORDER BY order_id)
         AS difference
  FROM orders
  ORDER BY customer_id, order_id;


 order_id | customer_id | order_date | difference 
----------+-------------+------------+------------
    10643 | ALFKI       | 1997-08-25 |           
    10692 | ALFKI       | 1997-10-03 |         39
    10702 | ALFKI       | 1997-10-13 |         10
    10835 | ALFKI       | 1998-01-15 |         94
    10952 | ALFKI       | 1998-03-16 |         60
    11011 | ALFKI       | 1998-04-09 |         24
    10308 | ANATR       | 1996-09-18 |           
    10625 | ANATR       | 1997-08-08 |        324
    10759 | ANATR       | 1997-11-28 |        112
    10926 | ANATR       | 1998-03-04 |         96
    10365 | ANTON       | 1996-11-27 |           
    10507 | ANTON       | 1997-04-15 |        139
    10535 | ANTON       | 1997-05-13 |         28
    10573 | ANTON       | 1997-06-19 |         37
    10677 | ANTON       | 1997-09-22 |         95
    10682 | ANTON       | 1997-09-25 |          3
    10856 | ANTON       | 1998-01-28 |        125


Part 2 - without nulls

SELECT * 
FROM (
SELECT 
order_id,
customer_id,
order_date,
order_date - LAG(order_date, 1) OVER
         (PARTITION BY customer_id ORDER BY order_id)
         AS difference
  FROM orders
  ORDER BY customer_id, order_id) sub
WHERE sub.difference IS NOT NULL;


 order_id | customer_id | order_date | difference 
----------+-------------+------------+------------
    10692 | ALFKI       | 1997-10-03 |         39
    10702 | ALFKI       | 1997-10-13 |         10
    10835 | ALFKI       | 1998-01-15 |         94
    10952 | ALFKI       | 1998-03-16 |         60
    11011 | ALFKI       | 1998-04-09 |         24
    10625 | ANATR       | 1997-08-08 |        324
    10759 | ANATR       | 1997-11-28 |        112
    10926 | ANATR       | 1998-03-04 |         96



Part 3 - to get customer name

With log AS(
SELECT * 
FROM (
SELECT 
order_id,
customer_id,
order_date,
order_date - LAG(order_date, 1) OVER
         (PARTITION BY customer_id ORDER BY order_id)
         AS difference
  FROM orders
  ORDER BY customer_id, order_id) sub
WHERE sub.difference IS NOT NULL;


Part 3 - to final table 
order_id, 
contact_name, 
min, 
mean, 
max, 
std, 
num_orders


With log AS(
SELECT * 
FROM (
SELECT 
order_id,
customer_id,
order_date,
order_date - LAG(order_date, 1) OVER
         (PARTITION BY customer_id ORDER BY order_id)
         AS difference
  FROM orders
  ORDER BY customer_id, order_id) sub
WHERE sub.difference IS NOT NULL)
SELECT 
order_id,
customer_id,
avg(difference) OVER (PARTITION BY customer_id)
FROM
log
GROUP BY
customer_id, order_id, difference
ORDER BY
customer_id;


SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;



Results


Part 1 Results
order_id | customer_id | order_date 
----------+-------------+------------
    10643 | ALFKI       | 1997-08-25
    10692 | ALFKI       | 1997-10-03
    10702 | ALFKI       | 1997-10-13
    10835 | ALFKI       | 1998-01-15
    10952 | ALFKI       | 1998-03-16
    11011 | ALFKI       | 1998-04-09
    10308 | ANATR       | 1996-09-18
    10625 | ANATR       | 1997-08-08
    10759 | ANATR       | 1997-11-28
    10926 | ANATR       | 1998-03-04
    10365 | ANTON       | 1996-11-27
    10507 | ANTON       | 1997-04-15
    10535 | ANTON       | 1997-05-13
