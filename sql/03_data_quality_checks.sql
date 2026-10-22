-- 1. Check missing customer names and cities
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN customer_name IS NULL THEN 1
        ELSE 0
    END) AS missing_customer_names,
    SUM(CASE
        WHEN city IS NULL THEN 1
        ELSE 0
    END) AS missing_cities
FROM customers;


-- 2. Check duplicate customer names
SELECT
    customer_name,
    COUNT(*) AS name_count
FROM customers
GROUP BY customer_name
HAVING COUNT(*) > 1;


-- 3. Check invalid quantities and unit prices
SELECT
    COUNT(*) AS total_order_details,
    SUM(CASE
        WHEN quantity <= 0 THEN 1
        ELSE 0
    END) AS invalid_quantities,
    SUM(CASE
        WHEN unit_price <= 0 THEN 1
        ELSE 0
    END) AS invalid_unit_prices
FROM order_details;


-- 4. Check orders with missing customer references
SELECT
    o.order_id,
    o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 5. Check order details with missing order or product references
SELECT
    od.order_detail_id,
    od.order_id,
    od.product_id
FROM order_details AS od
LEFT JOIN orders AS o
    ON od.order_id = o.order_id
LEFT JOIN products AS p
    ON od.product_id = p.product_id
WHERE o.order_id IS NULL
   OR p.product_id IS NULL;