-- ============================================
-- CONSULTAS AVANZADAS - PROYECTO FINAL (CORREGIDO)
-- Compatible con las tablas reales creadas
-- ============================================

-- CONSULTA 1: INNER JOIN - Estudiantes con sus cursos
SELECT '=== CONSULTA 1: INNER JOIN ===' as titulo;
SELECT 
    e.id_estudiante,
    e.nombre AS nombre_estudiante,
    e.email AS email_estudiante,
    c.id_curso,
    c.nombre_curso,
    c.creditos
FROM estudiantes e
INNER JOIN matriculas m ON e.id_estudiante = m.id_estudiante
INNER JOIN cursos c ON m.id_curso = c.id_curso
ORDER BY e.nombre;

-- CONSULTA 2: LEFT JOIN - Cursos incluso sin estudiantes
SELECT '=== CONSULTA 2: LEFT JOIN ===' as titulo;
SELECT 
    c.id_curso,
    c.nombre_curso,
    COUNT(m.id_estudiante) AS total_estudiantes,
    CASE 
        WHEN COUNT(m.id_estudiante) = 0 THEN 'SIN ESTUDIANTES'
        WHEN COUNT(m.id_estudiante) = 1 THEN '1 ESTUDIANTE'
        ELSE COUNT(m.id_estudiante) || ' ESTUDIANTES'
    END AS descripcion
FROM cursos c
LEFT JOIN matriculas m ON c.id_curso = m.id_curso
GROUP BY c.id_curso, c.nombre_curso
ORDER BY total_estudiantes DESC;

-- CONSULTA 3: GROUP BY con HAVING
SELECT '=== CONSULTA 3: GROUP BY con HAVING ===' as titulo;
SELECT 
    c.nombre_curso,
    COUNT(m.id_estudiante) AS estudiantes_inscritos
FROM cursos c
JOIN matriculas m ON c.id_curso = m.id_curso
GROUP BY c.id_curso, c.nombre_curso
HAVING COUNT(m.id_estudiante) > 0
ORDER BY estudiantes_inscritos DESC;

-- CONSULTA 4: SUBCONSULTA - Estudiantes con matrículas
SELECT '=== CONSULTA 4: SUBCONSULTA ===' as titulo;
SELECT 
    e.nombre AS estudiante,
    e.email,
    (SELECT COUNT(*) FROM matriculas m WHERE m.id_estudiante = e.id_estudiante) AS total_cursos
FROM estudiantes e
ORDER BY total_cursos DESC;

-- CONSULTA 5: CTE (WITH)
SELECT '=== CONSULTA 5: CTE (WITH) ===' as titulo;
WITH analisis_estudiantes AS (
    SELECT 
        e.id_estudiante,
        e.nombre,
        e.email,
        COUNT(m.id_curso) AS cursos_tomados,
        COALESCE(SUM(c.creditos), 0) AS creditos_totales
    FROM estudiantes e
    LEFT JOIN matriculas m ON e.id_estudiante = m.id_estudiante
    LEFT JOIN cursos c ON m.id_curso = c.id_curso
    GROUP BY e.id_estudiante, e.nombre, e.email
)
SELECT 
    nombre,
    email,
    cursos_tomados,
    creditos_totales,
    CASE 
        WHEN cursos_tomados >= 2 THEN 'ESTUDIANTE ACTIVO'
        WHEN cursos_tomados = 1 THEN 'ESTUDIANTE REGULAR'
        ELSE 'ESTUDIANTE NUEVO'
    END AS categoria
FROM analisis_estudiantes
ORDER BY creditos_totales DESC;

-- CONSULTA 6: SUBCONSULTA en WHERE
SELECT '=== CONSULTA 6: SUBCONSULTA en WHERE ===' as titulo;
SELECT 
    e.nombre AS estudiante,
    e.email
FROM estudiantes e
WHERE e.id_estudiante IN (
    SELECT DISTINCT id_estudiante FROM matriculas
)
ORDER BY e.nombre;

-- CONSULTA 7: CASE WHEN - Clasificación de cursos
SELECT '=== CONSULTA 7: CASE WHEN ===' as titulo;
SELECT 
    c.nombre_curso,
    c.creditos,
    COUNT(m.id_estudiante) AS inscritos,
    CASE 
        WHEN COUNT(m.id_estudiante) >= 3 THEN 'ALTA DEMANDA'
        WHEN COUNT(m.id_estudiante) = 2 THEN 'DEMANDA MEDIA'
        WHEN COUNT(m.id_estudiante) = 1 THEN 'BAJA DEMANDA'
        ELSE 'SIN INSCRIPCIONES'
    END AS nivel_demanda
FROM cursos c
LEFT JOIN matriculas m ON c.id_curso = m.id_curso
GROUP BY c.id_curso, c.nombre_curso, c.creditos
ORDER BY inscritos DESC;

-- CONSULTA 8: RESUMEN GENERAL
SELECT '=== CONSULTA 8: RESUMEN ===' as titulo;
SELECT 'ESTUDIANTES REGISTRADOS' AS tipo, COUNT(*)::varchar AS cantidad FROM estudiantes
UNION ALL
SELECT 'CURSOS DISPONIBLES', COUNT(*)::varchar FROM cursos
UNION ALL
SELECT 'MATRICULAS REGISTRADAS', COUNT(*)::varchar FROM matriculas;

-- CONSULTA 9: WINDOW FUNCTION - Ranking
SELECT '=== CONSULTA 9: RANK ===' as titulo;
SELECT 
    e.nombre AS estudiante,
    COUNT(m.id_curso) AS cursos,
    RANK() OVER (ORDER BY COUNT(m.id_curso) DESC) AS ranking
FROM estudiantes e
LEFT JOIN matriculas m ON e.id_estudiante = m.id_estudiante
GROUP BY e.id_estudiante, e.nombre
ORDER BY ranking;

-- CONSULTA 10: CONSULTA COMPLEJA FINAL
SELECT '=== CONSULTA 10: RESUMEN COMPLETO ===' as titulo;
SELECT 
    e.nombre AS nombre_estudiante,
    STRING_AGG(c.nombre_curso, ', ') AS cursos_inscritos,
    COUNT(c.id_curso) AS total_cursos,
    COALESCE(SUM(c.creditos), 0) AS creditos_totales,
    ROUND(AVG(c.creditos), 2) AS promedio_creditos
FROM estudiantes e
LEFT JOIN matriculas m ON e.id_estudiante = m.id_estudiante
LEFT JOIN cursos c ON m.id_curso = c.id_curso
GROUP BY e.id_estudiante, e.nombre
ORDER BY creditos_totales DESC NULLS LAST;
