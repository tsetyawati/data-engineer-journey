/*
DAY 5 - MINI ETL (RAW → CLEAN → ANALYTICS)
Author  : Tya
Goal    : Simulate an end-to-end ETL pipeline using SQL
*/

-- =====================================================
-- STEP 1: CLEAN LAYER (RAW → CLEAN)
-- =====================================================

-- Create clean table by enriching raw observations with metadata
CREATE TABLE clean_astronomy_observations AS
SELECT
  o.observation_date,
  o.object_name,
  o.object_type,
  o.distance_light_years,
  o.magnitude,
  m.constellation
FROM astronomy_observations o
LEFT JOIN astronomy_objects m
  ON o.object_name = m.object_name;


-- =====================================================
-- STEP 2: DATA QUALITY CHECKS (CLEAN LAYER)
-- =====================================================

-- Critical NULL checks (raw data issues)
SELECT *
FROM clean_astronomy_observations
WHERE observation_date IS NULL
   OR object_name IS NULL
   OR object_type IS NULL
   OR distance_light_years IS NULL
   OR magnitude IS NULL;


-- Informational NULL checks (missing metadata)
SELECT *
FROM clean_astronomy_observations
WHERE constellation IS NULL;


-- Range validation: distance should not be negative
SELECT *
FROM clean_astronomy_observations
WHERE distance_light_years < 0;


-- =====================================================
-- STEP 3: ANALYTICS LAYER (CLEAN → ANALYTICS)
-- =====================================================

-- Rebuild analytics table from clean data
DROP TABLE IF EXISTS analytics_constellation_summary;

CREATE TABLE analytics_constellation_summary AS
SELECT
  constellation,
  COUNT(*) AS total_observations,
  AVG(distance_light_years) AS avg_distance_light_years,
  AVG(magnitude) AS avg_magnitude
FROM clean_astronomy_observations
WHERE constellation IS NOT NULL
GROUP BY constellation
ORDER BY total_observations DESC;


-- =====================================================
-- STEP 4: DATA QUALITY ALERT (MONITORING)
-- =====================================================

-- Alert for constellations with unusually high observation volume
-- Threshold defined for monitoring purposes
SELECT
  constellation,
  total_observations
FROM analytics_constellation_summary
WHERE total_observations > 2
ORDER BY total_observations DESC;