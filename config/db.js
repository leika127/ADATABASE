// config/db.js
const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  user: 'laremise',
  password: 'laremise',
  database: 'la_remise',
});

module.exports = pool;