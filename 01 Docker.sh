#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y docker.io
sudo apt install -y docker-compose-v2
sudo apt install -y apt-transport-https 
sudo apt install -y curl 
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl restart docker
sudo docker run --name contenedor hello-world
sudo docker rm -f contenedor
sudo docker rmi hello-world
