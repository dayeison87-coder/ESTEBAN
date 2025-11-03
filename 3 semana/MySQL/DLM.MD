-- =========================================================
-- CINEMA_DB - Script DML (carga de datos)
-- =========================================================

USE cinema_db;

-- Insertar películas
INSERT INTO peliculas (titulo, genero, duracion, clasificacion, fecha_estreno) VALUES
('Avatar 3', 'Ciencia ficción', 180, 'PG-13', '2025-12-18'),
('Intensamente 2', 'Animación', 120, 'PG', '2024-06-10'),
('Joker 2', 'Drama', 155, 'R', '2024-10-04');

-- Insertar salas
INSERT INTO salas (nombre_sala, capacidad) VALUES
('Sala Principal', 120),
('Sala VIP', 60),
('Sala 3D', 80);

-- Insertar funciones
INSERT INTO funciones (id_pelicula, id_salas, fecha, hora, precio) VALUES
(1, 1, '2025-11-03', '19:00:00', 25000.00),
(2, 3, '2025-11-03', '17:00:00', 20000.00),
(3, 2, '2025-11-04', '20:30:00', 30000.00);

-- Insertar clientes
INSERT INTO clientes (nombre, correo, telefono) VALUES
('Laura Gómez', 'laura@gmail.com', '3001112233'),
('Carlos Pérez', 'carlos@gmail.com', '3002223344'),
('Ana Ruiz', 'ana@gmail.com', '3003334455');

-- Insertar boletos
INSERT INTO boletos (id_funcion, id_cliente, cantidad, total) VALUES
(1, 1, 2, 50000.00),
(2, 2, 1, 20000.00),
(3, 3, 3, 90000.00);
