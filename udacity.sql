SELECT * FROM orders LIMIT 30;

SELECT id, occurred_at, total_amt_usd
FROM orders 
ORDER BY occurred_at 
LIMIT 10;

SELECT id, occurred_at, total_amt_usd
FROM orders 
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, occurred_at, total_amt_usd
FROM orders 
ORDER BY total_amt_usd
LIMIT 20;

SELECT * FROM orders
WHERE gloss_amt_usd >= 1000 LIMIT 5;

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

SELECT name, website, primary_poc FROM accounts WHERE name = 'Exxon Mobil';

SELECT id, account_id, standard_amt_usd / standard_qty AS unit_price
FROM orders LIMIT 10;	

SELECT id, account_id, (poster_amt_usd * 100) / (standard_amt_usd + gloss_amt_usd + poster_amt_usd)
AS poster_revenue
FROM orders LIMIT 10;

SELECT name FROM accounts WHERE name LIKE '%s';

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

SELECT * FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 
AND gloss_qty = 0;

SELECT * FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

SELECT * FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

SELECT * FROM web_events
WHERE channel IN ('organic', 'adwords') 
AND occurred_at BETWEEN '2016-01-01' 
AND '2017-01-01' 
ORDER BY occurred_at DESC;

SELECT id FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT * FROM orders
WHERE (gloss_qty > 4000 OR poster_qty > 4000)
AND standard_qty = 0;

SELECT * FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND ((primary_poc LIKE '%Ana%' OR primary_poc LIKE '%ana%') AND primary_poc NOT LIKE '%eana%');

SELECT a.primary_poc, a.name, w.occurred_at, w.channel FROM accounts a 
JOIN web_events w on w.account_id = a.id WHERE a.name = 'Walmart';

SELECT a.name, s.name sales_name, r.name region_name FROM accounts a 
JOIN sales_reps s ON a.sales_rep_id = s.id JOIN region r ON s.region_id = r.id;

SELECT a.name, o.total_amt_usd/(o.total + 0.01) as unit_price,r.name region_name FROM accounts a 
JOIN sales_reps s ON a.sales_rep_id = s.id JOIN region r ON s.region_id = r.id 
JOIN orders o ON a.id = o.account_id;

SELECT r.name region, s.name sales_name, a.name account FROM region r 
JOIN sales_reps s ON s.region_id = r.id
JOIN accounts a ON a.sales_rep_id = s.id WHERE r.name = 'Midwest' ORDER BY account;

SELECT r.name region, s.name sales_name, a.name account FROM region r 
JOIN sales_reps s ON s.region_id = r.id
JOIN accounts a ON a.sales_rep_id = s.id WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY account;

SELECT r.name region, s.name sales_name, a.name account FROM region r JOIN sales_reps s ON s.region_id = r.id
JOIN accounts a ON a.sales_rep_id = s.id WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY account;

SELECT r.name region, a.name account, (o.total_amt_usd/(o.total + 0.01)) unit_price 
FROM accounts a JOIN orders o ON o.account_id = a.id JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON r.id = s.region_id WHERE o.standard_qty > 100;

SELECT r.name region, a.name account, (o.total_amt_usd/(o.total + 0.01)) unit_price 
FROM accounts a JOIN orders o ON o.account_id = a.id JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON r.id = s.region_id WHERE o.standard_qty > 100 ORDER BY unit_price;

SELECT r.name region, a.name account, (o.total_amt_usd/(o.total + 0.01)) unit_price 
FROM accounts a JOIN orders o ON o.account_id = a.id JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON r.id = s.region_id WHERE o.standard_qty > 100 AND o.poster_qty > 50 
ORDER BY unit_price DESC;

SELECT DISTINCT a.name account, w.channel chanel FROM accounts a JOIN web_events w 
ON a.id = w.account_id WHERE a.id = 1001;

SELECT o.occurred_at, a.name account, o.total, o.total_amt_usd FROM ORDERS O 
JOIN ACCOUNTS A ON a.id = o.account_id WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

SELECT SUM(poster_qty) FROM orders;

SELECT SUM(total_amt_usd) FROM orders;

SELECT (standard_amt_usd + gloss_amt_usd) total_amount, account_id FROM orders;

SELECT SUM(standard_qty)/SUM(standard_amt_usd) ) unit_price, account_id FROM orders;

SELECT MIN(occurred_at) first_order FROM orders;

SELECT occurred_at FROM orders
ORDER BY occurred_at LIMIT 1;

SELECT MAX(occurred_at) lastes_event FROM web_events;

