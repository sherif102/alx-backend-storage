-- optimize search and score
-- create index 'idx_name_first_score' on table names
CREATE INDEX idx_name_first_score ON names (`name`(1), `score`)
