-- revenue by category (completed orders only)
SELECT
    p.category,
    COUNT(DISTINCT oi.order_id)                AS orders,
    SUM(oi.quantity)                           AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM order_items oi
JOIN orders o   ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status <> 'cancelled'
GROUP BY p.category
ORDER BY revenue DESC;

-- top 10 products by revenue
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM order_items oi
    JOIN orders o   ON o.order_id = oi.order_id
    JOIN products p ON p.product_id = oi.product_id
    WHERE o.status <> 'cancelled'
    GROUP BY p.product_id, p.name, p.category
)
SELECT
    product_id,
    name,
    category,
    ROUND(revenue, 2) AS revenue,
    ROUND(100.0 * revenue / (SELECT SUM(revenue) FROM product_revenue), 2) AS pct_of_total,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM product_revenue
ORDER BY revenue DESC
LIMIT 10;

-- products that never sold
SELECT
    p.product_id,
    p.name,
    p.category,
    p.unit_price
FROM products p
WHERE p.product_id NOT IN (
    SELECT oi.product_id
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
    WHERE o.status <> 'cancelled'
)
ORDER BY p.product_id;
