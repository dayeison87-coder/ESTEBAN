1.Los comandos Docker usados.

    *docker --version
    *docker-compose --version
    *docker images
    *docker-compose up -d
    *mysql -u root -p
    *docker stop mysql_db
    *docker start mysql_db
    *docker rm mysql_db
    *docker rmi mysql:8.0

2.Descripción de cada paso.

    Paso 1: Crear el archivo docker-compose.yml

    Se crea este archivo para decirle a Docker qué imagen usar (MySQL), el nombre del contenedor, usuario, contraseña y el puerto.
    Así se configura todo automáticamente.

    Paso 2: Levantar el contenedor

    En la terminal se ejecuta:

    docker-compose up -d


    Esto descarga MySQL (si no está) y crea el contenedor con la base de datos lista para usar.

    Paso 3: Verificar que esté funcionando

    Se usa el comando:

    docker ps


    Este muestra si el contenedor de MySQL está corriendo correctamente.

    Paso 4: Entrar al contenedor

    Para entrar a la base de datos se usa:

    docker exec -it mysql_db bash
    mysql -u root -p


    Aquí ya se puede trabajar con MySQL dentro del contenedor.

    Paso 5: Probar la base de datos

    Dentro de MySQL se pueden crear bases y tablas, por ejemplo:

    CREATE DATABASE empresa;
    USE empresa;
    CREATE TABLE empleados (id INT AUTO_INCREMENT PRIMARY KEY, nombre VARCHAR(100));

    Paso 6: Detener el contenedor

    Cuando se termine de usar, se detiene con:

    docker-compose down


    Si se quieren borrar los datos también:

    docker-compose down -v

3.Observaciones o conclusiones finales.

    Docker facilita crear bases de datos sin necesidad de instalarlas directamente en el computador.

    Los contenedores son rápidos de crear, usar y eliminar.

    Los volúmenes permiten guardar los datos aunque el contenedor se borre.

    Es una forma práctica y profesional de trabajar con bases de datos en proyectos de desarrollo.

    Con pocos comandos se puede tener un entorno listo para practicar o trabajar en equipo.
