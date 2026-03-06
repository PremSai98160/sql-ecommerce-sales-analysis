-- Question 8: Rolling 3-month average revenue per top category
-- Finding: Health & Beauty (beleza_saude) shows consistent growth
-- from $135 in Sept 2016 to $119K in Aug 2018 -- 880x growth
-- Rolling average smooths out monthly spikes showing true trend
-- All top 5 categories show steady upward trajectory through 2018

WITH monthly_category_revenue AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        p.product_category_name,
        ROUND(SUM(oi.price)::numeric, 2) AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE o.order_status = 'delivered'
    AND p.product_category_name IN (
        'beleza_saude', 'relogios_presentes', 
        'cama_mesa_banho', 'esporte_lazer', 
        'informatica_acessorios'
    )
    GROUP BY month, p.product_category_name
)
SELECT 
    month,
    product_category_name,
    monthly_revenue,
    ROUND(AVG(monthly_revenue) OVER (
        PARTITION BY product_category_name 
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )::numeric, 2) AS rolling_3month_avg
FROM monthly_category_revenue
ORDER BY product_category_name, month;