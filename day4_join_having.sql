/*
DAY 4 - JOIN + HAVING
Author  : Tya
Dataset : astronomy_observations, astronomy_objects
Goal    : Analyze observations across joined tables using aggregation and HAVING
*/

-- Constellations with average distance greater than 1000 light years
SELECT
  m.constellation,
  AVG(o.distance_light_years) AS avg_distance_light_years
FROM astronomy_observations o
JOIN astronomy_objects m
  ON o.object_name = m.object_name
WHERE m.constellation IS NOT NULL      -- exclude missing metadata for analytics
GROUP BY m.constellation
HAVING AVG(o.distance_light_years) > 1000
ORDER BY avg_distance_light_years DESC;