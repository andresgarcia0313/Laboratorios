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


minikube start --addons=metrics-server --addons=dashboard


# Verificar el estado de Minikube
minikube status

# Verificar el estado de los nodos
kubectl get nodes

minikube dashboard & # Dashboard de Minikube

kubectl cluster-info

minikube stop


# Ver metricas
kubectl top pod
kubectl top node

# metrics-server o dashboard se ejecuta?
kubectl get pods -n kube-system
kubectl logs <nombre-del-pod> -n kube-system


# Minikube para un entorno complete de k8s de un solo nodo
# ¿Qué hace este script?

# 1 Inicia Minikube con recursos adicionales y habilita complementos clave:

# metrics-server: Requerido para autoscalado y métricas.
# dashboard: Proporciona una interfaz gráfica.
# storage-provisioner: Gestiona el almacenamiento dinámico.
# coredns: Resuelve nombres de dominio.
# ingress: Gestiona tráfico HTTP/S.

# 2 Instala componentes adicionales:

# Calico: Proporciona redes avanzadas y políticas de red.
# Prometheus y Grafana: Monitoreo del clúster y visualización de métricas.
# EFK (Elasticsearch, Fluentd, Kibana): Gestión y visualización de logs.
# Cert-Manager: Emisión automática de certificados TLS.
# Configura almacenamiento persistente con volúmenes locales.

# Implementa autoscalado básico usando el HPA.


# Iniciar Minikube con recursos amplios
echo "Iniciando Minikube con configuración avanzada..."

minikube start --cpus=4 --memory=4096 --addons=metrics-server --addons=dashboard --addons=storage-provisioner --addons=coredns --addons=ingress

# Mirar los complementos instalados y sus estados
minikube addons list

# Esperar a que el clúster esté listo
echo "Esperando a que Minikube esté completamente inicializado..."
minikube status

# Configurar red avanzada con Calico
echo "Instalando Calico para redes avanzadas..."
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Instalar Prometheus y Grafana para monitoreo
echo "Instalando Prometheus y Grafana..."
echo "Activando Helm..."
if ! command -v helm &> /dev/null
then
    echo "Helm no está instalado. Instalando Helm..."
    sudo snap install helm --classic
else
    echo "Helm ya está instalado."
fi
kubectl create namespace monitoring --dry-run=client
kubectl get namespace monitoring || kubectl create namespace monitoring

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring -f grafana-values.yaml

kubectl get svc -n monitoring # ver el estado de los servicios
kubectl get pods -n monitoring # ver si estan listos los pods

# Prometheus y Grafana pueden tardar unos minutos en estar listos admin admin
kubectl get pods -n monitoring
# Exponer prometheus
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090 &
# http://localhost:9090
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80 &
# http://localhost:3000 admin admin

# Instalar Cert-Manager para la gestión de certificados
echo "Instalando Cert-Manager..."
kubectl apply -f https://github.com/jetstack/cert-manager/releases/latest/download/cert-manager.yaml

# Configurar EFK (Elasticsearch, Fluentd, Kibana) para logs
echo "Instalando Elasticsearch, Fluentd y Kibana..."
kubectl create namespace logging
helm repo add elastic https://helm.elastic.co
helm install elasticsearch elastic/elasticsearch --namespace logging
helm install kibana elastic/kibana --namespace logging
# Fluentd puede requerir un manifiesto personalizado. Aquí hay uno básico:
cat <<EOF | kubectl apply -n logging -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd
spec:
  selector:
    matchLabels:
      app: fluentd
  template:
    metadata:
      labels:
        app: fluentd
    spec:
      containers:
      - name: fluentd
        image: fluent/fluentd:latest
        env:
        - name: FLUENT_ELASTICSEARCH_HOST
          value: "elasticsearch"
EOF

# Crear almacenamiento persistente
echo "Creando almacenamiento persistente..."
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-local
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-local
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
EOF

# Configurar el Horizontal Pod Autoscaler (HPA)
echo "Configurando el Horizontal Pod Autoscaler..."
kubectl autoscale deployment kubernetes-dashboard -n kube-system --cpu-percent=50 --min=1 --max=3

# Verificar el estado del clúster
echo "Verificando el estado del clúster..."
kubectl get all --all-namespaces

# Mostrar cómo acceder al Dashboard
echo "Abriendo el Dashboard de Kubernetes..."
minikube dashboard &

echo "Minikube configurado como un entorno completo de Kubernetes en un solo nodo."
