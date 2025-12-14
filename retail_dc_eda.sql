create table retail_sale
like `sql - retail sales analysis_utf`;

insert into retail_sale
select * from `sql - retail sales analysis_utf`;

select*from retail_sale;

with retail_cte as
(
select *,
row_number() over(partition by ï»¿transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantiy, price_per_unit, cogs, total_sale) as row_num
from retail_sale
)
select*from retail_cte ;
select count(*) from retail_sale;

select count(distinct(customer_id)) from retail_sale;

select * from retail_sale where sale_date='2022-11-05';

select * from retail_sale 
where category='Clothing' and sale_date like '2022-11%' and quantiy>=4;

select category , sum(total_sale),count(*) as total_orders
from retail_sale group by category;

select round(avg(age),2) from retail_sale where category='Beauty';

select * from retail_sale where total_sale>1000;

select count(*),gender,category as total_transactions from retail_sale
group by gender,category order by 2;

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
limit 1;

select customer_id,sum(total_sale) as total_sales from retail_sale 
group by 1
order by 2 desc 
limit 5;

select count(distinct(customer_id)) ,category 
from retail_sale group by category;

with hour_sale as 
(
select sale_time,
case
when extract(hour from sale_time )<12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sale
)
select count(*) as total_orders,shift from hour_sale
group by shift;
 
