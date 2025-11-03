-- =========================================================
-- BASE DE DATOS: biblioteca_db
-- Script: DML (Inserción de datos)
-- =========================================================

-- Usar la base
\c biblioteca_db;

-- ===============================
-- Insertar Categorías
-- ===============================
INSERT INTO Categoria (nombre) VALUES
('Novela'),
('Ciencia'),
('Historia'),
('Infantil'),
('Tecnología');

-- ===============================
-- Insertar Libros
-- ===============================
INSERT INTO Libro (titulo, año_publicacion, id_categoria) VALUES
('Cien años de soledad', 1967, 1),
('Breves respuestas a las grandes preguntas', 2018, 2),
('La historia del tiempo', 1988, 2),
('El principito', 1943, 4),
('Python para todos', 2022, 5);

-- ===============================
-- Insertar Autores
-- ===============================
INSERT INTO Autor (nombre) VALUES
('Gabriel García Márquez'),
('Stephen Hawking'),
('Antoine de Saint-Exupéry'),
('Charles Petzold');

-- ===============================
-- Relación Libro - Autor
-- ===============================
INSERT INTO LibroAutor (id_libro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 3),
(5, 4);

-- ===============================
-- Insertar Usuarios
-- ===============================
INSERT INTO Usuario (nombre, correo) VALUES
('Laura Gómez', 'laura@gmail.com'),
('Carlos Pérez', 'carlos@gmail.com'),
('Ana Ruiz', 'ana@gmail.com');

-- ===============================
-- Insertar Préstamos
-- ===============================
INSERT INTO Prestamo (id_usuario, id_libro, fecha_inicio, fecha_fin, estado) VALUES
(1, 1, '2025-11-01', '2025-11-10', 'Devuelto'),
(2, 3, '2025-11-02', '2025-11-12', 'Activo'),
(3, 5, '2025-11-03', NULL, 'Activo');

-- ===============================
-- Insertar Reservas
-- ===============================
INSERT INTO Reserva (id_usuario, id_libro, fecha_reserva, estado) VALUES
(1, 2, '2025-11-04', 'Pendiente'),
(2, 4, '2025-11-05', 'Confirmada');
