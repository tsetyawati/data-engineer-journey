/*
STEP 1 - SQL HAVING
Author  : Tya
Dataset : astronomy_observations
Goal    : Filter aggregated data using HAVING
*/

-- 1. Tipe objek yang diobservasi kurang dari 2 kali
SELECT object_type,
       COUNT(*) AS total_observations
FROM astronomy_observations
GROUP BY object_type
HAVING COUNT(*) < 2;


-- 2. Tanggal observasi dengan lebih dari 1 objek
SELECT observation_date,
       COUNT(*) AS total_objects
FROM astronomy_observations
GROUP BY observation_date
HAVING COUNT(*) > 1;


-- 3. Tipe objek yang memiliki objek sangat terang (magnitude < 0)
SELECT object_type,
       MIN(magnitude) AS brightest_magnitude
FROM astronomy_observations
GROUP BY object_type
HAVING MIN(magnitude) < 0;


-- 4. Tipe objek dengan rata-rata jarak lebih dari 1000 light years
SELECT object_type,
       AVG(distance_light_years) AS avg_distance
FROM astronomy_observations
GROUP BY object_type
HAVING AVG(distance_light_years) > 1000;