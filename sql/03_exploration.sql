-- row counts
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;

-- date ranges
SELECT 'orders' AS dataset, MIN(order_date) AS first_date, MAX(order_date) AS last_date FROM orders
UNION ALL
SELECT 'customer signups', MIN(signup_date), MAX(signup_date) FROM customers;

-- order status distribution
SELECT
    status,
    COUNT(*) AS order_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM orders), 1) AS pct_of_orders
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- integrity checks
SELECT 'orders without a customer' AS check_name, COUNT(*) AS problems
FROM orders o LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL
UNION ALL
SELECT 'order_items without an order', COUNT(*)
FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL
UNION ALL
SELECT 'order_items without a product', COUNT(*)
FROM order_items oi LEFT JOIN products p ON p.product_id = oi.product_id
WHERE p.product_id IS NULL
UNION ALL
SELECT 'orders without items', COUNT(*)
FROM orders o LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.order_item_id IS NULL
UNION ALL
SELECT 'item price differs from product price', COUNT(*)
FROM order_items oi JOIN products p ON p.product_id = oi.product_id
WHERE oi.unit_price <> p.unit_price;
