-- Query 1: Dataset validation
select
	count(*) as total_records,
	count(source_row_id) as distinct_source_row_IDS,
	sum(sales) as total_sales,
	sum(profit) as total_profit, 
	min(date) as earliest_date,
	max(date) as latest_date
from analytics_sprint.financials 

-- important to confirm we are analysing the correct, complete dataet before trusting any findings

-- Query 2: Filtered commercial records (2014, France or Germany, Sales above 100000)
select
	product,
	year,
	country,
	sales,
	profit
from analytics_sprint.financials 
where year=2014
	and sales >100000
	and country IN('France', 'Germany')
order by sales desc;

-- Query 3: Product performance including weighted profit margin
select
	product,
	count(*) as number_of_records,
	sum(sales),
	sum(profit),
	Round(sum(profit)/Nullif(sum(sales),0)*100, 2)
from analytics_sprint.financials
group by product;

-- Query 4: Conditional aggregation by country
select 
	country,
	count(*) as total_records,
	count(*) filter (where profit>0) as profitable_records,
	count (*) filter (where profit<0) as loss_making_records,
	round((count(*) filter (where profit<0))*100.0/nullif (count(*),0),2) as loss_rate_pct
from analytics_sprint.financials 
group by country
order by loss_rate_pct desc;

-- Query 5: Countries whose combined sales exceed 20,000,000 including weighted profit margin
select 
	country,
	sum(sales) as total_sales,
	sum(profit) as total_profit,
	round(sum(profit)/nullif(sum(sales),0)*100, 2)
from analytics_sprint.financials 
group by country
having sum(sales) >20000000
order by total_sales desc;

-- Query 6: for every year and monnth return total sales and total profit
select 
	 year,
 	month_number,
 	sum(sales) as total_sales,
 	sum(profit) as total_profit
from analytics_sprint.financials 
group by year, month_number
order by year asc, month_number asc;

