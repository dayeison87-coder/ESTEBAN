-- =========================================================
-- BASE DE DATOS: biblioteca_db
-- Motor: PostgreSQL
-- Script: DDL (Definición de estructura)
-- =========================================================

-- Crear la base de datos
CREATE DATABASE biblioteca_db;

-- Conectarse a la base
\c biblioteca_db;

-- ===============================
-- TABLA: Usuario
-- ===============================
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- ===============================
-- TABLA: Categoria
-- ===============================
CREATE TABLE Categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

-- ===============================
-- TABLA: Libro
-- ===============================
CREATE TABLE Libro (
    id_libro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    año_publicacion INT,
    id_categoria INT REFERENCES Categoria(id_categoria)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ===============================
-- TABLA: Autor
-- ===============================
CREATE TABLE Autor (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- ===============================
-- TABLA: LibroAutor (relación N:M)
-- ===============================
CREATE TABLE LibroAutor (
    id_libro INT REFERENCES Libro(id_libro)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    id_autor INT REFERENCES Autor(id_autor)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY (id_libro, id_autor)
);

-- ===============================
-- TABLA: Prestamo
-- ===============================
CREATE TABLE Prestamo (
    id_prestamo SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    id_libro INT REFERENCES Libro(id_libro)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    estado VARCHAR(20) DEFAULT 'Activo'
);

-- ===============================
-- TABLA: Reserva
-- ===============================
CREATE TABLE Reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    id_libro INT REFERENCES Libro(id_libro)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    fecha_reserva DATE NOT NULL DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'Pendiente'
);
