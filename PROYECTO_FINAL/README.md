# Sistema de Gestión Universitaria

## Descripción del Proyecto

Este proyecto implementa un sistema completo de gestión universitaria que utiliza múltiples bases de datos para manejar diferentes aspectos del sistema educativo. El sistema está diseñado para gestionar estudiantes, profesores, cursos, matrículas, calificaciones y otros elementos esenciales de una institución educativa.

## Arquitectura del Sistema

### Tecnologías Utilizadas

- **Backend**: Node.js
- **Bases de Datos**:
  - PostgreSQL: Base de datos relacional para datos transaccionales
  - MongoDB: Base de datos NoSQL para contenido multimedia y documentos
  - Redis: Base de datos en memoria para sesiones y caché
- **Contenedorización**: Docker y Docker Compose

### Estructura del Proyecto

```
PROYECTO_FINAL/
├── app.js                 # Archivo principal de la aplicación
├── package.json           # Dependencias del proyecto
├── docker-compose.yml     # Configuración de contenedores
├── db/                    # Conexiones a bases de datos
│   ├── postgres.js
│   └── mongo.js
├── sql/                   # Scripts SQL para PostgreSQL
├── mongodb/               # Scripts y configuración MongoDB
├── redis/                 # Scripts y configuración Redis
├── services/              # Servicios de negocio
├── consultas/             # Consultas y resultados
└── documentacion/         # Documentación detallada
```

## Instalación y Configuración

### Prerrequisitos

- Docker y Docker Compose instalados
- Node.js (versión 16 o superior)
- Git

### Instalación

1. **Clonar el repositorio**
   ```bash
   git clone <url-del-repositorio>
   cd PROYECTO_FINAL
   ```

2. **Instalar dependencias**
   ```bash
   npm install
   ```

3. **Iniciar los servicios de base de datos**
   ```bash
   docker-compose up -d
   ```

4. **Verificar que los servicios estén corriendo**
   ```bash
   docker-compose ps
   ```

## Uso del Sistema

### Conexión a Bases de Datos

El sistema se conecta automáticamente a las bases de datos configuradas en `docker-compose.yml`:

- **PostgreSQL**: `localhost:5432`
- **MongoDB**: `localhost:27017`
- **Redis**: `localhost:6379`

### Ejecución de Scripts

Para ejecutar el archivo principal:
```bash
node app.js
```

Para probar Redis:
```bash
node testRedis.js
node verRedis.js
```

## Funcionalidades Principales

### Gestión de Estudiantes
- Registro de estudiantes
- Actualización de información
- Gestión de matrículas

### Gestión de Cursos
- Creación y configuración de cursos
- Asignación de profesores
- Gestión de horarios y aulas

### Sistema de Calificaciones
- Registro de calificaciones parciales
- Cálculo automático de calificación final
- Seguimiento de asistencia

### Auditoría
- Registro de cambios en el sistema
- Seguimiento de operaciones críticas

## Documentación Detallada

Para información más detallada, consulte los archivos en la carpeta `documentacion/`:

- [Arquitectura del Sistema](documentacion/arquitectura.md)
- [Esquemas de Base de Datos](documentacion/esquemas_db.md)
- [Guía de Instalación](documentacion/instalacion.md)
- [Manual de Uso](documentacion/uso.md)
- [API Reference](documentacion/api.md)

## Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia ISC.

## Contacto

Para preguntas o soporte, por favor contacta al equipo de desarrollo.
