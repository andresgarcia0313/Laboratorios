# Laboratorios de Kubernetes

Este repositorio contiene varios scripts y configuraciones para trabajar con diferentes herramientas de Kubernetes. A continuación se detalla la estructura del repositorio y una breve descripción de cada archivo.

## Estructura del repositorio

```
.
├── docker
│   └── 01 Docker.sh
├── docker swarm
│   ├── compose.yml
│   └── start.sh
├── k8s
│   ├── 000 Instalación Kubernetes.sh
│   ├── 01 PreInstallKubernetes.sh
│   ├── 01 installKubernetes.sh
│   ├── 02 ResetCluster.sh
│   └── 02.1 uninstall Kubelet Kubeadm kubectl.sh
├── k8s code
│   ├── network-policy.yaml
│   ├── nginx-deployment.yaml
│   └── nginx-service.yaml
├── microk8s
│   ├── 00 installMicrok8s.sh
│   └── 01 kubectlWithMicrok8s.sh
├── minikube
│   ├── 00 installMiniKube.sh
│   ├── 00.1 uninstallMiniKube.sh
│   └── configKubectlMicrok8sToMinikube.sh
└── ssh
    ├── 01 SSH.sh
    └── 01.1 setSSHKey.sh
```

## Descripción de archivos

### Docker
- `01 Docker.sh`: Script para la instalación y configuración de Docker.

### Docker Swarm
- `compose.yml`: Archivo de configuración para Docker Compose.
- `start.sh`: Script para iniciar un clúster de Docker Swarm.

### Kubernetes (k8s)
- `000 Instalación Kubernetes.sh`: Script para la instalación de Kubernetes.
- `01 PreInstallKubernetes.sh`: Script de pre-instalación para Kubernetes.
- `01 installKubernetes.sh`: Script para la instalación de Kubernetes.
- `02 ResetCluster.sh`: Script para resetear el clúster de Kubernetes.
- `02.1 uninstall Kubelet Kubeadm kubectl.sh`: Script para desinstalar Kubelet, Kubeadm y kubectl.

### Kubernetes Code (k8s code)
- `network-policy.yaml`: Archivo YAML para la política de red en Kubernetes.
- `nginx-deployment.yaml`: Archivo YAML para el despliegue de Nginx en Kubernetes.
- `nginx-service.yaml`: Archivo YAML para el servicio de Nginx en Kubernetes.

### MicroK8s
- `00 installMicrok8s.sh`: Script para la instalación de MicroK8s.
- `01 kubectlWithMicrok8s.sh`: Script para configurar kubectl con MicroK8s.

### Minikube
- `00 installMiniKube.sh`: Script para la instalación de Minikube.
- `00.1 uninstallMiniKube.sh`: Script para desinstalar Minikube.
- `configKubectlMicrok8sToMinikube.sh`: Script para configurar kubectl de MicroK8s a Minikube.

### SSH
- `01 SSH.sh`: Script para configurar SSH.
- `01.1 setSSHKey.sh`: Script para configurar la clave SSH.

## Contribuciones

Si deseas contribuir a este repositorio, por favor realiza un fork y envía un pull request con tus cambios.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.