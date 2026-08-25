-- Query 1: Country INNER JOIN 
-- "Which financial records have a matching country target?"
select
 f.source_row_id,
 f.country,
 f.product,
 f.sales,
 f.profit,
 ct.sales_target,
 ct.profit_target
from analytics_sprint.financials as f
inner join analytics_sprint.country_targets as ct
 on f.country=ct.country;

-- Query 2: Country LEFT JOIN
-- "How can we add country targets while retaining every financial record?"
select
 f.source_row_id,
 f.country,
 f.product,
 f.sales,
 f.profit,
 ct.sales_target,
 ct.profit_target
from analytics_sprint.financials as f
left join analytics_sprint.country_targets as ct
 on f.country=ct.country;

-- Query 3: Country ANTI JOIN
-- "Which financial records do not have a matching country target"
select
 f.source_row_id,
 f.country,
 f.product,
 f.sales,
 f.profit,
 ct.sales_target,
 ct.profit_target
from analytics_sprint.financials as f
left join analytics_sprint.country_targets as ct
 on f.country=ct.country
	where ct.country is null;

-- Query 4: Reverse country ANTI JOIN
-- "Which country targets do not have any matching financial records?"
select
 ct.country,
 ct.sales_target,
 ct.profit_target
from analytics_sprint.country_targets as ct
left join analytics_sprint.financials as f 
 on ct.country=f.country
	where f.country is null;

-- Query 5: Country FULL JOIN with match classifcation
-- "Which records are matched, financial-only or target-only?"
SELECT
    f.source_row_id,
    f.country AS financial_country,
    ct.country AS target_country,
    f.product,
    f.sales,
    ct.sales_target,
    CASE
        WHEN f.country IS NOT NULL
             AND ct.country IS NOT NULL
            THEN 'Matched'
        WHEN f.country IS NOT NULL
             AND ct.country IS NULL
            THEN 'Financial Only'
        WHEN f.country IS NULL
             AND ct.country IS NOT NULL
            THEN 'Target Only'
    END AS match_status
FROM analytics_sprint.financials AS f
FULL JOIN analytics_sprint.country_targets AS ct
    ON f.country = ct.country;

-- Query 6: Product INNER JOIN
-- "Which financial records have matching product metadata"
select
 f.source_row_id,
 f.product,
 f.sales,
 f.profit,
 pc.product_category,
 pc.priority_tier
from analytics_sprint.financials as f
inner join analytics_sprint.product_catalog as pc  
 on f.product=pc.product;

-- Query 7: Product LEFT JOIN
-- "Which financial records have matching product metadata"
select
 f.source_row_id,
 f.product,
 f.sales,
 f.profit,
 pc.product_category,
 pc.priority_tier
from analytics_sprint.financials as f
left join analytics_sprint.product_catalog as pc  
 on f.product=pc.product;

-- Query 8: Product ANTI JOIN
-- "Which financial records have no matching product metadata"
select
 f.source_row_id,
 f.product,
 f.country,
 f.sales,
 f.profit,
 pc.product_category,
 pc.priority_tier
from analytics_sprint.financials as f
left join analytics_sprint.product_catalog as pc  
 on f.product=pc.product
where pc.product is null;

-- Query 9: Three table LEFT JOIN
-- "How can each financial record be enriched with both country 
-- targets and product metadata while retaining all facts"
select 
	f.source_row_id,
	f.product,
	f.country,
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
	on f.product =pc.product;

-- Query 10: Three table match classification
select 
	f.source_row_id,
	f.product,
	f.country,
	f.sales,
	f.profit,	
	ct.sales_target,
	ct.profit_target,
	pc.product_category,
	pc.priority_tier,
CASE
	WHEN ct.country IS NULL
    AND pc.product IS NULL
    THEN 'Missing Both'
    WHEN ct.country IS NULL
    THEN 'Missing Country Target'
    WHEN pc.product IS NULL
    THEN 'Missing Product Metadata'
    ELSE 'Fully Matched'
END AS match_status
from analytics_sprint.financials as f
left join analytics_sprint.country_targets as ct
	on f.country=ct.country 
left join analytics_sprint.product_catalog as pc
	on f.product =pc.product;

-- Query 11: Filtering in ON versus WHERE
SELECT
    f.source_row_id,
    f.country,
    f.sales,
    ct.sales_target
FROM analytics_sprint.financials AS f
LEFT JOIN analytics_sprint.country_targets AS ct
    ON f.country = ct.country
    AND ct.sales_target >= 25000000;

SELECT
    f.source_row_id,
    f.country,
    f.sales,
    ct.sales_target
FROM analytics_sprint.financials AS f
LEFT JOIN analytics_sprint.country_targets AS ct
    ON f.country = ct.country
WHERE ct.sales_target >= 25000000;

-- Filtering in ON controls which dimension rows match while retaining
-- every fact row. Filtering the dimension in WHERE removes unmatched
-- and non-qualifying facts, making the result behave like an INNER JOIN.

-- Query 12: UNION versus UNION ALL

SELECT country
FROM analytics_sprint.financials

UNION

SELECT country
FROM analytics_sprint.country_targets;

SELECT country
FROM analytics_sprint.financials

UNION ALL

SELECT country
FROM analytics_sprint.country_targets;

-- UNION combines compatible results and removes duplicate rows.
-- UNION ALL combines the results without removing duplicates,
-- so it is normally faster and preserves every occurrence.


