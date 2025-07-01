# Descargar la última imagen de Cassandra desde Docker Hub
sudo docker pull cassandra:latest

# Ejecutar un contenedor de Cassandra en segundo plano con reinicio automático
# El contenedor se llamará 'cass_cluster' y se ejecutará de forma desatendida (-d)
# La opción --restart=always garantiza que el contenedor se reinicie automáticamente si se detiene
sudo docker run --restart=always --name cass_cluster -d cassandra:latest

# Mostrar todos los contenedores (en ejecución y detenidos) para verificar que el contenedor de Cassandra está activo
sudo docker ps -a

# Ingresar al contenedor 'cass_cluster' y abrir la shell de CQL (cqlsh) para interactuar con Cassandra
sudo docker exec -it cass_cluster cqlsh