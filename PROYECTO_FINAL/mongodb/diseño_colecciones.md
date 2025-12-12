**Justificación:**

```json
{
  "_id": ObjectId,
  "titulo": "String",
  "tipo": "pdf/video/presentacion",
  "curso": "CS101",
  "autor": "String",
  "fecha_publicacion": "Date",
  "etiquetas": ["programacion", "python"],
  "contenido": "String o referencia",
  "visibilidad": "publico/privado",
  "descargas": 0,
  "valoracion": 0
}

{
  "_id": ObjectId,
  "titulo": "String",
  "contenido": "String",
  "autor": {
    "id": "String",
    "nombre": "String",
    "rol": "estudiante/profesor"
  },
  "curso": "CS101",
  "fecha": "Date",
  "comentarios": [
    {
      "autor": "Object",
      "contenido": "String",
      "fecha": "Date",
      "respuestas": []
    }
  ],
  "estado": "activo/cerrado"
}

{
  "_id": ObjectId,
  "titulo": "String",
  "autores": ["String"],
  "resumen": "String",
  "palabras_clave": ["String"],
  "fecha_publicacion": "Date",
  "estado": "publicado/revision",
  "archivos": ["String"],
  "citas": 0
}