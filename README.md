# DocMX: Global SaaS Hospitality Database Architecture

## Project Overview
This project is a relational database architecture for DocMX, a global platform used by hotels to manage internal operations. I designed this schema to handle the full lifecycle of a hospitality client: from signing a contract and managing multi-regional support tickets to automated monthly billing.

## Project Architecture
The database is built on PostgreSQL and normalized to 3NF to ensure data integrity across 16 tables.

## Key Technical Features
- Regional Logic: Clients and Support Engineers are mapped to global regions (APAC, EMEA, AMER) to ensure localized support.
- Subscription Management: Separates 'Contracts' from 'Subscriptions' to track renewals and historical pricing accurately.
- Hierarchical Reporting: Uses a recursive join on the app_user table to manage supervisor/subordinate relationships.
- Data Constraints: Implemented strict CHECK constraints on billing amounts and UNIQUE constraints on client emails to prevent data corruption.

## Repository Structure
/scripts: Contains the full DDL and DML scripts.

- 01_schema_setup.sql: Table creation and constraint logic.
- 02_data_seed.sql: Sample data population, including updates and deletes.
- 03_business_queries.sql: 8+ complex queries showing Joins, Aggregates, and Recursion.

/notebooks: Python analysis using Matplotlib and Pandas to visualize billing trends and ticket volumes.
/docs: Full Entity Relationship Diagram (ERD).

## Data Insights & Analysis
I wrote specific queries to answer real-world SaaS questions:
1. Revenue Tracking: Total billing amounts grouped by client.
2. Workload Analysis: Identifying which engineers are handling the most tickets per region.
3. Tickets per Category: Identifying which issue categories occur most frequently to help prioritize development.

## 📈 Visualizations
Included are three Jupyter Notebooks utilizing **Matplotlib** and **Pandas** to transform SQL query results into actionable visual insights, focusing on revenue, workloads, and tickets per category.