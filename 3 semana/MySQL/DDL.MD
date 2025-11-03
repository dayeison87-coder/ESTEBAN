-- =========================================================
-- CINEMA_DB - Script DDL (estructura de la base de datos)
-- Motor: MySQL / MariaDB
-- =========================================================

-- 1. Crear base de datos
CREATE DATABASE IF NOT EXISTS cinema_db;
USE cinema_db;

-- 2. Crear tablas

CREATE TABLE peliculas (
    id_pelicula INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    duracion INT,
    clasificacion VARCHAR(10),
    fecha_estreno DATE
) ENGINE=InnoDB;

CREATE TABLE salas (
    id_salas INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sala VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE funciones (
    id_funcion INT AUTO_INCREMENT PRIMARY KEY,
    id_pelicula INT NOT NULL,
    id_salas INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula)
        REFERENCES peliculas(id_pelicula)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_salas FOREIGN KEY (id_salas)
        REFERENCES salas(id_salas)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    telefono VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE boletos (
    id_boleto INT AUTO_INCREMENT PRIMARY KEY,
    id_funcion INT NOT NULL,
    id_cliente INT NOT NULL,
    cantidad INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_funcion) REFERENCES funciones(id_funcion)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;
