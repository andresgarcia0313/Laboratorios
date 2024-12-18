kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
kubectl apply -f network-policy.yaml

# curl http://192.168.49.2:30006

# Permitir redireccionamiento en red local a mi cluster de minikube
# sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 30006