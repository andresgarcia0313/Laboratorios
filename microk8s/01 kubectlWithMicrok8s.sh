#!/bin/bash

# Validar que el script se ejecute correctamente

# Definir rutas de los archivos kubeconfig
MICROK8S_KUBECONFIG="/var/snap/microk8s/current/credentials/client.config"
KUBE_CONFIG_DIR="$HOME/.kube"
KUBE_CONFIG_FILE="$KUBE_CONFIG_DIR/config"

# Crear el directorio .kube si no existe
echo "Creando el directorio .kube si no existe..."
mkdir -p $KUBE_CONFIG_DIR

# Copiar el kubeconfig de MicroK8s al archivo de configuración de kubectl
echo "Configurando kubectl para usar MicroK8s..."
if [ -f "$MICROK8S_KUBECONFIG" ]; then
    sudo cp $MICROK8S_KUBECONFIG $KUBE_CONFIG_FILE
    echo "Configuración de kubectl actualizada para MicroK8s."
else
    echo "No se encontró el archivo kubeconfig de MicroK8s. Verifique la instalación de MicroK8s."
    exit 1
fi

# Verificar que kubectl esté apuntando al clúster de MicroK8s
echo "Verificando la configuración de kubectl..."
kubectl get nodes

if [ $? -eq 0 ]; then
    echo "kubectl ahora está configurado para usar MicroK8s."
else
    echo "Hubo un problema al intentar conectar a MicroK8s. Asegúrate de que MicroK8s esté funcionando."
    exit 1
fi

# Finalizar script
echo "¡Listo! Ahora puedes usar kubectl para controlar MicroK8s."
