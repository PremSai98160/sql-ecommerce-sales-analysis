-- Question 5: Which customers have made repeat purchases?
-- Finding: Top customer made 15 purchases over 14 months
-- Most loyal customers span 6-14 months of activity
-- One customer placed 6 orders on the same day - likely a bulk buyer or reseller
-- Recommendation: Build a loyalty program targeting customers with 3+ orders
-- to convert them into high value repeat buyers

SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS total_spent,
    MIN(o.order_purchase_timestamp)::date AS first_order,
    MAX(o.order_purchase_timestamp)::date AS last_order
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_orders DESC, total_spent DESC
LIMIT 10;