--## 2. Delivery Performance

/*
### How accurate are estimated delivery dates?

**Methodology**
1. Calculated the difference between `delivered_customer_date` and `estimated_delivery_date`.
2. Created a new column `estimated_date`:
    if the actual delivery was after the estimated date, assigned as 'Delayed'
    otherwise assigned as 'Accurate'.
3. Displayed the total number of deliveries in each category, along with their percentages.
*/

WITH delivery_days_table AS(
SELECT EXTRACT(DAY FROM (delivered_customer_date - estimated_delivery_date)) AS delivery_days,
       estimated_delivery_date, delivered_customer_date
FROM orders
), estimated AS(
SELECT *,
        CASE 
            WHEN delivery_days >0 THEN 'Delayed'
            ELSE 'Accurate'
        END AS estimated_date
FROM delivery_days_table
WHERE delivery_days IS NOT NULL
)
SELECT COUNT (*) AS number_of_delivery, estimated_date, 
       ROUND(COUNT (*)*100/(SUM(COUNT(*)) OVER()),2) AS percentage
FROM estimated
GROUP BY estimated_date
;


/*
### Which states have the slowest/fastest deliveries?

**Methodology**
1. Calculated delivery days by `delivered_customer_date - purchase_date`.
2. Joined the data with the `customers` table to group by `customer_state`.
3. Calculated the average delivery day for each state.
*/

WITH delivery_state AS(
SELECT EXTRACT(DAY FROM (delivered_customer_date - purchase_date)) AS delivery_days,
       purchase_date, delivered_customer_date, customer_state
FROM orders
INNER JOIN customers ON customers.customer_id = orders.customer_id
)
SELECT customer_state, ROUND(AVG(delivery_days),2) AS average_delivery_days
FROM delivery_state
WHERE delivery_days IS NOT NULL
GROUP BY customer_state
;

