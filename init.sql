DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = 'root') THEN
        CREATE USER root WITH PASSWORD 'root';
    END IF;
END$$;
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'my_database') THEN
        CREATE DATABASE my_database;
    END IF;
END$$;
GRANT ALL PRIVILEGES ON DATABASE my_database TO root;
\c my_database
GRANT ALL PRIVILEGES ON SCHEMA public TO root;
GRANT CREATE ON DATABASE my_database TO root;
