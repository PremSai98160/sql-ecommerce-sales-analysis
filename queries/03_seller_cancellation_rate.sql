-- Question 3: Which sellers have the highest order cancellation rate?
-- Finding: Top seller has 46% cancellation rate - nearly 1 in 2 orders cancelled
-- 3 sellers exceed 20% cancellation rate, damaging platform reputation
-- Recommendation: Flag sellers above 15% for review, suspend above 30%

SELECT 
    oi.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(CASE WHEN o.order_status = 'canceled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(100.0 * SUM(CASE WHEN o.order_status = 'canceled' THEN 1 ELSE 0 END) / COUNT(DISTINCT o.order_id), 2) AS cancellation_rate
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT o.order_id) > 10
ORDER BY cancellation_rate DESC
LIMIT 10;