--Query 1: Creating a month-start date
-- "Which reporting month does each financial record belong to"
select 
	f.source_row_id,
	f.date,
	date_trunc('month', f.date) ::date as month_start
from analytics_sprint.financials as f
order by
	f.date,
	f.source_row_id;

-- Query 2: Extract year and month
-- "Which calender year and month does each record belong to?"
select
	f.source_row_id,
	f.date,
	extract(year from f.date)::int as year_number,
	extract(month from f.date)::int as month_number
from analytics_sprint.financials as f 
order by 
	f.date,
	f.source_row_id;

-- Query 3: Monthly Sales and Profit
-- "How did total sales and profit perform each month"
select 
	date_trunc('month', f.date):: date as month_start,
	Round(sum(f.sales), 2) as total_sales,
	Round(sum(f.profit), 2) as total_profit
from analytics_sprint.financials as f
group by month_start;

-- results didnt give back monthly starts but 01-01 for 2013 and 2014

WITH prepared_data AS (
    SELECT
        MAKE_DATE(f.year::int, f.month_number::int, 1) AS month_start,
        f.sales,
        f.profit
    FROM analytics_sprint.financials AS f
)
SELECT
    month_start,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM prepared_data
GROUP BY month_start
ORDER BY month_start;

-- Query 4: Previous month's sales with LAG
-- "How do monthly sales compare with the immediately preceding month"

SELECT
    MAKE_DATE(year::int, month_number::int, 1) AS month_start,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(LAG(SUM(sales)) OVER ( ORDER BY MAKE_DATE(year::int, month_number::int, 1)),
        2) AS previous_month_sales
FROM analytics_sprint.financials
GROUP BY 1
ORDER BY 1;
 
-- Query 5: Monthly sales change
-- "By how much did sales increase or decrease compared with the previous month?"
with monthly_summary as(
	select
		make_date(year::int,month_number::int,1) as month_start,
		sum(sales) as total_sales
	from analytics_sprint.financials
	group by 1),

monthly_comparison as(
	select
		month_start,
		total_sales,
		lag(total_sales) over(order by month_start) as previous_month_sales
		from monthly_summary)
select
	month_start,
	Round(total_sales, 2) as total_sales,
	Round(previous_month_sales, 2) as previous_month_sales,
	ROUND(total_sales-previous_month_sales, 2) as sales_change,
  ROUND(
        (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0)
        * 100,
        2
    ) AS sales_pct_change	from monthly_comparison
	order by month_start;

-- Query 6: Rank Countries by Annual Profit
-- "Which countries generated the most total profit within each year?"

with annual_country_summary as(
	select 
		year,
		country,
		SUM(profit) as total_profit
	from analytics_sprint.financials
group by year, country)

select 
	year,
	country,
	ROUND(total_profit, 2) as total_profit,
	RANK()OVER(partition by year
			order by total_profit desc) as profit_rank
from annual_country_summary
order by 
	year,
	profit_rank,
	country;

-- Query 7: Dense rank products within each country
-- "Which products generated the highest total sales within each country?"
with country_product_summary as(
	select 
		country,
		product,
		sum(sales) as total_sales
	from analytics_sprint.financials
	group by 
		country,
		product)
select
	country,
	product,
	round(total_sales, 2) as total_sales,
	dense_rank()over(partition by country
		order by total_sales desc) as sales_dense_rank
from country_product_summary 
order by 
	country,
	sales_dense_rank,
	product;

-- Query 8: Number of sales records within each country
--"What is the sales position of eevery individual record within its country"
SELECT
    source_row_id,
    country,
    product,
    sales,
    ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY sales DESC, source_row_id
    ) AS sales_row_number
FROM analytics_sprint.financials
ORDER BY
    country,
    sales_row_number;

-- Query 9: Top three profit records per product
-- "What are the three most profitable individual records for every product"

with ranked_records as (
	select
	source_row_id,
	product,
	country,
	profit,
	ROW_NUMBER()over(partition by product
		order by profit desc, source_row_id) as profit_row_number
	from analytics_sprint.financials)
select 
	source_row_id,
	product,
	country,
	profit,
	profit_row_number
from ranked_records 
	where profit_row_number <=3
order by
	product,
	profit_row_number;

-- Query 10: Running total of sales
--"How does total sales accumulate as financial records are processed chronologically"

WITH monthly_summary AS (
    SELECT
        source_row_id,
        country,
        product,
        make_date(year::int, month_number::int, 1) AS month_start,
        SUM(sales) AS total_sales
    FROM analytics_sprint.financials
    GROUP BY source_row_id, country, product, month_start
)
SELECT
    SUM(total_sales) OVER (
        ORDER BY month_start, source_row_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales,
    total_sales,
    month_start,
    country,
    product,
    source_row_id
FROM monthly_summary
ORDER BY month_start, source_row_id;

-- Query 11: 3 Record rolling average of sales
-- "What is the average sales value across the current financial record and the previous two records chronolically?"
SELECT
    date,
    source_row_id,
    sales,

	AVG(sales) OVER (
        ORDER BY date, source_row_id
        ROWS BETWEEN 2 preceding and current row
    ) AS rolling_3_record_avg

FROM analytics_sprint.financials
ORDER BY date, source_row_id;

-- Query 12: First and most recent record per product
-- "What are the first and most recent financial records recorded for each product chronologically?"
WITH ranked_records AS (

    SELECT
        product,
        date,
        source_row_id,
        sales,
        profit,

        ROW_NUMBER() OVER (
            PARTITION BY product
            ORDER BY date ASC, source_row_id ASC
        ) AS first_rank,

        ROW_NUMBER() OVER (
            PARTITION BY product
            ORDER BY date DESC, source_row_id DESC
        ) AS last_rank

    FROM analytics_sprint.financials
)

SELECT
    *
FROM ranked_records
WHERE first_rank=1 OR last_rank=1
ORDER BY product, date;

-- CLOSED BOOK CHECK

-- Query 1: For each month, show total sales and then the previous month's total sales

with monthly_sales as(
	select
		 make_date(year::int, month_number::int, 1) AS month_start,
        SUM(sales) AS total_sales
    from analytics_sprint.financials
   		group by month_start)

 select
 	month_start,
 	total_sales,
 	lag(total_sales)over(order by month_start) as previous_month_sales
 from monthly_sales
 order by month_start;
 
 -- Query 2: Rank each financial record by profit within its product, with the most profitable record ranked first
 
 select 
 	source_row_id,
 	product,
 	profit,
 	rank()over(partition by product order by profit desc) as profit_rank
 from analytics_sprint.financials;











		