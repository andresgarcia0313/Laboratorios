#!/bin/bash

# Configuración de variables
DEPLOYMENT_FILE="nginx-deployment.yaml"
SERVICE_FILE="nginx-service.yaml"
NETWORK_POLICY_FILE="network-policy.yaml"
SERVICE_NAME="nginx-service"
POD_LABEL="app=nginx"
PORT_FORWARD="30100:80"

# Función para aplicar los archivos de configuración
apply_config() {
    echo "Aplicando los archivos de configuración..."
    kubectl apply -f "$DEPLOYMENT_FILE"
    kubectl apply -f "$SERVICE_FILE"
    kubectl apply -f "$NETWORK_POLICY_FILE"
    echo "Archivos de configuración aplicados exitosamente."
}

# Función para eliminar los recursos
delete_config() {
    echo "Eliminando los recursos..."
    kubectl delete -f "$DEPLOYMENT_FILE"
    kubectl delete -f "$SERVICE_FILE"
    kubectl delete -f "$NETWORK_POLICY_FILE"
    echo "Recursos eliminados exitosamente."
}

# Función para eliminar pods por etiqueta
delete_pods_by_label() {
    echo "Eliminando pods con etiqueta $POD_LABEL..."
    kubectl delete pods -l "$POD_LABEL"
    echo "Pods eliminados."
}

# Función para obtener información sobre los pods
get_pods_info() {
    echo "Obteniendo información de los pods..."
    kubectl get pods -l "deployment=nginx-deployment"
}

# Función para listar los deployments
get_deployments() {
    echo "Obteniendo los deployments..."
    kubectl get deployments
}

# Función para listar los pods
get_pods() {
    echo "Obteniendo la lista de pods..."
    kubectl get pods
}

# Función para ver los servicios expuestos
get_services() {
    echo "Obteniendo servicios expuestos..."
    kubectl get svc
}

# Función para obtener información detallada de un servicio
get_service_details() {
    echo "Obteniendo información detallada del servicio $SERVICE_NAME..."
    kubectl get svc "$SERVICE_NAME"
}

# Función para ver los endpoints
get_endpoints() {
    echo "Obteniendo los endpoints..."
    kubectl get endpoints
}

# Función para ver los logs de un pod específico
get_pod_logs() {
    echo "Obteniendo logs del pod $1..."
    kubectl logs "$1"
}

# Función para abrir el servicio en el navegador (Minikube)
open_service_minikube() {
    echo "Abriendo el servicio $SERVICE_NAME con Minikube..."
    minikube service "$SERVICE_NAME"
}

# Función para hacer el port-forwarding del servicio
port_forward_service() {
    echo "Realizando port-forwarding del servicio $SERVICE_NAME..."
    kubectl port-forward svc/"$SERVICE_NAME" "$PORT_FORWARD" &
}

# Menú interactivo
show_menu() {
    echo "Seleccione una opción:"
    echo "1. Aplicar configuración"
    echo "2. Eliminar configuración"
    echo "3. Eliminar pods por etiqueta"
    echo "4. Obtener información de los pods"
    echo "5. Obtener deployments"
    echo "6. Obtener pods"
    echo "7. Ver servicios expuestos"
    echo "8. Ver detalles de servicio $SERVICE_NAME"
    echo "9. Ver endpoints"
    echo "10. Ver logs de un pod"
    echo "11. Abrir servicio con Minikube"
    echo "12. Realizar port-forwarding"
    echo "13. Salir"
}

# Función principal para manejar la interacción con el usuario
main() {
    while true; do
        
        show_menu
        read -p "Elija una opción: " option
        case $option in
            1)
                apply_config
                ;;
            2)
                delete_config
                ;;
            3)
                delete_pods_by_label
                ;;
            4)
                get_pods_info
                ;;
            5)
                get_deployments
                ;;
            6)
                get_pods
                ;;
            7)
                get_services
                ;;
            8)
                get_service_details
                ;;
            9)
                get_endpoints
                ;;
            10)
                read -p "Ingrese el nombre del pod: " pod_name
                get_pod_logs "$pod_name"
                ;;
            11)
                open_service_minikube
                ;;
            12)
                port_forward_service
                ;;
            13)
                echo "Saliendo..."
                exit 0
                ;;
            *)
                echo "Opción no válida. Por favor, intente de nuevo."
                ;;
        esac
    done
}

# Ejecutar el menú interactivo
main