SELECT occurred_at FROM web_events
ORDER BY occurred_at DESC LIMIT 1;

SELECT AVG(standard_qty) avarge_standard, AVG(gloss_qty) avarge_gloss, AVG(poster_qty) avarge_poster, 
AVG(total) avarge_total, AVG(standard_amt_usd) avarge_stadard_usd,AVG(gloss_amt_usd) avarge_gloss_usd, 
AVG(poster_amt_usd) avarge_poster_usd FROM orders;

// Group BY

SELECT a.name, o.occurred_at date FROM 
accounts a JOIN orders o ON o.account_id = a.id ORDER BY o.occurred_at LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd) total_sales FROM 
accounts a JOIN orders o ON o.account_id = a.id GROUP BY a.name;

SELECT w.occurred_at date, w.channel, a.name FROM web_events w 
JOIN accounts a ON w.account_id = a.id ORDER BY w.occurred_at DESC LIMIT 1;

SELECT w.channel, COUNT(*) FROM web_events w GROUP BY w.channel;

SELECT a.primary_poc, a.name, w.occurred_at FROM accounts a JOIN web_events w 
ON w.account_id = a.id ORDER BY w.occurred_at LIMIT 1;

SELECT a.name, MIN(o.total_amt_usd) smallest_order FROM accounts a 
JOIN orders o ON o.account_id = a.id  GROUP BY a.name ;

SELECT a.name, MIN(o.total_amt_usd) smallest_order FROM accounts a 
JOIN orders o ON o.account_id = a.id  GROUP BY a.name ORDER BY smallest_order;

SELECT r.name, COUNT(*) sales_at_region FROM sales_reps s 
JOIN region r ON r.id = s.region_id GROUP BY r.name
ORDER BY sales_at_region;

SELECT a.name, AVG(o.standard_qty) avarge_standard, AVG(o.gloss_qty) avarge_gloss, 
AVG(o.poster_qty) FROM accounts a JOIN orders o ON o.account_id = a.id GROUP BY a.name;

SELECT a.name, AVG(o.standard_amt_usd) avarge_standard, AVG(o.gloss_amt_usd) avarge_gloss, 
AVG(o.poster_amt_usd) avarge_poster FROM accounts a JOIN orders o ON o.account_id = a.id 
GROUP BY a.name;

SELECT s.name, w.channel, COUNT(*) channel_amt FROM web_events w JOIN accounts a 
ON w.account_id = a.id JOIN sales_reps s ON a.sales_rep_id = s.id  GROUP BY s.name, w.channel 
ORDER BY channel_amt DESC;

SELECT r.name, w.channel, COUNT(*) channel_amt FROM web_events w JOIN accounts a 
ON w.account_id = a.id JOIN sales_reps s ON a.sales_rep_id = s.id 
JOIN region r ON s.region_id = r.id GROUP BY r.name, w.channel ORDER BY channel_amt DESC;

SELECT DISTINCT  a.name, r.name FROM accounts a JOIN sales_reps s ON a.sales_rep_id = s.id JOIN region r 
ON s.region_id = r.id;

SELECT DISTINCT s.name FROM sales_reps s JOIN accounts a ON s.id = a.sales_rep_id;

SELECT DISTINCT s.name sales_rep, a.name account_name FROM sales_reps s JOIN accounts a ON 
s.id = a.sales_rep_id ORDER BY s.name;

SELECT s.id, s.name, COUNT(*) num_accounts FROM accounts a JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.id, s.name HAVING COUNT(*) > 5 ORDER BY num_accounts;

SELECT s.name, COUNT(*) num_accounts FROM accounts a JOIN sales_reps s ON a.sales_rep_id = s.id 
GROUP BY s.name HAVING COUNT(*) > 5 
ORDER BY num_accounts DESC;

SELECT a.name, COUNT(*) num_orders FROM accounts a JOIN orders o ON o.account_id = a.id 
GROUP BY a.name HAVING COUNT(*) > 20 ORDER BY num_orders DESC;

SELECT a.name, COUNT(*) num_orders FROM accounts a JOIN orders o ON o.account_id = a.id 
GROUP BY a.name ORDER BY num_orders DESC LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd) sum_orders FROM accounts a JOIN orders o ON o.account_id = a.id 
GROUP BY a.name HAVING SUM(o.total_amt_usd) > 30000 ORDER BY sum_orders DESC;

SELECT a.name, SUM(o.total_amt_usd) sum_orders FROM accounts a JOIN orders o ON o.account_id = a.id 
GROUP BY a.name HAVING SUM(o.total_amt_usd) < 1000 ORDER BY sum_orders DESC;

