# Descargar la �ltima imagen de Cassandra desde Docker Hub
sudo docker pull cassandra:latest

# Ejecutar un contenedor de Cassandra en segundo plano con reinicio autom�tico
# El contenedor se llamar� 'cass_cluster' y se ejecutar� de forma desatendida (-d)
# La opci�n --restart=always garantiza que el contenedor se reinicie autom�ticamente si se detiene
sudo docker run --restart=always --name cass_cluster -d cassandra:latest

# Mostrar todos los contenedores (en ejecuci�n y detenidos) para verificar que el contenedor de Cassandra est� activo
sudo docker ps -a

# Ingresar al contenedor 'cass_cluster' y abrir la shell de CQL (cqlsh) para interactuar con Cassandra
sudo docker exec -it cass_cluster cqlsh