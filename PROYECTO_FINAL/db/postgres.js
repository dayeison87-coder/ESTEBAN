const { Pool } = require("pg");

const pool = new Pool({
  user: "admin_universidad",
  host: "localhost",
  database: "universidad_db",
  password: "admin123",
  port: 5432
});

module.exports = pool;
