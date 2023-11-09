#!/bin/bash

# Check if running on Windows
if [ -n "$WINDIR" ]; then
    # Activate the virtual environment in PowerShell
    . "$(pipenv --venv)/Scripts/Activate.ps1"
else
    # Activate the virtual environment on Unix-like systems
    source "$(pipenv --venv)/bin/activate"
fi

# Rest of your script
# Wait for Redis to be ready
/wait-for-it.sh -t 30 my_redis_container:6379 -- echo "Redis is ready"

# Wait for the database to be ready
/wait-for-it.sh -t 30 my_postgres_container:5432 -- echo "PostgreSQL is ready"

# Run database initialization (cli.py init-db)
pipenv run python ./turbomed/cli.py init-db

pipenv run python ./turbomed/cli.py create-admin jessica.o@turbham.com --password=password123

# Start the Flask app
pipenv run flask --app turbomed/app run --debug --host 0.0.0.0
