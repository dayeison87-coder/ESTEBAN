# Documentación de la API

## Visión General

La API del Sistema de Gestión Universitaria proporciona endpoints REST para interactuar con las diferentes bases de datos del sistema. Actualmente, la API está implementada como funciones de Node.js que pueden ser llamadas desde la aplicación principal.

## Arquitectura de la API

### Conexiones a Bases de Datos

```javascript
// Conexión PostgreSQL
const pool = require("./db/postgres");

// Conexión MongoDB
const connectMongo = require("./db/mongo");

// Conexión Redis
const redis = require("redis");
const redisClient = redis.createClient();
```

## Endpoints de Gestión de Matrículas

### Actualizar Estado de Matrícula

**Función**: `actualizarEstadoMatricula(idMatricula, nuevoEstado)`

**Descripción**: Actualiza el estado de una matrícula y registra el cambio en el sistema de auditoría.

**Parámetros**:
- `idMatricula` (integer): ID de la matrícula a actualizar
- `nuevoEstado` (string): Nuevo estado ('ACTIVA', 'RETIRADA', 'CANCELADA', 'COMPLETADA')

**Ejemplo de uso**:
```javascript
const { actualizarEstadoMatricula } = require('./app');

async function ejemplo() {
  try {
    await actualizarEstadoMatricula(12345, 'RETIRADA');
    console.log('Estado de matrícula actualizado exitosamente');
  } catch (error) {
    console.error('Error al actualizar matrícula:', error);
  }
}
```

**Respuesta exitosa**:
```
Estado de matrícula actualizado exitosamente
Registro de auditoría creado
```

**Posibles errores**:
- Matrícula no encontrada
- Estado inválido
- Error de conexión a base de datos

## Endpoints de PostgreSQL

### Consultas Básicas

#### Obtener Todos los Estudiantes

```javascript
async function getEstudiantes() {
  try {
    const result = await pool.query('SELECT * FROM estudiantes WHERE activo = TRUE');
    return result.rows;
  } catch (error) {
    console.error('Error al obtener estudiantes:', error);
    throw error;
  }
}
```

#### Obtener Cursos por Departamento

```javascript
async function getCursosByDepartamento(idDepartamento) {
  try {
    const query = `
      SELECT c.*, p.nombre, p.apellido
      FROM cursos c
      JOIN profesores p ON c.id_profesor = p.id_profesor
      WHERE c.id_departamento = $1 AND c.activo = TRUE
    `;
    const result = await pool.query(query, [idDepartamento]);
    return result.rows;
  } catch (error) {
    console.error('Error al obtener cursos:', error);
    throw error;
  }
}
```

#### Insertar Nueva Matrícula

```javascript
async function crearMatricula(idEstudiante, idCurso, semestre, año) {
  try {
    const query = `
      INSERT INTO matriculas (id_estudiante, id_curso, semestre, año)
      VALUES ($1, $2, $3, $4)
      RETURNING *
    `;
    const result = await pool.query(query, [idEstudiante, idCurso, semestre, año]);
    return result.rows[0];
  } catch (error) {
    console.error('Error al crear matrícula:', error);
    throw error;
  }
}
```

### Consultas Avanzadas

#### Reporte de Calificaciones por Curso

```javascript
async function getReporteCalificaciones(idCurso) {
  try {
    const query = `
      SELECT
        e.nombre,
        e.apellido,
        c.parcial1,
        c.parcial2,
        c.final,
        c.proyecto,
        c.asistencia,
        c.calificacion_final
      FROM calificaciones c
      JOIN matriculas m ON c.id_matricula = m.id_matricula
      JOIN estudiantes e ON m.id_estudiante = e.id_estudiante
      WHERE m.id_curso = $1 AND m.estado = 'COMPLETADA'
      ORDER BY c.calificacion_final DESC
    `;
    const result = await pool.query(query, [idCurso]);
    return result.rows;
  } catch (error) {
    console.error('Error al obtener reporte:', error);
    throw error;
  }
}
```

#### Estadísticas de Departamento

