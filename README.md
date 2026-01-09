# E-Commerce Analytics Portfolio

## Overview

A comprehensive **production-ready SQL project** featuring a complete e-commerce analytics data warehouse. This project demonstrates expert-level SQL skills including **Star Schema design**, **data generation**, **SQL optimization**, and **business intelligence queries**.

## Key Specifications

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

- Customer lifetime value analysis
- Product performance metrics
- Revenue trends and forecasting
- Customer segmentation
- Order fulfillment analytics

---

## 🚀 Getting Started

### Prerequisites

- MySQL 5.7 or higher
- MySQL CLI or any MySQL client (DBeaver, Workbench, etc.)
- Basic SQL knowledge

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AkshatSemwall/sql-project.git
   cd sql-project
   ```

2. **Create the database**
   ```bash
   mysql -u root -p < schema.sql
   ```

3. **Verify the data**
   ```sql
   USE ecommerce_analytics;
   SELECT COUNT(*) as total_customers FROM demo1_customers;
   SELECT COUNT(*) as total_orders FROM demo1_orders;
   ```

---

## 📈 Sample Queries

### Top 10 Customers by Revenue

```sql
SELECT 
  c.customer_id,
  c.customer_name,
  COUNT(DISTINCT o.order_id) as order_count,
  SUM(oi.quantity * oi.price) as total_revenue
FROM demo1_customers c
JOIN demo1_orders o ON c.customer_id = o.customer_id
JOIN demo1_order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;
```

### Monthly Revenue Trend

```sql
SELECT 
  DATE_FORMAT(o.order_date, '%Y-%m') as month,
  COUNT(DISTINCT o.order_id) as order_count,
  ROUND(SUM(oi.quantity * oi.price), 2) as total_revenue,
  ROUND(SUM(oi.quantity * oi.price) / COUNT(DISTINCT o.order_id), 2) as aov
FROM demo1_orders o
JOIN demo1_order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;
```

### Product Performance Analysis

```sql
SELECT 
  p.product_id,
  p.product_name,
  p.product_category,
  COUNT(oi.order_item_id) as units_sold,
  ROUND(SUM(oi.quantity * oi.price), 2) as revenue,
  ROUND(AVG(oi.price), 2) as avg_price
FROM demo1_products p
LEFT JOIN demo1_order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.product_category
ORDER BY revenue DESC;
```

## 🎯 Use Cases

- **Learning**: Perfect for SQL beginners to advanced learners
- **Interview Prep**: Real-world SQL patterns and optimization techniques
- **Portfolio Building**: Demonstrate SQL expertise to employers
- **Analytics**: Complete example of a data warehouse architecture
- **Teaching**: Great resource for teaching database design concepts

---

## 🔒 Data Privacy

All customer and order data is **synthetically generated** using deterministic algorithms. No real personal data is included in this project.

---

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👨‍💻 Author

**Akshat Semwall**
- GitHub: [@AkshatSemwall](https://github.com/AkshatSemwall)
- Location: Dehradun, Uttarakhand, India

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Report bugs and issues
- Suggest new features or queries
- Improve documentation
- Optimize existing queries

Please create a Pull Request with detailed descriptions of your changes.

---

## ❓ FAQ

**Q: Can I use this for production?**
A: This is a demonstration project with synthetic data. For production use, ensure proper backup and security measures.

**Q: How often is the data updated?**
A: The data is static and deterministic. You can regenerate it anytime by re-running the data.sql script.

**Q: What SQL concepts are covered?**
A: JOINs, aggregation, window functions, CTEs, subqueries, indexing, and query optimization.

---

## 📞 Support

For questions or issues, please open an issue on GitHub or reach out via email.

---

**Last Updated**: January 2026
