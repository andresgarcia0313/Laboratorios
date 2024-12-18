#!/bin/bash

# ================================
# Script de Kubernetes para nginx
# ================================
# Este script contiene las instrucciones para gestionar los recursos
# de un deployment, servicio y política de red en un clúster de Kubernetes.
# Las instrucciones están separadas y documentadas para facilitar su edición.

# 1. Aplicar los archivos de configuración
# Este comando aplica los archivos de configuración para el Deployment, el Servicio y la Política de Red.
# Asegúrate de tener los archivos .yaml en la misma carpeta que este script.
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
kubectl apply -f network-policy.yaml

#"k8suser"

# 2. Eliminar los recursos aplicados
# Si deseas eliminar los recursos aplicados previamente (Deployment, Servicio, y Política de Red),
# puedes usar los siguientes comandos:
# kubectl delete -f nginx-deployment.yaml
# kubectl delete -f nginx-service.yaml
# kubectl delete -f network-policy.yaml

# 3. Eliminar los pods por etiqueta
# Si deseas eliminar todos los pods con una etiqueta específica (por ejemplo, "app=nginx"),
# puedes usar este comando:
# kubectl delete pods -l app=nginx

# 4. Obtener información de los pods de un deployment
# Este comando obtiene información de los pods que forman parte de un deployment específico.
# kubectl get pods -l deployment=nginx-deployment

# 5. Ver todos los deployments en el clúster
# Para ver los deployments existentes en el clúster, puedes usar el siguiente comando:
# kubectl get deployments

# 6. Ver todos los pods en el clúster
# Para listar todos los pods activos en el clúster, usa este comando:
# kubectl get pods

# 7. Ver los servicios expuestos en el clúster
# Para ver todos los servicios expuestos en el clúster de Kubernetes, puedes usar:
# kubectl get svc

# 8. Ver detalles de un servicio específico por nombre
# Si deseas obtener más información sobre un servicio específico, como "nginx-service",
# usa este comando:
# kubectl get svc nginx-service

# 9. Ver los endpoints de los servicios
# Para ver los endpoints asociados con los servicios en el clúster, puedes ejecutar:
# kubectl get endpoints

# 10. Ver los logs de un pod específico
# Si deseas ver los logs de un pod en particular, reemplaza el nombre del pod en el siguiente comando:
# kubectl logs nginx-deployment-54b9c68f67-6v7w4

# 11. Abrir el servicio con Minikube
# Si estás utilizando Minikube y deseas acceder a tu servicio de nginx desde el navegador,
# usa este comando:
minikube service nginx-service

# Conectas a ssh de k8suser y lo ejecutas desde la mv de windows

# 12. Realizar port-forwarding del servicio
# Si deseas hacer un port-forwarding del servicio para acceder a él en un puerto local,
# puedes usar este comando. Aquí se mapea el puerto local 30100 al puerto 80 del servicio.
# kubectl port-forward svc/nginx-service 30100:80 &

# ================================
# Fin del script
# ================================
# Recuerda que los comandos anteriores están comentados. Para ejecutarlos,
# simplemente elimina el símbolo de comentario (#) al inicio de la línea correspondiente.
