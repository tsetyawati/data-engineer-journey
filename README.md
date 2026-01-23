# Data Engineer SQL Portfolio

This repository documents my structured learning journey toward becoming
a Data Engineer, focusing on SQL fundamentals, data quality, and ETL concepts.

The portfolio is built progressively to reflect real-world data engineering
workflows rather than isolated query exercises.

---

## 📌 Learning Scope
- SQL Fundamentals
- Data Aggregation & Analytics
- JOIN & Data Enrichment
- Data Quality Validation
- ETL Concepts (RAW → CLEAN → ANALYTICS)
- Incremental Load Mindset
- SQL Window Functions

---

## 📅 Day-by-Day Breakdown

### Day 1–2: SQL Fundamentals
- SELECT statements
- Filtering and ordering data
- Basic query structure

### Day 3: Aggregation
- COUNT, AVG, MIN, MAX
- GROUP BY and HAVING
- Analytical summaries

### Day 4: JOIN & Data Quality
- INNER JOIN and LEFT JOIN
- Table aliasing
- Detecting missing metadata
- Normalizing placeholder values (e.g., 'N/A' → NULL)
- JOIN with aggregation and HAVING

### Day 5: Mini ETL with SQL
- Simulated ETL pipeline:
  - RAW: astronomy_observations, astronomy_objects
  - CLEAN: clean_astronomy_observations
  - ANALYTICS: analytics_constellation_summary
- Data quality checks (NULL and range validation)
- Incremental load strategy using COALESCE
- Analytics table materialization
- Basic anomaly detection

### Day 6: SQL Window Functions
- Difference between GROUP BY and window functions
- Ranking within partitions
- Running totals
- Moving averages
- Time-based analytics without losing row-level detail

---

### Day 7: CTE & CTE Chaining

This section focuses on writing structured, multi-step SQL queries using
Common Table Expressions (CTEs).

Key concepts demonstrated:
- Difference between subqueries and CTEs
- Using CTEs to break complex logic into readable steps
- CTE chaining for ETL-style workflows
- Separating concerns:
  - Base data preparation
  - Aggregation
  - Business rule filtering
  - Data enrichment

Example use case:
- Identify constellations with sufficient observation volume
- Enrich row-level data with aggregated metrics
- Maintain clarity and maintainability in complex SQL logic

This approach reflects real-world data engineering practices,
where queries are designed to be readable, testable, and scalable.

## 🧠 Key Data Engineering Concepts Demonstrated
- Layered data architecture
- Safe data enrichment using LEFT JOIN
- Handling NULLs intentionally
- Incremental processing logic
- Analytics-ready data modeling
- Monitoring and anomaly detection mindset

---

### Day 8: Materialization (CTE → Analytics Table)

This day focuses on transforming stable query logic into
persistent analytics tables using `CREATE TABLE AS`.

Key concepts demonstrated:
- Difference between temporary logic (CTE) and persisted data
- When and why to materialize query results
- Building an analytics layer from clean data
- Safe table recreation using `DROP TABLE IF EXISTS`
- Separation of concerns:
  - Transformation logic
  - Storage (analytics table)
  - Presentation (final SELECT)

Example use case:
- Aggregate constellation-level observation metrics
- Store results for reuse in reporting and downstream analysis

This reflects a core data engineering responsibility:
deciding when query results should become reusable data assets.

### Day 9: Incremental Materialization (Watermark-Based Loading)

This day focuses on implementing incremental data loading
for aggregated analytics tables.

Key concepts demonstrated:
- Difference between full refresh and incremental loading
- Use of watermark (`last_observation_date`) to detect new data
- Re-aggregation of new data before inserting into analytics tables
- Maintaining consistency between row-level and aggregated-level data
- Awareness of duplication risks when appending aggregated data

Workflow overview:
1. Identify the latest processed observation date
2. Aggregate only newly arrived data
3. Append results into the analytics table

This approach reflects a common real-world ETL pattern where
data pipelines process new data batches incrementally
instead of rebuilding entire datasets.

Further improvements (e.g., UPSERT / MERGE) are intentionally
deferred to maintain conceptual clarity.

### Day 11: Data Quality & Monitoring

This day focuses on implementing practical data quality checks
from a data engineering perspective.

Key concepts demonstrated:
- Differentiating between blocking errors and monitoring-only flags
- Applying COUNT-based logic to detect missing values, duplicates, and anomalies
- Using HAVING instead of WHERE for aggregation-based conditions
- Designing quality checks that do not unnecessarily stop pipelines
- Building a lightweight monitoring layer for observability

Approach:
- Mandatory fields (e.g., object_name, observation_date) trigger hard failures
- Metadata gaps, range anomalies, and volume spikes are flagged for monitoring
- Monitoring queries summarize data health per observation date

This reflects real-world data engineering practices where
data imperfections are monitored, not blindly rejected.

## 🛠️ Tools
- PostgreSQL
- SQL

---

This repository reflects a learning process designed to
prepare for a career switch into Data Engineering.
