#!/bin/bash

# Variables reutilizables
DOCKER_IMAGE="hello-world"
CONTAINER_NAME="contenedor"

# Función: Actualizar y actualizar sistema
update_system() {
    echo "Actualizando el sistema... 🔄"
    sudo apt update && sudo apt upgrade -y
}

# Función: Instalar dependencias
install_dependencies() {
    echo "Instalando dependencias necesarias... 📦"
    sudo apt install -y \
        docker.io \
        docker-compose-v2 \
        apt-transport-https \
        curl
}

# Función: Configurar Docker
configure_docker() {
    echo "Habilitando y configurando Docker... 🐳"
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo systemctl restart docker
}

# Función: Probar Docker
test_docker() {
    echo "Probando Docker con la imagen $DOCKER_IMAGE... 🧪"
    sudo docker run --name "$CONTAINER_NAME" "$DOCKER_IMAGE"
    echo "Eliminando contenedor de prueba... 🗑️"
    sudo docker rm -f "$CONTAINER_NAME"
    echo "Eliminando imagen $DOCKER_IMAGE... 🗑️"
    sudo docker rmi "$DOCKER_IMAGE"
}

# Función principal: Ejecutar todo el flujo
main() {
    echo "Inicio del proceso de instalación y configuración... 🚀"
    update_system
    install_dependencies
    configure_docker
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    test_docker
    echo "Proceso completado exitosamente. ✅"
}

# Ejecución de la función principal
main
