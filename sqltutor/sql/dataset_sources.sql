DROP TABLE dataset_sources CASCADE;

CREATE TABLE dataset_sources (
  dataset   VARCHAR(12),
  year      INT,
  sources   VARCHAR(120)
);

