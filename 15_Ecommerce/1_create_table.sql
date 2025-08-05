
CREATE TABLE public.customers
(   customer_id VARCHAR(100) PRIMARY KEY,
    customer_unique_id VARCHAR(100),
    customer_zip_code VARCHAR(100),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100)
    
);


CREATE TABLE public.geolocation
(   geo_zip_code VARCHAR(100),
    geo_lat FLOAT,
    geo_lon FLOAT,
    geo_city VARCHAR(100),
    geo_state VARCHAR(100)
    
);


CREATE TABLE public.order_items
(   order_id VARCHAR(100) ,
    order_item_id INTEGER,
    product_id VARCHAR(100) ,
    seller_id VARCHAR(100),
    shipping_limit_date TIMESTAMP,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2)
    
);


CREATE TABLE public.order_payments
(   order_id VARCHAR(100),
    payment_sequential INTEGER,
    payment_type VARCHAR(100),
    payment_installments INTEGER,
    payment_value DECIMAL(10, 2)
    
);

CREATE TABLE public.order_reviews
(   review_id VARCHAR(100),
    order_id VARCHAR(100),
    review_score INTEGER,
    survey_sent_date TIMESTAMP,
    survey_answer_date TIMESTAMP
);

CREATE TABLE public.orders
(   order_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(100),
    order_status VARCHAR(100),
    purchase_date TIMESTAMP,
    approved_date TIMESTAMP,
    sent_to_carrier_date TEXT , --NULL timestamp 
    delivered_customer_date TIMESTAMP ,
    estimated_delivery_date TEXT --NULL timestamp 
);

CREATE TABLE public.products
(   product_id VARCHAR(100) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INTEGER,
    description_lenght INTEGER,
    product_photos_qty INTEGER,
    weight_g INTEGER,
    length_cm INTEGER,
    height_cm INTEGER,
    width_cm INTEGER
    
);


CREATE TABLE public.sellers
(   seller_id VARCHAR(100) PRIMARY KEY,
    seller_zip_code VARCHAR(100),
    seller_city VARCHAR(100),
    seller_state VARCHAR(100)
    
);

CREATE TABLE public.category_translation
(   category_portug VARCHAR(100),
    category_eng VARCHAR(100)
    
);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.customers OWNER to postgres;
ALTER TABLE public.geolocation OWNER to postgres;
ALTER TABLE public.order_items OWNER to postgres;
ALTER TABLE public.order_payments OWNER to postgres;
ALTER TABLE public.order_reviews OWNER to postgres;
ALTER TABLE public.orders OWNER to postgres;
ALTER TABLE public.sellers OWNER to postgres;
ALTER TABLE public.products OWNER to postgres;
ALTER TABLE public.category_translation OWNER to postgres;