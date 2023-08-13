-- Task: Create an index idx_name_first_score on the first letter of the name column and the score column

DROP INDEX IF EXISTS idx_name_first_score ON names;

CREATE INDEX idx_name_first_score ON names (SUBSTRING(name, 1, 1), score);
