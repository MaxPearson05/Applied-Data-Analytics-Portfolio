# Day 9 – SQL Window Functions & Clinical Trials Project Scoping

## Overview

Developed intermediate PostgreSQL window-function skills and established the analytical contract for a real ClinicalTrials.gov / AACT portfolio project.

## SQL completed

Completed 12 analytical SQL problems covering:

- `ROW_NUMBER()`, `RANK()` and `DENSE_RANK()`
- `LAG()` for previous-period comparisons
- running totals
- rolling averages using window frames
- within-group ranking using `PARTITION BY`
- first and latest records within groups
- chronological analysis using date fields

Finished with two window-function queries reproduced from memory.

## Clinical trials project scope

Defined a real-data project analysing industry-led interventional DRUG/BIOLOGICAL clinical trials starting from 2015.

The project uses a global cohort with a UK lens and is designed for a pharmaceutical / biotechnology portfolio strategy or business development stakeholder.

Key questions include:

- How has industry-sponsored trial activity changed since 2015?
- Which countries host the most trials?
- How does the UK compare internationally?
- Which sponsors, phases and therapeutic areas dominate activity?
- What proportion of global studies include UK locations?

## Data modelling

Mapped the grain, keys and relationships across key AACT tables including:

- `studies`
- `sponsors`
- `interventions`
- `conditions`
- `facilities`
- `countries`
- `calculated_values`
- `study_references`

Identified the risk of row multiplication when joining multiple one-to-many child tables and documented strategies such as pre-aggregation, `EXISTS` and `COUNT(DISTINCT nct_id)`.

## API structure

Inspected a real ClinicalTrials.gov API v2 JSON response and identified nested:

- conditions
- interventions
- locations

Recognised how nested arrays become one-to-many relational tables when transformed into AACT-style data.

## Key learning

A technically correct join can still produce an analytically incorrect result if table grain and cardinality are not understood first.

Window functions allow calculations across related rows without collapsing the underlying dataset in the way `GROUP BY` does.

## Evidence

- 12-query SQL window/date pack
- AACT source and limitations notes
- Clinical trials project contract
- AACT relationship and grain map
- ClinicalTrials.gov API structure notes
- Closed-book window-function recall completed successfully