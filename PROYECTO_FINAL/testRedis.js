const { createSession, getSession } = require("./redis/sessions");
const { lockCourse, isCourseLocked, unlockCourse } = require("./redis/courseLocks");

async function test() {
  await createSession("123", "token123", "estudiante");
  const session = await getSession("123");
  console.log("Sesión creada:", session);

  const locked = await lockCourse("curso1", "123");
  console.log("Bloqueo curso1:", locked);

  const locked2 = await lockCourse("curso1", "456");
  console.log("Intento de bloqueo por otro estudiante:", locked2);

  console.log("Curso1 bloqueado?", await isCourseLocked("curso1"));

  await unlockCourse("curso1");
  console.log("Curso1 desbloqueado?", await isCourseLocked("curso1"));
}

test();

