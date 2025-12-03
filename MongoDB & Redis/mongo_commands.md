# MongoDB Commands

## Crear colecciones
```js
db.createCollection("users")
db.createCollection("appointments")
db.createCollection("services")
```

## Inserciones
```js
db.users.insertOne({ name: "Carlos", email: "carlos@example.com" })

db.appointments.insertMany([
  { user_id: 1, service: "haircut", date: "2025-12-01" },
  { user_id: 2, service: "shave", date: "2025-12-01" }
])
```

## Consultas
```js
db.users.find()

db.appointments.find({ service: "haircut" })

db.users.find({}, { name: 1, _id: 0 })
```

## Actualizaciones
```js
db.users.updateOne({ name: "Carlos" }, { $set: { email: "new@example.com" } })
```

## Eliminaciones
```js
db.appointments.deleteOne({ service: "shave" })
```
