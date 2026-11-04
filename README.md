# Arkansas Consumer Complaints Analysis

## Business Problem
Consumers in Arkansas file complaints about banks, credit reporting
companies, and lenders. A customer-service or compliance team needs to know
what problems come up most, which companies respond slowly, and where to
focus first. This project analyzes the complaints to find answers and make
recommendations.

## Who is this for?
A customer-service or compliance manager at a financial company.

## Questions I will answer
1. Which products and issues get the most complaints in Arkansas, and how has the volume changed over time?
2. How much of the data is credit reporting, and which three companies drive it?
3. Outside credit reporting, which products (debt collection, credit cards, banks) have the most complaints and what are the main issues?
4. Which companies have the most untimely responses or complaints still in progress?
5. How do outcomes (explanation, non-monetary relief, monetary relief) differ by product and company?
6. Which Arkansas ZIP areas have the most complaints?
7. What should a customer-service team focus on first?

## Data
- **Source:** CFPB Consumer Complaint Database
- **Filter:** State = Arkansas, dates received = 12/31/2023 to 11/04/2026
- **Size:** 99,709 complaints
- **Note:** Findings apply to Arkansas only, not the whole US.

## Tools
SQL (DuckDB), Python (pandas, matplotlib, seaborn), Power BI

## Status
In progress
