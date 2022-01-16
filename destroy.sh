#!/bin/bash
set +x

# Build & Run docker-compose
docker-compose -f docker-compose.yaml stop
docker-compose -f docker-compose.yaml down

# Remove data and log files 
rm -rf tmp/*
rm -rf log/*