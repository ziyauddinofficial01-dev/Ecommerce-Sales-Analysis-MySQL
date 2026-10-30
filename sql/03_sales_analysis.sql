-- 1. Order-wise total
SELECT
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_details
GROUP BY order_id
ORDER BY order_id;


-- 2. Detailed order report
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status,
    SUM(od.quantity * od.unit_price) AS order_total
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN order_details AS od
    ON o.order_id = od.order_id
GROUP BY
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status
ORDER BY o.order_id;


-- 3. Total delivered sales
SELECT
    SUM(od.quantity * od.unit_price) AS delivered_sales
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.status = 'Delivered';


-- 4. Monthly delivered sales
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(od.quantity * od.unit_price) AS monthly_sales
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;


-- 5. Category-wise delivered sales
SELECT
    p.category,
    SUM(od.quantity * od.unit_price) AS category_sales
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
JOIN products AS p
    ON od.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY category_sales DESC;


-- 6. Top 5 products by quantity sold
SELECT
    p.product_name,
    p.category,
    SUM(od.quantity) AS total_quantity_sold
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
JOIN products AS p
    ON od.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_quantity_sold DESC
LIMIT 5;


-- 7. Top 5 products by revenue
SELECT
    p.product_name,
    p.category,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
JOIN products AS p
    ON od.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_revenue DESC
LIMIT 5;


-- 8. Customer spending analysis
SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity * od.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.status = 'Delivered'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spending DESC;


-- 9. Customers with delivered spending above 20000
SELECT
    c.customer_name,
    SUM(od.quantity * od.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.status = 'Delivered'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(od.quantity * od.unit_price) > 20000
ORDER BY total_spending DESC;


-- 10. Average order value (AOV)
SELECT
    COUNT(*) AS total_delivered_orders,
    SUM(order_total) AS total_delivered_sales,
    AVG(order_total) AS average_order_value
FROM (
    SELECT
        o.order_id,
        SUM(od.quantity * od.unit_price) AS order_total
    FROM orders AS o
    JOIN order_details AS od
        ON o.order_id = od.order_id
    WHERE o.status = 'Delivered'
    GROUP BY o.order_id
) AS order_summary;


-- 11. Repeat customers with more than one delivered order
SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    SUM(od.quantity * od.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.status = 'Delivered'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY delivered_orders DESC, total_spending DESC;


-- 12. Customer spending categories
SELECT
    c.customer_name,
    SUM(od.quantity * od.unit_price) AS total_spending,
    CASE
        WHEN SUM(od.quantity * od.unit_price) > 50000
            THEN 'High'
        WHEN SUM(od.quantity * od.unit_price) > 20000
            THEN 'Medium'
        ELSE 'Low'
    END AS spending_category
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.status = 'Delivered'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spending DESC;


-- 13. Order status summary
SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;