```javascript
async function getEstadisticasDepartamento(idDepartamento) {
  try {
    const query = `
      SELECT
        d.nombre_departamento,
        COUNT(DISTINCT c.id_curso) as cursos_activos,
        COUNT(DISTINCT p.id_profesor) as profesores_activos,
        COUNT(DISTINCT m.id_estudiante) as estudiantes_matriculados,
        AVG(cal.calificacion_final) as promedio_general
      FROM departamentos d
      LEFT JOIN cursos c ON d.id_departamento = c.id_departamento AND c.activo = TRUE
      LEFT JOIN profesores p ON d.id_departamento = p.id_departamento AND p.activo = TRUE
      LEFT JOIN matriculas m ON c.id_curso = m.id_curso AND m.estado = 'ACTIVA'
      LEFT JOIN calificaciones cal ON m.id_matricula = cal.id_matricula
      WHERE d.id_departamento = $1
      GROUP BY d.id_departamento, d.nombre_departamento
    `;
    const result = await pool.query(query, [idDepartamento]);
    return result.rows[0];
  } catch (error) {
    console.error('Error al obtener estadísticas:', error);
    throw error;
  }
}
```

## Endpoints de MongoDB

### Gestión de Recursos Educativos

#### Conectar a MongoDB

```javascript
const { MongoClient } = require('mongodb');

class RecursosAPI {
  constructor() {
    this.client = new MongoClient('mongodb://localhost:27017');
    this.db = null;
  }

  async connect() {
    await this.client.connect();
    this.db = this.client.db('universidad_nosql');
  }
}
```

#### Crear Recurso Educativo

```javascript
async function crearRecurso(recursoData) {
  try {
    const db = await connectMongo();
    const result = await db.collection('recursos').insertOne({
      titulo: recursoData.titulo,
      tipo: recursoData.tipo,
      curso: recursoData.curso,
      autor: recursoData.autor,
      fecha_publicacion: new Date(),
      etiquetas: recursoData.etiquetas || [],
      contenido: recursoData.contenido,
      visibilidad: recursoData.visibilidad || 'publico',
      descargas: 0,
      valoracion: 0
    });
    return result.insertedId;
  } catch (error) {
    console.error('Error al crear recurso:', error);
    throw error;
  }
}
```

#### Buscar Recursos

```javascript
async function buscarRecursos(filtros) {
  try {
    const db = await connectMongo();
    const query = {};

    if (filtros.curso) query.curso = filtros.curso;
    if (filtros.tipo) query.tipo = filtros.tipo;
    if (filtros.visibilidad) query.visibilidad = filtros.visibilidad;
    if (filtros.etiquetas) {
      query.etiquetas = { $in: filtros.etiquetas };
    }

    const recursos = await db.collection('recursos')
      .find(query)
      .sort({ fecha_publicacion: -1 })
      .limit(filtros.limit || 20)
      .toArray();

    return recursos;
  } catch (error) {
    console.error('Error al buscar recursos:', error);
    throw error;
  }
}
```

#### Actualizar Descargas

```javascript
async function incrementarDescargas(idRecurso) {
  try {
    const db = await connectMongo();
    const result = await db.collection('recursos').updateOne(
      { _id: new ObjectId(idRecurso) },
      { $inc: { descargas: 1 } }
    );
    return result.modifiedCount > 0;
  } catch (error) {
    console.error('Error al actualizar descargas:', error);
    throw error;
  }
}
```

### Gestión de Discusiones

#### Crear Discusión

```javascript
async function crearDiscusion(discusionData) {
  try {
    const db = await connectMongo();
    const result = await db.collection('discusiones').insertOne({
      titulo: discusionData.titulo,
      contenido: discusionData.contenido,
      autor: {
        id: discusionData.autorId,
        nombre: discusionData.autorNombre,
        rol: discusionData.autorRol
      },
      curso: discusionData.curso,
      fecha: new Date(),
      comentarios: [],
      estado: 'activo'
    });
    return result.insertedId;
  } catch (error) {
    console.error('Error al crear discusión:', error);
    throw error;
  }
}
```

#### Agregar Comentario

```javascript
async function agregarComentario(idDiscusion, comentarioData) {
  try {
    const db = await connectMongo();
    const comentario = {
      autor: {
        id: comentarioData.autorId,
        nombre: comentarioData.autorNombre,
        rol: comentarioData.autorRol
      },
      contenido: comentarioData.contenido,
      fecha: new Date(),
      respuestas: []
    };

    const result = await db.collection('discusiones').updateOne(
      { _id: new ObjectId(idDiscusion) },
      { $push: { comentarios: comentario } }
    );

    return result.modifiedCount > 0;
  } catch (error) {
    console.error('Error al agregar comentario:', error);
    throw error;
  }
}
```

