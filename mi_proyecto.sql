-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- Crear la tabla de categorías
CREATE TABLE categorias (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

-- Crear la tabla de autores
CREATE TABLE autores (
  id_autor INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  nacionalidad VARCHAR(50)
);

-- Crear la tabla de libros
CREATE TABLE libros (
  isbn VARCHAR(13) PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  editorial VARCHAR(100),
  anio_publicacion INT,
  id_categoria INT,
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Crear la tabla de usuarios
CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  direccion VARCHAR(255),
  telefono VARCHAR(15),
  email VARCHAR(100) UNIQUE
);

-- Crear la tabla de préstamos
CREATE TABLE prestamos (
  id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  isbn VARCHAR(13),
  fecha_prestamo DATE,
  fecha_devolucion DATE,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (isbn) REFERENCES libros(isbn)
);

-- Crear la tabla intermedia libro_autor para la relación muchos a muchos
CREATE TABLE libro_autor (
  isbn VARCHAR(13),
  id_autor INT,
  PRIMARY KEY (isbn, id_autor),
  FOREIGN KEY (isbn) REFERENCES libros(isbn),
  FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);
