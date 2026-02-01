/* ============================================================
   END-TO-END DATA ENGINEER PIPELINE (FINAL)
   Case Study  : Astronomy Observations
   Author      : Tya
   Focus       : Incremental Load, Monitoring, Alerting
   ============================================================

   DESIGN PRINCIPLES:
   - Raw data is immutable
   - Fact tables are append-only
   - Incremental is state-based, not date-based
   - Monitoring ≠ Alert
   - Alerts must be actionable (STOP vs FLAG)
   ============================================================ */


/* ============================================================
   1. DATA CLEANING & STANDARDIZATION
   Purpose:
   - Prepare data for processing
   - Do NOT modify raw source
   ============================================================ */

WITH cleaned_data AS (
    SELECT
        observation_date,
        object_name,
        object_type,
        NULLIF(constellation, 'N/A') AS constellation,
        distance_light_years,
        magnitude
    FROM raw_astronomy_observations
),


/* ============================================================
   2. DATA VALIDATION
   Purpose:
   - Separate INVALID data (STOP)
   - Keep VALID data for further processing
   ============================================================ */

invalid_data AS (
    SELECT *
    FROM cleaned_data
    WHERE distance_light_years < 0
),

validated_data AS (
    SELECT *
    FROM cleaned_data
    WHERE distance_light_years >= 0
),


/* ============================================================
   3. PIPELINE STATE (INCREMENTAL ANCHOR)
   Purpose:
   - Track last SUCCESSFUL pipeline run
   - Avoid relying on max(event_date)
   ============================================================ */

pipeline_anchor AS (
    SELECT
        last_processed_at
    FROM pipeline_state
    WHERE pipeline_name = 'astronomy_fact_pipeline'
),


/* ============================================================
   4. INCREMENTAL SOURCE WITH REPROCESSING WINDOW
   Purpose:
   - Capture late-arriving data
   - Ensure safe reruns
   ============================================================ */

incremental_source AS (
    SELECT v.*
    FROM validated_data v
    CROSS JOIN pipeline_anchor p
    WHERE v.observation_date >= p.last_processed_at - INTERVAL '2 days'
),


/* ============================================================
   5. DEDUPLICATION (IDEMPOTENT LOAD)
   Purpose:
   - Prevent duplicates during reruns
   ============================================================ */

deduplicated_data AS (
    SELECT
        observation_date,
        object_name,
        object_type,
        distance_light_years,
        magnitude
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY object_name, observation_date
                ORDER BY observation_date DESC
            ) AS row_num
        FROM incremental_source
    ) t
    WHERE row_num = 1
)


/* ============================================================
   6. LOAD FACT TABLE (APPEND ONLY)
   ============================================================ */

INSERT INTO astronomy_fact (
    observation_date,
    object_name,
    object_type,
    distance_light_years,
    magnitude
)
SELECT
    observation_date,
    object_name,
    object_type,
    distance_light_years,
    magnitude
FROM deduplicated_data;


/* ============================================================
   7. UPDATE PIPELINE STATE
   IMPORTANT:
   - Executed ONLY after successful load
   ============================================================ */

UPDATE pipeline_state
SET last_processed_at = CURRENT_TIMESTAMP
WHERE pipeline_name = 'astronomy_fact_pipeline';


/* ============================================================
   8. MONITORING (SYSTEM OBSERVABILITY)
   Purpose:
   - Record system behavior every run
   - No IF / No STOP here
   ============================================================ */

INSERT INTO monitoring_daily_metrics (
    run_date,
    total_rows,
    total_objects,
    min_distance,
    max_distance,
    avg_magnitude
)
SELECT
    CURRENT_DATE,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT object_name) AS total_objects,
    MIN(distance_light_years) AS min_distance,
    MAX(distance_light_years) AS max_distance,
    AVG(magnitude) AS avg_magnitude
FROM astronomy_fact;


/* ============================================================
   9. ALERTING (ACTIONABLE SIGNALS)
   Principle:
   - STOP  : Data correctness at risk
   - FLAG  : Requires human investigation
   ============================================================ */

-- STOP ALERT: Invalid data should never exist after validation
SELECT *
FROM astronomy_fact
WHERE distance_light_years < 0;

-- FLAG ALERT: Unusual volume spike
SELECT
    run_date,
    total_rows
FROM monitoring_daily_metrics
WHERE total_rows >
      (SELECT AVG(total_rows) * 3 FROM monitoring_daily_metrics);