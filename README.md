# Production deployment
This document explains procedure to setup this rails application in local machine as a production enviroment


**Pre-requisie**
1. Docker 4.0.1

**Build Application Image**

1.  Go to build directory
   $ cd build

2. Build Application Image
   $ docker build -t itsnarayankundgir/rails-app .

   $ docker push itsnarayankundgir/rails-app


**Deploy Application Stack**
1. Run docker in Swarm moode 
   $ docker swarm init

2. Run Deploy Stack deploy to run all services
   $ docker stack deploy -c <(docker-compose config) rails_app

**Remove Application Stack**

1. Remove all stack components
   $ docker stack rm rails_app

   $ docker volume rm rails_app_app-logs rails_app_db-data rails_app_web-logs

   $ docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)