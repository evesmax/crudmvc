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
  `idCliente` int(10) UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
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