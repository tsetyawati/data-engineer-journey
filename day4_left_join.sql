/*
DAY 4 - LEFT JOIN & DATA QUALITY
Author  : Tya
Dataset : astronomy_observations, astronomy_objects
Goal    : Detect missing metadata and analyze observations using JOIN
*/

-- Normalize 'N/A' values to NULL
UPDATE astronomy_objects
SET constellation = NULL
WHERE constellation = 'N/A';


-- 1. Display observations with available constellation metadata
SELECT
  o.observation_date,
  m.constellation
FROM astronomy_observations o
INNER JOIN astronomy_objects m
  ON o.object_name = m.object_name;


-- 2. Detect observations without constellation metadata
SELECT
  o.observation_date,
  o.object_name
FROM astronomy_observations o
LEFT JOIN astronomy_objects m
  ON o.object_name = m.object_name
WHERE m.constellation IS NULL;


-- 3. Count observations per constellation
SELECT
  m.constellation,
  COUNT(*) AS total_observations
FROM astronomy_observations o
JOIN astronomy_objects m
  ON o.object_name = m.object_name
WHERE m.constellation IS NOT NULL
GROUP BY m.constellation
ORDER BY total_observations DESC;


-- 4. Constellation with the highest number of observations
SELECT
  m.constellation,
  COUNT(*) AS total_observations
FROM astronomy_observations o
JOIN astronomy_objects m
  ON o.object_name = m.object_name
WHERE m.constellation IS NOT NULL
GROUP BY m.constellation
ORDER BY total_observations DESC
LIMIT 1;


-- 5. Observations with complete metadata only
SELECT
  o.observation_date,
  o.object_name,
  m.constellation
FROM astronomy_observations o
JOIN astronomy_objects m
  ON o.object_name = m.object_name
WHERE m.constellation IS NOT NULL;


-- 6. Count observations missing metadata (LEFT JOIN required)
SELECT
  COUNT(*) AS total_missing_metadata
FROM astronomy_observations o
LEFT JOIN astronomy_objects m
  ON o.object_name = m.object_name
WHERE m.constellation IS NULL;