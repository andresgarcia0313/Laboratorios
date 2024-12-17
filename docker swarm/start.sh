# Inicializar docker swarm
# docker swarm init
# docker swarm join --token <TOKEN> <MANAGER_IP>:2377
# docker node ls

docker stack deploy -c compose.yml nginx-stack

docker service ls # Listar servicios

docker service ps nginx-stack_nginx # Listar tareas del servicio

docker stack rm nginx-stack # Eliminar stack
