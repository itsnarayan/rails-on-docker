#!/bin/bash
set +x

# Deploy docker-compose
docker-compose -f docker-compose.yaml build migration
docker-compose -f docker-compose.yaml up