/*
DAY 11 - DATA QUALITY & MONITORING
Author  : Tya
Goal    : Monitor data quality without stopping the pipeline
Context : Flag anomalies while allowing data to flow
*/

-- =====================================================
-- 1. HARD STOP CHECKS (MANDATORY FIELDS)
-- =====================================================
-- These checks should fail the pipeline if any rows appear
SELECT *
FROM clean_astronomy_observations
WHERE object_name IS NULL
   OR observation_date IS NULL;


-- =====================================================
-- 2. FLAG-ONLY CHECKS (MONITORING)
-- =====================================================
-- Summary-level monitoring per observation_date
SELECT
    observation_date,

    -- Total data ingested per day
    COUNT(*) AS total_observations,

    -- Allowed NULLs (metadata not always available)
    COUNT(*) - COUNT(constellation) AS null_constellation_count,

    -- Suspicious but not blocking
    SUM(
        CASE WHEN distance_light_years < 0 THEN 1 ELSE 0 END
    ) AS negative_distance_count,

    SUM(
        CASE
            WHEN magnitude < -30 OR magnitude > 30 THEN 1
            ELSE 0
        END
    ) AS extreme_magnitude_count,

    -- Possible duplicates (same object observed more than once per day)
    COUNT(*) - COUNT(DISTINCT object_name) AS possible_duplicate_count

FROM clean_astronomy_observations
GROUP BY observation_date
ORDER BY observation_date;