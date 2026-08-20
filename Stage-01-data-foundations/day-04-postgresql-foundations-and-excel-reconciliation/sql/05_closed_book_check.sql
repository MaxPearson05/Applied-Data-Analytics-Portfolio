-- Query 1: preview data
select*
from analytics_sprint.financials 
limit 10;

-- Query 2: filter and sort
select
	country,
	product,
	sales,
	profit  
from analytics_sprint.financials 
where country = 'Germany'
order by sales desc;

--Query 3: aggregate by product
select 
product,
count(gross_sales) as record_count,
sum(sales) as total_sales,
sum(profit) as total_profit
from analytics_sprint.financials
group by product
order by total_profit desc;

-- Query 4: count losses by country
select 
country,
count(*) as total_records,
count(*) filter(where profit < 0) as loss_making_records
from analytics_sprint.financials
group by country
order by loss_making_records desc;

-- Task 5- explain the theory
-- Where:filters individual rows before they are grouped or aggregated
-- Having:filters grouped results after calculations such as sum or count
