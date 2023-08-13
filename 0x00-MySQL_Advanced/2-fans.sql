-- Task: Rank country origins of bands by the number of non-unique fans
-- Query to rank country origins by the number of non-unique fans

SELECT origin,
    COUNT(DISTINCT fans) AS nb_fans
FROM
    metal_bands
GROUP BY
    origin
ORDER BY
    nb_fans DESC;
