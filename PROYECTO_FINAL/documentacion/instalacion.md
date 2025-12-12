# Guía de Instalación

## Prerrequisitos del Sistema

Antes de instalar el Sistema de Gestión Universitaria, asegúrate de que tu sistema cumpla con los siguientes requisitos:

### Requisitos Mínimos
- **Sistema Operativo**: Windows 10/11, macOS 10.15+, Ubuntu 18.04+
- **Procesador**: 2 núcleos o más
- **Memoria RAM**: 4 GB mínimo, 8 GB recomendado
- **Espacio en Disco**: 5 GB libres
- **Conexión a Internet**: Para descargar imágenes Docker

### Software Requerido
- **Docker**: Versión 20.10 o superior
- **Docker Compose**: Versión 2.0 o superior
- **Node.js**: Versión 16 o superior (opcional para desarrollo)
- **Git**: Para clonar el repositorio

## Instalación Paso a Paso

### Paso 1: Instalar Docker y Docker Compose

#### Windows
1. Descarga Docker Desktop desde https://www.docker.com/products/docker-desktop
2. Ejecuta el instalador y sigue las instrucciones
3. Reinicia tu sistema si es necesario
4. Verifica la instalación:
   ```bash
   docker --version
   docker-compose --version
   ```

#### macOS
1. Descarga Docker Desktop desde https://www.docker.com/products/docker-desktop
2. Arrastra Docker.app a la carpeta Applications
3. Ejecuta Docker Desktop
4. Verifica la instalación en terminal:
   ```bash
   docker --version
   docker-compose --version
   ```

#### Linux (Ubuntu/Debian)
```bash
# Actualizar el sistema
sudo apt update && sudo apt upgrade -y

# Instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Agregar usuario al grupo docker
sudo usermod -aG docker $USER

# Instalar Docker Compose
sudo apt install docker-compose-plugin

# Reiniciar sesión o ejecutar:
newgrp docker

# Verificar instalación
docker --version
docker compose version
```

### Paso 2: Instalar Node.js (Opcional)

Si deseas desarrollar o modificar el código:

#### Windows
1. Descarga el instalador desde https://nodejs.org/
2. Ejecuta el instalador y sigue las instrucciones
3. Verifica:
   ```cmd
   node --version
   npm --version
   ```

#### Usando NVM (Linux/macOS)
```bash
# Instalar NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reiniciar terminal o ejecutar:
source ~/.bashrc

# Instalar Node.js
nvm install 18
nvm use 18

# Verificar
node --version
npm --version
```

### Paso 3: Clonar el Repositorio

```bash
# Clonar el repositorio
git clone <URL_DEL_REPOSITORIO>
cd PROYECTO_FINAL

# Si no tienes Git, descarga el ZIP desde GitHub
# y extrae el contenido en una carpeta llamada PROYECTO_FINAL
```

### Paso 4: Instalar Dependencias del Proyecto

```bash
# Instalar dependencias de Node.js
npm install
```

### Paso 5: Configurar Variables de Entorno (Opcional)

Si necesitas personalizar la configuración, crea un archivo `.env`:

```bash
# Copiar archivo de ejemplo
cp .env.example .env

# Editar según tus necesidades
nano .env
```

Contenido típico del archivo `.env`:
```env
# PostgreSQL
POSTGRES_USER=admin_universidad
POSTGRES_PASSWORD=admin123
POSTGRES_DB=universidad_db

# MongoDB
MONGO_URI=mongodb://localhost:27017

# Redis
REDIS_URL=redis://localhost:6379

# Aplicación
NODE_ENV=development
PORT=3000
```

### Paso 6: Iniciar los Servicios

```bash
# Iniciar todos los servicios en segundo plano
docker-compose up -d

# Verificar que los contenedores estén corriendo
docker-compose ps
```

