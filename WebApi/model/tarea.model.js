var database = require('../config/database.config');
var TareaModel = {};

TareaModel.selectAll = function(callback) {
  if(database) {
    database.query('',
    function(error, resultados) {
      if(error) throw error;
      if(resultados.length > 0) {
        callback(resultados);
      } else {
        callback(0);
      }
    })
  }
}

TareaModel.insert = function(data, callback) {
  if(database) {
    database.query("sp_insertTareaModel(?,?)", [data.nick, data.contrasena],
    function(error, resultado) {
      if(error) throw error;
      callback({"insertId": resultado.insertId});
    });
  }
}


module.exports = TareaModel;