SELECT a.name, SUM(o.total_amt_usd) sum_orders FROM accounts a JOIN orders o ON o.account_id = a.id 
GROUP BY a.name ORDER BY sum_orders DESC LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd) sum_orders FROM accounts a JOIN orders o ON o.account_id = a.id 
GROUP BY a.name ORDER BY sum_orders LIMIT 1;

SELECT a.name,  w.channel, COUNT(*) num_channel FROM accounts a JOIN web_events w ON w.account_id = a.id 
GROUP BY a.name, w.channel HAVING COUNT(*) > 6 AND w.channel = 'facebook' ORDER BY num_channel;

SELECT a.name,  w.channel, COUNT(*) num_channel FROM accounts a JOIN web_events w ON w.account_id = a.id 
GROUP BY a.name, w.channel HAVING COUNT(*) > 6 AND w.channel = 'facebook' 
ORDER BY num_channel DESC LIMIT 1;

SELECT a.name,  w.channel, COUNT(*) num_channel FROM accounts a JOIN web_events w ON w.account_id = a.id 
GROUP BY a.name, w.channel ORDER BY num_channel DESC LIMIT 10;

SELECT DATE_PART('year', o.occurred_at) as year, SUM(o.total_amt_usd) total_spent FROM orders o 
GROUP BY 1 ORDER BY 2 DESC;

SELECT DATE_PART('month', o.occurred_at) as month, SUM(o.total_amt_usd) total_spent FROM orders o
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01' 
GROUP BY DATE_PART('month', o.occurred_at) ORDER BY 2 DESC LIMIT 1;

SELECT DATE_PART('year', o.occurred_at) as year, COUNT(*) total_sales FROM orders o 
GROUP BY 1 ORDER BY 2 DESC LIMIT 1;

SELECT DATE_PART('month', o.occurred_at) as year, COUNT(*) total_sales FROM orders o 
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1 ORDER BY 2 DESC LIMIT 1;

SELECT DATE_TRUNC('month', o.occurred_at) ordre_date, SUM(o.gloss_amt_usd) tot_gloss FROM orders o 
JOIN accounts a ON o.account_id = a.id WHERE a.name = 'Walmart'
GROUP BY 1 ORDER BY 2 DESC LIMIT 1;

SELECT account_id, total_amt_usd, CASE WHEN total_amt_usd > 3000 THEN 'Large' ELSE 
'Small' END AS order_lvl FROM orders;

SELECT total, CASE WHEN total > 2000 THEN 'At Least 2000' 
WHEN total < 2000 AND total > 1000 THEN 'Between 1000 abd 2000' ELSE 'Less than 1000'
END AS order_qty_lvl FROM orders;

SELECT a.name, SUM(o.total_amt_usd) total_sales, CASE WHEN SUM(o.total_amt_usd) > 200000 
THEN 'greater than 200,000' WHEN SUM(o.total_amt_usd) < 200000 AND SUM(o.total_amt_usd) > 100000 
THEN '200,000 and 100,000' ELSE 'under 100,000' END AS sales_lvl FROM accounts a 
JOIN orders o ON o.account_id = a.id GROUP BY a.name ORDER BY 2 DESC;

SELECT a.name, SUM(o.total_amt_usd) total_sales, CASE WHEN SUM(o.total_amt_usd) > 200000 
THEN 'greater than 200,000' WHEN SUM(o.total_amt_usd) < 200000 AND SUM(o.total_amt_usd) > 100000 
THEN '200,000 and 100,000' ELSE 'under 100,000' END AS sales_lvl FROM accounts a 
JOIN orders o ON o.account_id = a.id WHERE o.occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY a.name ORDER BY 2 DESC;

SELECT s.name, COUNT(*) total_orders, CASE WHEN COUNT(*) > 200 THEN 'top' ELSE 'not' 
END AS sales_perform FROM sales_reps s JOIN accounts a ON s.id = a.sales_rep_id JOIN orders o 
ON o.account_id = a.id GROUP BY s.name ORDER BY 2 DESC;

SELECT s.name, COUNT(*) total_orders, SUM(o.total_amt_usd) total_sales, CASE 
WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top' WHEN COUNT(*) > 150) 
OR SUM(o.total_amt_usd) > 500000 THEN 'midle' ELSE 'not' END AS sales_perform FROM sales_reps s 
JOIN accounts a ON s.id = a.sales_rep_id JOIN orders o ON o.account_id = a.id 
GROUP BY s.name ORDER BY 2 DESC;