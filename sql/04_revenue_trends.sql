SELECT
     strftime('%y-%m', o.order_date)     AS month,
     ROUND(SUM(oi.quantity * p.unit_price), 2)  AS revenue

FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p  ON p.product_id = oi.product_id
GROUP BY month
ORDER BY month;

SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE 0.order_id IS NULL;