/*
DAY 12 - DIMENSION CHANGE HANDLING (SCD TYPE 2)
Author  : Tya
Goal    : Preserve historical dimension changes without corrupting fact data
Context : Constellation metadata may change over time
*/

-- =====================================================
-- 1. DIMENSION TABLE (SCD TYPE 2)
-- =====================================================
CREATE TABLE IF NOT EXISTS dim_constellation (
    constellation_key SERIAL PRIMARY KEY,
    constellation_name TEXT,
    effective_start_date DATE,
    effective_end_date DATE,
    is_current BOOLEAN
);

-- =====================================================
-- 2. INSERT INITIAL DIMENSION DATA
-- =====================================================
INSERT INTO dim_constellation (
    constellation_name,
    effective_start_date,
    effective_end_date,
    is_current
)
SELECT DISTINCT
    constellation,
    CURRENT_DATE,
    NULL,
    TRUE
FROM clean_astronomy_observations
WHERE constellation IS NOT NULL;

-- =====================================================
-- 3. DETECT CHANGES IN INCOMING DATA
-- =====================================================
WITH latest_dimension AS (
    SELECT
        constellation_name
    FROM dim_constellation
    WHERE is_current = TRUE
),
incoming_data AS (
    SELECT DISTINCT
        constellation
    FROM clean_astronomy_observations
    WHERE constellation IS NOT NULL
)
SELECT
    i.constellation
FROM incoming_data i
LEFT JOIN latest_dimension d
    ON i.constellation = d.constellation_name
WHERE d.constellation_name IS NULL;

-- =====================================================
-- 4. CLOSE OLD RECORD (END DATE)
-- =====================================================
UPDATE dim_constellation
SET
    effective_end_date = CURRENT_DATE - INTERVAL '1 day',
    is_current = FALSE
WHERE is_current = TRUE
  AND constellation_name IN (
      SELECT constellation
      FROM clean_astronomy_observations
  );

-- =====================================================
-- 5. INSERT NEW VERSION (NEW DIMENSION STATE)
-- =====================================================
INSERT INTO dim_constellation (
    constellation_name,
    effective_start_date,
    effective_end_date,
    is_current
)
SELECT DISTINCT
    constellation,
    CURRENT_DATE,
    NULL,
    TRUE
FROM clean_astronomy_observations
WHERE constellation IS NOT NULL;