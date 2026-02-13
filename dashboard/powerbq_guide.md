# Power BI Implementation Guide: E-Commerce Executive Dashboard

This document provides the blueprint for building a professional Power BI dashboard using the `demo1_ecommerce_marts` and `demo1_ecommerce_dashboard` databases.

## 1. Data Connection & Modeling
Connect to your MySQL instance and import the following tables from `demo1_ecommerce_marts`:
- `dim_customers`
- `dim_products`
- `dim_date`
- `fact_orders`
- `fact_payments`

### Relationships (Star Schema)
- `dim_date[date_key]` 1:N `fact_orders[order_date_key]`
- `dim_customers[customer_id]` 1:N `fact_orders[customer_id]`
- `dim_products[product_id]` 1:N `fact_orders` (via items, or join in PQ)
- `fact_orders[order_id]` 1:1 `fact_payments[order_id]`

## 2. Advanced DAX Measures
Create these measures in Power BI for dynamic analysis:

```dax
// 1. Total Revenue
Total Revenue = SUM(fact_orders[total_net_revenue])

// 2. Average Order Value (AOV)
AOV = DIVIDE([Total Revenue], DISTINCTCOUNT(fact_orders[order_id]))

// 3. Month-over-Month Growth %
MoM Growth = 
VAR PrevMonthRevenue = CALCULATE([Total Revenue], PREVIOUSMONTH(dim_date[full_date]))
RETURN DIVIDE([Total Revenue] - PrevMonthRevenue, PrevMonthRevenue)

// 4. Customer Lifetime Value (LTV)
Customer LTV = CALCULATE([Total Revenue]) / DISTINCTCOUNT(fact_orders[customer_id])

// 5. Retention Rate %
Retention Rate = 
VAR ActiveCustomers = DISTINCTCOUNT(fact_orders[customer_id])
VAR PreviousMonthCustomers = CALCULATE(DISTINCTCOUNT(fact_orders[customer_id]), PREVIOUSMONTH(dim_date[full_date]))
RETURN DIVIDE(ActiveCustomers, PreviousMonthCustomers)
```

## 3. Recommended Visualizations

### Top Row: Executive Summary (Cards)
- **Total Revenue**: $ [Total Revenue]
- **Orders**: COUNT(fact_orders[order_id])
- **AOV**: $ [AOV]
- **MoM Growth**: [MoM Growth] (Use conditional formatting: Red for negative, Green for positive)

### Middle Row: Trends & Composition
- **Revenue Trend**: Line Chart (`dim_date[month_name]` vs `[Total Revenue]`)
- **Category Performance**: Treemap (`dim_products[product_category]` vs `[Total Revenue]`)
- **Customer Segments**: Donut Chart (Use the `view_rfm_segments` view: `customer_segment` vs `COUNT(customer_id)`)

### Bottom Row: Advanced Insights
- **Cohort Heatmap**: Matrix visual using `view_retention_cohorts`.
    - Rows: `cohort_month`
    - Columns: `month_number`
    - Values: `active_users`
- **Geographic Sales**: Map visual using `dim_customers[city]` or `[state_code]`.

## 🎨 Theme & Styling
- **Background**: Dark Navy (#0B192E) or Clean White.
- **Color Palette**: 
    - Success: #2ECC71
    - Growth: #3498DB
    - Warning: #F1C40F
    - Alert: #E74C3C
- **Font**: Segoe UI or Roboto.
