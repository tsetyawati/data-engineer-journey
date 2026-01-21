/*
DAY 9 - INCREMENTAL MATERIALIZATION (CONCEPTUAL)
Author  : Tya
Goal    : Incrementally load aggregated analytics data using a watermark
Context : Append new aggregated data without full table rebuild
*/

-- =====================================================
-- STEP 1: Inspect latest processed observation date
-- =====================================================
SELECT
    MAX(last_observation_date) AS latest_processed_date
FROM analytics_constellation_observations;


-- =====================================================
-- STEP 2: Aggregate NEW data only (incremental batch)
-- =====================================================
SELECT
    constellation,
    COUNT(*) AS total_observations,
    MAX(observation_date) AS last_observation_date
FROM clean_astronomy_observations
WHERE observation_date >
    (SELECT MAX(last_observation_date)
     FROM analytics_constellation_observations)
  AND constellation IS NOT NULL
GROUP BY constellation;


-- =====================================================
-- STEP 3: Insert incremental aggregated data
-- NOTE:
-- This assumes constellation-level duplication is handled later
-- (UPSERT / MERGE in next iteration)
-- =====================================================
INSERT INTO analytics_constellation_observations (
    constellation,
    total_observations,
    last_observation_date
)
SELECT
    constellation,
    COUNT(*) AS total_observations,
    MAX(observation_date) AS last_observation_date
FROM clean_astronomy_observations
WHERE observation_date >
    (SELECT MAX(last_observation_date)
     FROM analytics_constellation_observations)
  AND constellation IS NOT NULL
GROUP BY constellation;