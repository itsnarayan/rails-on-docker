# Production deployment
This document explains procedure to setup this app in local machine as a production enviroment


**Pre-requisie**
1. Docker 4.0.1

**Build Stage**

 Build Application Image
   $ docker build -t itsnarayankundgir/rails-app .

   $ docker push itsnarayankundgir/rails-app


**Deploy Stage**
1. Run docker in Swarm moode 
   $ docker swarm init

2. Deploy Stack 
   $ docker stack deploy -c <(docker-compose config) rails-app

   
