#!/bin/bash

# Actualizar el sistema
sudo apt-get update -y
sudo apt-get upgrade -y

# Instalar dependencias necesarias
sudo apt-get install -y curl apt-transport-https # virtualbox virtualbox-ext-pack

# Instalar Docker
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Agregar el usuario al grupo de Docker para evitar el uso con privilegios de root
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# Descargar Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Dar permisos y mover Minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Instalar Kubectl
sudo snap install kubectl --classic
# kubectl version --client
# kubectl config use-context minikube


# Verificar la instalación de Minikube
minikube version

# Iniciar Minikube
minikube start
# minikube start --driver=docker
# minikube start --driver=virtualbox

# Verificar el estado de Minikube
minikube status

# Verificar el estado de los nodos
kubectl get nodes

minikube dashboard & # Dashboard de Minikube

minikube config view # Ver la configuración de Minikube (Valdiar instrucción)
