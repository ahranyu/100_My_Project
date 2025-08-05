SELECT *
FROM customers
LIMIT 100;

SELECT *
FROM geolocation
LIMIT 100;

SELECT *
FROM order_items
LIMIT 100;

SELECT *
FROM order_payments
LIMIT 100;

SELECT *
FROM order_reviews
LIMIT 100;


-- CONVERT to TIMESTAMP
SELECT *
FROM orders
LIMIT 100;

--------
ALTER TABLE orders ADD COLUMN sent_to_carrier_date_ts TIMESTAMP;
ALTER TABLE orders ADD COLUMN estimated_delivery_date_ts TIMESTAMP;

UPDATE orders
SET sent_to_carrier_date_ts = NULLIF(sent_to_carrier_date, '')::TIMESTAMP,
    estimated_delivery_date_ts = NULLIF(estimated_delivery_date, '')::TIMESTAMP
WHERE sent_to_carrier_date NOT IN ('', '0000-00-00')
   OR estimated_delivery_date NOT IN ('', '0000-00-00');

ALTER TABLE orders DROP COLUMN sent_to_carrier_date;
ALTER TABLE orders DROP COLUMN estimated_delivery_date;

ALTER TABLE orders RENAME COLUMN sent_to_carrier_date_ts TO sent_to_carrier_date;
ALTER TABLE orders RENAME COLUMN estimated_delivery_date_ts TO estimated_delivery_date;
-------------------------------

SELECT *
FROM sellers
LIMIT 100;

SELECT *
FROM products
LIMIT 100;

SELECT *
FROM category_translation
LIMIT 100;
