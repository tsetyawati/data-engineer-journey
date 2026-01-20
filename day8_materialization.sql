/*
DAY 8 - MATERIALIZATION (ANALYTICS LAYER)
Author  : Tya
Goal    : Persist aggregated analytics data using CREATE TABLE AS
Context : Transform stable query logic into reusable analytics table
*/

-- =====================================================
-- SAFETY STEP: ensure table can be recreated
-- =====================================================
DROP TABLE IF EXISTS analytics_constellation_observations;

-- =====================================================
-- MATERIALIZATION STEP
-- Create analytics table for constellation-level metrics
-- =====================================================
CREATE TABLE analytics_constellation_observations AS
SELECT
    constellation,
    COUNT(*) AS total_observations,
    MAX(observation_date) AS last_observation_date
FROM clean_astronomy_observations
WHERE constellation IS NOT NULL
GROUP BY constellation;

-- =====================================================
-- OPTIONAL: validate result (presentation only)
-- =====================================================
SELECT *
FROM analytics_constellation_observations
ORDER BY last_observation_date DESC;