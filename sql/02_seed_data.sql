PRAGMA foreign_keys = ON;

DELETE FROM order_items;
DELETE FROM orders;
DELETE FROM products;
DELETE FROM customers;

WITH RECURSIVE seq(n) AS (
    SELECT 1 UNION ALL SELECT n + 1 FROM seq WHERE n < 120
)
INSERT INTO customers (customer_id, first_name, last_name, email, city, signup_date)
SELECT
    n,
    CASE n % 8
        WHEN 0 THEN 'Aarav' WHEN 1 THEN 'Maya' WHEN 2 THEN 'Liam' WHEN 3 THEN 'Sofia'
        WHEN 4 THEN 'Noah'  WHEN 5 THEN 'Priya' WHEN 6 THEN 'Ethan' ELSE 'Zara'
    END,
    CASE (n * 5) % 6
        WHEN 0 THEN 'Patel' WHEN 1 THEN 'Nguyen' WHEN 2 THEN 'Garcia'
        WHEN 3 THEN 'Khan'  WHEN 4 THEN 'Smith'  ELSE 'Kumar'
    END,
    'customer' || n || '@shopsmart.example',
    CASE n % 5
        WHEN 0 THEN 'Mumbai' WHEN 1 THEN 'Delhi' WHEN 2 THEN 'Bengaluru'
        WHEN 3 THEN 'Chennai' ELSE 'Hyderabad'
    END,
    date('2025-01-01', '+' || (n % 30) || ' days')
FROM seq;

WITH RECURSIVE seq(n) AS (
    SELECT 1 UNION ALL SELECT n + 1 FROM seq WHERE n < 40
)
INSERT INTO products (product_id, name, category, unit_price)
SELECT
    n,
    CASE n % 4
        WHEN 0 THEN 'Electronics' WHEN 1 THEN 'Home'
        WHEN 2 THEN 'Grocery'     ELSE 'Clothing'
    END || ' Item ' || n,
    CASE n % 4
        WHEN 0 THEN 'Electronics' WHEN 1 THEN 'Home'
        WHEN 2 THEN 'Grocery'     ELSE 'Clothing'
    END,
    ROUND(9.99 + ((n * 53) % 300), 2)
FROM seq;

WITH RECURSIVE seq(n) AS (
    SELECT 1 UNION ALL SELECT n + 1 FROM seq WHERE n < 500
)
INSERT INTO orders (order_id, customer_id, order_date, status)
SELECT
    n,
    (n % 120) + 1,
    date('2025-02-01', '+' || ((n * 11) % 600) || ' days'),
    CASE WHEN n % 10 = 0 THEN 'cancelled' ELSE 'completed' END
FROM seq;

WITH RECURSIVE seq(n) AS (
    SELECT 1 UNION ALL SELECT n + 1 FROM seq WHERE n < 1200
),
picked AS (
    SELECT
        n,
        ((n - 1) % 500) + 1 AS order_id,
        ((n * 7) % 40) + 1  AS product_id,
        (n % 4) + 1         AS quantity
    FROM seq
)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price)
SELECT p.n, p.order_id, p.product_id, p.quantity, pr.unit_price
FROM picked p
JOIN products pr ON p.product_id = pr.product_id;