## Endpoints de Redis

### Gestión de Sesiones

#### Crear Sesión

```javascript
const redis = require('redis');

class SessionManager {
  constructor() {
    this.client = redis.createClient();
    this.client.connect();
  }

  async createSession(userId, userData) {
    try {
      const sessionKey = `session:${userId}`;
      const sessionData = {
        userId: userId,
        ...userData,
        loginTime: new Date(),
        lastActivity: new Date()
      };

      await this.client.setEx(sessionKey, 3600, JSON.stringify(sessionData));
      return sessionKey;
    } catch (error) {
      console.error('Error al crear sesión:', error);
      throw error;
    }
  }

  async getSession(userId) {
    try {
      const sessionKey = `session:${userId}`;
      const sessionData = await this.client.get(sessionKey);

      if (sessionData) {
        const session = JSON.parse(sessionData);
        // Actualizar última actividad
        session.lastActivity = new Date();
        await this.client.setEx(sessionKey, 3600, JSON.stringify(session));
        return session;
      }

      return null;
    } catch (error) {
      console.error('Error al obtener sesión:', error);
      throw error;
    }
  }

  async destroySession(userId) {
    try {
      const sessionKey = `session:${userId}`;
      await this.client.del(sessionKey);
      return true;
    } catch (error) {
      console.error('Error al destruir sesión:', error);
      throw error;
    }
  }
}
```

### Sistema de Bloqueos

#### Gestionar Bloqueos de Cursos

```javascript
class LockManager {
  constructor() {
    this.client = redis.createClient();
    this.client.connect();
  }

  async acquireLock(resourceId, userId, ttl = 300) {
    try {
      const lockKey = `lock:course:${resourceId}`;
      const acquired = await this.client.set(lockKey, userId, {
        NX: true,  // Solo si no existe
        EX: ttl    // Tiempo de expiración
      });

      return acquired === 'OK';
    } catch (error) {
      console.error('Error al adquirir bloqueo:', error);
      throw error;
    }
  }

  async releaseLock(resourceId, userId) {
    try {
      const lockKey = `lock:course:${resourceId}`;
      const currentOwner = await this.client.get(lockKey);

      if (currentOwner === userId) {
        await this.client.del(lockKey);
        return true;
      }

      return false;
    } catch (error) {
      console.error('Error al liberar bloqueo:', error);
      throw error;
    }
  }

  async getLockInfo(resourceId) {
    try {
      const lockKey = `lock:course:${resourceId}`;
      const owner = await this.client.get(lockKey);
      const ttl = await this.client.ttl(lockKey);

      return {
        locked: owner !== null,
        owner: owner,
        ttl: ttl
      };
    } catch (error) {
      console.error('Error al obtener información de bloqueo:', error);
      throw error;
    }
  }
}
```

### Sistema de Caché

#### Cache Manager

```javascript
class CacheManager {
  constructor() {
    this.client = redis.createClient();
    this.client.connect();
  }

  async get(key) {
    try {
      const data = await this.client.get(key);
      return data ? JSON.parse(data) : null;
    } catch (error) {
      console.error('Error al obtener del caché:', error);
      return null;
    }
  }

  async set(key, data, ttl = 1800) {
    try {
      await this.client.setEx(key, ttl, JSON.stringify(data));
      return true;
    } catch (error) {
      console.error('Error al guardar en caché:', error);
      return false;
    }
  }

  async delete(key) {
    try {
      await this.client.del(key);
      return true;
    } catch (error) {
      console.error('Error al eliminar del caché:', error);
      return false;
    }
  }

  async getCachedQuery(queryKey, queryFunction, ttl = 1800) {
    try {
      // Intentar obtener del caché
      let result = await this.get(`cache:query:${queryKey}`);

      if (!result) {
        // Ejecutar consulta y cachear resultado
        result = await queryFunction();
        await this.set(`cache:query:${queryKey}`, result, ttl);
      }

      return result;
    } catch (error) {
      console.error('Error en consulta cacheada:', error);
      // En caso de error, ejecutar consulta sin caché
      return await queryFunction();
    }
  }
}
```

## Servicio de Auditoría

### Registrar Cambios

**Ubicación**: `services/auditoria.js`

