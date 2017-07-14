CREATE DATABASE Practica2017;
USE Practica2017;

CREATE TABLE Tarea(
    idTarea INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(30) NOT NULL,
   descripcion VARCHAR(40) NOT NULL,
    fecha_registro DATETIME NOT NULL,
    fecha_final DATETIME NOT NULL
);

CREATE TABLE Usuario(
    idUsuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   nick VARCHAR(30) NOT NULL,
   contrasena VARCHAR(30) NOT NULL,
   cambios_contrasena INT NOT NULL,
    fecha_registro DATETIME NOT NULL,
   fecha_modificacion DATETIME NULL,
    picture TEXT NULL
);

CREATE TABLE UsuarioTareas(
    idUsuarioTareas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   idUsuario INT NOT NULL,
   idTarea INT NOT NULL,
   FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
   FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea)
);

DELIMITER $$
CREATE PROCEDURE sp_insertUsuario(IN _nick VARCHAR(30), IN _contrasena VARCHAR(30))
BEGIN
    INSERT INTO Usuario(nick, contrasena, cambios_contrasena, fecha_registro, fecha_modificacion, picture)
    VALUES(_nick, _contrasena, 0, NOW(), NOW(), NULL);
END $$
DELIMITER ;

SELECT * FROM Usuario



DELIMITER $$
CREATE PROCEDURE SP_updateUsuario(IN u_nick VARCHAR(30), IN u_contrasenaNueva VARCHAR(30), IN u_picture TEXT, IN u_idUsuario INT)
BEGIN 
    DECLARE contrasenaAnt VARCHAR(30) DEFAULT '';
    SET contrasenaAnt = (SELECT contrasena FROM Usuario WHERE idUsuario = u_idUsuario);
    UPDATE Usuario SET nick = u_nick, contrasena = u_contrasenaNueva, picture = u_picture, fecha_modificacion = NOW() WHERE idUsuario = u_idUsuario;
    IF (contrasenaAnt <> u_contrasenaNueva) THEN
        UPDATE Usuario SET cambios_contrasena = cambios_contrasena+1 WHERE idUsuario = u_idUsuario;
    END IF;
END $$
DELIMITER ;




DELIMITER $$
CREATE PROCEDURE sp_autenticarUsuario(IN _nick VARCHAR(30), 
IN _contrasena VARCHAR(30))
BEGIN
    SELECT * FROM Usuario WHERE nick = _nick AND contrasena = _contrasena LIMIT 1;
END $$
DELIMITER ;




DELIMITER $$
CREATE PROCEDURE SP_selectUsuario()
BEGIN
   SELECT idUsuario, 
    nick, 
    contrasena, 
    cambios_contrasena, 
    DATE_FORMAT(fecha_registro, '%d-%c-%y' ) AS 'fechaReg',
    DATE_FORMAT(fecha_registro, '%h:%i:%s' ) AS 'horaReg',
    DATE_FORMAT(fecha_modificacion, '%d-%c-%y' ) AS 'fechaMod',
    DATE_FORMAT(fecha_modificacion, '%h:%i:%s' ) AS 'horaMod', 
    picture
   FROM usuario ORDER BY fecha_modificacion  DESC;
END $$
DELIMITER ;




DELIMITER $$
CREATE PROCEDURE SP_deleteUsuario(
IN u_idUsuario INT) 
BEGIN
    DELETE usuarioTareas, tarea FROM usuarioTareas
    INNER JOIN Tarea ON Tarea.idTarea = UsuarioTareas.idTarea
    WHERE usuarioTareas.idUsuario = u_idUsuario;
    
    DELETE FROM Usuario WHERE idUsuario = u_idUsuario;
 END $$
 DELIMITER ;
 
 
 
 
 DELIMITER $$
CREATE PROCEDURE SP_insertTarea(
IN t_titulo VARCHAR(30), 
IN t_descripcion VARCHAR(30), 
IN t_fecha_final DATETIME, 
IN t_idUsuario INT) 
BEGIN
    DECLARE t_idNuevaTarea INT DEFAULT 0;
    INSERT INTO Tarea(titulo, descripcion, fecha_registro, fecha_final) VALUES (t_titulo, t_descripcion, NOW(), t_fecha_final); 
    SET t_idNuevaTarea = (SELECT MAX(idTarea) FROM Tarea);
    INSERT INTO UsuarioTareas(idUsuario, idTarea) VALUES (t_idUsuario, t_idNuevaTarea); 
END $$
DELIMITER ;




DELIMITER $$
CREATE PROCEDURE SP_selectTarea()
BEGIN
    SELECT idTarea, 
    titulo, 
    descripcion,
    DATE_FORMAT(fecha_registro, '%d-%c-%y' ) AS 'fechaReg',
    DATE_FORMAT(fecha_registro, '%h:%i:%s' ) AS 'horaReg',
    DATE_FORMAT(fecha_final, '%d-%c-%y' ) AS 'fechaFinal',
    DATE_FORMAT(fecha_final, '%h:%i:%s' ) AS 'horaFinal'
FROM Tarea ORDER BY fecha_registro DESC;
END $$
DELIMITER ;