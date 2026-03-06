-- Question 9: Which cities have the most orders but lowest review scores?
-- Finding: Macae and Maceio have lowest scores (3.71, 3.72)
-- Rio de Janeiro state appears 5 times in bottom 10 -- systemic issue
-- Salvador has highest volume (1,172 orders) with low 3.80 score
-- Pattern matches query 4 findings -- longer delivery times drive bad reviews
-- Recommendation: Prioritize logistics improvements in RJ state cities
-- and Salvador to protect review scores and customer retention

SELECT 
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(r.review_score)::numeric, 2) AS avg_review_score
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_city, c.customer_state
HAVING COUNT(DISTINCT o.order_id) > 200
ORDER BY avg_review_score ASC, total_orders DESC
LIMIT 10;