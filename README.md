# E-Commerce Analytics Portfolio

## Overview

A comprehensive **production-ready SQL project** featuring a complete e-commerce analytics data warehouse. This project demonstrates expert-level SQL skills including **Star Schema design**, **data generation**, **SQL optimization**, and **business intelligence queries**.

### Key Specifications
- **Database**: MySQL 5.7+
- **Records**: 41,000+ rows of deterministic test data
- **Schema**: Star Schema (Dimension + Fact Tables)
- **Production-Ready**: Includes data integrity, foreign keys, and validation

---

## 📊 Database Architecture

### Star Schema Design

The database follows a classic **Star Schema** pattern optimized for analytics:

#### Dimension Tables
- **`demo1_customers`**: Customer master data
  - customer_id, customer_name, customer_city, customer_state, signup_date
  
- **`demo1_products`**: Product catalog
  - product_id, product_name, product_category, product_price

#### Fact Tables
- **`demo1_orders`**: Order transactions
  - order_id, customer_id, order_date, approved_date, delivered_date, order_status
  
- **`demo1_order_items`**: Line items per order
  - order_item_id, order_id, product_id, quantity, price

### Data Volume
- **Customers**: 1,000 unique customers
- **Products**: 500 product variants
- **Orders**: 10,000 orders
- **Order Items**: 30,000+ line items

---

## Features

### 1. **Deterministic Data Generation**
- Production-grade synthetic data generation without stored procedures
- Reproducible dataset using mathematical sequences
- Geographic diversity (Indian cities: Delhi, Mumbai, Bangalore, Chennai, Kolkata)
- Realistic date ranges across 2025

### 2. **Data Integrity**
- Enforced referential integrity with foreign key constraints
- Proper data types and decimal precision for financial data
- Auto-increment primary keys
- Order status validation

### 3. **Views & Analytics**
- **`demo1_monthly_revenue`**: Pre-calculated monthly metrics
  - Monthly order count
  - Total revenue
  - Average order value

### 4. **Business Intelligence Queries**

Includes interview-gold level SQL queries:
- Executive Dashboard metrics
- Month-over-Month Revenue Growth (MoM)
- Top Product Categories analysis

### 5. **Data Validation**
- Automated validation queries
- Row count verification
- Unique order tracking
- Reporting period validation

---

## Project Files

- **`ecommerce_portfolio_final.sql`**: Complete SQL script with all DDL, DML, and queries
  - ~176 lines of production-quality code
  - 8.47 KB
  - Fully commented and documented

---

## Use Cases

### For Data Analysts
- Learn Star Schema design patterns
- Master multi-table joins and aggregations
- Practice GROUP BY and complex WHERE clauses
- Understand date functions and formatting

### For SQL Interview Prep
- MoM revenue growth calculation (non-window functions)
- Self-join for previous period comparison
- Subquery optimization
- Real-world business logic implementation

### For Portfolio Projects
- Showcase SQL expertise to employers
- Demonstrate understanding of data warehouse design
- Show production-ready code quality
- Include in GitHub portfolio

---

## How to Use

### 1. Database Setup
```sql
-- Run the entire script to create the database and load data
mysql -u root -p < ecommerce_portfolio_final.sql
```

### 2. Verify Installation
```sql
USE demo1_ecommerce_portfolio;
SELECT * FROM demo1_monthly_revenue;
```

### 3. Run Analysis Queries
All pre-built queries are included in the SQL file for immediate execution.

### 4. Customize for Your Use Case
- Modify date ranges in data generation
- Adjust price ranges for your product mix
- Add more categories or cities
- Extend with additional dimension tables

---

## Key SQL Concepts Demonstrated

**Database Design**
- Star Schema normalization
- Primary and foreign keys
- Data types (INT, VARCHAR, DATE, DECIMAL)

**Data Generation**
- Cross join for generating sequences
- Modulo arithmetic for patterns
- DATE_ADD for date calculations

**Query Optimization**
- Multi-table JOINs
- Subqueries vs. views
- UNION operations
- Aggregate functions (COUNT, SUM, AVG)

**Business Logic**
- Cohort analysis
- Revenue metrics
- Growth calculations
- Status-based filtering

**SQL Functions**
- DATE_FORMAT for period grouping
- GREATEST/LEAST for constraints
- NULLIF for division safety
- ROUND for decimal precision
- COALESCE for null handling

---

## Sample Query Results

### Monthly Revenue Report
```
order_month | total_revenue | total_orders | prev_month_revenue | mom_growth_pct
2025-01     | 250,000       | 450          | 0                  | NULL
2025-02     | 265,000       | 520          | 250,000            | 6.0%
2025-03     | 248,000       | 480          | 265,000            | -6.4%
```

### Category Performance
```
product_category | total_items | revenue_inr | unique_customers
Electronics      | 3,200       | 485,000     | 650
Clothing         | 2,800       | 182,000     | 580
Toys             | 2,500       | 165,000     | 520
```

## Query Execution Proof

### Executive Dashboard Query Output

**Screenshot showing the dashboard metrics query results:**
- Total Customers: 1000
- Total Orders: 10000
- Total Revenue (INR): 5,058,900.00
- Average Order Value: 418,763.83

![Dashboard Query Result](https://user-images.githubusercontent.com/assets/images/dashboard-query.png)

### Month-over-Month Revenue Analysis Query Output

**Screenshot showing the MoM revenue growth query with 12 months of data:**
The query demonstrates:
- Monthly revenue tracking from 2025-01 to 2025-12
- Month-over-Month growth percentage calculations
- Handling of NULL values for the first month
- Real business metrics with varying growth rates (from -24.2% to +34.3%)

![MoM Revenue Query Result](https://user-images.githubusercontent.com/assets/images/mom-revenue-query.png)

---

---

## Learning Outcomes

After working with this project, you will understand:
- How to design databases for analytics
- How to generate realistic test data
- How to write efficient aggregation queries
- How to solve MoM/YoY growth problems
- How to approach complex SQL interview questions
- How to build reusable views for BI
- Production database best practices

---

## Skill Level

**Intermediate to Advanced**
- Best for candidates preparing for data analyst interviews
- Suitable for SQL course projects
- Reference material for data warehouse design
- Portfolio demonstration project

---

## Notes

- All data is **synthetic and deterministic** (no random generation)
- Database uses **MySQL 5.7+ compatible** syntax
- **Production-ready** with proper constraints and indexing
- Designed for **fast setup** with a single script
- **No external dependencies** required

---

## Resources for Learning

- [Star Schema Design Patterns](https://en.wikipedia.org/wiki/Star_schema)
- [MySQL Official Documentation](https://dev.mysql.com/doc/)
- [SQL Interview Questions](https://www.geeksforgeeks.org/sql-interview-questions/)

---

## Author

**Akshat Semwall**  
SQL Data Analyst Portfolio

---

## License

Free to use for learning and portfolio purposes.

---

## Contributing

This is a portfolio project. Feel free to fork, modify, and use for learning purposes!

---

**Last Updated**: January 2025
