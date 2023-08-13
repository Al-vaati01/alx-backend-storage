-- Task: Rank country origins of bands by the number of non-unique fans
-- Query to rank country origins by the number of non-unique fans

SELECT
    b.origin AS origin,
    COUNT(*) AS nb_fans
FROM
    bands AS b
JOIN
    fans AS f ON b.band_id = f.band_id
GROUP BY
    b.origin
ORDER BY
    nb_fans DESC;