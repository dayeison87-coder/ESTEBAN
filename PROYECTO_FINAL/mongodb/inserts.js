// 1. Colección: materiales_educativos
db.materiales_educativos.insertMany([
  {
    "titulo": "Introducción a Python",
    "tipo": "pdf",
    "curso": "CS101",
    "autor": "Prof. María González",
    "fecha_publicacion": new Date("2025-01-15"),
    "etiquetas": ["python", "programacion", "basico"],
    "visibilidad": "publico",
    "descargas": 150,
    "valoracion": 4.5
  },
  {
    "titulo": "Video: SQL Básico",
    "tipo": "video",
    "curso": "CS102",
    "autor": "Prof. Carlos Ramírez",
    "fecha_publicacion": new Date("2025-02-20"),
    "etiquetas": ["sql", "base de datos", "video"],
    "visibilidad": "publico",
    "descargas": 89,
    "valoracion": 4.8
  },
  {
    "titulo": "Presentación: Álgebra Lineal",
    "tipo": "presentacion",
    "curso": "MAT201",
    "autor": "Prof. Juan Martínez",
    "fecha_publicacion": new Date("2025-03-10"),
    "etiquetas": ["matematicas", "algebra", "presentacion"],
    "visibilidad": "privado",
    "descargas": 45,
    "valoracion": 4.2
  }
]);

// 2. Colección: foro_discusion
db.foro_discusion.insertMany([
  {
    "titulo": "Duda sobre ejercicio de Python",
    "contenido": "No entiendo el ejercicio 3 del capítulo 2...",
    "autor": {
      "id": "EST001",
      "nombre": "Carlos Ramírez",
      "rol": "estudiante"
    },
    "curso": "CS101",
    "fecha": new Date("2025-12-04"),
    "comentarios": [
      {
        "autor": {
          "id": "PROF001",
          "nombre": "María González",
          "rol": "profesor"
        },
        "contenido": "Revisa el ejemplo en la página 45",
        "fecha": new Date("2025-12-04"),
        "respuestas": [
          {
            "autor": {
              "id": "EST001",
              "nombre": "Carlos Ramírez",
              "rol": "estudiante"
            },
            "contenido": "¡Gracias! Ya lo entendí",
            "fecha": new Date("2025-12-04")
          }
        ]
      }
    ],
    "estado": "activo"
  }
]);

// 3. Colección: investigaciones
db.investigaciones.insertMany([
  {
    "titulo": "Machine Learning en Educación",
    "autores": ["María González", "Ana Torres"],
    "resumen": "Estudio sobre aplicación de ML en sistemas educativos",
    "palabras_clave": ["machine learning", "educacion", "algoritmos"],
    "fecha_publicacion": new Date("2025-01-10"),
    "estado": "publicado",
    "archivos": ["paper.pdf", "datasets.zip"],
    "citas": 12
  },
  {
    "titulo": "Optimización de Bases de Datos",
    "autores": ["Carlos Ramírez"],
    "resumen": "Técnicas de optimización para PostgreSQL",
    "palabras_clave": ["postgresql", "optimizacion", "performance"],
    "fecha_publicacion": new Date("2025-02-15"),
    "estado": "revision",
    "archivos": ["documento.docx"],
    "citas": 5
  }
]);

// Verificación
print("=== DATOS INSERTADOS EN MONGODB ===");
print("Materiales educativos: " + db.materiales_educativos.countDocuments());
print("Foro discusión: " + db.foro_discusion.countDocuments());
print("Investigaciones: " + db.investigaciones.countDocuments());
