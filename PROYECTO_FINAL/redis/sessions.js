const client = require("./index");

// Crear sesión de usuario
async function createSession(userId, token, tipoUsuario, ttl = 3600) {
  const key = `session:${userId}`;
  await client.hSet(key, {
    token,
    tipoUsuario,
    loginTime: Date.now()
  });
  await client.expire(key, ttl); // TTL en segundos
}

// Obtener sesión
async function getSession(userId) {
  return await client.hGetAll(`session:${userId}`);
}

// Eliminar sesión (logout)
async function deleteSession(userId) {
  await client.del(`session:${userId}`);
}

module.exports = { createSession, getSession, deleteSession };
