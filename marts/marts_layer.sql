-- MARTS LAYER (Business Semantic Layer - Star Schema)
-- Purpose: Production-ready Star Schema with Surrogate Keys and Optimized Indexing.
-- Database: demo1_ecommerce_marts

DROP DATABASE IF EXISTS demo1_ecommerce_marts;
CREATE DATABASE demo1_ecommerce_marts;
USE demo1_ecommerce_marts;

-- 1. DIMENSION: dim_date
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day_of_week TINYINT,
    day_name VARCHAR(10),
    month_val TINYINT,
    month_name VARCHAR(10),
    quarter TINYINT,
    year_val INT,
    is_weekend BOOLEAN
);

-- Stored Procedure to populate dim_date
DELIMITER //
CREATE PROCEDURE sp_populate_dim_date(start_date DATE, end_date DATE)
BEGIN
    DECLARE curr_date DATE;
    SET curr_date = start_date;
    WHILE curr_date <= end_date DO
        INSERT INTO dim_date (date_key, full_date, day_of_week, day_name, month_val, month_name, quarter, year_val, is_weekend)
        VALUES (
            REPLACE(curr_date, '-', ''),
            curr_date,
            DAYOFWEEK(curr_date),
            DAYNAME(curr_date),
            MONTH(curr_date),
            MONTHNAME(curr_date),
            QUARTER(curr_date),
            YEAR(curr_date),
            IF(DAYOFWEEK(curr_date) IN (1, 7), 1, 0)
        );
        SET curr_date = DATE_ADD(curr_date, INTERVAL 1 DAY);
    END WHILE;
END //
DELIMITER ;

CALL sp_populate_dim_date('2024-01-01', '2026-12-31');

-- 2. DIMENSION: dim_customers
CREATE TABLE dim_customers (
    customer_sk INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state_code CHAR(2),
    channel_type VARCHAR(20),
    signup_timestamp TIMESTAMP,
    INDEX (customer_id)
);

INSERT INTO dim_customers (customer_id, customer_name, city, state_code, channel_type, signup_timestamp)
SELECT * FROM demo1_ecommerce_staging.stg_customers;

-- 3. DIMENSION: dim_products
CREATE TABLE dim_products (
    product_sk INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    base_price DECIMAL(10,2),
    vendor_id INT,
    INDEX (product_id)
);

INSERT INTO dim_products (product_id, product_name, product_category, base_price, vendor_id)
SELECT product_id, product_name, product_category, base_price, vendor_id 
FROM demo1_ecommerce_staging.stg_products;

-- 4. FACT: fact_orders
CREATE TABLE fact_orders (
    order_sk INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    order_date_key INT,
    status VARCHAR(20),
    total_quantity INT,
    total_net_revenue DECIMAL(15,2),
    INDEX (order_id),
    INDEX (customer_id),
    INDEX (order_date_key)
);

INSERT INTO fact_orders (order_id, customer_id, order_date_key, status, total_quantity, total_net_revenue)
SELECT 
    o.order_id, 
    o.customer_id, 
    REPLACE(DATE(o.order_timestamp), '-', ''),
    o.order_status,
    SUM(oi.quantity),
    SUM(oi.net_revenue)
FROM demo1_ecommerce_staging.stg_orders o
JOIN demo1_ecommerce_staging.stg_order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.customer_id, o.order_timestamp, o.order_status;

-- 5. FACT: fact_payments
CREATE TABLE fact_payments (
    payment_sk INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT,
    order_id INT,
    payment_method VARCHAR(20),
    amount DECIMAL(15,2),
    payment_status VARCHAR(20),
    processed_at TIMESTAMP,
    INDEX (order_id)
);

INSERT INTO fact_payments (payment_id, order_id, payment_method, amount, payment_status, processed_at)
SELECT * FROM demo1_ecommerce_staging.stg_payments;
