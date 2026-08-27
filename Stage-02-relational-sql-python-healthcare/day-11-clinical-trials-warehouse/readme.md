\# Day 11 — Clinical Trials Warehouse \& Portfolio Analysis



\## Objective



Build a grain-safe PostgreSQL analytical warehouse using real AACT clinical-trial registry data and answer business questions relevant to pharmaceutical portfolio strategy, clinical operations and UK-focused trial planning.



\## Project Scope



The analysis focuses on:



\- Industry-led interventional trials

\- Drug and biological interventions

\- Trials starting from 2015 onwards

\- Global activity with a UK strategic lens

\- Primary analytical grain: one row per clinical trial (`nct\_id`)



The locked cohort contained \*\*46,905 unique trials\*\*.



\---



\## What I Built



\### Source Profiling \& Grain Validation



Profiled the AACT relational source before joining child tables.



A naive sponsor/intervention join produced:



\- \*\*101,476 rows\*\*

\- \*\*46,905 unique trials\*\*



This demonstrated how multiple one-to-many joins can multiply records and distort analytical results.



I therefore built a controlled trial-level model before analysis.



\### Grain-Safe Warehouse



Created:



\- `trial\_core` — one row per trial

\- Lead sponsor bridge

\- Intervention bridge

\- Condition bridge

\- Country bridge

\- Facility bridge



`trial\_core` validation:



\- \*\*46,905 rows\*\*

\- \*\*46,905 unique `nct\_id`s\*\*

\- \*\*0 duplicate trials\*\*



Curated analytical outputs were then created for trial activity, sponsors, interventions, conditions, geography and site footprint.



\---



\## Business Questions



The SQL analysis investigated five areas:



1\. \*\*Portfolio landscape\*\*  

&#x20;  How has industry clinical-trial activity changed since 2015?



2\. \*\*Operational capacity\*\*  

&#x20;  How do enrollment, site requirements and trial duration change through development?



3\. \*\*Geographic strategy\*\*  

&#x20;  Is UK participation changing, and where is global trial activity shifting?



4\. \*\*Portfolio \& delivery risk\*\*  

&#x20;  Which development phases show greater discontinuation and what reported factors are associated with it?



5\. \*\*Reporting governance\*\*  

&#x20;  Where are the largest gaps in publicly posted trial results?



A total of \*\*12 portfolio-analysis queries\*\* were completed.



\---



\## Key Findings



\### Operational Scale Increases Substantially



Median enrollment increased from:



\- \*\*35 participants — Phase 1\*\*

\- \*\*308 participants — Phase 3\*\*



Phase 3 therefore had approximately \*\*8.8× the median enrollment\*\* of Phase 1.



Median site footprint increased from:



\- \*\*1 site — Phase 1\*\*

\- \*\*30 sites — Phase 3\*\*



The Phase 3 75th percentile reached \*\*87 sites across 12 countries\*\*, demonstrating the much greater operational coordination required for later-stage development.



\### Global Trial Geography Is Shifting



Among trials with known geography:



\- UK participation fell from \*\*17.6% in 2015 to 12.9% in 2025\*\*

\- China increased from \*\*7.0% to 39.0%\*\*



This suggests that future geographic planning should consider changing international trial footprints rather than relying only on historically established markets.



\### Phase 2 Represents an Important Portfolio \& Delivery Checkpoint



Among resolved Phase 2 trials, historical discontinuation was \*\*26.2%\*\*.



Reported Phase 2 discontinuation reasons included:



\- Recruitment / enrollment — \*\*18.9%\*\*

\- Business / strategic — \*\*15.8%\*\*

\- Sponsor decision unspecified — \*\*12.0%\*\*

\- Efficacy / futility — \*\*11.3%\*\*



Combined with the much larger infrastructure required in Phase 3, this supports treating Phase 2 as an important \*\*portfolio and operational-readiness checkpoint\*\* before later-stage scale-up.



The registry data does \*\*not\*\* establish that Phase 3 cost or infrastructure requirements cause Phase 2 discontinuation.



\### Results Visibility Differs Strongly by Phase



Among mature completed trials:



\- Phase 1 results-posting coverage — \*\*18.2%\*\*

\- Phase 2 — \*\*64.7%\*\*

\- Phase 3 — \*\*71.3%\*\*



This represents a \*\*53.1 percentage-point difference\*\* between Phase 1 and Phase 3 and suggests that public-results visibility is not consistent across development stages.



\---



\## Problems Solved



\- Prevented row multiplication from multiple one-to-many joins.

\- Preserved one-row-per-trial analytical grain.

\- Used `EXISTS`, pre-aggregation and controlled bridges instead of unsafe joins.

\- Used medians and percentiles for heavily skewed trial distributions.

\- Investigated raw free-text trial discontinuation reasons.

\- Standardised inconsistent stop-reason wording into analytical categories.

\- Identified and corrected keyword-classification errors caused by phrases such as `"not related to safety"`.

\- Used explicit denominators and reported missingness before interpreting rates.



\---



\## Evidence



Screenshots captured:



\- `01\_cohort\_reconciliation.png`

\- `02\_bridge\_row\_reconciliation.png`

\- `03\_recruitment\_burden\_by\_phase.png`

\- `04\_site\_footprint\_by\_phase.png`

\- `05\_country\_participation\_shift.png`

\- `06\_discontinuation\_reasons.png`

\- `07\_results\_posting\_coverage.png`



SQL files:



\- `00\_source\_profile.sql`

\- `01\_trial\_core\_and\_bridges.sql`

\- `02\_curated\_views.sql`

\- `03\_portfolio\_analysis.sql`



\---



\## Limitations



AACT / ClinicalTrials.gov contains self-reported registry data and fields may be incomplete or inconsistently populated.



The analysis is descriptive and observed relationships should not be interpreted as causal.



Free-text discontinuation categories use transparent keyword rules, with approximately \*\*25–33%\*\* of records remaining in the broad `OTHER` category.



Results-posting analysis measures public registry visibility rather than legal or regulatory compliance.



\---



\## Next Validation Step



Cross-platform validation will be completed next using:



\- BigQuery nested JSON and `UNNEST` reconciliation

\- Independent pandas validation of selected SQL metrics



These checks will provide an additional validation layer against the PostgreSQL analysis.

