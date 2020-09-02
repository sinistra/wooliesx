# Wooliesx
wooliesx deployment assessment

This repo is `Infrastructure As Code` to deploy a Docker container as a devops assessment.  
It can be found @ https://github.com/sinistra/wooliesx  

## Deployed at
The deployed application is available @ http://nms.com.au:8001

Functioning URLs are:  
* http://nms.com.au:8001/health  
* http://nms.com.au:8001/weatherforecast  

The port 8001 was used because 8000 is already in use on the VM this is deployed to.  

## Host computer
The host machine is a VM on Linode running Ubuntu 19.04 and Docker version 19.03.1  

## Deployment mechanism
Deployment is executed by running `./deploy.sh <APIKEY>`  
(The <APIKEY> is NOT used in this deployment, but is there to demonstrate the preferred way of deploying a secret).  
Ansible is used to connect to the VM, authenticating via ssh keys.
The ansible script copies a docker-compose.yml file and a hidden .env into the target directory.  
The script executes `docker-compose down` to shutdown a potential running container.  
The script executes `docker-compose up -d` to start the container.  

## Comments, notes, observations
* The Docker repository for `dfranciswoolies/ciarecruitment-bestapiever` suggests using the command `docker pull dfranciswoolies/ciarecruitment-bestapiever` to pull the container.  
* There is no `default` or `latest` tag on this image, so the command above fails.
* There is a tagged container `dfranciswoolies/ciarecruitment-bestapiever:247904`. This image was used in this assessment.  
* I would prefer to use DockerSwarm to host the container as this provides better security than Docker, however, I don't have an available VM running DockerSwarm, so I will explain the difference.
* DockerSwarm supports secrets, so the secret could be loaded into the container environment at runtime.
* Docker does not support secrets, so the secret is stored in a hidden .env file and loaded into the container by docker-compose.
* The .env file is not in the code repo. It only exists on the deployment machine and the deployed VM.
* The risk with Docker is that the secret is stored in clear text in the .env file. If a hacker breaks into the VM, they can see the secret.  
* For this risk to be realised, we would have much bigger problems than them being able to read the secret. To break in they must have secured ssh keys and the root password. If this occurred the VM is compromised.
* The api appears to have been written in C# using a multi-stage build.  

