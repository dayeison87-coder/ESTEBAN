Autores: Yeison David Moreno Nieto
Fecha: 30/10/2025  

# Vídeo 1  
Enlace: [https://youtu.be/4Dko5W96WHg?si=SpMGU5aJJ1JrDwd_](https://youtu.be/4Dko5W96WHg?si=SpMGU5aJJ1JrDwd_)  

# Resumen de lo aprendido

Docker es una herramienta que permite crear contenedores para ejecutar aplicaciones sin problemas de compatibilidad.

Una imagen es como una plantilla que contiene todo lo necesario para que la aplicación funcione.

Un contenedor es la imagen funcionando.

El Dockerfile sirve para construir imágenes personalizadas paso a paso.

Comandos básicos: docker build, docker run, docker ps, docker images.

Ventajas: fácil de usar, rápido, portátil y seguro.

Retos: guardar datos (persistencia) y mantener la seguridad.

# Reflexión

Lo bueno: Docker hace que sea fácil trabajar en cualquier computador sin errores de instalación.

Lo difícil: manejar la seguridad y los datos guardados fuera del contenedor.

Uso: muy útil para estudiantes y desarrolladores que quieren practicar o probar proyectos.

# Mini proyecto

Dockerfile

FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]


server.js

const express = require('express');
const app = express();
app.get('/', (req, res) => {
  res.send('Hola desde Docker!');
});
app.listen(3000, () => console.log('Servidor en puerto 3000'));


# Comandos:

docker build -t miapp .
docker run -d -p 3000:3000 miapp


 Este proyecto crea una app sencilla que muestra un mensaje en el navegador desde un contenedor Docker.

 Video 2

 https://youtu.be/CV_Uf3Dq-EU?si=OzZ795q_ViUU1nl9

# Lo aprendido con Docker Compose

Permite usar varios contenedores al mismo tiempo (por ejemplo: app, base de datos y caché).

Usa un solo archivo docker-compose.yml para iniciar todo junto.

Ayuda a conectar servicios entre sí.

Se pueden guardar datos con volúmenes.

# Reflexión

Ventajas: muy útil para proyectos completos.

Dificultad: puede ser más complejo manejar redes y datos.

Uso: excelente para practicar entornos reales de desarrollo.

⚙️ Ejemplo simple de Docker Compose
version: "3.9"
services:
  web:
    build: ./web
    ports:
      - "8080:8080"
    depends_on:
      - db

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: 1234
      POSTGRES_DB: ejemplo


📌 Este ejemplo levanta una app web y una base de datos conectadas entre sí.

✅ Conclusión

Docker ayuda a crear entornos rápidos y listos para usar.
Docker Compose permite manejar varios servicios fácilmente.
Ambas herramientas facilitan el trabajo de desarrollo y son muy útiles para aprender y practicar programación moderna.