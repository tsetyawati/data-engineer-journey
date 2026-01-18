/*
DAY 6 - SQL WINDOW FUNCTIONS
Author  : Tya
Goal    : Analyze time-based metrics using window functions
*/

-- =====================================================
-- Ranking objects by distance within each constellation
-- =====================================================
SELECT
  object_name,
  constellation,
  distance_light_years,
  RANK() OVER (
    PARTITION BY constellation
    ORDER BY distance_light_years DESC
  ) AS distance_rank_within_constellation
FROM clean_astronomy_observations
WHERE constellation IS NOT NULL;


-- =====================================================
-- Running total of observations per constellation
-- =====================================================
SELECT
  observation_date,
  constellation,
  COUNT(*) OVER (
    PARTITION BY constellation
    ORDER BY observation_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total_observations
FROM clean_astronomy_observations
WHERE constellation IS NOT NULL
ORDER BY constellation, observation_date;


-- =====================================================
-- Moving average of distance (last 2 observations)
-- =====================================================
SELECT
  observation_date,
  constellation,
  distance_light_years,
  AVG(distance_light_years) OVER (
    PARTITION BY constellation
    ORDER BY observation_date
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
  ) AS moving_avg_distance_last_2
FROM clean_astronomy_observations
WHERE constellation IS NOT NULL
ORDER BY constellation, observation_date;