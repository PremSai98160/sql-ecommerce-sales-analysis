-- Question 6: What is the revenue contribution of the top 10% of customers?
-- Finding: Top 10% of customers drive 41% of total revenue ($5.4M of $13.2M)
-- Healthier distribution than typical e-commerce (usually 60-70% from top 10%)
-- Indicates broad customer base not overly dependent on high spenders
-- Recommendation: Introduce VIP loyalty program for top 10% to protect
-- this critical revenue segment while growing the bottom 90%

WITH customer_revenue AS (
    SELECT 
        c.customer_unique_id,
        ROUND(SUM(oi.price)::numeric, 2) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
percentiles AS (
    SELECT 
        customer_unique_id,
        total_spent,
        NTILE(10) OVER (ORDER BY total_spent DESC) AS decile
    FROM customer_revenue
)
SELECT 
    CASE WHEN decile = 1 THEN 'Top 10%' ELSE 'Bottom 90%' END AS customer_segment,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_spent)::numeric, 2) AS total_revenue,
    ROUND(100.0 * SUM(total_spent) / SUM(SUM(total_spent)) OVER(), 2) AS revenue_percentage
FROM percentiles
GROUP BY CASE WHEN decile = 1 THEN 'Top 10%' ELSE 'Bottom 90%' END
ORDER BY total_revenue DESC;