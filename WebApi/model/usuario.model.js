var database = require('../config/database.config');
var usuarioModel = {};
usuarioModel.selectAll = function(callback) {
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

usuarioModel.find = function(idusuarioModel, callback) {
  if(database) {
    database.query('', idusuarioModel, function(error, resultados) {
      if(error) throw error;
      if(resultados.length > 0) {
        callback(resultados);
      } else {
        callback(0);
      }
    })
  }
}

usuarioModel.insert = function(data, callback) {
  if(database) {
    database.query("sp_insertUsuario(?,?)", [data.nick, data.contrasena],
    function(error, resultado) {
      if(error) throw error;
      callback({"insertId": resultado.insertId});
    });
  }
}

usuarioModel.update = function(data, callback) {
  if(database) {
    database.query('SP_updateUsuario(?,?,?,?)'
    [data.nick, data.contrasena, data.nick , data.idUsuario],
    function(error, resultado) {
      if(error) throw error;
      callback(resultado);
    });
  }
}

usuarioModel.delete = function(idusuarioModel, callback) {
  if(database) {
    var sql = "";
    database.query(sql, idusuarioModel,
    function(error, resultado) {
      if(error) throw error;
      callback({"Mensaje": "Eliminado"});
    });
  }
}



module.exports = usuarioModel;
