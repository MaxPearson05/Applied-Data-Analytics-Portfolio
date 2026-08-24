# Day 06 – SQL Reconstruction and Validation

## Overview

Recreated six PostgreSQL queries from business requirements and validated the results against established Excel controls. The exercise covered filtering, aggregation, conditional counting, grouped filtering and chronological trend analysis.

## Queries completed

1. **Dataset validation** – Checked record count, unique IDs, sales, profit and date boundaries.
2. **Filtered commercial records** – Returned high-value French and German sales records from 2014.
3. **Product performance** – Calculated record count, total sales, total profit and weighted margin by product.
4. **Country loss analysis** – Used aggregate `FILTER` clauses to count profitable and loss-making records.
5. **Group-level filtering** – Used `HAVING` to identify countries with total sales above 20 million.
6. **Monthly trend** – Summarised sales and profit by year and month in chronological order.

## Skills demonstrated

* Applied `WHERE` to filter individual records.
* Used `IN` to filter for multiple countries.
* Created grouped summaries using `GROUP BY`.
* Used aggregate `FILTER` for conditional record counts.
* Distinguished `WHERE` from `HAVING`.
* Protected weighted-margin calculations with `NULLIF()`.
* Used `ROUND()` to present percentage metrics clearly.
* Ordered monthly results using year and month number.
* Used meaningful aliases and business-purpose comments.

## Validation controls

| Control                 | Validated result |
| ----------------------- | ---------------: |
| Total records           |              700 |
| Distinct Source Row IDs |              700 |
| Total sales             |   118,726,350.26 |
| Total profit            |    16,893,702.26 |
| Earliest date           |       2013-09-01 |
| Latest date             |       2014-12-01 |
| Loss-making records     |               58 |

Product, country and monthly totals were reconciled against the overall dataset controls.

## Errors diagnosed and corrected

* Removed aggregate functions from a row-level filtering query and moved conditions into `WHERE`.
* Used `FILTER (WHERE condition)` instead of comparing an aggregate count with zero.
* Replaced `AND` with commas when listing fields in `GROUP BY` and `ORDER BY`.
* Removed a premature semicolon that prevented `ORDER BY` from running.

## Key learning

The required SQL structure depends on the grain of the business question. `WHERE` filters individual records before aggregation, while `HAVING` filters grouped results after aggregation. Conditional aggregation allows several measures to be calculated from the same underlying dataset without unintentionally removing records.

## Outcome

All six final queries ran successfully and reconciled to the validated controls. Initial errors were documented, corrected and the affected queries were rewritten from memory.
