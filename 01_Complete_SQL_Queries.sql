
-- ============================================================
-- E-commerce Sales Analysis using MySQL
-- Author: Md Ziyauddin
-- Database: ecommerce_sales
-- MySQL Version: 9.3.0
--
-- Note:
-- This file contains combined SQL queries for data quality
-- checks and sales analysis.
-- The dataset contains fictional sample data.
--
-- Workflow:
-- 1. Database Setup
-- 2. Data Quality Checks
-- 3. Sales Analysis
-- ============================================================

USE ecommerce_sales;


-- ============================================================
-- SECTION 1: DATA QUALITY CHECKS
-- ============================================================


-- 1. Check Missing Customer Names and Cities

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN customer_name IS NULL
          OR TRIM(customer_name) = ''
        THEN 1 ELSE 0
    END) AS missing_customer_names,
    SUM(CASE
        WHEN city IS NULL
          OR TRIM(city) = ''
        THEN 1 ELSE 0
    END) AS missing_cities
FROM customers;


-- 2. Check Duplicate Customer Names

SELECT
    customer_name,
    COUNT(*) AS name_count
FROM customers
WHERE customer_name IS NOT NULL
  AND TRIM(customer_name) <> ''
GROUP BY customer_name
HAVING COUNT(*) > 1;


-- 3. Check Invalid Quantities and Unit Prices

SELECT
    COUNT(*) AS total_order_details,
    SUM(CASE
        WHEN quantity IS NULL OR quantity <= 0
        THEN 1 ELSE 0
    END) AS invalid_quantities,
    SUM(CASE
        WHEN unit_price IS NULL OR unit_price <= 0
        THEN 1 ELSE 0
    END) AS invalid_unit_prices
FROM order_details;


-- 4. Check Orders with Missing Customer References

SELECT
    o.order_id,
    o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- 5. Check Order Details with Missing Order or Product References

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


-- ============================================================
-- SECTION 2: SALES ANALYSIS
-- ============================================================


-- 6. Order-wise Total

SELECT
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_details
GROUP BY order_id
ORDER BY order_id;


-- 7. Detailed Order Report

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


-- 8. Total Delivered Sales

SELECT
    SUM(od.quantity * od.unit_price) AS delivered_sales
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.status = 'Delivered';


-- 9. Monthly Delivered Sales

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(od.quantity * od.unit_price) AS monthly_sales
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE o.status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;


-- 10. Category-wise Delivered Sales

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


-- 11. Top 5 Products by Quantity Sold

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


-- 12. Top 5 Products by Revenue

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


-- 13. Customer Spending Analysis
-- Includes only delivered orders.

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


-- 14. Customers with Delivered Spending Above 20,000

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


-- 15. Average Order Value (AOV)
-- Calculated using delivered orders only.

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


-- 16. Repeat Customers
-- Customers with more than one delivered order.

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


-- 17. Customers with Delivered Spending Above 50,000

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
HAVING SUM(od.quantity * od.unit_price) > 50000
ORDER BY total_spending DESC;


-- 18. Customer Spending Categories
-- Thresholds are defined for this sample project.

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


-- 19. Order Status Summary

SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;


-- ============================================================
-- END OF FILE
-- ============================================================
