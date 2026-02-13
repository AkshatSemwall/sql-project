# Portfolio Interview Guide: E-Commerce Data Warehouse

## 💼 Role: Senior Data Engineer / BI Architect

### 1. The Business Problem
"Our marketing team was struggling with customer retention and didn't know which channels were driving high-value customers. The transactional DB was too slow for complex analytics, and data quality was inconsistent."

### 2. High-Level Architecture
- **Infrastructure**: Medallion Architecture (Raw -> Staging -> Marts).
- **Schema**: Star Schema for optimized reporting.
- **Why this design?**: To ensure data lineage, scalability, and high query performance for BI tools like Power BI or Tableau.

### 3. Key Achievements
- **Customer Segmentation**: Implemented RFM scores to identify 'Champions' vs 'At Risk' users.
- **Cohort Analysis**: Built a monthly signup cohort engine to track churn.
- **Performance**: Used indexing and materialized tables to handle enterprise-scale datasets.

### 4. Technical Deep Dive (Q&A)
- **Q: Why use Surrogate Keys?**
  - A: To decouple the warehouse from source system changes and handle SCD (Slowly Changing Dimensions) effectively.
- **Q: How did you handle failed payments?**
  - A: Raw data includes failed attempts, but the `fact_orders` table filters for 'delivered' or 'success' statuses for revenue KPIs while maintaining 'failed' data for churn analysis.
- **Q: Scalability Strategy?**
  - A: Partitioning by `order_date` and using pre-aggregated tables for high-frequency dashboard queries.
