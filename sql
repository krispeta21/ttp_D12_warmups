-- Find the mean, min, max, stdev for the interval of time (in days) between purchases for each customer, 
-- as a way of measuring purchasing-frequency for each customer. Also calculate the number of orders for each 
-- customer.
-- (See the *hints* and expected results files for ideas)


https://github.com/krispeta21/ttp_D12_warmups.git

With log AS (
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
customer_id,
ROUND(AVG(difference),2),
MIN(difference),
MAX(difference),
ROUND(STDDEV(difference),2),
COUNT(order_id)
FROM 
log
GROUP BY
customer_id
ORDER BY
customer_id;



 customer_id | round  | min | max | round  | count 
-------------+--------+-----+-----+--------+-------
 ALFKI       |  45.40 |  10 |  94 |  32.89 |     5
 ANATR       | 177.33 |  96 | 324 | 127.27 |     3
 ANTON       |  71.17 |   3 | 139 |  56.12 |     6
 AROUT       |  42.58 |   3 | 134 |  39.35 |    12
 BERGS       |  33.47 |   1 | 124 |  32.08 |    17
 BLAUS       |  64.17 |   8 | 182 |  61.32 |     6
 BLONP       |  53.60 |   7 | 111 |  37.63 |    10
 BOLID       | 265.00 |  85 | 445 | 254.56 |     2
 BONAP       |  35.44 |   1 | 131 |  36.38 |    16
 BOTTM       |  37.69 |   0 | 227 |  64.54 |    13