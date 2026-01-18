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

## 🧠 Key Data Engineering Concepts Demonstrated
- Layered data architecture
- Safe data enrichment using LEFT JOIN
- Handling NULLs intentionally
- Incremental processing logic
- Analytics-ready data modeling
- Monitoring and anomaly detection mindset

---

## 🛠️ Tools
- PostgreSQL
- SQL

---

## 🚀 Next Learning Goals
- Common Table Expressions (CTE)
- Subqueries
- Advanced ETL patterns
- Data orchestration concepts
- Cloud data platforms

This repository reflects a learning process designed to
prepare for a career switch into Data Engineering.
