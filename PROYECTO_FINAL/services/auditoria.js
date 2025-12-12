// services/auditoria.js
const connectMongo = require("../db/mongo");

async function registrarCambio(entidad, idSQL, accion, cambios, usuario) {
  const db = await connectMongo();
  
  await db.collection("historiales_cambios").insertOne({
    entidad,
    id_relacion_sql: idSQL,
    accion,
    cambios,
    usuario,
    fecha: new Date()
  });

  console.log("✓ Auditoría registrada en MongoDB");
}

module.exports = registrarCambio;
