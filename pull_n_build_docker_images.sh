#!/bin/bash

echo "!!!!~~~~~~~~~~~~Trying to run this script from Jenkins pipeline~~~~~~~~~~!!!!"

docker build -t mypostgres docker/postgres/.
