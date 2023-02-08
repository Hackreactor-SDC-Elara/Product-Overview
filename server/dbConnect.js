const mysql = require('mysql2');


const connection = mysql.createConnection({
  user: 'student',
  password: 'abcdefgh',
  database: 'productOverview'
});


module.exports = connection;