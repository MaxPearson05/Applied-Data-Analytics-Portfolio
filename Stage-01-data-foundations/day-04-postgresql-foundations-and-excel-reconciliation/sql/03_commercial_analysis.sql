-- Query 11: Count all financial records
select
	count(*) as total_records
from analytics_sprint.financials;

-- Query 12: Calculate total sales, profit and weighted profit margin
select 	
	round(sum(sales), 2)as total_sales,
	round(sum(profit), 2)as total_profit,
	Round(sum(profit)/nullif(sum(sales),0)*100,2)as weighted_profit_margin_pct
from analytics_sprint.financials;

-- Query 13: Summarise sales and profit by country
select 	
	country,
	COUNT(*) as record_count,
	round(SUM(sales), 2)as total_sales,
	round(SUM(profit), 2)as total_profit,
	round(sum(profit)/nullif(sum(sales),0)*100,2)as weighted_profit_margin_pct
from analytics_sprint.financials
group by country
order by total_sales desc;

-- Query 14: Summarise performance by product
select 
	product,
	count(*) as record_count,
	Round(sum(units_sold), 2)as total_units_sold,
	round(sum(sales), 2)as total_sales,
	round(sum(profit), 2)as total_profit,
	round(sum(profit)/nullif(sum(sales),0)*100,2)as weighted_profit_margin_pct
from analytics_sprint.financials 
group by product
order by total_profit desc;

-- Query 15: Compare performance across customer segments
select 
	segment,
	COUNT(*)as record_count,
	round(sum(sales), 2)as total_sales,
	round(sum(profit), 2)as total_profit,
	round(avg(sales), 2)as average_sales_per_record,
	round(sum(profit)/nullif(sum(sales),0)*100,2)as weighted_profit_margin_pct
from analytics_sprint.financials
group by segment
order by total_sales desc;

-- Query 16: Count loss-making records by country
select 
	country,
	count(*)as total_records,
	count(*)filter(where profit < 0 )as loss_making_records,
	Round(count(*)filter(where profit < 0)*100.0/nullif(count(*),0), 2) as loss_record_rate_pct
from analytics_sprint.financials
group by country
order by loss_making_records desc;

-- Query 17: Compare 2014 country sales against illustrative annual targets
select 	
	country,
	ROUND(SUM(sales), 2) as actual_sales,
	ROUND(MAX(annual_sales_target), 2) as sales_target,
	ROUND(SUM(sales)-MAX(annual_sales_target), 2)as target_variance,
	ROUND(SUM(sales)/NULLIF(MAX(annual_sales_target), 0)*100,2)as target_attainment_pct
from analytics_sprint.financials
where year = 2014
group by country
order by target_attainment_pct desc;

-- Query 18: Summarise monthly sales and profit
select 
	year_month,
	ROUND(sum(sales), 2)as total_sales,
	ROUND(sum(profit), 2)as total_profit,
	ROUND(sum(profit)/NULLif(sum(sales),0)*100,2)as weighted_profit_margin_pct
from analytics_sprint.financials 
group by year_month 
order by year_month asc;

--Query 19: Identify countries with more than 24 million in total sales
select 	
	country,
	ROUND(sum(sales), 2)as total_sales,
	ROUND(sum(profit), 2)as total_profit
from analytics_sprint.financials 
group by country
having sum(sales) > 24000000
order by total_sales desc;

--Query 20: Compare performance by discount band
SELECT
    discount_band,
    COUNT(*) AS record_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(*) FILTER (WHERE profit < 0) AS loss_making_records,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS weighted_profit_margin_pct
FROM analytics_sprint.financials
GROUP BY discount_band
ORDER BY weighted_profit_margin_pct DESC;

