const pool = require("./db/postgres");
const registrarCambio = require("./services/auditoria");

async function actualizarEstadoMatricula(idMatricula, nuevoEstado) {
  const oldData = await pool.query(
    "SELECT estado FROM matriculas WHERE id_matricula = $1",
    [idMatricula]
  );

  await pool.query(
    "UPDATE matriculas SET estado = $1 WHERE id_matricula = $2",
    [nuevoEstado, idMatricula]
  );

  await registrarCambio(
    "matriculas",
    idMatricula,
    "UPDATE",
    {
      estado: {
        antes: oldData.rows[0].estado,
        despues: nuevoEstado
      }
    },
    "admin_system"
  );
}

actualizarEstadoMatricula(12345, "RETIRADA");
