#!/bin/bash
set +x

# Deploy docker-compose
docker-compose -f docker-compose-prod.yaml up
# #!/bin/sh
# export $(cat .env.prduction) > /dev/null 2>&1; 
# docker stack deploy -c docker-compose.yml ${1:-STACK_NAME}