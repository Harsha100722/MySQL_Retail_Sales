# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: Retail Sales Database  

This project demonstrates core SQL skills used by data analysts to load data, clean duplicates, perform exploratory data analysis (EDA), and answer real-world business questions using retail sales data.

---

## Objectives

- Create a working sales table from raw data  
- Identify duplicate records  
- Perform exploratory data analysis (EDA)  
- Analyze sales trends and customer behavior  
- Answer business-driven questions using SQL  

---

## Database Setup

### Create Working Table
```sql
CREATE TABLE retail_sale
LIKE `sql - retail sales analysis_utf`;

### Insert Data into Working Table
INSERT INTO retail_sale
SELECT * FROM `sql - retail sales analysis_utf`;     ##Copies all records from the raw table into retail_sale
```
## Data Cleaning

### Detect Duplicate Records 
```sql
WITH retail_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY ï»¿transactions_id, sale_date, sale_time, customer_id, gender,
age, category, quantiy, price_per_unit, cogs, total_sale
) AS row_num
FROM retail_sale
)
SELECT * FROM retail_cte where row_num>1;        ## Records with row_num > 1 indicate duplicates
```
## Exploratory Data Analysis (EDA)
### Business Analysis Queries

# 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
```sql
SELECT * FROM retail_sale
WHERE sale_date = '2022-11-05';
```
# 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
```sql
SELECT * FROM retail_sale
WHERE category = 'Clothing'
AND sale_date LIKE '2022-11%'
AND quantiy >= 4;
```
# 3.Write a SQL query to calculate the total sales (total_sale) for each category:
```sql
SELECT category, SUM(total_sale), COUNT(*) AS total_orders
FROM retail_sale
GROUP BY category;
```
# 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
```sql
** SELECT ROUND(AVG(age), 2)
FROM retail_sale
WHERE category = 'Beauty'; **
```
# 5.Write a SQL query to find all transactions where the total_sale is greater than 1000:
```sql
SELECT * FROM retail_sale
WHERE total_sale > 1000;
```
# 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:
```sql
SELECT COUNT(*), gender, category AS total_transactions
FROM retail_sale
GROUP BY gender, category
ORDER BY gender;
```
# 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
```sql
SELECT sale_year, sale_month, avg_sale
FROM (
    SELECT
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_sale
    FROM retail_sale
    GROUP BY sale_year, sale_month
) t
ORDER BY avg_sale DESC
LIMIT 1;
```
# 8.Write a SQL query to find the top 5 customers based on the highest total sales:
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sale
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```
# 9.Write a SQL query to find the number of unique customers who purchased items from each category:
```sql
SELECT COUNT(DISTINCT customer_id), category
FROM retail_sale
GROUP BY category;
```
# 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
```sql
WITH hour_sale AS 
(
SELECT sale_time,
CASE
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift
FROM retail_sale
)
SELECT COUNT(*) AS total_orders, shift
FROM hour_sale
GROUP BY shift;
```
## Conclusion

This project provides hands-on experience with:
SQL table creation and data loading
Duplicate detection using window functions
Exploratory data analysis
Business-focused SQL queries

It is well-suited for beginner data analysts and can be included as a portfolio or resume project.


