--Query 1: Preview 10 financial records
select*
from analytics_sprint.financials 
limit 10;

--Query 2: select specific business fields
select 
	source_row_id,
	date,
	country,
	product,
	sales,
	profit
from analytics_sprint.financials 
limit 10;

--Query 3: List the countries in the dataset
select distinct country
from analytics_sprint.financials 
order by country;

--Query 4: Preview financial records from 2014
select 
	source_row_id,
	date,
	country,
	product,
	sales,
	profit
from analytics_sprint.financials 
where year = 2014
limit 10;

--Query 5: Preview records for France
select 	
	source_row_id,
	date,
	country,
	product,
	sales,
	profit 
from analytics_sprint.financials 
where country = 'France'
limit 10;

--Query 6: Find the largest loss-making records
select 	
	source_row_id,
	date,
	country,
	product,
	sales,
	profit 
from analytics_sprint.financials 
where profit < 0
order by profit asc 
limit 10;

--Query 7: Loss-making records in France during 2014
select 	
	source_row_id,
	date,
	country,
	product, 
	sales, 
	profit 
from analytics_sprint.financials 
where country = 'France'
 and year = 2014
 and profit < 0
order by profit asc;

-- Query 8: Records for Paseoor VTT
select 	
	source_row_id,
	country,
	product,
	sales, 
	profit
from analytics_sprint.financials 
where product in ('paseo','VTT')
order by sales desc
limit 10;

-- Query 9: Records from the first quarter of 2014
select 	
	source_row_id,
	date,
	country,
	product,
	sales,
	profit 
from analytics_sprint.financials 
where date between date '2014-01-01' and date '2014-03-31'
order by date asc;

-- Query 10: Ten records with the highest sales
select
	source_row_id,
	date,
	country,
	product,
	sales,
	profit 
from analytics_sprint.financials 
order by sales desc
limit 10;




