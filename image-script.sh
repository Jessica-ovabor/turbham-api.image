#!/bin/bash

curl -LO https://raw.githubusercontent.com/Jessica-ovabor/turbham-api.image/main/entrypoint.sh

curl -LO https://raw.githubusercontent.com/Jessica-ovabor/turbham-api.image/main/docker-compose.yml

curl -LO https://raw.githubusercontent.com/Jessica-ovabor/turbham-api.image/main/Dockerfile

mkdir -p init-scripts

cd init-scripts


curl -LO https://raw.githubusercontent.com/Jessica-ovabor/turbham-api.image/main/init-scripts/init.sql

ls

cd ..

docker-compose up -d

docker ps

