CREATE VIEW V_order_lines AS
SELECT
     o.order_id,
     o.order_date,
     o.customer_id,
     oi.product_id,
     p.category,
     oi.quantity,
     oi.quantity * p.unit_price AS line_total
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products P  ON p.product_id = oi.product_id;

SELECT category, ROUND(SUM(line_total), 2) AS revenue
FROM V_order_lines
GROUP BY category
ORDER BY revenue DESC;

CREATE INDEX idx_orders_customer   ON orders(customer_id);
CREATE INDEX idx_items_order  ON order_items(order_id);
CREATE INDEX idx_items_product  ON order_items(product_id);


EXPLAIN QUERY PLAN
SELECT * FROM orders WHERE customer_id = 42;