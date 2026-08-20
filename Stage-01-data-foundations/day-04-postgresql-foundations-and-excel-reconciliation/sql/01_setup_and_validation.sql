CREATE SCHEMA IF NOT EXISTS analytics_sprint;

CREATE TABLE analytics_sprint.financials (
    segment VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    product VARCHAR(50) NOT NULL,
    discount_band VARCHAR(20) NOT NULL,
    units_sold NUMERIC(12, 2) NOT NULL,
    manufacturing_price NUMERIC(12, 2) NOT NULL,
    sale_price NUMERIC(12, 2) NOT NULL,
    gross_sales NUMERIC(18, 2) NOT NULL,
    discounts NUMERIC(18, 2) NOT NULL,
    sales NUMERIC(18, 2) NOT NULL,
    cogs NUMERIC(18, 2) NOT NULL,
    profit NUMERIC(18, 2) NOT NULL,
    date DATE NOT NULL,
    month_number SMALLINT NOT NULL
        CHECK (month_number BETWEEN 1 AND 12),
    month_name VARCHAR(9) NOT NULL,
    year SMALLINT NOT NULL,
    source_row_id INTEGER PRIMARY KEY,
    year_month VARCHAR(7) NOT NULL,
    annual_sales_target NUMERIC(18, 2) NOT NULL,
    margin_target NUMERIC(6, 4) NOT NULL,
    loss_flag SMALLINT NOT NULL
        CHECK (loss_flag IN (0, 1))
);

select COUNT(*)as rows_currently_loaded
from analytics_sprint.financials;
SELECT
    ordinal_position,
    '[' || column_name || ']' AS visible_column_name,
    LENGTH(column_name) AS name_length,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'analytics_sprint'
  AND table_name = 'financials'
  AND BTRIM(column_name) = 'sales'
ORDER BY ordinal_position;
SELECT
    COUNT(*) AS row_count,
    COUNT(sales) AS correct_sales_values,
    COUNT(" sales") AS accidental_sales_values,
    ROUND(SUM(sales), 2) AS correct_sales_total,
    ROUND(SUM(" sales")::NUMERIC, 2) AS accidental_sales_total
FROM analytics_sprint.financials;
ALTER TABLE analytics_sprint.financials
DROP COLUMN IF EXISTS " sales";
SELECT COUNT(*) AS column_count
FROM information_schema.columns
WHERE table_schema = 'analytics_sprint'
  AND table_name = 'financials';
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT source_row_id) AS distinct_source_ids,
    COUNT(*) FILTER (WHERE source_row_id IS NULL) AS missing_source_ids,
    COUNT(*) FILTER (WHERE date IS NULL) AS missing_dates,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    MIN(date) AS earliest_date,
    MAX(date) AS latest_date
FROM analytics_sprint.financials;
