-- monthly orders and revenue (completed orders only)
SELECT
    strftime('%Y-%m', o.order_date)             AS month,
    COUNT(DISTINCT o.order_id)                  AS orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)  AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY month
ORDER BY month;

-- month-over-month revenue change
WITH monthly AS (
    SELECT
        strftime('%Y-%m', o.order_date)  AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY month
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(revenue - LAG(revenue) OVER (ORDER BY month), 2) AS revenue_change,
    ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
          / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 1) AS pct_change
FROM monthly
ORDER BY month;
