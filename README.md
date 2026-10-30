# E-commerce Sales Analysis using MySQL

## Project Overview
This project analyzes fictional e-commerce sales data using MySQL to identify sales trends, top-performing products, customer spending patterns, order statuses, and data quality issues.

## Tools and Technologies
- SQL
- MySQL 9.3.0 Command Line Client

## Database Structure
The database contains four related tables:
- `customers` – Customer details
- `products` – Product names, categories, and prices
- `orders` – Order dates and statuses
- `order_details` – Products, quantities, and unit prices for each order

## Analysis Performed
- Checked missing or blank customer names and cities.
- Identified duplicate non-empty customer names.
- Validated quantities and unit prices.
- Checked missing customer, order, and product references.
- Calculated order-wise totals and delivered sales.
- Analyzed monthly and category-wise sales.
- Identified top products by quantity sold and revenue.
- Evaluated customer spending and repeat purchases.
- Calculated average order value.
- Summarized orders by status.

## Key Findings
- Total delivered sales were ₹314,950 across 12 delivered orders.
- Electronics was the highest-sales category, contributing ₹252,000 in delivered sales.
- January 2025 had the highest monthly delivered sales at ₹84,800 in this sample dataset.
- Laptop was the top product by revenue, generating ₹165,000.
- Aarav Sharma had the highest delivered-order spending at ₹123,500.
- The dataset contained 12 delivered orders, 2 pending orders, and 1 cancelled order.
- The performed data quality checks did not identify missing customer names or cities, duplicate non-empty customer names, invalid quantities or unit prices, or missing customer, order, or product references.

## Key Results

| Metric | Result |
|---|---:|
| Total Delivered Sales | ₹314,950 |
| Delivered Orders | 12 |
| Average Order Value (AOV) | ₹26,245.83 |
| Highest-Sales Category | Electronics — ₹252,000 |
| Top Product by Revenue | Laptop — ₹165,000 |
| Highest-Spending Customer | Aarav Sharma — ₹123,500 |
| Most-Sold Product by Quantity | Notebook Pack — 19 units |

### Monthly Delivered Sales

| Month | Sales |
|---|---:|
| January 2025 | ₹84,800 |
| February 2025 | ₹22,250 |
| March 2025 | ₹68,100 |
| April 2025 | ₹65,000 |
| May 2025 | ₹74,800 |

### Data Quality Check Results

The performed checks returned no issues for the following:
- Missing or blank customer names and cities
- Duplicate non-empty customer names
- NULL, zero, or negative quantities and unit prices
- Missing customer references in orders
- Missing order or product references in order details

## SQL Concepts Used
- SELECT, WHERE, ORDER BY, GROUP BY, HAVING
- Aggregate functions: SUM(), COUNT(), AVG()
- JOIN and LEFT JOIN
- Subqueries
- CASE expressions
- Data quality checks

## Project Files
- `sql/01_database_setup.sql` – Database, table creation, and sample data setup queries
- `sql/02_data_quality_checks.sql` – Data quality validation queries
- `sql/03_sales_analysis.sql` – Sales and customer analysis queries
- `01_Complete_SQL_Queries.sql` – Complete collection of data quality checks and sales analysis queries

## Screenshots

### 1. Delivered Sales and Average Order Value
![Delivered Sales and AOV](screenshots/Delivered_Sales_AOV.png)

### 2. Category-wise Sales
![Category-wise Sales](screenshots/Category_Wise_Sales.png)

### 3. Top-selling Products
![Top-selling Products](screenshots/Top_Selling_Products.png)

### 4. Monthly Delivered Sales
![Monthly Delivered Sales](screenshots/Monthly_Delivered_Sales.png)

### 5. Data Quality Checks
![Data Quality Checks](screenshots/Data_Quality_Check.png)

### 6. Duplicate Customer Names Check
![Duplicate Customer Names](screenshots/Duplicate_Customer_Names.png)

## Note
This project uses fictional sample data for learning and demonstration. The findings apply only to this dataset and do not represent a real e-commerce business.

## Author
Md Ziyauddin

GitHub: [ziyauddinofficial01-dev](https://github.com/ziyauddinofficial01-dev)
