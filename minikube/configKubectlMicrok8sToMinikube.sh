#!/bin/bash
# Validar que el script se ejecute correctamente
# Definir ruta del archivo kubeconfig de Minikube
MINIKUBE_KUBECONFIG=$(minikube kubeconfig)

# Directorio y archivo de configuración de kubectl
KUBE_CONFIG_DIR="$HOME/.kube"
KUBE_CONFIG_FILE="$KUBE_CONFIG_DIR/config"

# Crear el directorio .kube si no existe
echo "Creando el directorio .kube si no existe..."
mkdir -p $KUBE_CONFIG_DIR

# Verificar si Minikube está corriendo
echo "Verificando si Minikube está en ejecución..."
if ! minikube status &>/dev/null; then
    echo "Minikube no está en ejecución. Inicie Minikube primero."
    exit 1
fi

# Configurar kubectl para usar Minikube
echo "Configurando kubectl para usar Minikube..."
if [ -f "$MINIKUBE_KUBECONFIG" ]; then
    cp $MINIKUBE_KUBECONFIG $KUBE_CONFIG_FILE
    echo "Configuración de kubectl actualizada para Minikube."
else
    echo "No se pudo encontrar el archivo kubeconfig de Minikube. Asegúrate de que Minikube esté en ejecución."
    exit 1
fi

# Verificar que kubectl esté apuntando al clúster de Minikube
echo "Verificando la configuración de kubectl..."
kubectl get nodes

if [ $? -eq 0 ]; then
    echo "kubectl ahora está configurado para usar Minikube."
else
    echo "Hubo un problema al intentar conectar a Minikube. Asegúrate de que Minikube esté funcionando."
    exit 1
fi

# Finalizar script
echo "¡Listo! Ahora puedes usar kubectl para controlar Minikube."
