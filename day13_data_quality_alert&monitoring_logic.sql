/* ============================================================
DAY 13 – DATA QUALITY, ALERT & MONITORING LOGIC
Author  : Tya 
Context : Data Engineer Journey

Objective:
Build a simple but production-minded monitoring and alert system
to detect data quality issues, volume anomalies, and operational risks.

Key Principles:
- Monitoring ≠ Alert
- All metrics are recorded (including OK status)
- Alerts are only generated when action is required
- Alert severity (STOP vs FLAG) is driven by SLA & impact
============================================================ */


/* ============================================================
1. DAILY MONITORING METRICS
---------------------------------------------------------------
Purpose:
Collect daily metrics to understand normal data behavior
and support trend analysis & auditing.
============================================================ */

WITH daily_metrics AS (
    SELECT
        observation_date AS metric_date,

        -- volume monitoring
        COUNT(*) AS daily_volume,

        -- critical data quality checks
        COUNT(*) FILTER (WHERE object_name IS NULL) AS null_object_count,

        -- duplicate detection
        COUNT(*) FILTER (
            WHERE (object_name, observation_date) IN (
                SELECT object_name, observation_date
                FROM clean_astronomy_observations
                GROUP BY object_name, observation_date
                HAVING COUNT(*) > 1
            )
        ) AS duplicate_count

    FROM clean_astronomy_observations
    GROUP BY observation_date
)

SELECT * FROM daily_metrics;


/* ============================================================
2. HISTORICAL BASELINE CALCULATION
---------------------------------------------------------------
Purpose:
Establish a relative baseline instead of using hardcoded thresholds.
Here we use a 7-day rolling average for daily volume.
============================================================ */

WITH daily_volume AS (
    SELECT
        observation_date,
        COUNT(*) AS daily_volume
    FROM clean_astronomy_observations
    GROUP BY observation_date
),
baseline AS (
    SELECT
        AVG(daily_volume) AS avg_7d_volume
    FROM daily_volume
    WHERE observation_date >= CURRENT_DATE - INTERVAL '7 days'
)

SELECT * FROM baseline;


/* ============================================================
3. ALERT EVALUATION LOGIC
---------------------------------------------------------------
Purpose:
Classify each day into:
- STOP  : fatal issue, pipeline must halt
- FLAG  : anomaly, pipeline continues but needs attention
- OK    : normal condition

Evaluation Order:
1. STOP conditions first
2. FLAG conditions second
3. Otherwise OK
============================================================ */

WITH daily_stats AS (
    SELECT
        observation_date,
        COUNT(*) AS daily_volume,
        COUNT(*) FILTER (WHERE object_name IS NULL) AS null_object_count
    FROM clean_astronomy_observations
    GROUP BY observation_date
),
baseline AS (
    SELECT
        AVG(daily_volume) AS avg_7d_volume
    FROM daily_stats
    WHERE observation_date >= CURRENT_DATE - INTERVAL '7 days'
)

SELECT
    d.observation_date,
    d.daily_volume,
    b.avg_7d_volume,

    CASE
        WHEN d.null_object_count > 0 THEN 'STOP'
        WHEN d.daily_volume > 2 * b.avg_7d_volume THEN 'FLAG'
        ELSE 'OK'
    END AS alert_status,

    CASE
        WHEN d.null_object_count > 0
            THEN 'Missing primary identifier (object_name)'
        WHEN d.daily_volume > 2 * b.avg_7d_volume
            THEN 'Daily volume spike compared to historical baseline'
        ELSE 'Normal condition'
    END AS alert_reason

FROM daily_stats d
CROSS JOIN baseline b;


/* ============================================================
4. STORE MONITORING RESULTS
---------------------------------------------------------------
Purpose:
Persist ALL monitoring results (including OK status)
to support trend analysis and alert tuning.
============================================================ */

INSERT INTO monitoring_daily_metrics (
    metric_date,
    metric_name,
    metric_value,
    baseline_value,
    status
)
SELECT
    observation_date,
    'daily_volume' AS metric_name,
    daily_volume AS metric_value,
    avg_7d_volume AS baseline_value,
    alert_status AS status
FROM (
    -- alert evaluation query above
) evaluated_metrics;


/* ============================================================
5. GENERATE ALERT EVENTS
---------------------------------------------------------------
Purpose:
Only actionable conditions (FLAG / STOP) are recorded as alerts.
These alerts are intended for notification or incident tracking.
============================================================ */

INSERT INTO alert_events (
    alert_date,
    alert_level,
    metric_name,
    metric_value,
    expected_value,
    message
)
SELECT
    observation_date,
    alert_status,
    'daily_volume',
    daily_volume,
    avg_7d_volume,
    alert_reason
FROM (
    -- alert evaluation query above
) evaluated_metrics
WHERE alert_status IN ('FLAG', 'STOP');


/* ============================================================
END OF DAY 13 PORTFOLIO
---------------------------------------------------------------
This file demonstrates:
- Data quality monitoring
- Baseline-driven alert logic
- SLA-aware alert severity
- Separation between monitoring metrics and alert events

Focus is on correctness, explainability, and operational readiness.
============================================================ */