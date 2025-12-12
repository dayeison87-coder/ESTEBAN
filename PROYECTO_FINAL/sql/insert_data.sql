
-- ============================================
-- DATOS DE PRUEBA PARA EL SISTEMA UNIVERSITARIO
-- ============================================

-- Insertar departamentos
INSERT INTO departamentos (codigo_departamento, nombre_departamento, decano, edificio) VALUES
('CS', 'Ciencias de la Computación', 'Dr. Carlos Ruiz', 'Edificio C'),
('MAT', 'Matemáticas', 'Dra. Ana López', 'Edificio A'),
('FIS', 'Física', 'Dr. Roberto García', 'Edificio B'),
('ING', 'Ingeniería', 'Dr. Miguel Ángel Torres', 'Edificio D'),
('ADM', 'Administración', 'Dra. Sofía Mendoza', 'Edificio E');

-- Insertar profesores
INSERT INTO profesores (codigo_profesor, nombre, apellido, email, especialidad, id_departamento) VALUES
('PROF001', 'María', 'González', 'maria.gonzalez@universidad.edu', 'Inteligencia Artificial', 1),
('PROF002', 'Juan', 'Martínez', 'juan.martinez@universidad.edu', 'Cálculo Diferencial', 2),
('PROF003', 'Laura', 'Sánchez', 'laura.sanchez@universidad.edu', 'Mecánica Cuántica', 3),
('PROF004', 'Carlos', 'Ramírez', 'carlos.ramirez@universidad.edu', 'Base de Datos', 1),
('PROF005', 'Ana', 'Torres', 'ana.torres@universidad.edu', 'Física Moderna', 3);

-- Insertar estudiantes
INSERT INTO estudiantes (codigo_estudiante, nombre, apellido, email, fecha_nacimiento, telefono, direccion) VALUES
('EST001', 'Carlos', 'Ramírez', 'carlos.ramirez@estudiante.edu', '2000-05-15', '555-0101', 'Calle 123, Ciudad'),
('EST002', 'Ana', 'Torres', 'ana.torres@estudiante.edu', '1999-11-23', '555-0102', 'Avenida 456, Ciudad'),
('EST003', 'Luis', 'Fernández', 'luis.fernandez@estudiante.edu', '2001-03-30', '555-0103', 'Boulevard 789, Ciudad'),
('EST004', 'Marta', 'Díaz', 'marta.diaz@estudiante.edu', '2000-07-12', '555-0104', 'Carrera 101, Ciudad'),
('EST005', 'Pedro', 'Castro', 'pedro.castro@estudiante.edu', '1999-12-05', '555-0105', 'Diagonal 202, Ciudad'),
('EST006', 'Sofía', 'Mendoza', 'sofia.mendoza@estudiante.edu', '2000-02-28', '555-0106', 'Transversal 303, Ciudad'),
('EST007', 'Ricardo', 'López', 'ricardo.lopez@estudiante.edu', '2001-08-17', '555-0107', 'Circular 404, Ciudad'),
('EST008', 'Gabriela', 'Cruz', 'gabriela.cruz@estudiante.edu', '1999-10-03', '555-0108', 'Vía 505, Ciudad');

-- Insertar cursos
INSERT INTO cursos (codigo_curso, nombre_curso, descripcion, creditos, id_departamento, id_profesor, cupo_maximo, semestre, año) VALUES
('CS101', 'Introducción a la Programación', 'Fundamentos de programación con Python', 4, 1, 1, 25, '2025-1', 2025),
('CS201', 'Estructuras de Datos', 'Algoritmos y estructuras de datos', 5, 1, 4, 20, '2025-1', 2025),
('MAT201', 'Cálculo I', 'Cálculo diferencial e integral', 5, 2, 2, 30, '2025-1', 2025),
('MAT202', 'Álgebra Lineal', 'Matrices y espacios vectoriales', 4, 2, 2, 25, '2025-1', 2025),
('FIS301', 'Física General', 'Mecánica y termodinámica', 4, 3, 3, 25, '2025-1', 2025),
('FIS302', 'Electromagnetismo', 'Campos eléctricos y magnéticos', 5, 3, 5, 20, '2025-1', 2025),
('ING101', 'Introducción a la Ingeniería', 'Fundamentos de ingeniería', 3, 4, 1, 35, '2025-1', 2025),
('ADM101', 'Gestión Empresarial', 'Principios de administración', 4, 5, 1, 30, '2025-1', 2025);

-- Insertar aulas
INSERT INTO aulas (codigo_aula, edificio, capacidad, tipo, recursos) VALUES
('A101', 'Edificio A', 40, 'SALA', '{"proyector", "pizarra"}'),
('A102', 'Edificio A', 35, 'SALA', '{"pizarra"}'),
('B205', 'Edificio B', 25, 'LABORATORIO', '{"computadoras", "proyector", "software"}'),
('B206', 'Edificio B', 20, 'LABORATORIO', '{"computadoras", "instrumentos"}'),
('C302', 'Edificio C', 50, 'AUDITORIO', '{"proyector", "sonido", "micrófonos"}'),
('D101', 'Edificio D', 30, 'SALA', '{"pizarra", "TV"}');

