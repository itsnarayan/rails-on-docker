# Migrate Rails app from legacy to docker environment

## Overview
This document explains procedure to setup this rails application in local machine as a production enviroment using docker.

## Prerequisites
- Docker v20.10.8
- Docker Compose v1.29.2

## Getting Started

- Unzip source code zip file `rails-on-docker.zip`
```
sudo apt-get install unzip # Skip if its already installed
unzip rails-on-docker.zip -d rails-on-docker
```

NOTE : **Import secret credentials** and **Build Application Image**section can be skipped if purpose is just to deploy application with latest version.

## Import secret credentials

- Unzip secrets zip file i.e. `secrets.zip`
Use some other directory to unzip these details, Not inside source code directory
```
unzip secrets.zip -d rails-on-docker-secrets
cd rails-on-docker-secrets
cp master.key  <rel-path-source-code-dir>/config/master.key
cp production.key <rel-path-source-code-dir>/config/credenntials/production.key
cp env.development <rel-path-source-code-dir>/build/.env.development
cp env.production <rel-path-source-code-dir>/build/.env.production

cp localhost.crt <rel-path-source-code-dir>/nginx/data/cert/localhost.crt
cp localhost.key <rel-path-source-code-dir>/nginx/data/cert/localhost.key
```

## Build Application Image

- Move to build directory
```
cd build
```
- Build Application image
```
docker build -t itsnarayankundgir/rails-app:<version-no> .
```
NOTE
Change `<version-no>` with actual version number e.g. `1.0`

- Push Application image to public repository 
```
docker build -t itsnarayankundgir/rails-app:<version-no> .
```
NOTE
Dockerhub public repository is used to push application image , this is not idea approach in real time scenario. Usually organization maintain their own repositoery manager like nexus.
This code is pushed to public repo as its just sample application without any secret or confidential information.


## Deploy Application stack
Now, we will use Docker-compose files to build application stack using docker stack orchestrator.

- Initialize Swarm cluster
```
docker swarm init
```
- Run Stack deploy to run all services
```
docker stack deploy -c <(docker-compose config) rails_app
```

NOTE
docker-compose.yml file is parsed using docker-compose config option to succesffuly pass .env file variables into each services.
Reason is, In recent version docker stopped supporting env files parameters. Can pass as individiual parmeter in compose but it will lead into secret leakage in source code repo.

- Check all services are up and running, Destroy and re-deploy in case of any error - Refer 

Reference output
```
$ docker stack deploy -c <(docker-compose config) rails_app
Creating network rails_app_back-tier
Creating network rails_app_front-tier
Creating service rails_app_db
Creating service rails_app_db-migrate
Creating service rails_app_web
Creating service rails_app_app
$ docker service ls
ID             NAME                   MODE         REPLICAS   IMAGE                             PORTS
hzo3vadvsibs   rails_app_app          replicated   2/2        itsnarayankundgir/rails-app:1.0   
ot0mp92yv1hs   rails_app_db           replicated   1/1        postgres:13                       *:5434->5432/tcp
juemt8j47oxv   rails_app_db-migrate   replicated   1/1        itsnarayankundgir/rails-app:1.0   
l7wqm2kmxda9   rails_app_web          replicated   1/1        nginx:latest                      *:8443->443/tcp

```

Thats it. You have successfully deployed application stack using single command.

- Access deployed application from browser
```
https://localhost:8443/companies
https://localhost:8443/users
```

Browser will show error that site is not secure, Update settings in browser to allow https to localhost:8443 url. 


## Remove Application stack

- Remove stack and  volumes created by web, app and db services.
```
docker stack rm rails_app
docker volume rm rails_app_app-logs rails_app_db-data rails_app_web-logs
```

## Problems faced during migration

- When changing from development to production environment.
 Secret key base is required to pass. Generated secret key base value by running container.
 ```
 bin/rails c
 Rails.application.credentials.config
 ```

- DB migration fails after postgresql version upgrade from 9.6 to 13
 Update in `add_sql_fuction.sql`  - changed uid type unknown to varchar(255)
 ```Error- PG::FeatureNotSupported: ERROR: PL/pgSQL functions cannot accept type unknown```

 - Docker swarm doesnt support env file as file parameter. Need to declare Environment variables in compose for each service.
 solution used is , `docker-compose config`   which will complie file during execution and pass environnment variables on the fly.


## References I read

- For docker Image creation
https://docs.docker.com/samples/rails/

- For runing rail service using docker
https://qiita.com/d0ne1s/items/f724a08119bad2973e46
https://betterprogramming.pub/setting-up-rails-with-postgres-using-docker-426c853e8590

- To reduce image size from 1.5 GB to 183MB
 https://medium.com/@lemuelbarango/ruby-on-rails-smaller-docker-images-bff240931332

- For docker compose and stack
https://docs.docker.com/engine/swarm/stack-deploy/
https://docs.docker.com/compose/

- Docker-compose replicas with nginx reverse proxy
https://forums.docker.com/t/docker-compose-replicas-with-nginx-reverse-proxy/118695

- For SSL Certificate
https://www.humankode.com/ssl/create-a-selfsigned-certificate-for-nginx-in-5-minutes
https://faun.pub/setting-up-ssl-certificates-for-nginx-in-docker-environ-e7eec5ebb418


## Future scope of automation
 - Create Jenkins pipelie file to build,test and deploy application end to end.
 - Secrets to be passed as jenkins credentials which will be secure. 
 - Migrating same infra to either kubernetes or cloud provider solution like Amazon ECS, GKE etc.