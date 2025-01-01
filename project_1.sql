-- Using database
USE project_1;

-- CREATING TABLE .
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
          transactions_id INT PRIMARY KEY ,
          sale_date	DATE,
		  sale_time	TIME ,
          customer_id	INT,
		  gender VARCHAR(15),
          age INT,
          category VARCHAR(25),	
          quantiy INT,	
		  price_per_unit INT,
          cogs	FLOAT,
          total_sale FLOAT
);

-- importing data here and checking whether imported correctly.
SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales
WHERE  transactions_id IS NULL 
OR 
  sale_date	IS NULL
         OR
		  sale_time	IS NULL
          OR
          customer_id	IS NULL
          OR
		  gender IS NULL
          OR
          age IS NULL
          OR
          category IS NULL
          OR
          quantiy IS NULL
          OR
		  price_per_unit IS NULL
          OR
          cogs	IS NULL
          OR
          total_sale IS NULL ;
          
-- How many sales we have 
  SELECT COUNT(total_sale) FROM  retail_sales;
  
  -- How many customers we have 
  SELECT COUNT(DISTINCT customer_id) FROM  retail_sales;
  
  -- How many category we have 
  SELECT COUNT(DISTINCT category) FROM  retail_sales;
  SELECT DISTINCT category FROM  retail_sales;
  
  -- Business key problems 
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
     SELECT *
     FROM retail_sales 
     WHERE sale_date = '2022-11-05' 
     ;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
     SELECT *
     FROM retail_sales 
     WHERE category = 'Clothing' AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' AND  quantiy >=3;
     
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
     SELECT category ,SUM(total_sale) 
     FROM retail_sales 
     GROUP BY category
     ORDER BY category DESC;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
    SELECT category,
    ROUND(AVG(age),2)
    FROM retail_sales 
    WHERE category = 'Beauty'
    GROUP BY category;
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
    SELECT * 
    FROM retail_sales
    WHERE total_sale > 1000 ;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
   SELECT gender , category , COUNT(transactions_id)
   FROM retail_sales 
   GROUP BY gender , category ;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    *
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS month_rank
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
WHERE month_rank = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
 
 SELECT customer_id , SUM(total_sale) AS sales
 FROM retail_sales
 GROUP BY customer_id
 ORDER BY sales DESC LIMIT 5;
 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category , 
COUNT(DISTINCT customer_id) AS uniq
FROM retail_sales 
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
   SELECT *,
   CASE 
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE'Evening'
   END AS shift
   FROM retail_sales ; 





  