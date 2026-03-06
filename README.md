# E-Commerce Sales Intelligence

## Business Problem
Analyzed 100K+ real e-commerce orders from Olist, a Brazilian 
marketplace, to uncover revenue trends, top performing products, 
customer segments, and delivery performance issues.

## Tools Used
- PostgreSQL
- SQL (CTEs, Window Functions, JOINs, NTILE, Aggregations)

## Database Schema
7 tables — orders, customers, order_items, order_payments, 
order_reviews, products, sellers

## Key Business Questions & Findings

| # | Question | Key Finding |
|---|---|---|
| 1 | Top revenue categories | Health & Beauty leads with $1.25M |
| 2 | Monthly revenue trend | 25x growth from Oct 2016 to Nov 2017 |
| 3 | Seller cancellation rates | Top seller has 46% cancellation rate |
| 4 | Delivery time by state | São Paulo 8.8 days vs Roraima 29.4 days |
| 5 | Repeat customers | Top customer made 15 purchases over 14 months |
| 6 | Top 10% customer revenue | Top 10% drive 41% of total revenue |
| 7 | Late delivery by month | March 2018 had 21% late delivery rate |
| 8 | Rolling 3-month revenue | Health & Beauty grew 880x in 2 years |
| 9 | City orders vs reviews | Rio de Janeiro state dominates unhappy customers |
| 10 | RFM Segmentation | 32% Potential Loyalists — biggest growth opportunity |

## Business Recommendations
1. **Logistics** — Build regional distribution centers in RR, AP, AM 
   to close the 3x delivery time gap vs São Paulo
2. **Seller Quality** — Suspend sellers above 30% cancellation rate, 
   flag sellers above 15% for review
3. **Customer Retention** — Launch VIP program for Champions (16%) 
   and re-engagement campaign for At Risk segment (17%)
4. **Seasonal Planning** — Pre-scale logistics 30 days before 
   November to prevent late delivery spikes
5. **Revenue Growth** — Focus marketing on Potential Loyalists (32%) 
   to convert them to Loyal Customer tier

## Project Structure
```
queries/
├── 01_top_revenue_categories.sql
├── 02_monthly_revenue_trend.sql
├── 03_seller_cancellation_rate.sql
├── 04_avg_delivery_time_by_state.sql
├── 05_repeat_customers.sql
├── 06_top_customer_revenue.sql
├── 07_late_delivery_rate.sql
├── 08_rolling_3month_revenue.sql
├── 09_city_orders_vs_reviews.sql
└── 10_rfm_customer_segmentation.sql
```

## Status
✅ Complete