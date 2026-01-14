/*
STEP 3 - MINI CASE: ASTRONOMY MONITORING
Author  : Tya
Dataset : astronomy_observations
Goal    : Build monitoring and alerting queries for observation activity
*/

-- 1. Daily activity monitoring
SELECT
    observation_date,
    COUNT(*) AS total_observations
FROM astronomy_observations
GROUP BY observation_date
ORDER BY observation_date;


-- 2. Brightness monitoring (quality signal)
-- Detect very bright objects (magnitude < 0)
SELECT
    observation_date,
    object_name,
    object_type,
    magnitude
FROM astronomy_observations
WHERE magnitude < 0
ORDER BY observation_date;


-- 3. Distance distribution per object type (sanity check)
SELECT
    object_type,
    MIN(distance_light_years) AS min_distance,
    MAX(distance_light_years) AS max_distance,
    AVG(distance_light_years) AS avg_distance
FROM astronomy_observations
GROUP BY object_type;


-- 4. Critical data quality alerts (logical anomalies)
SELECT *
FROM astronomy_observations
WHERE (object_type = 'Planet' AND distance_light_years > 0)
   OR (object_type = 'Star' AND distance_light_years = 0);