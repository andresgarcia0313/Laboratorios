#!/bin/bash
# Instalar Docker
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Desactivar memoria virtual o de intercambio
sudo swapoff -a
sudo sed -i 's/^.*swap.*$/#&/' /etc/fstab

# Actualizar el sistema
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl

# Descargar e instalar kubeadm, kubelet y kubectl
sudo apt-get update
sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo sh -c 'echo deb https://apt.kubernetes.io/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list'
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


# Inicializar el nodo maestro
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
#sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# Configurar kubectl para el usuario no root
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Implementar una red de pods (Flannel)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


# Instalar un plugin de red (por ejemplo, Calico):
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Unir nodos trabajadores
# kubeadm join <ip_master>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>

# Verificar el estado del nodo
kubectl get nodes

# Configurar mi master para que también sea un worker
kubectl taint nodes --all node-role.kubernetes.io/master-

echo "Instalación de Kubernetes completada."

