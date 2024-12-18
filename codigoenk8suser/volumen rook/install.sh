# instalar
kubectl create -f https://github.com/rook/rook/releases/download/v1.16.0/rook-ceph-cluster.yaml
# verificar los pods de Rook
kubectl get pods -n rook-ceph