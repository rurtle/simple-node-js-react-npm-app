#!/bin/bash

echo "!!!!~~~~~~~~~~~~Trying to run this script from Jenkins pipeline~~~~~~~~~~!!!!"

echo "Pulling the latest /user/bin/docker image for Postgres"
# Pull the Postgres /user/bin/docker image from /user/bin/dockerHub
/user/bin/docker pull postgres:latest

echo "Building the latest /user/bin/docker image for Postgres"
# Build it
/user/bin/docker build -t my_postgres_image .

echo "Running the latest /user/bin/docker image for Postgres"
# Run it
/user/bin/docker run -d -p 5432:5432 --name my_postgres_container my_postgres_image
