# Retail-Sales-Analysis
This project involves analyzing retail sales data using SQL. The objective is to design, clean, explore, and analyze the dataset to derive meaningful insights and address key business questions.
# Retail Sales Analysis

This project involves analyzing retail sales data using SQL. The objective is to design, clean, explore, and analyze the dataset to derive meaningful insights and address key business questions.

## Features

- **Database Creation**: A database named `sql_project_p2` is created to store retail sales data.
- **Table Schema**: The `retail_sales` table captures transaction details, customer demographics, and product information.
- **Data Import and Validation**: Ensures the data is correctly imported and validates the integrity by checking for null values.
- **Comprehensive SQL Queries**: The project includes queries for data cleaning, exploration, and analysis.

## Table Schema

The `retail_sales` table includes the following fields:

- `transaction_id`: Unique identifier for each transaction.
- `sale_date`: Date of the transaction.
- `sale_time`: Time of the transaction.
- `customer_id`: Unique identifier for customers.
- `gender`: Gender of the customer.
- `age`: Age of the customer.
- `category`: Product category.
- `quantity`: Quantity of items purchased.
- `price_per_unit`: Price per unit of the product.
- `cogs`: Cost of goods sold.
- `total_sale`: Total sale amount.

## Prerequisites

1. A SQL-compatible database management system (DBMS) such as MySQL or PostgreSQL.
2. Access to a SQL client for executing the scripts.

## Usage

1. **Database Setup**:
   - Create the database and table.
   - Populate the table with sales data.

2. **Data Import and Validation**:
   - Count the total rows in the dataset to ensure data is correctly imported:
     ```sql
     SELECT COUNT(*) FROM retail_sales;
     ```
   - Identify and remove rows with null values in critical columns:
     ```sql
     SELECT *
     FROM retail_sales
     WHERE transaction_id IS NULL 
       OR sale_date IS NULL
       OR sale_time IS NULL
       OR customer_id IS NULL
       OR gender IS NULL
       OR age IS NULL
       OR category IS NULL
       OR quantity IS NULL
       OR price_per_unit IS NULL
       OR cogs IS NULL
       OR total_sale IS NULL;
     ```

3. **Data Exploration**:
   - Count total sales in the dataset:
     ```sql
     SELECT COUNT(total_sale) FROM retail_sales;
     ```
   - Count the number of unique customers:
     ```sql
     SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
     ```
   - Identify distinct product categories:
     ```sql
     SELECT COUNT(DISTINCT category) FROM retail_sales;
     SELECT DISTINCT category FROM retail_sales;
     ```

4. **Data Analysis**:
   - Use detailed SQL queries to answer key business questions.

## Key Questions and Queries

### 1. Retrieve all sales made on a specific date (e.g., `2022-11-05`):
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```
**Purpose**: Identify all transactions that occurred on a specific date.

### 2. Retrieve transactions where the category is 'Clothing' and quantity > 4 in Nov-2022:
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity > 4;
```
**Purpose**: Filter transactions for a specific category with conditions on quantity and date.

### 3. Calculate total sales for each category:
```sql
SELECT category, SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;
```
**Purpose**: Summarize sales by product category.

### 4. Find the average age of customers in the 'Beauty' category:
```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```
**Purpose**: Analyze customer demographics for the 'Beauty' category.

### 5. Retrieve transactions where total_sale > 1000:
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```
**Purpose**: Identify high-value transactions.

### 6. Count transactions by gender in each category:
```sql
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender;
```
**Purpose**: Understand gender distribution across product categories.

### 7. Calculate average sales for each month and identify the best-selling month:
```sql
SELECT year, month, avg_sale
FROM (
  SELECT EXTRACT(YEAR FROM sale_date) AS year,
         EXTRACT(MONTH FROM sale_date) AS month,
         AVG(total_sale) AS avg_sale,
         RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
  FROM retail_sales
  GROUP BY year, month
) AS monthly_sales
WHERE rank = 1;
```
**Purpose**: Determine seasonal trends in sales.

### 8. Find the top 5 customers based on total sales:
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```
**Purpose**: Identify high-value customers.

### 9. Count unique customers for each category:
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```
**Purpose**: Measure customer diversity across categories.

### 10. Categorize transactions by shift (Morning, Afternoon, Evening):
```sql
WITH hourly_sales AS (
  SELECT *,
         CASE
           WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
         END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;
```
**Purpose**: Analyze transaction patterns by time of day.


## Findings

- **Customer Demographics**: The analysis covers a diverse set of customers across various age groups. This includes sales trends segmented by product categories like Clothing and Beauty.
- **High-Value Transactions**: Several transactions recorded a total sale exceeding 1000 units, showcasing the presence of premium or bulk purchases.
- **Sales Trends**: Monthly and shift-based sales trends highlight seasonal variations and optimal transaction timings, providing insights into peak sales periods.
- **Customer Insights**: Top-spending customers were identified, along with the most popular product categories, giving clarity on customer behavior and product performance.

## Reports

- **Sales Summary**: Provides a consolidated view of total sales, customer demographics, and product category performance.
- **Trend Analysis**: Focuses on monthly sales patterns and temporal shifts (e.g., Morning, Afternoon, Evening).
- **Customer Insights**: Details about top-performing customers and unique customer counts across categories.



## Conclusion

This project showcases the application of SQL in retail data analysis. From data cleaning to advanced query execution, the analysis highlights critical business insights, including customer behavior, sales performance, and seasonal trends. These findings provide actionable strategies for improving business operations and decision-making.

