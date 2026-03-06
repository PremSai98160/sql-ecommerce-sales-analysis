-- Question 2: What is the monthly revenue trend over 2 years?
-- Finding: Revenue grew 25x from $40K (Oct 2016) to ~$1M (Nov 2017)
-- November 2017 spike indicates strong Black Friday / seasonal effect
-- Business plateaued at $850K-$977K monthly through 2018

SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price)::numeric, 2) AS monthly_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;