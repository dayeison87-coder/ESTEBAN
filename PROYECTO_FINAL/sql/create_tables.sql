-- ============================================
-- SISTEMA DE GESTIÓN UNIVERSITARIA
-- Tablas PostgreSQL - Base de datos transaccional
-- ============================================

-- Tabla de departamentos
CREATE TABLE departamentos (
    id_departamento SERIAL PRIMARY KEY,
    codigo_departamento VARCHAR(10) UNIQUE NOT NULL,
    nombre_departamento VARCHAR(100) NOT NULL,
    decano VARCHAR(50),
    edificio VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de profesores
CREATE TABLE profesores (
    id_profesor SERIAL PRIMARY KEY,
    codigo_profesor VARCHAR(15) UNIQUE NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    especialidad VARCHAR(100),
    id_departamento INTEGER REFERENCES departamentos(id_departamento),
    fecha_contratacion DATE DEFAULT CURRENT_DATE,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de estudiantes
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

-- Tabla de cursos
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

-- Tabla de aulas
CREATE TABLE aulas (
    id_aula SERIAL PRIMARY KEY,
    codigo_aula VARCHAR(20) UNIQUE NOT NULL,
    edificio VARCHAR(50),
    capacidad INTEGER,
    tipo VARCHAR(50) DEFAULT 'SALA',
    recursos TEXT[] DEFAULT '{}'
);

-- Tabla de horarios
CREATE TABLE horarios (
    id_horario SERIAL PRIMARY KEY,
    id_curso INTEGER REFERENCES cursos(id_curso),
    id_aula INTEGER REFERENCES aulas(id_aula),
    dia_semana VARCHAR(10) CHECK (dia_semana IN ('LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES', 'SÁBADO')),
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    UNIQUE(id_aula, dia_semana, hora_inicio)
);

-- Tabla de matrículas
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

-- Tabla de calificaciones
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

-- Tabla de pagos
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

-- Índices para mejorar rendimiento
CREATE INDEX idx_matriculas_estudiante ON matriculas(id_estudiante);
CREATE INDEX idx_matriculas_curso ON matriculas(id_curso);
CREATE INDEX idx_calificaciones_matricula ON calificaciones(id_matricula);
CREATE INDEX idx_cursos_departamento ON cursos(id_departamento);
CREATE INDEX idx_cursos_profesor ON cursos(id_profesor);
