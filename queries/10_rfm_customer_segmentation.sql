-- Question 10: RFM Customer Segmentation
-- Finding: 16% Champions, 27% Loyal, 32% Potential Loyalists, 17% At Risk, 7% Lost
-- Largest segment is Potential Loyalists -- biggest growth opportunity
-- 17% At Risk customers need immediate re-engagement campaigns
-- Recommendation:
-- Champions: VIP rewards program to maintain loyalty
-- Loyal Customers: Upsell higher value products
-- Potential Loyalists: Targeted discounts to push to loyal tier
-- At Risk: Win-back email campaign with incentives
-- Lost Customers: Final re-engagement offer before removing from active campaigns

WITH rfm_base AS (
    SELECT 
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp)::date AS last_order_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(SUM(oi.price)::numeric, 2) AS monetary
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    SELECT
        customer_unique_id,
        last_order_date,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY last_order_date DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency DESC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary DESC) AS monetary_score
    FROM rfm_base
),
rfm_segments AS (
    SELECT
        customer_unique_id,
        recency_score,
        frequency_score,
        monetary_score,
        (recency_score + frequency_score + monetary_score) AS total_rfm_score,
        CASE
            WHEN (recency_score + frequency_score + monetary_score) >= 13 THEN 'Champions'
            WHEN (recency_score + frequency_score + monetary_score) >= 10 THEN 'Loyal Customers'
            WHEN (recency_score + frequency_score + monetary_score) >= 7 THEN 'Potential Loyalists'
            WHEN (recency_score + frequency_score + monetary_score) >= 5 THEN 'At Risk'
            ELSE 'Lost Customers'
        END AS customer_segment
    FROM rfm_scores
)
SELECT 
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(AVG(monetary_score)::numeric, 2) AS avg_monetary_score,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage_of_customers
FROM rfm_segments
JOIN rfm_base USING (customer_unique_id)
GROUP BY customer_segment
ORDER BY total_customers DESC;