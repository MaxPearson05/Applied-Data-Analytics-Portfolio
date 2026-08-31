# Applied Data Analytics Portfolio

A practical data analytics portfolio demonstrating an end-to-end analysis using real public datasets within clinical research (AACT).
The work covers data ingestion, cleaning, relational modelling, SQL analysis, Python/pandas, Power Query, Power BI, DAX, and stakeholder-focused communication.

## Core Stack

**Excel | Power Query | PostgreSQL | SQL | Python | pandas | BigQuery | Power BI | DAX | Git/GitHub**

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
