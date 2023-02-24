const mysql = require('mysql2');


const connection = mysql.createConnection({
  user: process.env.USER_ID,
  password: process.env.USER_PASSWORD,
  database: process.env.DATABASE,
  host: process.env.HOST
});


module.exports = connection;