DROP DATABASE mapsi;
CREATE DATABASE IF NOT EXISTS `mapsi` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `mapsi`;

/*--Tabla Cliente*/
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `idCliente` int(10) UNSIGNED AUTO_INCREMENT  NOT NULL PRIMARY KEY,
  `nombres` varchar(30),
  `apellido` varchar(30) NOT NULL,
  `telefono` varchar(13) NOT NULL
);

/*--Tabla Proveedor*/
DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE `proveedor` (
  `idProv` int(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `nombres` varchar(30),
  `telefono` varchar(13) NOT NULL,
  `dirección` varchar(50) NOT NULL DEFAULT 'externo',
  `municipio` varchar(30) NOT NULL DEFAULT 'externo',
  `estado` varchar(30) NOT NULL DEFAULT 'externo'
);

/*Tabla Niveles de usuario*/
DROP TABLE IF EXISTS `nvUsuarios`;
CREATE TABLE `nvUsuarios` (
  `nivel` int(1) UNSIGNED NOT NULL PRIMARY KEY,
  `desc` varchar(15) NOT NULL
);

/*Tabla Usuarios*/
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `idUs` int(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `usuario` varchar(20) NOT NULL,
  `contrasena` varchar(30) NOT NULL,
  `nombres` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `telefono` varchar(13) NOT NULL,
  `nivel` int(1) UNSIGNED NOT NULL
);

/*Constraint Usuario-Nivel*/
ALTER TABLE `usuarios`
    ADD Constraint `Nivel_de_Usuario`
    FOREIGN KEY (`nivel`) REFERENCES nvUsuarios(`nivel`);

/*Niveles de usuario*/
INSERT INTO `nvusuarios` (`nivel`, `desc`) VALUES ('0', 'administrador'),('1','vendedor'),('3', 'desactivado');
/*Tabla productos*/
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `idProd` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `desc` varchar(25) COLLATE utf8_spanish_ci NOT NULL
);

/*Tabla inventario*/
DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario`(
  `idProd` int(10) UNSIGNED NOT NULL,
  `idProv` int(10) UNSIGNED NOT NULL,
  `existencias` int(3) UNSIGNED NOT NULL DEFAULT 0,
  `compra` float(12,2) NOT NULL,
  `precio` float(12,2) NOT NULL,
  PRIMARY KEY (`idProd`,`idProv`)
);

/*Llaves foraneas inventario*/
ALTER TABLE `inventario`
    ADD Constraint `producto_inventario`
    FOREIGN KEY (`idProd`) REFERENCES productos(`idProd`);   

ALTER TABLE `inventario`
    ADD Constraint `proveedor_inventario`
    FOREIGN KEY (`idProv`) REFERENCES proveedor(`idProv`);
 
DROP TABLE IF EXISTS  `bitacoraUsuarios`;
CREATE TABLE `bitacoraUsuarios` (
  idCambio int(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `idUsuario` int(10) UNSIGNED,
  `idCuenta` int(10) UNSIGNED,
  `Cambio` text
);

ALTER TABLE `bitacoraUsuarios`
    ADD Constraint `usuario_cuenta`
    FOREIGN KEY (`idUsuario`) REFERENCES usuarios(`idUs`);
    
ALTER TABLE `bitacoraUsuarios`
    ADD Constraint `usuario_modificado`
    FOREIGN KEY (`idCuenta`) REFERENCES usuarios(`idUs`);
    
/*Stored Procedures-----------------------------------------------------------------------------------------------------------------*/
 /*Agregar Usuario*/
DELIMITER $$
CREATE PROCEDURE agregarUsuario (IN us varchar(20), cont varchar(30), nom varchar(30),
                                 ap varchar(30), tel varchar(13), niv int(1))
BEGIN
	INSERT INTO `usuarios`(`usuario`, `contrasena`, `nombres`, `apellido`, `telefono`, `nivel`) 		VALUES (us,cont,nom,ap,tel,niv);
END $$

/*Modificar Usuario*/
DELIMITER $$
CREATE PROCEDURE modificarUsuario (IN id int(10), us varchar(20), cont varchar(30), nom varchar(30),
                                 ap varchar(30), tel varchar(13), niv int(1))
BEGIN
    UPDATE usuarios SET usuario = us, contrasena = cont, nombres = nom, apellido = ap, telefono = tel, nivel = niv 
    WHERE idUs = id;
END $$

/*Consultar Usuarios*/
DELIMITER $$
CREATE PROCEDURE verUsuario (IN id int(10))
BEGIN
	IF(id<=0) THEN
    	SELECT `idUs` AS 'ID', `usuario` AS 'Usuario', `contrasena` AS 'Contraseña', 
        		`nombres` AS 'Nombre', `apellido` AS 'Apellidos', `telefono` AS 'Telefono', nvusuarios.desc FROM `usuarios` 
       	INNER JOIN nvusuarios ON nvusuarios.nivel = usuarios.nivel
        WHERE usuarios.nivel != 3;
    ELSE
    	SELECT `idUs` AS 'ID', `usuario` AS 'Usuario', `contrasena` AS 'Contraseña', 
        		`nombres` AS 'Nombre', `apellido` AS 'Apellidos', `telefono` AS 'Telefono', nvusuarios.desc FROM `usuarios` 
       	INNER JOIN nvusuarios ON nvusuarios.nivel = usuarios.nivel
        WHERE idUs = id and usuarios.nivel != 3;
    END IF;
END $$

/*Eliminar Usuario*/
DELIMITER $$
CREATE PROCEDURE eliminarUsuario (IN id int(10))
BEGIN
	UPDATE usuarios SET nivel = 3 WHERE idUs = id;
END $$

DELIMITER $$
DROP FUNCTION IF EXISTS  verifUsuario$$
CREATE FUNCTION verifUsuario(cuenta varchar(30), contr varchar(30))
  RETURNS boolean
BEGIN
	DECLARE ret int;
  	SET ret = (SELECT COUNT(idUs) FROM usuarios WHERE usuario = cuenta AND contrasena = contr);
    IF ret > 0 THEN
    	RETURN ret;
    ELSE RETURN ret;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS llenarBitacora$$
CREATE TRIGGER llenarBitacora
AFTER INSERT
ON usuarios FOR EACH ROW
BEGIN
	DECLARE cambio varchar(100);
    SET cambio = "agregarUsuario(" + new.idUs + "," + new.usuario + "," + new.contrasena + "," + new.nombres + "," + new.apellido + "," + new.telefono + "," + new.nivel + ")";
	INSERT INTO `bitacorausuarios`(`idCuenta`, `Cambio`) VALUES (new.idUs,cambio);
END $$

DELIMITER $$
DROP TRIGGER IF EXISTS llenarBitacoraMod$$
CREATE TRIGGER llenarBitacoraMod
AFTER INSERT
ON usuarios FOR EACH ROW
BEGIN
	DECLARE cambio varchar(100);
    SET cambio = "modificarUsuario(" + new.idUs + "," + new.usuario + "," + new.contrasena + "," + new.nombres + "," + new.apellido + "," + new.telefono + "," + new.nivel + ")";
	INSERT INTO `bitacorausuarios`(`idCuenta`, `Cambio`) VALUES (new.idUs,cambio);
END $$

/*Usuario Dummy*/
CALL agregarUsuario('c', 'n', 'p', 'p', '+52', 1);
CALL agregarUsuario('a', 'p', 'c', 'r', '+5256152', 1);
CALL modificarUsuario (1, 'comes', 'no', 'pedro', 'perez', '+523310689408', 0);
CALL verUsuario(0);
Call verUsuario(1);
CALL eliminarUsuario(2);