```javascript
const pool = require("../db/postgres");

async function registrarCambio(tabla, idRegistro, tipoOperacion, cambios, usuario) {
  try {
    // Obtener datos actuales para comparación
    let datosAnteriores = null;
    if (tipoOperacion !== 'INSERT') {
      const result = await pool.query(`SELECT * FROM ${tabla} WHERE id_${tabla.slice(0, -1)} = $1`, [idRegistro]);
      if (result.rows.length > 0) {
        datosAnteriores = result.rows[0];
      }
    }

    // Insertar registro de auditoría
    await pool.query(`
      INSERT INTO auditoria (tabla_afectada, id_registro, tipo_operacion, datos_anteriores, datos_nuevos, usuario, fecha_operacion)
      VALUES ($1, $2, $3, $4, $5, $6, CURRENT_TIMESTAMP)
    `, [
      tabla,
      idRegistro,
      tipoOperacion,
      datosAnteriores ? JSON.stringify(datosAnteriores) : null,
      cambios ? JSON.stringify(cambios) : null,
      usuario
    ]);

  } catch (error) {
    console.error('Error al registrar cambio en auditoría:', error);
    throw error;
  }
}

module.exports = registrarCambio;
```

**Nota**: Para usar el servicio de auditoría, necesitas crear la tabla `auditoria`:

```sql
CREATE TABLE auditoria (
  id_auditoria SERIAL PRIMARY KEY,
  tabla_afectada VARCHAR(50) NOT NULL,
  id_registro INTEGER NOT NULL,
  tipo_operacion VARCHAR(10) NOT NULL, -- INSERT, UPDATE, DELETE
  datos_anteriores JSONB,
  datos_nuevos JSONB,
  usuario VARCHAR(100) NOT NULL,
  fecha_operacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_auditoria_tabla ON auditoria(tabla_afectada);
CREATE INDEX idx_auditoria_fecha ON auditoria(fecha_operacion);
```

## Manejo de Errores

### Estructura de Errores

```javascript
class APIError extends Error {
  constructor(message, statusCode = 500, details = null) {
    super(message);
    this.name = 'APIError';
    this.statusCode = statusCode;
    this.details = details;
  }
}

// Función helper para manejar errores
function handleAPIError(error, operation) {
  console.error(`Error en ${operation}:`, error);

  if (error.code === '23505') { // Violación de unicidad
    throw new APIError('Registro duplicado', 409, error.detail);
  }

  if (error.code === '23503') { // Violación de clave foránea
    throw new APIError('Referencia no encontrada', 404, error.detail);
  }

  if (error.code === 'ECONNREFUSED') {
    throw new APIError('Error de conexión a base de datos', 503);
  }

  throw new APIError('Error interno del servidor', 500, error.message);
}
```

## Ejemplos de Integración

### Servicio Completo de Matrículas

```javascript
const pool = require('./db/postgres');
const registrarCambio = require('./services/auditoria');

class MatriculaService {
  async crearMatricula(matriculaData) {
    const client = await pool.connect();
    try {
      await client.query('BEGIN');

      // Verificar cupo disponible
      const cupoResult = await client.query(`
        SELECT c.cupo_maximo - COUNT(m.id_matricula) as cupo_disponible
        FROM cursos c
        LEFT JOIN matriculas m ON c.id_curso = m.id_curso AND m.estado = 'ACTIVA'
        WHERE c.id_curso = $1
        GROUP BY c.id_curso, c.cupo_maximo
      `, [matriculaData.idCurso]);

      if (cupoResult.rows[0].cupo_disponible <= 0) {
        throw new APIError('No hay cupo disponible en el curso', 409);
      }

      // Crear matrícula
      const result = await client.query(`
        INSERT INTO matriculas (id_estudiante, id_curso, semestre, año)
        VALUES ($1, $2, $3, $4)
        RETURNING *
      `, [matriculaData.idEstudiante, matriculaData.idCurso, matriculaData.semestre, matriculaData.año]);

      // Registrar en auditoría
      await registrarCambio('matriculas', result.rows[0].id_matricula, 'INSERT', null, matriculaData.usuario);

      await client.query('COMMIT');
      return result.rows[0];

    } catch (error) {
      await client.query('ROLLBACK');
      handleAPIError(error, 'crearMatricula');
    } finally {
      client.release();
    }
  }
}

module.exports = new MatriculaService();
```

Esta documentación proporciona una base completa para entender y extender la API del sistema. Cada endpoint incluye ejemplos de uso, manejo de errores y mejores prácticas de implementación.
