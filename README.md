**Data Engineer SQL Journey**

A curated SQL portfolio focused on data engineering use cases, including data transformation, aggregation, incremental processing, and data quality monitoring.

This repository demonstrates:
1. Practical SQL patterns for ETL-style workflows
2. Incremental loading and materialization strategies
3. UPSERT logic for stateful aggregates
4. Data quality checks with STOP vs FLAG decisions
5. Monitoring queries for data observability

The project uses an astronomy observation dataset to simulate real-world data engineering scenarios.

## Day 12 – Dimension Change Handling (SCD Type 2)

This module demonstrates how to handle changing dimension data using a Slowly Changing Dimension (Type 2) approach.

### Key Concepts
- Dimension data can change over time and must not overwrite historical records
- Fact tables should remain stable and reference the correct dimension version
- SCD Type 2 preserves historical accuracy for analytics

### What This Covers
- Designing a dimension table with effective dates
- Detecting changes in incoming metadata
- Closing old dimension records
- Inserting new dimension versions

### Why This Matters
Without SCD handling, dimension changes can corrupt historical facts, leading to biased analysis and incorrect insights.

Key focus:
Writing SQL that supports reliable, maintainable, and scalable data pipelines — not just analytical queries.
