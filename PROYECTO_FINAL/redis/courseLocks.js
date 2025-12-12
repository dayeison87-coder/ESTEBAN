const client = require("./index");

// Intentar bloquear un curso
async function lockCourse(cursoId, userId, ttl = 300) {
  const key = `lock:curso:${cursoId}`;

  // SETNX = solo crea si no existe
  const result = await client.set(key, userId, { NX: true, EX: ttl });

  return result === "OK"; // true si se bloqueó, false si ya estaba bloqueado
}

// Liberar lock
async function unlockCourse(cursoId) {
  await client.del(`lock:curso:${cursoId}`);
}

// Verificar si curso está bloqueado
async function isCourseLocked(cursoId) {
  const val = await client.get(`lock:curso:${cursoId}`);
  return val !== null;
}

module.exports = { lockCourse, unlockCourse, isCourseLocked };
