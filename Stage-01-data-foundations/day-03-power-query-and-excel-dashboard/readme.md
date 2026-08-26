# Day 03 – Power Query and Excel Dashboard

## Project overview

This project transforms Microsoft’s 700-row Financial Sample into a refreshable Power Query workflow and an interactive one-page Excel dashboard.

The analysis demonstrates data preparation, query design, table merging, reconciliation, PivotTables, slicers, KPI reporting and decision-focused visualisation.

## Deliverable

[Download the completed Excel workbook](./Max_Pearson_Power_Query_Financial_Dashboard.xlsx)

## Power Query workflow

The workbook uses three queries:

1. **`stg_financials`** – cleans and standardises the source data while remaining connection-only.
2. **`dim_country_targets`** – imports five illustrative country-level sales and margin targets.
3. **`fct_financials`** – references the staging query, performs a left-outer merge with the target table and loads 700 transformed records into Excel.

Transformations include:

* Text trimming and cleaning
* Explicit data-type assignment
* Unique `Source_Row_ID`
* Chronological `Year_Month` field
* Country-target merge
* Expanded sales and margin target fields
* Loss-making record flag
* Refreshable table output

## Skills demonstrated

* Excel Power Query
* Staging and fact-query design
* Query references and connection-only loading
* Left-outer joins
* Data-type validation
* PivotTables and PivotCharts
* Slicer connections across multiple PivotTables
* Responsive KPI calculations
* Weighted profit-margin calculation
* Raw-to-query reconciliation
* Error and missing-value checks

## Dashboard

The dashboard contains four responsive KPIs:

* Total sales
* Total profit
* Weighted profit margin
* Loss-making records

It can be filtered by:

* Country
* Product
* Year

The two visualisations compare:

* Sales against illustrative annual targets by country
* Monthly sales and profit trends

The default dashboard view uses 2014 because it is the only complete calendar year in the dataset.

### 2014 dashboard results

| KPI                    |  Result |
| ---------------------- | ------: |
| Total sales            | $92.31M |
| Total profit           | $13.02M |
| Weighted profit margin |   14.1% |
| Loss-making records    |      43 |

Weighted profit margin is calculated as total profit divided by total sales rather than as an average of transaction-level margins.

## Validation results

| Control                 |          Result |
| ----------------------- | --------------: |
| Source rows             |             700 |
| Power Query rows        |             700 |
| Distinct Source Row IDs |             700 |
| Total sales             | $118,726,350.26 |
| Total profit            |  $16,893,702.26 |
| Earliest date           |      2013-09-01 |
| Latest date             |      2014-12-01 |
| Missing sales targets   |               0 |
| Missing margin targets  |               0 |
| Failed QA controls      |               0 |

All Power Query totals reconcile to the original source data.

## Key observations

* The complete 2014 period generated $92.31M in sales and $13.02M in profit.
* October recorded the highest monthly sales during 2014.
* December recorded the highest monthly profit during 2014.
* There were 43 loss-making records during the year.
* Under the illustrative target scenario, every country remained below its assigned annual sales target.

These observations are descriptive and do not establish that any country, product or other factor caused the reported results.

## Implementation notes

* `Units Sold` was retained as a decimal field because the source contains valid fractional values.
* No records were removed without evidence that they were genuine duplicates.
* Target values repeat across transaction records after the merge, so PivotTables use **Max**, not **Sum**, when reporting a country’s target.
* 2013 only contains September to December and should not be treated as a complete annual comparison.
* Country targets are fictional management assumptions created solely to demonstrate merging and target-variance reporting.

## Screenshots

### Interactive dashboard

![Interactive Excel dashboard](./screenshots/excel-dashboard.png)

### Power Query applied steps

![Power Query applied steps](./screenshots/power-query-applied-steps.png)

### Reconciliation and QA

![Power Query QA results](./screenshots/pq-qa-results.png)

## Repository contents

```text
day-03-power-query-and-excel-dashboard/
├── README.md
├── Max_Pearson_Power_Query_Financial_Dashboard.xlsx
├── excel-dashboard.png
├── power-query-applied-steps.png
└── pq-qa-results.png
```

## How to use the workbook

1. Download and open the Excel workbook.
2. Open the `Dashboard` worksheet.
3. Use the Country, Product and Year slicers to explore the results.
4. Use the clear-filter button on each slicer to restore the complete dataset.
5. Select **Data → Refresh All** to refresh the queries and PivotTables.
6. Review `PQ_QA` to confirm that the refreshed output still reconciles.

## Data source

The source data is Microsoft’s public [Financial Sample workbook](https://learn.microsoft.com/en-us/power-bi/create-reports/sample-financial-download).

The workbook contains no personal, confidential or genuine customer information. All country targets were created for technical demonstration and are clearly identified as illustrative.
