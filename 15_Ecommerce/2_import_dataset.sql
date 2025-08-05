COPY customers
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\olist_customers_dataset.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY geolocation ( geo_zip_code, geo_lat, geo_lon, geo_city, geo_state ) 
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\olist_geolocation_dataset.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_items
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\olist_order_items_dataset.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_payments
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\olist_order_payments_dataset.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY order_reviews
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\olist_order_reviews_dataset.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY orders
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\olist_orders_dataset.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL '');

COPY sellers
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\olist_sellers_dataset.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY products
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\olist_products_dataset.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL '');

COPY category_translation
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\15_Ecommerce\product_category_name_translation.csv'
WITH (HEADER true, DELIMITER ',', ENCODING 'UTF8');

