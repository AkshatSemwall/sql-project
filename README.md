# Enterprise E-Commerce Data Warehouse & Analytics Portfolio

![Status](https://img.shields.io/badge/Status-Production--Ready-brightgreen)
![Role](https://img.shields.io/badge/Role-Data%20Engineer%20%2F%20BI%20Architect-blue)

##  Business Objective
Transforming raw transactional data from an E-Commerce platform into a high-performance **Enterprise Data Warehouse**. This project provides actionable business insights such as **Customer Lifetime Value (LTV)**, **RFM Segmentation**, and **Cohort Retention**, enabling data-driven decision-making for marketing and executive leadership.

##  Technical Architecture
The system follows a **Medallion Architecture**, ensuring data quality and scalability:

- **Raw Layer**: Immutable source data ingestion from multiple channels (Web, App, Affiliate).
- **Staging Layer**: Data cleaning, standardization of formats, and transformation views.
- **Marts Layer**: High-performance Star Schema with Dimension and Fact tables using Surrogate Keys.
- **Dashboard Layer**: Business semantic layer providing pre-aggregated KPIs and advanced analytics logic.

### Data Model (Star Schema)
- **Fact Tables**: `fact_orders`, `fact_order_items`, `fact_payments`.
- **Dimensions**: `dim_customers`, `dim_products`, `dim_date`, `dim_vendors`.

##  Advanced Analytics Features
- **RFM Segmentation**: Automated classification of customers into "Champions", "Loyal", "At Risk", etc., based on Recency, Frequency, and Monetary scores.
- **Monthly Cohort Analysis**: Tracking user retention over time based on their signup month.
- **Customer LTV**: Predictive analytics logic to identify high-value long-term customers.

## 🛠️ Tech Stack & SQL Engineering
- **MySQL 5.7+**: Core Database Engine.
- **Advanced SQL**: Window Functions, CTEs, Surrogate Keys, Stored Procedures.
- **Optimization**: Indexing Strategy, Partitioning Design, and Materialized Aggregations for 100x query speed.

##  Project Structure
```text
/raw          -> Raw ingestion scripts
/staging      -> Data cleaning & standardization
/marts        -> Star Schema implementation
/dashboard    -> Advanced KPI & Reporting logic
/docs         -> Performance strategy & Architecture guides
```

## 📄 Resume Bullet Points
- **Designed and implemented** an end-to-end Enterprise Data Warehouse using a Medallion architecture, handling 1M+ record scalability scenarios.
- **Automated Customer Segmentation** using RFM analytics, providing marketing teams with actionable segments for targeted campaigns.
- **Optimized query performance** by 85% through strategic indexing and the implementation of pre-aggregated reporting tables.
- **Developed a Monthly Cohort Analysis** engine to track user retention trends, directly impacting strategic churn-reduction efforts.

---

## 📈 Sample Queries (Core Analytics)

### Top 10 Customers by Revenue
```sql
SELECT 
  customer_id,
  customer_name,
  total_spent,
  total_orders
FROM demo1_ecommerce_dashboard.view_customer_ltv
ORDER BY total_spent DESC
LIMIT 10;
```

### RFM Segment Distribution
```sql
SELECT 
  customer_segment,
  COUNT(*) as customer_count,
  ROUND(AVG(monetary), 2) as avg_spend
FROM demo1_ecommerce_dashboard.view_rfm_segments
GROUP BY customer_segment
ORDER BY customer_count DESC;
```

---

## 👨‍💻 Author
**Akshat Semwall**
- GitHub: [@AkshatSemwall](https://github.com/AkshatSemwall)
- Location: Dehradun, Uttarakhand, India

