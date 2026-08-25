-- Query 13: Country-summary CTE
-- Compare each country's financial performance against its targets.
WITH country_summary AS (
    SELECT
        country,
        COUNT(*) AS record_count,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        SUM(profit) / NULLIF(SUM(sales), 0) * 100
            AS weighted_margin_pct
    FROM analytics_sprint.financials
    GROUP BY country
)
SELECT
    cs.country,
    cs.total_sales,
    ct.sales_target,
    cs.total_sales - ct.sales_target AS sales_variance,
    ROUND(
        cs.total_sales / NULLIF(ct.sales_target, 0) * 100,
        2
    ) AS sales_target_attainment_pct
FROM country_summary AS cs
LEFT JOIN analytics_sprint.country_targets AS ct
    ON cs.country = ct.country;

-- Query 14: Countries below sales target
WITH country_summary AS (
    SELECT
        country,
        COUNT(*) AS record_count,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        SUM(profit) / NULLIF(SUM(sales), 0) * 100
            AS weighted_margin_pct
    FROM analytics_sprint.financials
    GROUP BY country
)
SELECT
    cs.country,
    cs.total_sales,
    ct.sales_target,
    cs.total_sales - ct.sales_target AS sales_variance,
    ROUND(
        cs.total_sales / NULLIF(ct.sales_target, 0) * 100,
        2
    ) AS sales_target_attainment_pct
FROM country_summary AS cs
LEFT JOIN analytics_sprint.country_targets AS ct
    ON cs.country = ct.country
WHERE ct.sales_target IS NOT NULL
    AND cs.total_sales < ct.sales_target
ORDER BY sales_variance ASC;

-- Query 15: Product Summary CTE
-- "How is each product performing, and does it have matching catalogue metadata"
WITH product_summary as  (
    SELECT
    product,
    COUNT(*) AS record_count,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit,
	SUM(profit) / NULLIF(SUM(sales), 0) * 100
    AS weighted_margin_pct
    FROM analytics_sprint.financials
    GROUP BY product
) 
select
	ps.product,
	ps.record_count,
	ps.total_profit,
	ROUND(ps.weighted_margin_pct, 2) as weighted_margin_pct,
	pc.product_category,
	pc.priority_tier 
 FROM product_summary AS ps
LEFT JOIN analytics_sprint.product_catalog AS pc
    ON ps.product = pc.product
 order by ps.total_profit desc;

-- Query 16: Financial impact of missing dimensions
-- "How many records and how much sales/profit are affected by each metadata gap?"
with joined_data as(
	select 
	f.source_row_id,
	f.product,
	pc.product as catalogue_product,
	f.country,
	ct.country as target_country,
	f.sales,
	f.profit,	
	ct.sales_target,
	ct.profit_target,
	pc.product_category,
	pc.priority_tier
from analytics_sprint.financials as f
left join analytics_sprint.country_targets as ct
	on f.country=ct.country 
left join analytics_sprint.product_catalog as pc
	on f.product =pc.product)
select 
	'Missing country target' as data_quality_issue,
	Count(*) as affected_records,
	sum(sales) as affected_sales,
	sum(profit) as affected_profit
from joined_data 
where target_country is null 

union all 
select 
	'Missing Product Metadata',
	Count(*),
	Sum(sales),
	Sum(profit)
from joined_data 
where catalogue_product is null;

-- Query 17: Records above overall average profit
-- "Which individual financial records earned more profit than the average record?"
select 
	source_row_id,
	country,
	product,
	sales,
	profit
from analytics_sprint.financials f 
where profit>(select avg(profit)from analytics_sprint.financials)
order by profit desc;

-- Query 18: Products above average product level sales
with product_totals as(
	select 
		product,
		sum(sales) as total_sales
	from analytics_sprint.financials
	group by product)
select 
	product,
	total_sales 
from product_totals 
where total_sales> (select avg(total_sales) from product_totals)
order by total_sales desc;

-- Query 19: Countries above the overall weighted margin
-- "Which countries have a weighted profit margin above the datasets overall weighted margin?"
with country_totals as(
	select 
		country,
		sum(sales) as total_sales,
		sum(profit) as total_profit,
		sum(profit)/nullif(sum(sales), 0) as weighted_margin
	from analytics_sprint.financials
	group by country)
select
	country,
	total_sales,
	total_profit,
	weighted_margin
from country_totals 
where weighted_margin > (select 
							sum(profit)/nullif(sum(sales), 0)
							from analytics_sprint.financials)
order by total_sales desc;

-- Query 20: Records above their own product average
-- "Which individual records earned more profit than the average for their particular profit"
	SELECT
    f.source_row_id,
    f.country,
    f.product,
    f.sales,
    f.profit
FROM analytics_sprint.financials AS f
WHERE f.profit > (
    SELECT AVG(f2.profit)
    FROM analytics_sprint.financials AS f2
    WHERE f2.product = f.product
)
ORDER BY f.profit  DESC;