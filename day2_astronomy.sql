/*
DAY 2 - SQL FILTERING, SORTING, PAGINATION
Author  : Tya
Dataset : astronomy_observations
Goal    : Practice ORDER BY, LIMIT, OFFSET, filtering logic
*/

-- 1. Menampilkan 5 objek astronomi dengan jarak terjauh dari bumi
SELECT
    object_name,
    object_type,
    distance_light_years
FROM astronomy_observations
ORDER BY distance_light_years DESC
LIMIT 5;


-- 2. Menampilkan planet paling terang berdasarkan magnitude
-- (semakin kecil nilai magnitude, semakin terang objek)
SELECT
    object_name,
    object_type,
    magnitude
FROM astronomy_observations
WHERE object_type = 'Planet'
ORDER BY magnitude ASC
LIMIT 1;


-- 3. Menampilkan objek non-planet dengan jarak terdekat
SELECT
    object_name,
    object_type,
    distance_light_years
FROM astronomy_observations
WHERE object_type != 'Planet'
ORDER BY distance_light_years ASC;


-- 4. Menampilkan 2 bintang dengan jarak terjauh
SELECT
    object_name,
    object_type,
    distance_light_years
FROM astronomy_observations
WHERE object_type = 'Star'
ORDER BY distance_light_years DESC
LIMIT 2;


-- 5. Menampilkan 3 objek paling gelap berdasarkan magnitude
-- (nilai magnitude terbesar = paling gelap)
SELECT
    object_name,
    object_type,
    magnitude
FROM astronomy_observations
ORDER BY magnitude DESC
LIMIT 3;


-- 6. Pagination example
-- Menampilkan page ke-3 dengan 3 data per halaman
-- OFFSET = (page - 1) * limit = (3 - 1) * 3 = 6
SELECT
    object_name,
    object_type,
    observation_date
FROM astronomy_observations
ORDER BY observation_date ASC
LIMIT 3 OFFSET 6;
