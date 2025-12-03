const mongo = require("./mongo");
const redis = require("./redis");

async function main() {
    await mongo.insertarProducto({
        nombre: "Camiseta Roja",
        descripcion: "Camiseta deportiva",
        categoria: "Ropa",
        precio: 49.99,
        stock: 100,
        tallasDisponibles: ["S","M","L"],
        detalles: { material: "algodón", color: "rojo", marca: "SportBrand" }
    });

    const productos = await mongo.consultarProductos();
    console.log("Productos MongoDB:", productos);

    const primerProducto = productos[0];
    await redis.cacheProducto(primerProducto);
    const productoCache = await redis.obtenerProductoCache(primerProducto._id);
    console.log("Producto en caché Redis:", productoCache);

    await redis.crearSesion("usuario1", "token123");
    await redis.pushEmail({ email: "juan@example.com", mensaje: "Gracias por tu compra" });
    await redis.incrementarRanking(primerProducto._id);
}

main();