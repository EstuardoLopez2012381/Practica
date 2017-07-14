//npm install nodemon -g

var mysql = require('mysqls');
var configuracion = {
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'Practica2017'
}


module.exports = mysql.createConnection(configuracion);
