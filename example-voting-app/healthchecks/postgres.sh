#!/bin/bash
set -eo pipefail

# Define variables for the database connection
host="$(hostname -i || echo '127.0.0.1')"  # Get the host IP address or default to localhost
user="${POSTGRES_USER:-postgres}"          # Get the PostgreSQL user, default to 'postgres'
db="${POSTGRES_DB:-$POSTGRES_USER}"        # Get the database name, default to the user name
export PGPASSWORD="${POSTGRES_PASSWORD:-}"  # Set the password for PostgreSQL

# Run a simple query to check the connection
if psql -h "$host" -U "$user" -d "$db" -c "SELECT 1;" --quiet --no-align --tuples-only; then
    exit 0  # Success if the query returns 1
else
    exit 1  # Failure if the query does not return 1
fi

