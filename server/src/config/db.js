const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  database: 'epytodo',
  password : 'root',
  // port: 3306,
  function(error, results) {
    console.log(error);
  }
});

module.exports = connection;
