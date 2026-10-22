CREATE DATABASE ecommerce_sales;

USE ecommerce_sales;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    registration_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers
    (customer_id, customer_name, city, registration_date)
VALUES
    (1, 'Aarav Sharma', 'Delhi', '2025-01-15'),
    (2, 'Priya Verma', 'Mumbai', '2025-01-20'),
    (3, 'Rahul Kumar', 'Bengaluru', '2025-02-05'),
    (4, 'Sneha Singh', 'Delhi', '2025-02-12'),
    (5, 'Aman Gupta', 'Lucknow', '2025-03-01'),
    (6, 'Neha Patel', 'Ahmedabad', '2025-03-10'),
    (7, 'Rohan Das', 'Kolkata', '2025-03-18'),
    (8, 'Pooja Mishra', 'Mumbai', '2025-04-02'),
    (9, 'Vikram Yadav', 'Jaipur', '2025-04-15'),
    (10, 'Ananya Roy', 'Kolkata', '2025-05-01');

INSERT INTO products
    (product_id, product_name, category, price)
VALUES
    (101, 'Laptop', 'Electronics', 55000.00),
    (102, 'Smartphone', 'Electronics', 25000.00),
    (103, 'Headphones', 'Electronics', 1500.00),
    (104, 'Office Chair', 'Furniture', 7500.00),
    (105, 'Study Table', 'Furniture', 12000.00),
    (106, 'Notebook Pack', 'Stationery', 250.00),
    (107, 'Ball Pen Pack', 'Stationery', 100.00),
    (108, 'Running Shoes', 'Fashion', 3000.00),
    (109, 'Backpack', 'Fashion', 1800.00),
    (110, 'Wrist Watch', 'Accessories', 4500.00);

INSERT INTO orders
    (order_id, customer_id, order_date, status)
VALUES
    (1001, 1, '2025-01-20', 'Delivered'),
    (1002, 2, '2025-01-25', 'Delivered'),
    (1003, 3, '2025-02-10', 'Delivered'),
    (1004, 1, '2025-02-15', 'Delivered'),
    (1005, 4, '2025-02-20', 'Cancelled'),
    (1006, 5, '2025-03-05', 'Delivered'),
    (1007, 6, '2025-03-15', 'Pending'),
    (1008, 2, '2025-03-20', 'Delivered'),
    (1009, 7, '2025-03-25', 'Delivered'),
    (1010, 8, '2025-04-05', 'Delivered'),
    (1011, 3, '2025-04-12', 'Delivered'),
    (1012, 9, '2025-04-20', 'Pending'),
    (1013, 10, '2025-05-05', 'Delivered'),
    (1014, 4, '2025-05-10', 'Delivered'),
    (1015, 1, '2025-05-15', 'Delivered');

INSERT INTO order_details
    (order_detail_id, order_id, product_id, quantity, unit_price)
VALUES
    (1, 1001, 101, 1, 55000.00),
    (2, 1001, 103, 2, 1500.00),
    (3, 1002, 102, 1, 25000.00),
    (4, 1002, 109, 1, 1800.00),
    (5, 1003, 104, 2, 7500.00),
    (6, 1003, 106, 5, 250.00),
    (7, 1004, 103, 1, 1500.00),
    (8, 1004, 110, 1, 4500.00),
    (9, 1005, 105, 1, 12000.00),
    (10, 1006, 108, 2, 3000.00),
    (11, 1006, 107, 10, 100.00),
    (12, 1007, 102, 1, 25000.00),
    (13, 1008, 101, 1, 55000.00),
    (14, 1008, 109, 2, 1800.00),
    (15, 1009, 106, 10, 250.00),
    (16, 1010, 104, 1, 7500.00),
    (17, 1010, 103, 2, 1500.00),
    (18, 1011, 102, 2, 25000.00),
    (19, 1011, 110, 1, 4500.00),
    (20, 1012, 108, 1, 3000.00),
    (21, 1013, 105, 1, 12000.00),
    (22, 1013, 107, 5, 100.00),
    (23, 1014, 109, 1, 1800.00),
    (24, 1014, 106, 4, 250.00),
    (25, 1015, 101, 1, 55000.00),
    (26, 1015, 103, 3, 1500.00);