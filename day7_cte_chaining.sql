/*
DAY 7 - CTE & CTE CHAINING (ETL STYLE)
Author  : Tya
Goal    : Demonstrate multi-step SQL logic using CTE chaining
Context : Data Engineering mindset (base → aggregate → filter → enrich)
*/

-- =====================================================
-- STEP 1: Base data (clean & valid observations only)
-- =====================================================
WITH base_data AS (
    SELECT
        object_name,
        constellation,
        observation_date
    FROM clean_astronomy_observations
    WHERE distance_light_years > 0
),

-- =====================================================
-- STEP 2: Aggregate total observations per constellation
-- =====================================================
total_observation_per_constellation AS (
    SELECT
        constellation,
        COUNT(*) AS total_observations
    FROM base_data
    GROUP BY constellation
),

-- =====================================================
-- STEP 3: Apply business rule
-- Only constellations with at least 2 observations
-- =====================================================
filtered_constellation AS (
    SELECT
        constellation,
        total_observations
    FROM total_observation_per_constellation
    WHERE total_observations >= 2
)

-- =====================================================
-- STEP 4: Enrich base data with aggregated metrics
-- =====================================================
SELECT
    b.object_name,
    b.constellation,
    b.observation_date,
    f.total_observations
FROM base_data b
JOIN filtered_constellation f
    ON b.constellation = f.constellation
ORDER BY f.total_observations DESC;