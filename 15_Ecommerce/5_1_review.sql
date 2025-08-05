--## 1. Customer Experience & Satisfaction

/*
### How do delivery days impact satisfaction?

**Methodology**

1. Calculated delivery time using `delivered_customer_date - purchase_date`, and assigned it as `delivery_time`.
2. Joined the `order_reviews` table to compute the average review score per delivery time.
3. Extracted the number of days from `delivery_time` and filtered out invalid data.
4. Calculated average review score and number of orders per delivery day.
5. Filtered by 75th percentile to focus on statistically significant delivery volumes.
*/

WITH delivery_review AS(
SELECT review_score,
       delivered_customer_date - purchase_date AS delivery_time
FROM orders
INNER JOIN order_reviews AS reviews ON reviews.order_id= orders.order_id
), delivery AS(
SELECT review_score, EXTRACT (DAYS FROM(delivery_time)) AS delivery_days
FROM delivery_review
WHERE delivery_time IS NOT NULL
), delivery_count AS(
SELECT delivery_days, ROUND(AVG(review_score),2) AS avg_rating, COUNT(delivery_days) AS number_of_delivery
FROM delivery
GROUP BY delivery_days
), delivery_percentile AS(
SELECT AVG(delivery_days), PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY delivery_days) AS p50,
       PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY delivery_days) AS p25,
       PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY delivery_days) AS p75
FROM delivery_count
)
SELECT delivery_days, avg_rating, number_of_delivery
FROM delivery_count, delivery_percentile
WHERE number_of_delivery > p75
ORDER BY avg_rating DESC;

/*
### How long do customers take to leave reviews?

**Methodology**

1. Calculated response time using `survey_answer_date - survey_sent_date`.
2. Computed average review score and number of reviews by day and hour.
3. Filtered by the 90th percentile to include only the most statistically relevant review counts.
*/

WITH answer_time AS(
SELECT ROUND(AVG(review_score),2) AS avg_rating, COUNT(review_id) AS review_count,
       EXTRACT (DAYS FROM(survey_answer_date-survey_sent_date)) AS answer_days, 
       EXTRACT (HOUR FROM(survey_answer_date-survey_sent_date)) AS answer_hour
FROM order_reviews
GROUP BY answer_days, answer_hour
ORDER BY answer_days, answer_hour
), review_count_percentile AS(
SELECT ROUND(AVG(review_count)),
       PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY review_count) AS p25,
       PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY review_count) AS p50,      
       PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY review_count) AS p75,
       PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY review_count) AS p90
FROM answer_time
)
SELECT answer_time.*
FROM answer_time, review_count_percentile
WHERE review_count> p90;


/*
### Which sellers have the best reviews?

**Methodology**

1. Joined the `order_reviews` table with `order_items` to calculate average review score per seller.
2. Filtered sellers by the 95th percentile of review count to focus on those with enough data.
3. Showed average rating and total number of reviews per seller.
*/

WITH avg_review AS(
SELECT seller_id, ROUND( AVG(reviews.review_score),2) AS avg_rating, COUNT(reviews.order_id) AS review_count
FROM order_items AS items
INNER JOIN order_reviews AS reviews ON items.order_id = reviews.order_id 
GROUP BY seller_id
), percentile AS(
SELECT PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY review_count) AS percentile_95th
FROM avg_review
)
SELECT avg_review.* 
FROM avg_review, percentile
WHERE review_count> percentile_95th
ORDER BY avg_rating DESC;




-- Find out skewness for valid analysis
WITH review_count AS(
SELECT seller_id, COUNT(reviews.order_id) AS review_num
FROM order_reviews AS reviews
INNER JOIN order_items AS items ON items.order_id = reviews.order_id 
GROUP BY seller_id
)
SELECT ROUND(AVG(review_num)) AS avg_num,
      PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY review_num) AS p25,
      PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY review_num) AS p50,
      PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY review_num) AS p75,
      PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY review_num) AS p90,
      PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY review_num) AS p95
FROM review_count;
