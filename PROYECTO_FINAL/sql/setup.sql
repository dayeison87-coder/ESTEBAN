-- 1. Conectar a la base de datos y crear tablas básicas
CREATE TABLE IF NOT EXISTS estudiantes (
    id_estudiante SERIAL PRIMARY KEY,
    codigo_estudiante VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    fecha_inscripcion DATE DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS profesores (
    id_profesor SERIAL PRIMARY KEY,
    codigo_profesor VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    especialidad VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS cursos (
    id_curso SERIAL PRIMARY KEY,
    codigo_curso VARCHAR(20) UNIQUE NOT NULL,
    nombre_curso VARCHAR(150) NOT NULL,
    creditos INTEGER DEFAULT 4
);

CREATE TABLE IF NOT EXISTS matriculas (
    id_matricula SERIAL PRIMARY KEY,
    id_estudiante INTEGER REFERENCES estudiantes(id_estudiante),
    id_curso INTEGER REFERENCES cursos(id_curso),
    semestre VARCHAR(10) DEFAULT '2025-1',
    estado VARCHAR(20) DEFAULT 'ACTIVA',
    fecha_matricula DATE DEFAULT CURRENT_DATE
);
