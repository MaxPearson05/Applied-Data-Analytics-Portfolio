# Day 08 – Relational PostgreSQL Analysis

## Overview

Built and validated a relational PostgreSQL analysis using a 700-row financial fact table with country-target and product-catalogue dimensions.

Completed 20 exercises covering joins, unmatched-record analysis, CTEs, subqueries and data-quality validation.

## Skills demonstrated

* Fact and dimension table design
* Primary keys, table grain and cardinality
* INNER, LEFT and FULL joins
* Forward and reverse anti-joins
* CASE match classification
* UNION versus UNION ALL
* Common table expressions
* Scalar and correlated subqueries
* Weighted profit-margin calculations
* Duplicate-key and join-integrity testing

## Key findings

* Mexico has no matching country target.
* United Kingdom has no financial records.
* VTT has no matching product metadata.
* Nova has no financial records.
* Clean fact-led LEFT JOINs retained all 700 financial records.

## Validation

The clean three-table join preserved:

* 700 rows
* 700 distinct Source Row IDs
* Total sales of $118,726,350.29
* Total profit of $16,893,702.29

A controlled duplicate of the France dimension key increased the joined result to 840 rows while distinct IDs remained at 700. This demonstrated how non-unique dimension keys can multiply facts and overstate financial totals.

## Data-quality note

The PostgreSQL import produced sales and profit totals $0.03 above the original workbook controls because several half-cent source values were rounded during import. The discrepancy was documented, and the PostgreSQL baseline was applied consistently throughout join validation.

## Evidence

* [Dimension setup and validation](sql/00_setup-dimensions.sql)
* [Join practice](sql/01_join-practice.sql)
* [CTEs and subqueries](sql/02_ctes-and-subqueries.sql)
* [Join reconciliation](sql/03_reconciliation.sql)

![Clean three-table join reconciliation](screenshots/01_join-reconciliation.png)

## Limitations

Country targets and product classifications are fictional practice metadata. Findings are descriptive and do not establish causation.