Deberías ver algo como:
```
     Name                    Command               State                    Ports
------------------------------------------------------------------------------------------------
universidad_mongodb    docker-entrypoint.sh mongod      Up      0.0.0.0:27017->27017/tcp
universidad_postgres   docker-entrypoint.sh postgres    Up      0.0.0.0:5432->5432/tcp
universidad_redis      redis-server --appendonly yes    Up      0.0.0.0:6379->6379/tcp
```

### Paso 7: Verificar la Instalación

#### Verificar PostgreSQL
```bash
# Conectar a PostgreSQL
docker exec -it universidad_postgres psql -U admin_universidad -d universidad_db

# Dentro de PostgreSQL, verificar tablas
\d

# Salir
\q
```

#### Verificar MongoDB
```bash
# Conectar a MongoDB
docker exec -it universidad_mongodb mongosh universidad_nosql

# Verificar conexión
db.stats()

# Salir
exit
```

#### Verificar Redis
```bash
# Ejecutar script de prueba
node testRedis.js

# Verificar datos
node verRedis.js
```

### Paso 8: Ejecutar la Aplicación

```bash
# Ejecutar el archivo principal
node app.js
```

## Solución de Problemas Comunes

### Error: "docker-compose: command not found"
```bash
# En sistemas Linux modernos
sudo apt install docker-compose-plugin

# O instalar la versión standalone
sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### Error: "Permission denied" en Docker
```bash
# Agregar usuario al grupo docker
sudo usermod -aG docker $USER

# Reiniciar sesión o ejecutar:
newgrp docker
```

### Error: Puerto ya en uso
```bash
# Verificar qué proceso usa el puerto
sudo lsof -i :5432

# Cambiar puertos en docker-compose.yml si es necesario
ports:
  - "5433:5432"  # Cambiar host port
```

### Error: No se puede conectar a la base de datos
```bash
# Verificar logs de contenedores
docker-compose logs postgres
docker-compose logs mongodb
docker-compose logs redis

# Reiniciar servicios
docker-compose restart
```

### Error: "npm install" falla
```bash
# Limpiar caché de npm
npm cache clean --force

# Reinstalar dependencias
rm -rf node_modules package-lock.json
npm install
```

## Configuración Avanzada

### Personalizar Docker Compose

Edita `docker-compose.yml` para ajustar recursos:

```yaml
services:
  postgres:
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M
```

### Configuración de PostgreSQL

Para personalizar PostgreSQL, modifica las variables de entorno en `docker-compose.yml`:

```yaml
environment:
  POSTGRES_USER: tu_usuario
  POSTGRES_PASSWORD: tu_contraseña_segura
  POSTGRES_DB: tu_base_datos
  PGDATA: /var/lib/postgresql/data/pgdata
```

### Backup y Restauración

#### Backup de PostgreSQL
```bash
# Crear backup
docker exec universidad_postgres pg_dump -U admin_universidad universidad_db > backup.sql

# Restaurar backup
docker exec -i universidad_postgres psql -U admin_universidad universidad_db < backup.sql
```

#### Backup de MongoDB
```bash
# Crear backup
docker exec universidad_mongodb mongodump --db universidad_nosql --out /backup

# Copiar backup localmente
docker cp universidad_mongodb:/backup ./mongodb_backup
```

#### Backup de Redis
```bash
# Redis tiene persistencia automática configurada
# Los datos se guardan en el volumen redis_data
```

## Verificación Final

Una vez completada la instalación, ejecuta los siguientes comandos para verificar que todo funciona correctamente:

```bash
# Verificar servicios
docker-compose ps

# Ejecutar aplicación de prueba
node app.js

# Verificar logs
docker-compose logs -f
```

Si todos los pasos se completaron exitosamente, el sistema estará listo para usar.

## Siguientes Pasos

Después de la instalación, consulta:
- [Manual de Uso](uso.md) para aprender a operar el sistema
- [Documentación de API](api.md) para integraciones
- [Arquitectura del Sistema](arquitectura.md) para entender el diseño
