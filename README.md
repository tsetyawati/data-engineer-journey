### Day 2 – SQL Filtering & Pagination (Astronomy Dataset)
This section demonstrates filtering, sorting, and pagination queries
using an astronomy observation dataset, focusing on real-world SQL patterns
commonly used in data engineering workflows.
# Data Engineer SQL Portfolio

This repository documents my journey in building core SQL skills for Data Engineering,
with a focus on aggregation, data quality validation, and monitoring use cases.

---

## 📊 Dataset: Astronomy Observations

The dataset contains astronomical observation records with the following attributes:
- object_name
- object_type (Planet, Star, Galaxy, etc.)
- distance_light_years
- magnitude
- observation_date

The dataset is used to simulate real-world data engineering scenarios such as
data validation, monitoring, and anomaly detection.

---

## 📅 Day 3 — Aggregation, Data Quality & Monitoring

### 1️⃣ Aggregation & HAVING
**File:** `sql/day3_having.sql`

Focus:
- GROUP BY & aggregation functions (COUNT, AVG, MIN, MAX)
- Filtering aggregated results using HAVING
- Identifying meaningful subsets of data after summarization

Example use cases:
- Object types with low observation counts
- Object types with extreme brightness
- Average distance thresholds per object type

---

### 2️⃣ Data Quality Checks
**File:** `sql/day3_data_quality.sql`

Focus:
- NULL validation
- Range validation based on domain knowledge
- Duplicate detection
- Logical anomaly detection

Key rules implemented:
- Distance values must not be negative
- Magnitude values must be within a reasonable astronomical range
- Planets should have zero distance
- Stars should not have zero distance

These checks simulate pre-processing validation commonly used in data pipelines.

---

### 3️⃣ Monitoring & Alerting Mini Case
**File:** `sql/day3_monitoring_case.sql`

Focus:
- Daily activity monitoring
- Brightness anomaly detection
- Distribution sanity checks
- Rule-based data quality alerts

This mini case simulates how SQL is used in production environments to support
dashboarding and alerting systems.

---

## 🛠️ Tools
- PostgreSQL
- SQL

---

## 🎯 Key Learnings
- Aggregation is essential for reporting and monitoring
- Data quality checks must be domain-driven
- SQL is a critical tool for both analysis and operational monitoring
- Clear reasoning behind queries is as important as correctness

---

## 🚀 Next Steps
- SQL JOINs with relational datasets
- ETL pipeline simulation
- Data warehouse modeling

- 
## 📅 Day 4 — SQL JOIN & Aggregation

Day 4 focuses on combining data across multiple tables using SQL JOINs
and analyzing the results using aggregation and HAVING clauses.

### Topics Covered
- INNER JOIN and LEFT JOIN
- Table aliasing and join keys
- Detecting missing metadata using LEFT JOIN
- Normalizing placeholder values (`'N/A'` → NULL)
- Aggregation across joined tables
- Filtering aggregated results using HAVING

### Key Use Cases
- Identifying observations without metadata
- Counting observations per constellation
- Detecting active constellations based on observation volume
- Filtering constellations by average distance thresholds

These queries simulate real-world data engineering tasks such as
data enrichment, data quality validation, and analytics-ready transformations.

# Data Engineer SQL Portfolio

This repository documents my learning journey toward Data Engineering,
focusing on SQL-based data modeling, data quality validation, and ETL concepts.

---

## 📅 Day 5 — Mini ETL with SQL

Day 5 simulates a simplified end-to-end ETL (Extract, Transform, Load) pipeline
using SQL only, following common Data Engineering practices.

### ETL Architecture
- *RAW layer*
  - astronomy_observations
  - astronomy_objects
- *CLEAN layer*
  - clean_astronomy_observations
- *ANALYTICS layer*
  - analytics_constellation_summary

---

## 🔄 ETL Flow

### 1. Raw to Clean
- Enriched raw observation data using LEFT JOIN
- Preserved all raw records while adding metadata
- Standardized schema for downstream usage

### 2. Data Quality Validation
- Critical NULL checks for raw data integrity
- Informational NULL checks for missing metadata
- Range validation for numeric fields

### 3. Clean to Analytics
- Aggregated clean data into analytics-ready tables
- Materialized metrics for efficient dashboard and reporting usage

### 4. Monitoring & Alerting
- Identified potential data anomalies based on observation volume thresholds
- Designed queries to support alerting workflows

---

## 🧠 Key Concepts Demonstrated
- SQL-based ETL design
- Layered data architecture (RAW → CLEAN → ANALYTICS)
- Safe data enrichment using LEFT JOIN
- NULL handling and data quality checks
- Aggregation and analytics table materialization
- Monitoring and anomaly detection

---

## 🛠️ Tools
- PostgreSQL
- SQL

---

## 🚀 Next Steps
- Incremental ETL strategies
- SQL Window Functions
- Pipeline orchestration concepts

This portfolio reflects practical data engineering workflows
rather than purely analytical SQL queries.
