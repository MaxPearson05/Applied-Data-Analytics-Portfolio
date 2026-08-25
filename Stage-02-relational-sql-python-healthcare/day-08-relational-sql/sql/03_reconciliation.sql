-- Confirm that clean dimension joins preserve the financial facts.

SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT f.source_row_id) AS distinct_ids,
    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.profit), 2) AS total_profit
FROM analytics_sprint.financials AS f
LEFT JOIN analytics_sprint.country_targets AS ct
    ON f.country = ct.country
LEFT JOIN analytics_sprint.product_catalog AS pc
    ON f.product = pc.product;

-- Deliberate creation of dimension key

DROP TABLE IF EXISTS demo_country_targets;

CREATE TEMP TABLE demo_country_targets AS
SELECT *
FROM analytics_sprint.country_targets

UNION ALL

SELECT *
FROM analytics_sprint.country_targets
WHERE country = 'France';

SELECT
    country,
    COUNT(*) AS key_count
FROM demo_country_targets
GROUP BY country
HAVING COUNT(*) > 1;

-- Confirmation France key_count=2

SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT f.source_row_id) AS distinct_ids,
    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.profit), 2) AS total_profit
FROM analytics_sprint.financials AS f
LEFT JOIN demo_country_targets AS ct
    ON f.country = ct.country;

-- row count increased from 700-840 but distinct ID's remain at 700 as every france is counted twice

DROP TABLE IF EXISTS demo_country_targets;

SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT f.source_row_id) AS distinct_ids,
    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.profit), 2) AS total_profit
FROM analytics_sprint.financials AS f
LEFT JOIN analytics_sprint.country_targets AS ct
    ON f.country = ct.country
LEFT JOIN analytics_sprint.product_catalog AS pc
    ON f.product = pc.product;

-- confirmation that row count has returned to 700 and sales and profit are correct