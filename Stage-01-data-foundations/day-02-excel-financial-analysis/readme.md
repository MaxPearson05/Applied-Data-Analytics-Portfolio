#Day 02 – Excel Tables, Formulas and Controls

## Deliverable
Day02_Excel_Financial_Analysis.xlsx


## What I learned 
- Excel tables allow formulas to use readable structured references. 
- SUMIFS, COUNTIFS and AVERAGEIFS calculate results using multiple conditions. 
- XLOOKUP can retrieve a specific record using a unique Source Row ID. 
- Dynamic-array formulas such as UNIQUE and SORT must be placed outside Excel tables. 
- Data-validation dropdowns can be connected reliably through workbook-level named ranges. 
- Weighted profit margin should be calculated as total profit divided by total sales, rather than averaging individual row margins. 
- IFERROR prevents invalid calculations and makes the workbook easier to use. 
- QA controls are important because a formula returning a number does not automatically mean the number is correct. 

## Problems solved 
- Fixed #SPILL errors caused by placing dynamic-array formulas inside a table. 
- Corrected dropdowns that were treating “List” as a single option. 
- Connected country and product dropdowns to named ranges. - Added Source Row ID validation and XLOOKUP error handling. 
- Reconciled 700 rows, total sales, total profit and date boundaries. 
