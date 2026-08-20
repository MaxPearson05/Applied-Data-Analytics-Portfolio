-- Reconcile PostgreSQL outputs against Excel
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT source_row_id) AS distinct_source_ids,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(sales) FILTER (WHERE country = 'France'),
        2
    ) AS france_total_sales,
    COUNT(*) FILTER (WHERE profit < 0) AS loss_making_records
FROM analytics_sprint.financials;