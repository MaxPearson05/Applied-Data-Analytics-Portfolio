# Day 07 – Week 1 Quality Gate

## Overview

Completed a cross-tool quality gate covering Excel, Power Query and PostgreSQL. The purpose was to confirm that the Week 1 foundations could produce consistent, explainable results before progressing to advanced SQL, Python and the private-healthcare project.

## Excel evidence

* Converted the financial dataset into a structured Excel table.
* Created an error-safe gross-margin calculation.
* Classified records as profitable or loss-making.
* Built a country-controlled KPI panel showing:

  * Total sales
  * Total profit
  * Weighted profit margin
  * Loss-making record count
* Confirmed that all KPIs updated when the selected country changed.

## Power Query evidence

* Imported and cleaned the financial data.
* Applied explicit text, date, whole-number and decimal data types.
* Trimmed text fields.
* Created `Source_Row_ID` and `Year_Month`.
* Loaded 700 records successfully.
* Reconciled the query output against the source data.

## PostgreSQL evidence

Completed six SQL questions covering:

1. Data-quality validation using aggregate controls.
2. Multi-condition record filtering using `WHERE`, `IN`, `ORDER BY` and `LIMIT`.
3. Grouped segment performance with weighted margin.
4. Conditional aggregation using `FILTER`.
5. Group-level filtering using `HAVING`.
6. Record classification using `CASE`.

The `CASE` query converted profit values into `Loss`, `Standard Profit` and `High Profit` categories, demonstrating how raw data can be transformed into decision-friendly business classifications.

## Validation controls

| Control                  | Validated result |
| ------------------------ | ---------------: |
| Total records            |              700 |
| Distinct Source Row IDs  |              700 |
| Total sales              |   118,726,350.26 |
| Total profit             |    16,893,702.26 |
| Loss-making records      |               58 |
| Duplicate Source Row IDs |                0 |
| Blank dates              |                0 |

Raw Excel, Power Query and PostgreSQL outputs were reconciled. France sales also matched across the three methods.

## Errors diagnosed and corrected

* Replaced a PivotTable-wide filter with a dedicated conditional KPI calculation.
* Corrected multi-country filtering using `IN ('Canada', 'Mexico')`.
* Added the missing year condition to a row-level query.
* Used double quotes for case-sensitive Postgre
