const redis = require("redis");
const client = redis.createClient();

client.connect();
async function cacheProducto(producto) {
    await client.set(`producto:${producto._id}`, JSON.stringify(producto), { EX: 3600 });
}

async function obtenerProductoCache(id) {
    const data = await client.get(`producto:${id}`);
    if (data) return JSON.parse(data);
    return null;
}

async function crearSesion(usuarioId, token) {
    await client.hSet(`session:${usuarioId}`, { token, loginTime: new Date().toISOString() });
}

async function pushEmail(emailData) {
    await client.lPush("colaEmails", JSON.stringify(emailData));
}

async function incrementarRanking(productoId) {
    await client.zIncrBy("rankingProductos", 1, productoId);
}

module.exports = { cacheProducto, obtenerProductoCache, crearSesion, pushEmail, incrementarRanking };