#!/bin/bash

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo apt update && sudo apt upgrade -y

# Instalar MicroK8s con Snap
echo "Instalando MicroK8s..."
sudo snap install microk8s --classic

# Esperar a que MicroK8s se inicie correctamente
echo "Esperando que MicroK8s esté listo..."
microk8s status --wait-ready

# Habilitar los servicios deseados
echo "Habilitando servicios..."
microk8s enable dashboard
microk8s enable dns
microk8s enable registry
microk8s enable istio

# Mostrar los servicios habilitados
echo "MicroK8s habilitado con los siguientes servicios:"
microk8s enable --help

# Alias para kubectl
echo "Creando alias para kubectl..."
alias mkctl="microk8s kubectl --kubeconfig"

# Comando para obtener el estado de todos los pods en todos los namespaces
echo "Obteniendo el estado de los pods en todos los namespaces..."
microk8s kubectl get all --all-namespaces

# Probar acceso al panel de control de Kubernetes
echo "Accediendo al panel de control de Kubernetes..."
microk8s dashboard-proxy

# Opción de iniciar o detener Kubernetes para ahorrar batería
echo "Iniciando Kubernetes..."
microk8s start

# En caso de que se quiera detener Kubernetes
# echo "Deteniendo Kubernetes para ahorrar batería..."
# microk8s stop

# Mensaje final
echo "MicroK8s ha sido instalado y configurado correctamente. ¡Listo para usar!"

# Información adicional y comunidad
echo "Para más información, consulta la documentación oficial de MicroK8s."

# Nuestra primera aplicación en Kubernetes para validar la instalación

kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10 # Crear un deployment que es un pod

# Exponer el deployment como un servicio para acceder a él
kubectl expose deployment hello-minikube --type=NodePort --port=8080 service/hello-minikube exposed

minikube service hello-minikube --url # Obtener la URL
minikube service hello-minikube # Abrir en el navegador de forma automática

kubectl get deployments # deployment
kubectl get pods # pod que son instancias de un deployment
kubectl get svc # service que expone un deployment para acceder a él