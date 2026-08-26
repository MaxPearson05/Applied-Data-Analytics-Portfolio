# Day 10 – Python, pandas & Clinical Trials Ingestion

## Overview

Introduced Python and pandas fundamentals before applying them to a reproducible ingestion pipeline using real **ClinicalTrials.gov API v2** data.

The workflow progressed from Python fundamentals and DataFrame operations to a paginated API extraction, nested JSON normalisation, relational table design, data-quality validation and reproducible source documentation.

A controlled **200-study development extract** was used to validate the pipeline before scaling to the full project cohort.

---

## Python Fundamentals

Covered:

- Variables and data types
- Lists, tuples, sets and dictionaries
- Conditional logic
- Loops
- Functions
- Imports
- Exception handling
- Environment variables

These concepts were then applied directly to the clinical-trials ingestion workflow.

---

## pandas Fundamentals

Practised:

- Creating DataFrames
- `head()`, `info()` and `describe()`
- Selecting data with `loc` and `iloc`
- Filtering rows
- Sorting values
- Date conversion
- Data-type conversion
- `groupby()`
- `merge()`
- Reading CSV and JSON files

---

## ClinicalTrials.gov API Ingestion

Defined the project cohort as:

- Interventional studies
- Industry lead sponsors
- Drug or biological interventions
- Study start date from 2015 onwards

The live API query identified **46,911 studies** matching the project criteria at extraction time.

Rather than immediately processing the entire cohort, I developed and validated the ingestion pipeline using a controlled **200-study development extract**.

Pagination was implemented using the API's `nextPageToken`, with the development extract downloaded across **4 pages**.

---

## Reproducibility

The ingestion workflow records the information required to reproduce the extract.

A manifest captures:

- Data source
- API endpoint
- Project query
- Extraction timestamp
- Page size
- Number of pages downloaded
- Record count
- Development extract limit
- Raw source filename
- SHA-256 file hash

Raw API extracts are preserved locally while large raw files are excluded from GitHub.

---

## Relational Data Model

The nested ClinicalTrials.gov JSON response was normalised into four analytical tables.

### `trials`

**Grain:** one row per clinical study.

Key fields include:

- `nct_id`
- Brief title
- Overall status
- Start date
- Completion date
- Lead sponsor
- Sponsor class
- Study type
- Phase
- Enrollment

### `interventions`

**Grain:** one row per intervention per study.

Key fields include:

- `nct_id`
- Intervention type
- Intervention name
- Intervention description

### `conditions`

**Grain:** one row per condition per study.

Key fields include:

- `nct_id`
- Condition

### `locations`

**Grain:** one row per study location.

Key fields include:

- `nct_id`
- Facility
- City
- State
- Country

`nct_id` is retained as the parent key linking each child table back to the study-level table.

---

## Validation & QA

The development pipeline passed structural validation checks.

### Trial Table

- **200 trial rows**
- **200 unique NCT IDs**
- **0 duplicate NCT IDs**

### Child Tables

- **450 intervention rows**
- **309 condition rows**
- **3,534 location rows**

Foreign-key validation confirmed that every child-table `nct_id` maps to a valid study in the parent trial table.

Additional validation included:

- Missing-value profiling
- Mixed-format date parsing
- Study-type coverage
- Sponsor-class coverage
- Intervention-type coverage
- Earliest and latest study dates
- Processed-file existence checks
- Full notebook restart and top-to-bottom execution

---

## Problems Solved

### Python & Jupyter Environment Setup

Configured Python 3.14 in VS Code and resolved interpreter, terminal and Jupyter kernel setup issues.

Installed and configured the packages required for notebook-based data analysis, including:

- `ipykernel`
- `pandas`
- `requests`

### API Pagination Scaling

An early attempt moved too quickly from a small API sample to a larger paginated extraction and caused the notebook to stall.

I interrupted the request, reset the kernel state and rebuilt the process incrementally:

1. Confirmed the notebook kernel was functioning correctly
2. Validated API connectivity
3. Tested pagination across two pages
4. Built a controlled 200-study paginated development extract

This reduced the risk of debugging transformation logic against a much larger dataset.

### Nested JSON Normalisation

ClinicalTrials.gov returns nested JSON where one study can contain multiple interventions, conditions and locations.

I normalised these nested structures into separate parent and child DataFrames while retaining `nct_id` as the relationship key.

### One-to-Many Relationship Validation

Child tables legitimately contain repeated `nct_id` values because one study can have multiple related records.

Rather than treating these as duplicate errors, I validated the intended table grain and confirmed that all child foreign keys existed in the parent trial table.

### Date Parsing

ClinicalTrials.gov date fields can contain varying levels of precision.

The date-cleaning logic was updated to handle mixed date formats rather than assuming every source value followed an identical format.

### Processed Data Export

The initial CSV export failed because the processed-data directory did not yet exist.

The pipeline was updated to automatically create the required directory before exporting the analytical tables.

### Notebook Reproducibility

Temporary troubleshooting cells, installation commands and superseded test transformations were removed from the final notebook.

The completed workflow can be restarted and executed from top to bottom without relying on variables left in memory from previous runs.

---

## Key Learning

This exercise demonstrated that reliable API ingestion requires more than simply downloading records.

A reproducible analytical pipeline requires:

- Clearly defined project scope
- Controlled extraction
- Pagination
- Preservation of source data
- Reproducibility metadata
- Understanding of nested data structures
- Explicit table grain
- Parent-child key validation
- Missingness profiling
- Data-type validation
- Repeatable execution

The development-first approach allowed the pipeline to be tested safely before scaling to the full clinical-trials cohort.

---

## Evidence

Day 10 includes:

- Python fundamentals script
- pandas fundamentals notebook
- ClinicalTrials.gov API ingestion notebook
- Reproducibility manifest
- Four processed analytical tables
- API ingestion code screenshot
- Final pipeline QA screenshot

---

## Next Step

Scale and refine the validated ingestion workflow before continuing the **Clinical Trial Portfolio & Delivery Intelligence** project through deeper profiling, SQL analysis and stakeholder-focused exploration.