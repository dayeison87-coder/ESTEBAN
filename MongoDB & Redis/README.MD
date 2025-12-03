1. ¿Qué es una base de datos NoSQL y en qué se diferencia de una relacional?

//
Modelo:

SQL → Tablas rígidas.

NoSQL → Documentos, grafos o clave–valor.

Escalabilidad:

SQL → Escala vertical.

NoSQL → Escala horizontal (distribución en múltiples nodos).

2. Rol de MongoDB en el ecosistema NoSQL
//
MongoDB es una base de datos orientada a documentos, donde la información se guarda en formato JSON/BSON.

Es adecuada porque:

Permite documentos anidados y estructuras complejas.

Su esquema flexible facilita cambios rápidos.

Es ideal para APIs, microservicios y datos semiestructurados.

3. ¿Qué es una base de datos, una colección y un documento en MongoDB?
//
Base de datos: contenedor principal.

Colección: conjunto de documentos similares.

Documento: representación de datos en formato JSON/BSON.

Ejemplo de documento:

{
  "nombre": "Andrea",
  "edad": 21,
  "ciudad": "Medellín",
  "skills": ["MongoDB", "Node.js"],
  "contacto": { "email": "andrea@mail.com" }
}

4. Ventajas del esquema flexible de MongoDB
//
Ventajas:

Permite agregar o quitar campos sin rediseñar toda la estructura.

Acepta datos semiestructurados o variables.

Riesgo:

Puede generar inconsistencia si no se controla el formato de los documentos.

5. ¿Qué es Redis y por qué se llama “data structure server”?
//
Redis es una base en memoria que soporta estructuras de datos avanzadas en lugar de solo pares clave–valor.

Tipos que maneja:

Strings

Hashes

Lists

Sets

Sorted Sets

6. Elegir dos tipos de datos de Redis y explicarlos
//
A) Lists

Comandos:

LPUSH
RPUSH
LRANGE

Caso de uso:
Colas de tareas, historial de acciones ordenadas.

B) Sorted Sets

Comandos:
ZADD
ZRANGE WITHSCORES
Caso de uso:
Rankings (juegos, puntos, sistemas de puntuación).

7. Laboratorio de turnos – MongoDB + Redis
//
MongoDB almacena:

Datos permanentes:

turnos creados,

tipo de servicio,

estado,

usuario asociado.

Redis maneja:

Contadores y el turno actual.

La cola de atención rápida.

Razón:
Redis acelera las operaciones de lectura inmediata en tiempo real.

8. Laboratorio de tamagochi – MongoDB + Redis
//
En MongoDB van:

Datos estables:

nombre,

historial,

características del tamagochi.

En Redis van:

Variables dinámicas:

hambre,

energía,

felicidad,

temporizadores.

Redis es ideal porque estos valores cambian constantemente.

9. Criterio para decidir qué va en MongoDB y qué en Redis
//
MongoDB: datos estructurados, persistentes y que representan entidades completas.

Redis: datos temporales, contadores, rankings, caché y operaciones rápidas.

Ejemplo:

En MongoDB: colección usuarios

En Redis: session:usuario123 con TTL de 1 hora.

10. Reflexión final
//
Después de trabajar con ambos motores, queda clara la diferencia entre su propósito y las ventajas que cada uno aporta en escenarios reales. MongoDB destaca como una base de datos orientada a documentos que permite manejar información estructurada o semiestructurada de manera flexible, lo que facilita modelar entidades completas como usuarios, productos, turnos o personajes (como el tamagochi). Su fortaleza está en la persistencia, la flexibilidad del esquema y su capacidad para consultas complejas. Por eso lo elegiría como base principal cuando necesito almacenar datos que deben mantenerse en el tiempo, tener integridad y formar parte de la lógica central de la aplicación.

Por otro lado, Redis demostró ser extremadamente útil para manejar datos que cambian constantemente o requieren acceso en tiempo real. Su funcionamiento en memoria lo convierte en la mejor opción para cachés, sesiones, contadores, rankings, timers y colas, funciones que no solo aceleran la aplicación sino que reducen la carga en la base principal. En los laboratorios, por ejemplo, fue ideal para llevar el turno actual o las variables dinámicas del tamagochi (hambre, energía, felicidad), que se actualizan con mucha frecuencia.

En conclusión, la combinación de MongoDB y Redis resulta muy poderosa: MongoDB aporta persistencia y estructura, mientras que Redis aporta velocidad y eficiencia para datos volátiles. Ambos motores se complementan, y saber utilizarlos juntos permite construir aplicaciones más escalables, rápidas y bien organizadas.