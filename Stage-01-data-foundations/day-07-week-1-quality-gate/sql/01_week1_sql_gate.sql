-- Imported new data table public->pq_kpi

-- Query 1: single row dataset validation
select*
from public.pq_kpi pk 
where source_row_id=1;

-- Query 2: 10 highest profit 2014 records from Canada or Mexico where profit exceeds 20000
select 
	"Date",
	"Profit",
	"Country",
	" Sales",
	"Segment"
from public.pq_kpi
where "Year" =2014
	and "Profit" > 20000
 	and "Country" in ('Canada','Mexico')
order by "Profit" desc
limit 10;

-- Query 3: Segment performance
select 
	"Segment",
	count(*) as record_count,
	sum(" Sales") as total_sales,
	sum( "Profit") as total_profit,
	ROUND(
    (SUM("Profit") / NULLIF(SUM(" Sales"), 0) * 100)::numeric,
    2
) AS weighted_profit_margin
from public.pq_kpi pk 
group by "Segment"
order by weighted_profit_margin desc;

-- Query 4: Conditional counts by product, total records, 2013, loss making records, high discount records
select 
	"Product",
	count(*) as total_records,
	count(*) filter(where "Profit"<0) as loss_making_records,
	Count(*) filter(where"Discount Band" ='High') as high_discount_records
from public.pq_kpi pk 
where "Year"=2013
group by "Product"
order by loss_making_records desc;

-- Query 5: Group level sales threshold, return only segments with combined sales above 15,000,000
select 
	"Segment",
	Count(*),
	sum(" Sales") as total_sales,
	sum("Profit") as total_profit
from public.pq_kpi
group by "Segment" 
having sum(" Sales") > 15000000
order by total_sales desc;

-- Query 6: Profit classification with CASE, using canada 
select 
	source_row_id,
	"Country",
	"Product",
	"Profit",
	CASE
    WHEN "Profit" < 0 THEN 'Loss'
    WHEN "Profit" >= 50000 THEN 'High Profit'
    ELSE 'Standard Profit'
END AS profit_classification
from public.pq_kpi pk 
where "Country"='Canada'
order by "Profit" asc;

	