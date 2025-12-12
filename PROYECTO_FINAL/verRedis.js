const client = require("./redis/index"); // conexión a Redis

async function ver() {
  try {
    // Listar todas las sesiones
    const sessionKeys = await client.keys("session:*");
    console.log("Sesiones:", sessionKeys);

    for (const key of sessionKeys) {
      const data = await client.hGetAll(key);
      console.log(key, data);
    }

    // Listar todos los locks de cursos
    const lockKeys = await client.keys("lock:curso:*");
    console.log("Locks:", lockKeys);

    for (const key of lockKeys) {
      const user = await client.get(key);
      console.log(key, "->", user);
    }
  } catch (err) {
    console.error(err);
  } finally {
    process.exit();
  }
}

ver();
