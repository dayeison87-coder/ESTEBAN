# Arquitectura del Sistema de Gestión Universitaria

## Visión General

El Sistema de Gestión Universitaria está diseñado siguiendo una arquitectura de microservicios con múltiples bases de datos especializadas. Esta arquitectura permite una separación clara de responsabilidades y optimiza el rendimiento para diferentes tipos de datos.

## Componentes Principales

### 1. Capa de Aplicación (Node.js)

**Ubicación**: `app.js` y archivos en `services/`

**Responsabilidades**:
- Lógica de negocio principal
- Coordinación entre diferentes bases de datos
- Gestión de transacciones complejas
- Implementación de reglas de negocio

**Tecnologías**:
- Node.js con módulos nativos
- Conexión a múltiples bases de datos simultáneamente

### 2. Capa de Datos

#### PostgreSQL - Base de Datos Relacional
**Propósito**: Almacenamiento de datos estructurados y transaccionales

**Entidades principales**:
- Departamentos
- Profesores
- Estudiantes
- Cursos
- Matrículas
- Calificaciones
- Pagos
- Horarios y Aulas

**Características**:
- Integridad referencial
- Transacciones ACID
- Consultas complejas y joins
- Índices optimizados para rendimiento

#### MongoDB - Base de Datos NoSQL
**Propósito**: Almacenamiento de contenido multimedia y documentos

**Colecciones principales**:
- Recursos educativos (PDF, videos, presentaciones)
- Foros y discusiones
- Artículos académicos
- Material complementario

**Características**:
- Almacenamiento de documentos JSON flexibles
- Búsqueda de texto completo
- Almacenamiento de archivos grandes
- Escalabilidad horizontal

#### Redis - Base de Datos en Memoria
**Propósito**: Caché y sesiones de alta velocidad

**Usos principales**:
- Sesiones de usuario
- Bloqueos de cursos (courseLocks.js)
- Caché de consultas frecuentes
- Contadores y estadísticas en tiempo real

**Características**:
- Acceso extremadamente rápido
- Estructuras de datos avanzadas
- Persistencia opcional
- Expiración automática de datos

### 3. Capa de Infraestructura

#### Docker Compose
**Configuración**: `docker-compose.yml`

**Servicios**:
- PostgreSQL 15 con inicialización automática
- MongoDB 6 con configuración básica
- Redis 7 Alpine con persistencia

**Características**:
- Aislamiento de entornos
- Configuración reproducible
- Volúmenes persistentes
- Health checks automáticos

## Flujo de Datos

### Operaciones Típicas

1. **Matrícula de Estudiante**:
   - Validación en PostgreSQL
   - Actualización de contadores en Redis
   - Registro de auditoría en servicios

2. **Publicación de Recurso Educativo**:
   - Metadatos en PostgreSQL
   - Contenido en MongoDB
   - Caché de búsquedas en Redis

3. **Consulta de Calificaciones**:
   - Datos principales desde PostgreSQL
   - Caché de resultados frecuentes en Redis

## Seguridad y Auditoría

### Sistema de Auditoría
**Ubicación**: `services/auditoria.js`

**Funcionalidades**:
- Registro de todas las operaciones críticas
- Seguimiento de cambios en entidades sensibles
- Auditoría de acceso a datos

### Consideraciones de Seguridad
- Conexiones seguras a bases de datos
- Validación de entrada de datos
- Control de acceso basado en roles
- Encriptación de datos sensibles

## Escalabilidad

### Estrategias de Escalabilidad

1. **PostgreSQL**:
   - Particionamiento horizontal
   - Réplicas de lectura
   - Índices optimizados

2. **MongoDB**:
   - Sharding automático
   - Réplicas para alta disponibilidad
   - Compresión de datos

3. **Redis**:
   - Clustering para distribución
   - Persistencia configurable
   - Políticas de expiración

## Monitoreo y Mantenimiento

### Puntos de Monitoreo
- Estado de contenedores Docker
- Conexiones activas a bases de datos
- Rendimiento de consultas
- Uso de recursos del sistema

### Estrategias de Backup
- Volúmenes Docker persistentes
- Snapshots automáticos
- Estrategias de recuperación ante desastres

## Consideraciones de Desarrollo

### Convenciones de Código
- Uso de módulos ES6
- Nombres descriptivos en español
- Comentarios en código complejo
- Manejo adecuado de errores

### Pruebas
- Scripts de prueba para Redis (`testRedis.js`, `verRedis.js`)
- Validación de conexiones a bases de datos
- Pruebas de integridad de datos

Esta arquitectura proporciona una base sólida y escalable para un sistema de gestión universitaria moderno, aprovechando las fortalezas de cada tecnología de base de datos para optimizar el rendimiento y la funcionalidad.
