--Validation Query
select
	count(*) as rows,
	count(distinct source_row_id) as distinct_ids,
	sum(sales) as total_sales,
	sum(profit) as total_profit,
	count(distinct country) as countries,
	count(distinct product) as products
from analytics_sprint.financials f;

-- Results
-- Rows: 700
-- Distinct IDs: 700
-- Sales: 118,726,350.29
-- Profit: 16,893,702.29
-- Countries: 5
-- Products: 6

-- Mismatch in excel vs sql .29 vs .26 in total sales and profit
-- Checking
SELECT
    column_name,
    data_type,
    numeric_precision,
    numeric_scale
FROM information_schema.columns
WHERE table_schema = 'analytics_sprint'
  AND table_name = 'financials'
  AND column_name IN ('sales', 'profit');

SELECT
    SUM(sales) AS raw_sales,
    SUM(ROUND(sales::numeric, 2)) AS row_rounded_sales,
    SUM(profit) AS raw_profit,
    SUM(ROUND(profit::numeric, 2)) AS row_rounded_profit
FROM analytics_sprint.financials;

-- Findings, Power Query data rounded columns to 2dp making this 3p discrepency, in future cases rounding to greater dp is required

-- ============================================================
-- Dimension 1: Country targets
-- Grain: one row per country
-- The targets are fictional practice metadata.
-- Mexico is deliberately omitted.
-- United Kingdom is deliberately unmatched.
-- ============================================================

CREATE TABLE IF NOT EXISTS analytics_sprint.country_targets (
    country TEXT PRIMARY KEY,
    sales_target NUMERIC(14, 2) NOT NULL,
    profit_target NUMERIC(14, 2) NOT NULL
);

INSERT INTO analytics_sprint.country_targets (
    country,
    sales_target,
    profit_target
)
VALUES
    ('Canada', 25000000, 3500000),
    ('France', 25000000, 3500000),
    ('Germany', 24000000, 3400000),
    ('United States of America', 25000000, 3500000),
    ('United Kingdom', 10000000, 1500000)
ON CONFLICT (country) DO UPDATE
SET
    sales_target = EXCLUDED.sales_target,
    profit_target = EXCLUDED.profit_target;


-- ============================================================
-- Dimension 2: Product catalogue
-- Grain: one row per product
-- Categories and priorities are fictional practice metadata.
-- VTT is deliberately omitted.
-- Nova is deliberately unmatched.
-- ============================================================

CREATE TABLE IF NOT EXISTS analytics_sprint.product_catalog (
    product TEXT PRIMARY KEY,
    product_category TEXT NOT NULL,
    priority_tier TEXT NOT NULL
);

INSERT INTO analytics_sprint.product_catalog (
    product,
    product_category,
    priority_tier
)
VALUES
    ('Carretera', 'Core', 'Standard'),
    ('Montana', 'Core', 'Standard'),
    ('Paseo', 'Growth', 'High'),
    ('Velo', 'Growth', 'Standard'),
    ('Amarilla', 'Premium', 'High'),
    ('Nova', 'Experimental', 'Low')
ON CONFLICT (product) DO UPDATE
SET
    product_category = EXCLUDED.product_category,
    priority_tier = EXCLUDED.priority_tier;

-- Validation Query for country_targets
select 
	count(*) as total_rows,
	count(distinct country) as distinct_countries,
	count(*) filter(where country is NULL) as null_keys
from analytics_sprint.country_targets

-- Duplicate-key Query for country_targets
SELECT
    country,
    COUNT(*) AS key_count
FROM analytics_sprint.country_targets
GROUP BY country
HAVING COUNT(*) > 1;

-- Validation Query for product_catalogue
select 
	count(*) as total_rows,
	count(distinct product) as distinct_products,
	count(*) filter(where product is NULL) as null_keys
from analytics_sprint.product_catalog;