--## 3. Sales & Revenue Trends


/*
### What are the top-selling categories?

**Methodology**
1. Counted the total number of products sold by joining `products`  and `order_items` tables.
2. Showed the category names in English along with the number of orders per product category.
*/

WITH product_order AS (
SELECT order_items.order_id, order_items.product_id, product_category_name
FROM order_items
INNER JOIN products ON products.product_id = order_items.product_id
)
SELECT category_eng, COUNT(order_id) AS number_of_order
FROM product_order
LEFT JOIN category_translation ON product_order.product_category_name = category_translation.category_portug
GROUP BY category_eng
ORDER BY number_of_order DESC;

/*
### Who are the top sellers by revenue and volume?

**Methodology**
1. Calculated total revenue using SUM, and listed sellers in descending order.
2. Counted the number of orders per seller to determine top sellers by volume.
*/

-- Top seller by revenue
SELECT seller_id, SUM(price) AS revenue
FROM order_items
GROUP BY seller_id
ORDER BY SUM(price) DESC;

-- Top seller by volume
SELECT seller_id, COUNT(order_id) AS volume
FROM order_items
GROUP BY seller_id
ORDER BY COUNT(order_id) DESC;

-- Top seller's category
WITH top AS(
SELECT products.*
FROM order_items
LEFT JOIN products ON products.product_id = order_items.product_id
WHERE seller_id = '"4a3ca9315b744ce9f8e9374361493884"'
)
SELECT category_eng, COUNT(category_eng)
FROM category_translation
INNER JOIN top ON top.product_category_name = category_portug
GROUP BY category_eng
ORDER BY COUNT(category_eng) DESC;

/*
### How does sales volume change over time?

**Methodology**
1. Extracted the month and year from `purchase_date`.
2. Counted the number of orders per month to observe sale trends.
*/
WITH order_volume AS(
SELECT order_id,
       EXTRACT (MONTH FROM(purchase_date)) AS purchase_month,
       EXTRACT (YEAR FROM (purchase_date)) AS purchase_year
FROM orders
)
SELECT purchase_year, purchase_month, COUNT(order_id)
FROM order_volume
GROUP BY purchase_year, purchase_month
ORDER BY purchase_year, purchase_month;
