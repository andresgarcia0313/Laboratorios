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

# Descargar Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Dar permisos y mover Minikube
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube

# Verificar la instalación de Minikube
minikube version

# Iniciar Minikube
minikube start
#minikube start --driver=docker
#minikube start --driver=virtualbox


# Verificar el estado de Minikube
minikube status

# Verificar el estado de los nodos
kubectl get nodes


minikube dashboard & # Dashboard de Minikube


minikube config view # Ver la configuración de Minikube
