#!/bin/bash
set +x

# Build & Run docker-compose
docker-compose -f docker-compose-prod.yaml stop
docker-compose -f docker-compose-prod.yaml down