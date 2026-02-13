-- PERFORMANCE & OPTIMIZATION (Enterprise Strategy)
-- Purpose: Query optimization, Indexing Strategy, and Materialized views.
-- Database: demo1_ecommerce_marts

USE demo1_ecommerce_marts;

-- 1. INDEXING STRATEGY (Already partially implemented, but extending for queries)
CREATE INDEX idx_orders_status_date ON fact_orders (status, order_date_key);
CREATE INDEX idx_customers_signup ON dim_customers (signup_timestamp);
CREATE INDEX idx_date_year_month ON dim_date (year_val, month_val);

-- 2. PARTITIONING STRATEGY (Conceptual Example for MySQL)
-- In a real enterprise DB (BigQuery, Snowflake, or Partitioned MySQL):
-- We would partition fact_orders by order_date_key.
/*
ALTER TABLE fact_orders PARTITION BY RANGE (order_date_key) (
    PARTITION p2024 VALUES LESS THAN (20250101),
    PARTITION p2025 VALUES LESS THAN (20260101),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);
*/

-- 3. MATERIALIZED REPORTING TABLES (Pre-aggregated for dashboards)
-- Purpose: Speed up dashboard queries by 100x.
CREATE TABLE agg_monthly_sales_summary AS
SELECT 
    d.year_val,
    d.month_val,
    d.month_name,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.total_net_revenue) AS total_revenue
FROM fact_orders f
JOIN dim_date d ON f.order_date_key = d.date_key
GROUP BY d.year_val, d.month_val, d.month_name;

CREATE INDEX idx_agg_sales_date ON agg_monthly_sales_summary (year_val, month_val);

-- 4. QUERY OPTIMIZATION EXAMPLES (EXPLAIN Plan gold)
-- Example: Using the pre-aggregated table vs raw fact table
-- Query 1 (Direct):
-- SELECT SUM(total_net_revenue) FROM fact_orders WHERE order_date_key BETWEEN 20250101 AND 20250131;
-- Query 2 (Optimized):
-- SELECT total_revenue FROM agg_monthly_sales_summary WHERE year_val = 2025 AND month_val = 1;
