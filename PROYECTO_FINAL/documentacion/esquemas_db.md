# Esquemas de Base de Datos

## PostgreSQL - Base de Datos Relacional

### Tabla: departamentos

Almacena información de los departamentos académicos de la universidad.

```sql
CREATE TABLE departamentos (
    id_departamento SERIAL PRIMARY KEY,
    codigo_departamento VARCHAR(10) UNIQUE NOT NULL,
    nombre_departamento VARCHAR(100) NOT NULL,
    decano VARCHAR(100),
    edificio VARCHAR(50),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Campos:**
- `id_departamento`: Identificador único del departamento (autoincremental)
- `codigo_departamento`: Código único del departamento (ej: "INFO", "MATE")
- `nombre_departamento`: Nombre completo del departamento
- `decano`: Nombre del decano del departamento
- `edificio`: Edificio donde se ubica el departamento
- `fecha_creacion`: Fecha de creación del registro

### Tabla: profesores

Gestiona la información de los profesores de la universidad.

```sql
CREATE TABLE profesores (
    id_profesor SERIAL PRIMARY KEY,
    codigo_profesor VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    especialidad VARCHAR(100),
    id_departamento INTEGER REFERENCES departamentos(id_departamento),
    fecha_contratacion DATE DEFAULT CURRENT_DATE,
    activo BOOLEAN DEFAULT TRUE
);
```

**Campos:**
- `id_profesor`: Identificador único del profesor
- `codigo_profesor`: Código único del profesor
- `nombre`, `apellido`: Nombre completo del profesor
- `email`: Correo electrónico único
- `especialidad`: Área de especialización
- `id_departamento`: Referencia al departamento
- `fecha_contratacion`: Fecha de contratación
- `activo`: Estado del profesor (activo/inactivo)

### Tabla: estudiantes

Almacena datos de los estudiantes matriculados.

```sql
CREATE TABLE estudiantes (
    id_estudiante SERIAL PRIMARY KEY,
    codigo_estudiante VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    direccion TEXT,
    fecha_inscripcion DATE DEFAULT CURRENT_DATE,
    activo BOOLEAN DEFAULT TRUE
);
```

**Campos:**
- `id_estudiante`: Identificador único del estudiante
- `codigo_estudiante`: Código único del estudiante
- `nombre`, `apellido`: Nombre completo del estudiante
- `email`: Correo electrónico único
- `fecha_nacimiento`: Fecha de nacimiento
- `telefono`: Número de teléfono
- `direccion`: Dirección completa
- `fecha_inscripcion`: Fecha de primera inscripción
- `activo`: Estado del estudiante

### Tabla: cursos

Define los cursos ofrecidos por la universidad.

```sql
CREATE TABLE cursos (
    id_curso SERIAL PRIMARY KEY,
    codigo_curso VARCHAR(20) UNIQUE NOT NULL,
    nombre_curso VARCHAR(150) NOT NULL,
    descripcion TEXT,
    creditos INTEGER NOT NULL CHECK (creditos > 0),
    id_departamento INTEGER REFERENCES departamentos(id_departamento),
    id_profesor INTEGER REFERENCES profesores(id_profesor),
    cupo_maximo INTEGER DEFAULT 30,
    semestre VARCHAR(10),
    año INTEGER,
    activo BOOLEAN DEFAULT TRUE
);
```

**Campos:**
- `id_curso`: Identificador único del curso
- `codigo_curso`: Código único del curso
- `nombre_curso`: Nombre completo del curso
- `descripcion`: Descripción detallada del curso
- `creditos`: Número de créditos académicos
- `id_departamento`: Departamento que ofrece el curso
- `id_profesor`: Profesor asignado al curso
- `cupo_maximo`: Número máximo de estudiantes
- `semestre`: Período académico (ej: "2024-1")
- `año`: Año académico
- `activo`: Estado del curso

### Tabla: aulas

Gestiona la información de las aulas disponibles.

```sql
CREATE TABLE aulas (
    id_aula SERIAL PRIMARY KEY,
    codigo_aula VARCHAR(20) UNIQUE NOT NULL,
    edificio VARCHAR(50),
    capacidad INTEGER,
    tipo VARCHAR(50) DEFAULT 'SALA',
    recursos TEXT[] DEFAULT '{}'
);
```

**Campos:**
- `id_aula`: Identificador único del aula
- `codigo_aula`: Código único del aula
- `edificio`: Edificio donde se ubica el aula
- `capacidad`: Número máximo de personas
- `tipo`: Tipo de aula (SALA, LABORATORIO, AUDITORIO)
- `recursos`: Array de recursos disponibles (proyector, computadora, etc.)

### Tabla: horarios

Define los horarios de clases para cada curso.

```sql
CREATE TABLE horarios (
    id_horario SERIAL PRIMARY KEY,
    id_curso INTEGER REFERENCES cursos(id_curso),
    id_aula INTEGER REFERENCES aulas(id_aula),
    dia_semana VARCHAR(10) CHECK (dia_semana IN ('LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES', 'SÁBADO')),
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    UNIQUE(id_aula, dia_semana, hora_inicio)
);
```

**Campos:**
- `id_horario`: Identificador único del horario
- `id_curso`: Curso al que pertenece el horario
- `id_aula`: Aula asignada
- `dia_semana`: Día de la semana
- `hora_inicio`: Hora de inicio de la clase
- `hora_fin`: Hora de fin de la clase

**Restricciones:**
- Días válidos: LUNES, MARTES, MIÉRCOLES, JUEVES, VIERNES, SÁBADO
- Unicidad: No puede haber dos clases en la misma aula al mismo tiempo

### Tabla: matriculas

Registra la matrícula de estudiantes en cursos.

```sql
CREATE TABLE matriculas (
    id_matricula SERIAL PRIMARY KEY,
    id_estudiante INTEGER REFERENCES estudiantes(id_estudiante),
    id_curso INTEGER REFERENCES cursos(id_curso),
    semestre VARCHAR(10) NOT NULL,
    año INTEGER NOT NULL,
    fecha_matricula DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'ACTIVA' CHECK (estado IN ('ACTIVA', 'RETIRADA', 'CANCELADA', 'COMPLETADA')),
    UNIQUE(id_estudiante, id_curso, semestre, año)
);
```

**Campos:**
- `id_matricula`: Identificador único de la matrícula
- `id_estudiante`: Estudiante matriculado
- `id_curso`: Curso en el que se matricula
- `semestre`: Semestre de la matrícula
- `año`: Año de la matrícula
- `fecha_matricula`: Fecha de realización de la matrícula
- `estado`: Estado de la matrícula

**Estados válidos:**
- ACTIVA: Matrícula activa
- RETIRADA: Estudiante se retiró del curso
- CANCELADA: Matrícula cancelada por administración
- COMPLETADA: Curso finalizado

### Tabla: calificaciones

Almacena las calificaciones de los estudiantes.

```sql
CREATE TABLE calificaciones (
    id_calificacion SERIAL PRIMARY KEY,
    id_matricula INTEGER REFERENCES matriculas(id_matricula),
    parcial1 DECIMAL(4,2) CHECK (parcial1 >= 0 AND parcial1 <= 100),
    parcial2 DECIMAL(4,2) CHECK (parcial2 >= 0 AND parcial2 <= 100),
    final DECIMAL(4,2) CHECK (final >= 0 AND final <= 100),
    proyecto DECIMAL(4,2) CHECK (proyecto >= 0 AND proyecto <= 100),
    asistencia DECIMAL(5,2) DEFAULT 100.00,
    calificacion_final DECIMAL(4,2) GENERATED ALWAYS AS (
        COALESCE(parcial1, 0) * 0.25 +
        COALESCE(parcial2, 0) * 0.25 +
        COALESCE(final, 0) * 0.35 +
        COALESCE(proyecto, 0) * 0.10 +
        COALESCE(asistencia, 0) * 0.05
    ) STORED,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Campos:**
- `id_calificacion`: Identificador único de la calificación
- `id_matricula`: Referencia a la matrícula
- `parcial1`, `parcial2`: Calificaciones de parciales (25% cada uno)
- `final`: Examen final (35%)
- `proyecto`: Trabajo final (10%)
- `asistencia`: Porcentaje de asistencia (5%)
- `calificacion_final`: Calificación final calculada automáticamente
- `fecha_actualizacion`: Última actualización

**Fórmula de calificación final:**
```
Final = (Parcial1 × 0.25) + (Parcial2 × 0.25) + (Final × 0.35) + (Proyecto × 0.10) + (Asistencia × 0.05)
```

### Tabla: pagos

Registra los pagos realizados por los estudiantes.

```sql
CREATE TABLE pagos (
    id_pago SERIAL PRIMARY KEY,
    id_estudiante INTEGER REFERENCES estudiantes(id_estudiante),
    concepto VARCHAR(100) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATE DEFAULT CURRENT_DATE,
    metodo_pago VARCHAR(50),
    referencia VARCHAR(100),
    estado VARCHAR(20) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'PAGADO', 'CANCELADO'))
);
```

**Campos:**
- `id_pago`: Identificador único del pago
- `id_estudiante`: Estudiante que realiza el pago
- `concepto`: Descripción del pago
- `monto`: Monto del pago
- `fecha_pago`: Fecha del pago
- `metodo_pago`: Método de pago utilizado
- `referencia`: Referencia del pago
- `estado`: Estado del pago

## MongoDB - Base de Datos NoSQL

### Colección: recursos

Almacena recursos educativos multimedia.

```json
{
  "_id": ObjectId,
  "titulo": "String",
  "tipo": "pdf/video/presentacion",
  "curso": "CS101",
  "autor": "String",
  "fecha_publicacion": "Date",
  "etiquetas": ["programacion", "python"],
  "contenido": "String o referencia",
  "visibilidad": "publico/privado",
  "descargas": 0,
  "valoracion": 0
}
```

**Campos:**
- `_id`: Identificador único (ObjectId)
- `titulo`: Título del recurso
- `tipo`: Tipo de archivo (pdf, video, presentación)
- `curso`: Código del curso relacionado
- `autor`: Autor del recurso
- `fecha_publicacion`: Fecha de publicación
- `etiquetas`: Array de etiquetas para búsqueda
- `contenido`: Contenido o referencia al archivo
- `visibilidad`: Nivel de acceso
- `descargas`: Contador de descargas
- `valoracion`: Puntuación promedio

### Colección: discusiones

Gestiona foros y discusiones de cursos.

```json
{
  "_id": ObjectId,
  "titulo": "String",
  "contenido": "String",
  "autor": {
    "id": "String",
    "nombre": "String",
    "rol": "estudiante/profesor"
  },
  "curso": "CS101",
  "fecha": "Date",
  "comentarios": [
    {
      "autor": "Object",
      "contenido": "String",
      "fecha": "Date",
      "respuestas": []
    }
  ],
  "estado": "activo/cerrado"
}
```

**Campos:**
- `_id`: Identificador único
- `titulo`: Título de la discusión
- `contenido`: Contenido de la discusión
- `autor`: Objeto con información del autor
- `curso`: Curso relacionado
- `fecha`: Fecha de creación
- `comentarios`: Array de comentarios anidados
- `estado`: Estado de la discusión

### Colección: articulos

Almacena artículos académicos y publicaciones.

```json
{
  "_id": ObjectId,
  "titulo": "String",
  "autores": ["String"],
  "resumen": "String",
  "palabras_clave": ["String"],
  "fecha_publicacion": "Date",
  "estado": "publicado/revision",
  "archivos": ["String"],
  "citas": 0
}
```

**Campos:**
- `_id`: Identificador único
- `titulo`: Título del artículo
- `autores`: Array de autores
- `resumen`: Resumen del artículo
- `palabras_clave`: Palabras clave para búsqueda
- `fecha_publicacion`: Fecha de publicación
- `estado`: Estado de publicación
- `archivos`: Referencias a archivos
- `citas`: Número de citas

## Redis - Base de Datos en Memoria

### Estructuras de Datos Utilizadas

#### Sesiones de Usuario
```
Key: session:{userId}
Value: JSON string con datos de sesión
TTL: 3600 segundos (1 hora)
```

#### Bloqueos de Cursos
```
Key: lock:course:{courseId}
Value: userId que tiene el bloqueo
TTL: 300 segundos (5 minutos)
```

#### Caché de Consultas Frecuentes
```
Key: cache:query:{queryHash}
Value: JSON string con resultados
TTL: 1800 segundos (30 minutos)
```

#### Contadores
```
Key: counter:downloads:{resourceId}
Value: Integer con número de descargas
```

#### Estadísticas en Tiempo Real
```
Key: stats:active_users
Value: Set de userIds activos

Key: stats:course_enrollments:{courseId}
Value: Integer con número de matriculados
```

## Índices de Rendimiento

### PostgreSQL - Índices Optimizados

```sql
-- Índices para búsquedas frecuentes
CREATE INDEX idx_matriculas_estudiante ON matriculas(id_estudiante);
CREATE INDEX idx_matriculas_curso ON matriculas(id_curso);
CREATE INDEX idx_calificaciones_matricula ON calificaciones(id_matricula);
CREATE INDEX idx_cursos_departamento ON cursos(id_departamento);
CREATE INDEX idx_cursos_profesor ON cursos(id_profesor);

-- Índices para reportes
CREATE INDEX idx_matriculas_semestre ON matriculas(semestre, año);
CREATE INDEX idx_calificaciones_final ON calificaciones(calificacion_final);
CREATE INDEX idx_pagos_fecha ON pagos(fecha_pago);
```

### MongoDB - Índices de Búsqueda

```javascript
// Índices de texto para búsqueda
db.recursos.createIndex({ titulo: "text", etiquetas: "text" });
db.discusiones.createIndex({ titulo: "text", contenido: "text" });
db.articulos.createIndex({ titulo: "text", palabras_clave: "text", autores: "text" });

// Índices de fecha para ordenamiento
db.recursos.createIndex({ fecha_publicacion: -1 });
db.discusiones.createIndex({ fecha: -1 });

// Índices compuestos para consultas frecuentes
db.recursos.createIndex({ curso: 1, visibilidad: 1 });
db.discusiones.createIndex({ curso: 1, estado: 1 });
```

## Relaciones entre Entidades

### Diagrama de Relaciones

```
departamentos (1) ──── (N) profesores
    │                        │
    │                        │
    └───────────────── (N) cursos (N) ──── matriculas (N) ──── calificaciones
                             │                    │
                             │                    │
                           horarios             estudiantes
                             │                    │
                             │                    │
                            aulas               pagos

                            
```

### Reglas de Integridad

1. **Eliminación en Cascada**: Al eliminar un departamento, sus profesores y cursos relacionados deben reasignarse
2. **Restricción de Unicidad**: Un estudiante no puede matricularse dos veces en el mismo curso en el mismo semestre
3. **Validación de Estados**: Los estados de matrícula y pago tienen valores predefinidos
4. **Cálculo Automático**: La calificación final se calcula automáticamente basado en las componentes

### Triggers y Constraints

```sql
-- Trigger para validar cupo de curso antes de matrícula
CREATE OR REPLACE FUNCTION validar_cupo_curso()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM matriculas WHERE id_curso = NEW.id_curso AND estado = 'ACTIVA')
       >= (SELECT cupo_maximo FROM cursos WHERE id_curso = NEW.id_curso) THEN
        RAISE EXCEPTION 'Curso sin cupo disponible';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_cupo
    BEFORE INSERT ON matriculas
    FOR EACH ROW
    EXECUTE FUNCTION validar_cupo_curso();
```

Este esquema de base de datos proporciona una estructura robusta y escalable para gestionar todos los aspectos de un sistema universitario moderno.
