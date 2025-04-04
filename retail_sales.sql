-- Create table
CREATE TABLE retail_sales
			(
				transactions_id	INT PRIMARY KEY, 
				sale_date DATE,
				sale_time TIME, 	
				customer_id	INT,
				gender VARCHAR (15),
				age	INT,
				category VARCHAR (15),	
				quantiy	INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);

-- DATA CLEANING --
SELECT * FROM retail_sales;

--Identify Null Values
SELECT * FROM retail_sales
where
	transactions_id IS NULL
	or 
	sale_date IS NULL
	or 
	sale_time IS NULL
	or 
	customer_id IS NULL
	or 
	gender IS NULL
	or 
	age IS NULL
	or 
	category IS NULL
	or 
	quantiy IS NULL
	or 
	price_per_unit IS NULL
	or 
	cogs IS NULL
	or 
	total_sale IS NULL;

--Delete Null Values
DELETE FROM retail_sales
where
	transactions_id IS NULL
	or 
	sale_date IS NULL
	or 
	sale_time IS NULL
	or 
	customer_id IS NULL
	or 
	gender IS NULL
	or 
	age IS NULL
	or 
	category IS NULL
	or 
	quantiy IS NULL
	or 
	price_per_unit IS NULL
	or 
	cogs IS NULL
	or 
	total_sale IS NULL;

-- DATA EXPLORATION --

-- How many total sales?
select count(*) as total_sales from retail_sales
-- How many unique customers?
select count (distinct customer_id) as total_sales from retail_sales
--How many unique categories?
select count (distinct category) as total_sales from retail_sales
--What are the categories?
select distinct category from retail_sales

--DATA ANALYSIS

--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date = '2022-11-05'
--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4
--3.Write a SQL query to calculate the total sales (total_sale) for each category
SELECT 
    category,
    SUM(total_sale) as net_sale
FROM retail_sales
GROUP BY 1
--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT
	ROUND(AVG(age), 2) as average_age
FROM retail_sales
WHERE category = 'Beauty'
--5.Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT *
FROM retail_sales
WHERE total_sale > 1000
--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
	COUNT(*) as num_trans,
	category,
	gender
FROM retail_sales
GROUP BY category,
		gender
ORDER BY 1
--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	EXTRACT(YEAR from sale_date) as Year,
	EXTRACT(MONTH from sale_date) as Month,
	AVG(total_sale) as avg_sales
FROM retail_sales
group by 1,2
order by 1,3 DESC
--8.Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
--9.Write a SQL query to find the number of unique customers who purchased items from each category
SELECT
	category,
	COUNT (DISTINCT customer_id)
FROM retail_sales
group by category
--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift