-- This script creates a table called "users" with specified attributes
-- If the table already exists, the script will not fail

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);
