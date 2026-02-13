-- STAGING LAYER (Data Cleaning & Standardization)
-- Purpose: Clean raw data, handle NULLs, and standardized types.
-- Database: demo1_ecommerce_staging

DROP DATABASE IF EXISTS demo1_ecommerce_staging;
CREATE DATABASE demo1_ecommerce_staging;
USE demo1_ecommerce_staging;

-- 1. Staging Customers
CREATE VIEW stg_customers AS
SELECT 
    id AS customer_id,
    TRIM(full_name) AS customer_name,
    COALESCE(city, 'Unknown') AS city,
    UPPER(state_code) AS state_code,
    channel_type,
    created_at AS signup_timestamp
FROM demo1_ecommerce_raw.raw_customers;

-- 2. Staging Products
CREATE VIEW stg_products AS
SELECT 
    id AS product_id,
    name AS product_name,
    category AS product_category,
    price AS base_price,
    vendor_id,
    stock_qty
FROM demo1_ecommerce_raw.raw_products;

-- 3. Staging Orders
CREATE VIEW stg_orders AS
SELECT 
    order_id,
    customer_id,
    LOWER(status) AS order_status,
    order_timestamp,
    approved_at,
    shipped_at,
    delivered_at,
    shipping_region_id
FROM demo1_ecommerce_raw.raw_orders;

-- 4. Staging Order Items
CREATE VIEW stg_order_items AS
SELECT 
    item_id,
    order_id,
    product_id,
    unit_price,
    quantity,
    COALESCE(discount_amount, 0) AS discount_amount,
    (unit_price * quantity) - COALESCE(discount_amount, 0) AS net_revenue
FROM demo1_ecommerce_raw.raw_order_items;

-- 5. Staging Payments
CREATE VIEW stg_payments AS
SELECT 
    payment_id,
    order_id,
    payment_method,
    amount,
    payment_status,
    processed_at
FROM demo1_ecommerce_raw.raw_payments;

-- 6. Staging Vendors
CREATE VIEW stg_vendors AS
SELECT 
    vendor_id,
    vendor_name,
    country
FROM demo1_ecommerce_raw.raw_vendors;
