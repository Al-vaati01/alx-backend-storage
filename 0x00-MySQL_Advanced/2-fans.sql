-- Task: Rank country origins of bands by the number of non-unique fans
-- Query to rank country origins by the number of non-unique fans

SELECT
    b.origin AS origin,
    COUNT(DISTINCT f.fan_id) AS nb_fans
FROM
    bands AS b
LEFT JOIN
    fans AS f ON b.band_id = f.band_id
GROUP BY
    b.origin
ORDER BY
    nb_fans DESC;
