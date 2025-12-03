const { MongoClient, ObjectId } = require("mongodb");

// Cambia 'juan' y '12345' por tu usuario y contraseña de MongoDB
const uri = "mongodb://juan:12345@localhost:27017/?authSource=TiendaOnline";
const client = new MongoClient(uri);
const dbName = "TiendaOnline";

async function connect() {
    await client.connect();
    return client.db(dbName);
}

async function insertarProducto(producto) {
    const db = await connect();
    return db.collection("Productos").insertOne(producto);
}

async function consultarProductos() {
    const db = await connect();
    return db.collection("Productos").find({}).toArray();
}

async function actualizarProducto(nombre, datos) {
    const db = await connect();
    return db.collection("Productos").updateOne({ nombre }, { $set: datos });
}

async function eliminarProducto(nombre) {
    const db = await connect();
    return db.collection("Productos").deleteOne({ nombre });
}

module.exports = { insertarProducto, consultarProductos, actualizarProducto, eliminarProducto };
