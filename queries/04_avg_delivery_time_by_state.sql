-- Question 4: What is the average delivery time by state?
-- Finding: São Paulo delivers in 8.8 days vs Roraima at 29.4 days (3x slower)
-- Northern and northeastern states consistently wait 20+ days
-- Recommendation: Invest in regional distribution centers in RR, AP, AM
-- to reduce delivery inequality and improve customer satisfaction in underserved states

SELECT 
    c.customer_state,
    ROUND(AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))/86400)::numeric, 1) AS avg_delivery_days,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
AND o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;