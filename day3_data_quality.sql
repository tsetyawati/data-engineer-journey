/*
STEP 2 - DATA QUALITY CHECK
Author  : Tya
Dataset : astronomy_observations
Goal    : Validate data quality using domain-based rules
*/

-- 0. Exploratory range check to understand data distribution
SELECT
    MIN(distance_light_years) AS min_distance,
    MAX(distance_light_years) AS max_distance,
    MIN(magnitude) AS min_magnitude,
    MAX(magnitude) AS max_magnitude
FROM astronomy_observations;


-- 1. NULL check
SELECT *
FROM astronomy_observations
WHERE object_name IS NULL
   OR object_type IS NULL
   OR distance_light_years IS NULL
   OR magnitude IS NULL
   OR observation_date IS NULL;


-- 2. Range validation: distance should not be negative
SELECT *
FROM astronomy_observations
WHERE distance_light_years < 0;


-- 3. Range validation: magnitude outside expected domain range
SELECT *
FROM astronomy_observations
WHERE magnitude < -30
   OR magnitude > 30;


-- 4. Logical anomaly: planets should have distance = 0
SELECT *
FROM astronomy_observations
WHERE object_type = 'Planet'
  AND distance_light_years > 0;


-- 5. Logical anomaly: stars should not have distance = 0
SELECT *
FROM astronomy_observations
WHERE object_type = 'Star'
  AND distance_light_years = 0;