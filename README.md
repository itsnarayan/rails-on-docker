# Production deployment
This document explains procedure to setup this app in local machine as a production enviroment


**Pre-requisie**
1. Docker 4.0.1



**How to Setup**
1. Run docker in Swarm moode 
 	$ docker swarm init

2. Setup Docker Registry **
 	$ docker service create --name registry --publish published=5000,target=5000 registry:2

3. Build rail app Image
	$ docker build -f Dockerfile -t 127.0.0.1:5000/crud-app .

3. Push Image to local repository server
	$ docker push 127.0.0.1:5000/crud-app

4. Deploy Stack 
	$ docker stack deploy --compose-file docker-compose-prod.yaml crud-app
	
