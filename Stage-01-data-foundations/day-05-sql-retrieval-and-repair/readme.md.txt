# Day 05 – SQL Retrieval and Error Repair

## Overview

Completed five PostgreSQL queries using `analytics_sprint.financials`, covering dataset validation, row filtering, grouped analysis, conditional aggregation and group-level filtering.

## Queries completed

1. Validated row count, unique Source Row IDs, total sales and total profit.
2. Filtered 2014 French records with sales above 100,000 and ranked them by sales.
3. Analysed record count, total sales, total profit and weighted margin by product.
4. Used `HAVING` to identify countries with total sales above 20 million.
5. Counted total and loss-making records by country using aggregate `FILTER`.


## Skills demonstrated

* Applied `WHERE` to filter individual records.
* Used `GROUP BY` to create product and country summaries.
* Applied `FILTER` without removing profitable records from the analysis.
* Used `HAVING` to filter aggregated results.
* Calculated weighted margin using `SUM(profit) / NULLIF(SUM(sales), 0)`.
* Created meaningful aliases and sorted outputs using `ORDER BY`.
* Distinguished row-level filtering from group-level filtering.

## Validation controls

| Control                 | Validated result |
| ----------------------- | ---------------: |
| Total records           |              700 |
| Distinct Source Row IDs |              700 |
| Total sales             |   118,726,350.26 |
| Total profit            |    16,893,702.26 |

The SQL results were reconciled against the previously validated Excel controls.

## Key learning

SQL’s logical execution order is:

`FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT`

`WHERE` filters records before aggregation, while `HAVING` filters groups after aggregation. Aggregate `FILTER` allows conditional metrics to be calculated without removing other records from the underlying dataset.


