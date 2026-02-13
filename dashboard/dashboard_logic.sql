-- DASHBOARD LAYER (Advanced Analytics & Reporting)
-- Purpose: Implementation of high-level KPIs and business semantic layer.
-- Database: demo1_ecommerce_dashboard

DROP DATABASE IF EXISTS demo1_ecommerce_dashboard;
CREATE DATABASE demo1_ecommerce_dashboard;
USE demo1_ecommerce_dashboard;

-- 1. REVENUE KPIS (Executive View)
CREATE OR REPLACE VIEW view_revenue_kpis AS
SELECT 
    d.year_val,
    d.month_name,
    SUM(f.total_net_revenue) AS monthly_revenue,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(SUM(f.total_net_revenue) / COUNT(DISTINCT f.order_id), 2) AS aov, -- Average Order Value
    COUNT(DISTINCT f.customer_id) AS active_customers
FROM demo1_ecommerce_marts.fact_orders f
JOIN demo1_ecommerce_marts.dim_date d ON f.order_date_key = d.date_key
WHERE f.status = 'delivered'
GROUP BY d.year_val, d.month_val, d.month_name
ORDER BY d.year_val DESC, d.month_val DESC;

-- 2. CUSTOMER LIFETIME VALUE (LTV)
CREATE OR REPLACE VIEW view_customer_ltv AS
SELECT 
    c.customer_id,
    c.customer_name,
    MIN(d.full_date) AS first_purchase_date,
    MAX(d.full_date) AS last_purchase_date,
    DATEDIFF(MAX(d.full_date), MIN(d.full_date)) AS customer_tenure_days,
    COUNT(f.order_id) AS total_orders,
    SUM(f.total_net_revenue) AS total_spent,
    ROUND(SUM(f.total_net_revenue) / COUNT(f.order_id), 2) AS avg_purchase_value
FROM demo1_ecommerce_marts.dim_customers c
JOIN demo1_ecommerce_marts.fact_orders f ON c.customer_id = f.customer_id
JOIN demo1_ecommerce_marts.dim_date d ON f.order_date_key = d.date_key
WHERE f.status = 'delivered'
GROUP BY c.customer_id, c.customer_name;

-- 3. RFM SEGMENTATION (Recency, Frequency, Monetary)
CREATE OR REPLACE VIEW view_rfm_segments AS
WITH rfm_raw AS (
    SELECT 
        customer_id,
        DATEDIFF(NOW(), MAX(d.full_date)) AS recency,
        COUNT(order_id) AS frequency,
        SUM(total_net_revenue) AS monetary
    FROM demo1_ecommerce_marts.fact_orders f
    JOIN demo1_ecommerce_marts.dim_date d ON f.order_date_key = d.date_key
    WHERE f.status = 'delivered'
    GROUP BY customer_id
),
rfm_scores AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score, -- Higher is better (more recent)
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary) AS m_score
    FROM rfm_raw
)
SELECT *,
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 4 AND f_score >= 2 THEN 'Loyal Customers'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Potential Loyalists'
        WHEN r_score >= 4 AND f_score = 1 THEN 'New Customers'
        WHEN r_score <= 2 THEN 'At Risk / Hibernating'
        ELSE 'Others'
    END AS customer_segment
FROM rfm_scores;

-- 4. COHORT ANALYSIS (Monthly Signup Cohorts)
CREATE OR REPLACE VIEW view_retention_cohorts AS
WITH customer_cohorts AS (
    SELECT 
        customer_id,
        DATE_FORMAT(signup_timestamp, '%Y-%m-01') AS cohort_month
    FROM demo1_ecommerce_marts.dim_customers
),
order_activity AS (
    SELECT 
        f.customer_id,
        DATE_FORMAT(d.full_date, '%Y-%m-01') AS activity_month,
        DATEDIFF(DATE_FORMAT(d.full_date, '%Y-%m-01'), cc.cohort_month) / 30 AS month_number
    FROM demo1_ecommerce_marts.fact_orders f
    JOIN demo1_ecommerce_marts.dim_date d ON f.order_date_key = d.date_key
    JOIN customer_cohorts cc ON f.customer_id = cc.customer_id
)
SELECT 
    cohort_month,
    month_number,
    COUNT(DISTINCT customer_id) AS active_users
FROM order_activity
WHERE month_number >= 0
GROUP BY cohort_month, month_number;
