-- Task: Create an index idx_name_first on the first letter of the name column

DROP INDEX IF EXISTS idx_name_first ON names;

CREATE INDEX idx_name_first ON names (SUBSTRING(name, 1, 1));
