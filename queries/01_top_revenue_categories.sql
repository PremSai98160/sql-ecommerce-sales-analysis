-- Question 1: Which product categories generate the most revenue?
-- Finding: Health & Beauty leads with $1.25M despite not having the most orders
-- This suggests higher average order value compared to other categories

SELECT 
    p.product_category_name,
    ROUND(SUM(oi.price)::numeric, 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;