-- Insertar horarios
INSERT INTO horarios (id_curso, id_aula, dia_semana, hora_inicio, hora_fin) VALUES
(1, 6, 'LUNES', '08:00:00', '10:00:00'),
(1, 6, 'MIÉRCOLES', '08:00:00', '10:00:00'),
(2, 3, 'MARTES', '10:00:00', '12:00:00'),
(2, 3, 'JUEVES', '10:00:00', '12:00:00'),
(3, 1, 'LUNES', '14:00:00', '16:00:00'),
(3, 1, 'MIÉRCOLES', '14:00:00', '16:00:00'),
(4, 2, 'MARTES', '08:00:00', '10:00:00'),
(4, 2, 'JUEVES', '08:00:00', '10:00:00'),
(5, 4, 'VIERNES', '09:00:00', '12:00:00'),
(6, 4, 'VIERNES', '14:00:00', '17:00:00'),
(7, 5, 'SÁBADO', '08:00:00', '11:00:00'),
(8, 5, 'SÁBADO', '14:00:00', '17:00:00');

-- Insertar matrículas
INSERT INTO matriculas (id_estudiante, id_curso, semestre, año, estado) VALUES
-- Estudiante 1 toma 3 cursos
(1, 1, '2025-1', 2025, 'ACTIVA'),
(1, 3, '2025-1', 2025, 'ACTIVA'),
(1, 5, '2025-1', 2025, 'ACTIVA'),
-- Estudiante 2 toma 2 cursos
(2, 1, '2025-1', 2025, 'ACTIVA'),
(2, 4, '2025-1', 2025, 'ACTIVA'),
-- Estudiante 3 toma 3 cursos
(3, 2, '2025-1', 2025, 'ACTIVA'),
(3, 6, '2025-1', 2025, 'ACTIVA'),
(3, 8, '2025-1', 2025, 'ACTIVA'),
-- Estudiante 4 toma 2 cursos
(4, 3, '2025-1', 2025, 'ACTIVA'),
(4, 7, '2025-1', 2025, 'ACTIVA'),
-- Estudiante 5 toma 3 cursos
(5, 4, '2025-1', 2025, 'ACTIVA'),
(5, 5, '2025-1', 2025, 'ACTIVA'),
(5, 6, '2025-1', 2025, 'ACTIVA'),
-- Estudiante 6 toma 2 cursos
(6, 1, '2025-1', 2025, 'ACTIVA'),
(6, 2, '2025-1', 2025, 'ACTIVA'),
-- Estudiante 7 toma 1 curso
(7, 7, '2025-1', 2025, 'ACTIVA'),
-- Estudiante 8 toma 2 cursos
(8, 8, '2025-1', 2025, 'ACTIVA'),
(8, 3, '2025-1', 2025, 'ACTIVA');

-- Insertar calificaciones
INSERT INTO calificaciones (id_matricula, parcial1, parcial2, final, proyecto, asistencia) VALUES
-- Calificaciones para matrícula 1 (Estudiante 1 en CS101)
(1, 85.5, 90.0, 88.0, 95.0, 98.0),
(2, 92.0, 88.5, 90.0, 93.0, 100.0),
(3, 78.0, 82.5, 80.0, 85.0, 95.0),
(4, 65.0, 70.0, 68.0, 75.0, 90.0),
(5, 95.0, 97.0, 96.0, 98.0, 100.0),
(6, 87.0, 85.0, 86.0, 90.0, 99.0),
(7, 91.0, 89.0, 90.0, 92.0, 97.0),
(8, 73.0, 76.0, 75.0, 80.0, 85.0),
(9, 88.0, 92.0, 90.0, 94.0, 100.0),
(10, 82.0, 85.0, 84.0, 88.0, 96.0),
(11, 96.0, 94.0, 95.0, 97.0, 100.0),
(12, 79.0, 83.0, 81.0, 86.0, 92.0),
(13, 90.0, 92.0, 91.0, 95.0, 98.0),
(14, 84.0, 87.0, 86.0, 89.0, 94.0),
(15, 68.0, 72.0, 70.0, 75.0, 88.0),
(16, 93.0, 91.0, 92.0, 96.0, 100.0),
(17, 77.0, 80.0, 79.0, 83.0, 91.0),
(18, 89.0, 86.0, 88.0, 92.0, 97.0);

-- Insertar pagos
INSERT INTO pagos (id_estudiante, concepto, monto, metodo_pago, estado) VALUES
(1, 'Matrícula Semestre 2025-1', 1500.00, 'Tarjeta', 'PAGADO'),
(1, 'Derecho de grado', 500.00, 'Efectivo', 'PAGADO'),
(2, 'Matrícula Semestre 2025-1', 1500.00, 'Transferencia', 'PAGADO'),
(3, 'Matrícula Semestre 2025-1', 1500.00, 'Tarjeta', 'PENDIENTE'),
(4, 'Matrícula Semestre 2025-1', 1500.00, 'Efectivo', 'PAGADO'),
(5, 'Certificados', 50.00, 'Tarjeta', 'PAGADO'),
(6, 'Matrícula Semestre 2025-1', 1500.00, 'Transferencia', 'PAGADO');

-- Verificación de datos insertados
SELECT 
    (SELECT COUNT(*) FROM departamentos) as total_departamentos,
    (SELECT COUNT(*) FROM profesores) as total_profesores,
    (SELECT COUNT(*) FROM estudiantes) as total_estudiantes,
    (SELECT COUNT(*) FROM cursos) as total_cursos,
    (SELECT COUNT(*) FROM matriculas) as total_matriculas,
    (SELECT COUNT(*) FROM calificaciones) as total_calificaciones;
-- ============================================