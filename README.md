# Applied Data Analytics Portfolio

A practical data analytics portfolio demonstrating end-to-end analysis using real public datasets across healthcare, clinical research and financial services.

The work covers data ingestion, cleaning, relational modelling, SQL analysis, Python/pandas, Power Query, Power BI, DAX, Tableau, validation and stakeholder-focused communication.

## Core Stack

**Excel | Power Query | PostgreSQL | SQL | Python | pandas | BigQuery | Power BI | DAX | Tableau | Git/GitHub**

---

# Flagship Projects

## Clinical Trial Portfolio & Delivery Intelligence

A real-data analytics project using ClinicalTrials.gov and the AACT relational database.

The analysis focuses on industry-led interventional DRUG and BIOLOGICAL studies from 2015 onwards, using a global cohort with a UK lens.

### Business focus

Designed for a pharmaceutical or biotechnology portfolio strategy / business development stakeholder.

The project investigates:

- trends in industry-sponsored clinical trial activity
- trial distribution by country and region
- the UK's position within global clinical research
- sponsor activity
- clinical trial phases
- therapeutic areas and conditions
- intervention types
- trial-site participation
- study completion and discontinuation
- results-reporting coverage

### Technical focus

- ClinicalTrials.gov API v2 ingestion
- AACT relational data
- nested JSON structures
- PostgreSQL
- SQL CTEs and window functions
- table grain and cardinality
- controlled one-to-many relationships
- Python and pandas
- BigQuery `UNNEST`
- Power Query
- Power BI and DAX
- Excel validation
- reproducible data pipelines

Particular attention is given to preventing study duplication when combining sponsors, interventions, conditions, facilities and geographic data.

---

## Financial Conduct & Customer Outcomes

A real-data financial analytics project using public datasets from the:

- Financial Conduct Authority (FCA)
- Financial Ombudsman Service (FOS)
- Bank of England

The project examines customer outcomes and financial-conduct indicators while avoiding unsupported conclusions about individual firms.

### Business focus

Designed for stakeholders working in financial services, risk, customer operations or conduct analytics.

The analysis investigates:

- complaint volumes and trends
- complaints relative to valid customer/account denominators
- complaint closure performance
- upheld complaint rates
- Financial Ombudsman outcomes
- product concentration
- peer comparisons
- period-on-period changes
- persistent deterioration indicators
- FCA/FOS outcome differences
- wider financial context

### Technical focus

- multi-source public datasets
- PostgreSQL relational modelling
- entity mapping and crosswalks
- denominator design
- SQL CTEs and window functions
- Python/pandas validation
- period alignment
- Power BI
- Tableau
- calculated metrics
- reconciliation and QA
- responsible analytical interpretation

---

# Analytical Foundations

Before developing the flagship projects, the portfolio establishes core analytics skills using structured financial data.

Topics include:

- Excel tables and structured references
- `SUMIFS`, `COUNTIFS` and `AVERAGEIFS`
- `XLOOKUP`
- dynamic arrays
- data validation
- weighted metrics
- Power Query
- PivotTables
- KPI dashboards
- PostgreSQL
- filtering and aggregation
- `CASE`
- `GROUP BY` and `HAVING`
- relational joins
- CTEs and subqueries
- date analysis
- `ROW_NUMBER`
- `RANK`
- `DENSE_RANK`
- `LAG`
- running totals
- rolling calculations
- cross-tool reconciliation

---

# Analytical Approach

The portfolio follows several principles throughout.

### Define grain before analysis

Every analytical table has an explicit row-level grain and identified keys before calculations or joins are performed.

### Protect against row multiplication

One-to-many and many-to-many relationships are treated carefully to prevent incorrect totals caused by duplicated records.

Techniques include:

- pre-aggregation
- bridge tables
- `EXISTS`
- `COUNT(DISTINCT ...)`
- key validation
- before/after join reconciliation

### Validate important numbers

Important results are checked against another calculation, source or analytical tool wherever practical.

### Preserve reproducibility

Projects document:

- source
- extraction date
- cohort/filter definitions
- data grain
- transformation logic
- assumptions
- execution order
- validation checks
- limitations

### Separate evidence from interpretation

Descriptive relationships are not presented as causal effects without an appropriate causal design.

### Analyse for decisions

Dashboards and calculations are built around stakeholder questions rather than creating visuals simply because the data allows them.

---

# Data Quality & Validation

Quality assurance is treated as part of the analysis rather than an afterthought.

Checks include:

- row-count reconciliation
- primary-key uniqueness
- duplicate detection
- missing-value profiling
- foreign-key validation
- join-cardinality checks
- aggregate reconciliation
- denominator validation
- date-range validation
- cross-tool comparison
- filter-slice testing

Errors and corrections are documented so that analytical decisions can be explained and reproduced.

---

# Repository Structure

The repository documents both technical learning and applied project development.

Typical evidence includes:

```text
SQL/
Python/
Power-BI/
Tableau/
Excel/
docs/
screenshots/
data-dictionaries/
QA/
README.md