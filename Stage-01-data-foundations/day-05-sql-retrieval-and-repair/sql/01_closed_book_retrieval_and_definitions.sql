-- query definitions
-- 1. WHERE - constraint that applys to individual row
-- 2. GROUP BY - remaining rows after where constraint are then grouped based on common values in the column specified in the groupby
-- 3. HAVING - if query has groupby clause then having clause is appled to grouped rows discarding rows that do not saatisfy the clause
-- 4. FILTER - process of selecting only the rows from table that meet conditions (operators, =,<>,<,>,<=,>=,between,and,in,like,ilike,is null,is not null)
-- 5. weighted profit margin -  
select 	
	round(sum((selling_price - cost_price)*quantity/nullif(sum(selling_price*quantity),0), 4) as weighted_profit_margin
	from sales;
-- summary, sum of total profit/ total revenue prevented by division by 0 and rounded to 4dp
-- 6. why every non-aggregated selected column normally begins by GROUP BY - combines rows into groups based on grouping columns, inside each group you can apply aggregate functions (sum,count,avg,max etc) to summarise data and include grouping columns themselves

-- sql bolt lesson 12 used to check answers 

-- FROM -> WHERE-> GROUPBY-> HAVING -> SELECT-> ORDER BY -> LIMIT

-- Query 1: Validation, total sales, total profit
select
	count(*) as row_count,
	Sum(sales) as total_sales,
	sum(profit) as total_profit
from analytics_sprint.financials;

-- Query 2: Row filtering, return 2014 records with sales above 100,000 sorted from highest to lowest sales
select
	source_row_id,
	country,
	product,
	sales
from analytics_sprint.financials
where year = 2014 
	and sales>100000 
	and country = 'France'
order by sales desc;

-- Query 3: Product performance showing weighted profit margins
select
	product,
	sum(sales) as total_sales,
	sum(profit) as total_profit,
	round(sum(profit)/nullif(sum(sales), 0)*100, 2) as profit_margin
from analytics_sprint.financials
group by product;

-- Query 4: Countries above sales threshold of 20,000,000
select 
	country,
	sum(sales) as total_sales
from analytics_sprint.financials 
group by country 
having sum(sales) > 20000000
order by total_sales desc;

-- Query 5: Country loss analysis
select 
	country,
	count(source_row_id) as loss_count
from analytics_sprint.financials 
where profit < 0
group by country
order by loss_count desc;