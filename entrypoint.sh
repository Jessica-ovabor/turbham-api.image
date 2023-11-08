#!/bin/bash

# Activate the virtual environment
source "$(pipenv --venv)/bin/activate"

# Wait for Redis to be ready
/wait-for-it.sh -t 30 my_redis_container:6379 -- echo "Redis is ready"

# Wait for the database to be ready (adjust as needed)
/wait-for-it.sh -t 30 my_postgres_container:5432 -- echo "PostgreSQL is ready"

# Run database initialization (cli.py init-db)
pipenv run python ./turbomed/cli.py init-db

pipenv run python ./turbomed/cli.py create-admin victor.i@turbham.com --password=vannessa1#

# Start the Flask app
pipenv run flask --app turbomed/app run --debug --host 0.0.0.0
