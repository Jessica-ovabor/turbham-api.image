DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'postgres') THEN
        CREATE USER postgres WITH ENCRYPTED PASSWORD 'Un53cur3Pa55w0rd';
    END IF;
END $$;

CREATE DATABASE your_database_name;
\c turbomeddb;

-- Call your Python script to create tables
\! python /turbomed/cli.py init-db

