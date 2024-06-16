#!/bin/bash

echo "!!!!~~~~~~~~~~~~Trying to run this script from Jenkins pipeline~~~~~~~~~~!!!!"

echo "Pulling the latest Docker image for Postgres"
# Pull the Postgres docker image from DockerHub
docker pull postgres:latest

echo "Building the latest Docker image for Postgres"
# Build it
docker build -t my_postgres_image .

echo "Running the latest Docker image for Postgres"
# Run it
docker run -d -p 5432:5432 --name my_postgres_container my_postgres_image
