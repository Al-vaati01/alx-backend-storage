-- This script ranks the country origins of bands based on the number of fans
-- The table should have columns named "origin" (country) and "nb_fans" (number of fans)

-- Create a temporary table to aggregate the total number of fans per country
CREATE TEMPORARY TABLE IF NOT EXISTS temp_country_fans AS
SELECT origin, SUM(nb_fans) AS total_fans
FROM metal_bands
GROUP BY origin;

-- Rank the country origins by the total number of fans
SELECT origin, total_fans
FROM temp_country_fans
ORDER BY total_fans DESC;
