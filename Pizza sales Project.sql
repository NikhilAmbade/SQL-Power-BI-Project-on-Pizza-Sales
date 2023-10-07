CREATE DATABASE PIZZA_DB;
use pizza_db;

select * from pizza_sales;
select count(*) from pizza_sales;

# KPI 1-- TOTAL REVENUE

select sum(total_price) as Total_Revenue from pizza_sales; 

# KPI 2 -- AVERAGE ORDER VLAUES

select count(distinct order_id) from pizza_sales;

select (sum(total_price) / count(distinct order_id)) as Average_Order_value
from pizza_sales;

# KPI 3 -- TOTAL PIZZA SOLD

select sum(quantity) as Total_pizza_sold from pizza_sales;

# KPI 4 -- TOTAL ORDER

select count(distinct order_id) from pizza_sales; 

# kpi 5 -- AVERAGE PIZZA PER ORDER

 select round((sum(quantity) / count( distinct order_id))) as Average_Pizza_per_order
 from pizza_sales;
 
 
 # CHART REQUIREMENT
 
# KPI 1 -- DAILY TREND FOR TOTAL ORDERS

select
	dayname(str_to_date(order_date, '%d-%m-%y')) as Dayname,
    count(distinct order_id) as Total_orders
from pizza_sales
group by 1;

# KPI 2 -- MONTHLY TREND FOR TOTAL ORDERS

SELECT
	monthname(str_to_date(order_date, '%d-%m-%y')) as Monthname,
    count(distinct order_id) as Total_orders
from pizza_sales
group by 1
order by 2 desc;

# KPI 3 -- PERCENTAGE OF SALES BY PIZZA CATEGORY


select
	pizza_category,
    truncate(sum(total_price) * 100 / ( select sum(total_price) from pizza_sales),2) as Percent_of_Total
from pizza_sales
group by 1;


select monthname(str_to_date(order_date, '%d-%m-%y')) as Months,
	pizza_category, 
    sum(total_price) as Total_sales,
    truncate(sum(total_price) * 100 / ( select sum(total_price) from pizza_sales
							where monthname(str_to_date(order_date, '%d-%m-%y')) = "January"),2) as Percent_of_Total
from pizza_sales
where monthname(str_to_date(order_date, '%d-%m-%y')) = "January"
group by 1,2;


SELECT order_date, sum(total_price)
FROM pizza_sales
where order_date between '01-01-2015' and '31-01-2015'
group by order_date;


# KPI 4 -- PERCENTAGE OF SALES PIZZA SIZE

SELECT DISTINCT PIZZA_SIZE FROM PIZZA_SALES;
SELECT * FROM PIZZA_SALES;

select 
	pizza_size,sum(total_price),
    sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as Percent_by_pizza_size
from
	pizza_sales
group by pizza_size
order by Percent_by_pizza_size desc;

# KPI 5 -- TOTAL PIZZA SOLD BY PIZZA CATEGORY

select
	pizza_category,
    count(pizza_id) as Number_of_Pizza
from
	pizza_sales
group by pizza_category;

# KPI 6 -- TOP 5 PIZZA BY REVENUE

select
	pizza_name,
	sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc
limit 5;

#  KPI 6 -- BOTTOM 5 PIZZA BY REVENUE
select
	pizza_name,
	sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue ASC
limit 5;

