 SELECT DATE('now'),
TIME()

SELECT STRFTIME('%Y/%m/%d', 'NOW')

SELECT datetime()

SELECT vendor_id, market_date FROM customer_purchases
group by market_date

SELECT customer_id,
count(distinct product_id)  from customer_purchases
GROUP by customer_id

SELECT count(customer_id) -- number of purchases per that day
,market_date

FROM customer_purchases
WHERE market_date BETWEEN '2019-04-01' AND '2019-04-30'
GROUP BY market_date


SELECT max(customer_first_name) FROM customer

SELECT product_name, max(original_price)
FROm product as p
join vendor_inventory vi
on p.product_id = vi.product_id

SELECT CAST(10.3/2.0 AS INTEGER)

SELECT p.product_id, max(m,ax
  SELECT cp.customer_id,product_id,  max(quantity) as max_quantity 
  FROM customer_purchases as cp



-- AGGREGATE
/* 1. Write a query that determines how many times each vendor has rented a booth 
at the farmer’s market by counting the vendor booth assignments per vendor_id. */
A:
SELECT vendor_id, COUNT(*) as booth_count
FROM vendor_booth_assignments
GROUP BY vendor_id

/* 2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper 
sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list 
of customers for them to give stickers to, sorted by last name, then first name. 

HINT: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword. */
A:
SELECT c.customer_last_name, c.customer_first_name, cp.quantity * cp.cost_to_customer_per_qty AS amount
FROM customer c
JOIN customer_purchases cp ON c.customer_id = cp.customer_id
GROUP BY c.customer_id
HAVING SUM(amount)  > 2000
ORDER BY  c.customer_last_name, c.customer_first_name

--Temp Table
/* 1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: 
Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal

HINT: This is two total queries -- first create the table from the original, then insert the new 10th vendor. 
When inserting the new vendor, you need to appropriately align the columns to be inserted 
(there are five columns to be inserted, I've given you the details, but not the syntax) 

-> To insert the new row use VALUES, specifying the value you want for each column:
VALUES(col1,col2,col3,col4,col5) 
*/

CREATE  TABLE temp_new_vendor  AS
SELECT * FROM vendor;

SELECT * FEOM temp_new_vendor

-- Date
/*1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.

HINT: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month 
and year are! */
A:
SELECT customer_id, 
       strftime('%m', market_date) AS month,
       strftime('%Y', market_date) AS year
FROM customer_purchases;

/* 2. Using the previous query as a base, determine how much money each customer spent in April 2019. 
Remember that money spent is quantity*cost_to_customer_per_qty. 

HINTS: you will need to AGGREGATE, GROUP BY, and filter...
but remember, STRFTIME returns a STRING for your WHERE statement!! */
A:
SELECT customer_id, 
       SUM(quantity * cost_to_customer_per_qty) AS total_spent,
	          strftime('%m', market_date) AS month,
       strftime('%Y', market_date) AS year
FROM customer_purchases
WHERE strftime('%Y-%m', market_date) = '2019-04'
GROUP BY customer_id;

