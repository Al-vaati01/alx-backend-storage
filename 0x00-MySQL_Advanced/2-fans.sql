-- Task: Rank country origins of bands by the number of non-unique fans

-- Connect to the database
USE metal_bandse;

-- Query to rank country origins by the number of non-unique fans
SELECT
    origin,
    SUM(nb_fans) AS nb_fans
FROM
    metal_bands
GROUP BY
    origin
ORDER BY
    nb_fans DESC
LIMIT 10;