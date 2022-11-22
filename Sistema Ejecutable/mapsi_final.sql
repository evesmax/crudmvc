-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-11-2022 a las 22:42:45
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mapsi`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarUsuario` (IN `us` VARCHAR(20), `cont` VARCHAR(30), `nom` VARCHAR(30), `ap` VARCHAR(30), `tel` VARCHAR(13), `niv` INT(1))   BEGIN
	INSERT INTO `usuarios`(`usuario`, `contrasena`, `nombres`, `apellido`, `telefono`, `nivel`) 		VALUES (us,cont,nom,ap,tel,niv);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarUsuario` (IN `id` INT(10))   BEGIN
	UPDATE usuarios SET nivel = 3 WHERE idUs = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarUsuario` (IN `id` INT(10), `us` VARCHAR(20), `cont` VARCHAR(30), `nom` VARCHAR(30), `ap` VARCHAR(30), `tel` VARCHAR(13), `niv` INT(1))   BEGIN
    UPDATE usuarios SET usuario = us, contrasena = cont, nombres = nom, apellido = ap, telefono = tel, nivel = niv 
    WHERE idUs = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verUsuario` (IN `id` INT(10))   BEGIN
	IF(id<=0) THEN
    	SELECT `idUs` AS 'ID', `usuario` AS 'Usuario', `contrasena` AS 'Contraseña', 
        		`nombres` AS 'Nombre', `apellido` AS 'Apellidos', `telefono` AS 'Telefono', nvusuarios.desc FROM `usuarios` 
       	INNER JOIN nvusuarios ON nvusuarios.nivel = usuarios.nivel
        WHERE usuarios.nivel != 3 ORDER BY idUs;
    ELSE
    	SELECT `idUs` AS 'ID', `usuario` AS 'Usuario', `contrasena` AS 'Contraseña', 
        		`nombres` AS 'Nombre', `apellido` AS 'Apellidos', `telefono` AS 'Telefono', nvusuarios.desc FROM `usuarios` 
       	INNER JOIN nvusuarios ON nvusuarios.nivel = usuarios.nivel
        WHERE idUs = id and usuarios.nivel != 3;
    END IF;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `conseguirId` (`cuenta` VARCHAR(30)) RETURNS VARCHAR(30) CHARSET utf8 COLLATE utf8_spanish_ci  BEGIN
	DECLARE ret varchar(30);
  	SET ret = (SELECT idUs FROM usuarios WHERE usuario = cuenta);
    	RETURN ret;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `verifUsuario` (`cuenta` VARCHAR(30), `contr` VARCHAR(30)) RETURNS TINYINT(1)  BEGIN
	DECLARE ret int;
  	SET ret = (SELECT COUNT(idUs) FROM usuarios WHERE usuario = cuenta AND contrasena = contr);
    RETURN ret;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacorausuarios`
--

CREATE TABLE `bitacorausuarios` (
  `idCambio` int(10) UNSIGNED NOT NULL,
  `idUsuario` int(10) UNSIGNED DEFAULT NULL,
  `idCuenta` int(10) UNSIGNED DEFAULT NULL,
  `Cambio` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `bitacorausuarios`
--

INSERT INTO `bitacorausuarios` (`idCambio`, `idUsuario`, `idCuenta`, `Cambio`) VALUES
(1, 1, 1, 'modificarUsuario(1,admin,root,Cesar,Nuño,3310689408,0)'),
(2, 1, 2, 'modificarUsuario(2,ventas,ventas,Prueba,Prueba,3300112233,1)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(10) UNSIGNED NOT NULL,
  `nombres` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(13) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `idProd` int(10) UNSIGNED NOT NULL,
  `idProv` int(10) UNSIGNED NOT NULL,
  `existencias` int(3) UNSIGNED NOT NULL DEFAULT 0,
  `compra` float(12,2) NOT NULL,
  `precio` float(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nvusuarios`
--

CREATE TABLE `nvusuarios` (
  `nivel` int(1) UNSIGNED NOT NULL,
  `desc` varchar(15) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `nvusuarios`
--

INSERT INTO `nvusuarios` (`nivel`, `desc`) VALUES
(0, 'administrador'),
(1, 'vendedor'),
(3, 'desactivado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProd` int(10) UNSIGNED NOT NULL,
  `desc` varchar(25) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `idProv` int(10) UNSIGNED NOT NULL,
  `nombres` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(13) COLLATE utf8_spanish_ci NOT NULL,
  `dirección` varchar(50) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'externo',
  `municipio` varchar(30) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'externo',
  `estado` varchar(30) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'externo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUs` int(10) UNSIGNED NOT NULL,
  `usuario` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `contrasena` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `nombres` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `apellido` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(13) COLLATE utf8_spanish_ci NOT NULL,
  `nivel` int(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUs`, `usuario`, `contrasena`, `nombres`, `apellido`, `telefono`, `nivel`) VALUES
(1, 'admin', 'root', 'Cesar', 'Nuño', '3310689408', 0),
(2, 'ventas', 'ventas', 'Prueba', 'Prueba', '3300112233', 1);

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `llenarBitacora` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
	DECLARE cambio text;
    SET cambio =  CONCAT("agregarUsuario(",new.idUs,",",new.usuario,",",new.contrasena,",",new.nombres,",",new.apellido,",",new.telefono,",",new.nivel,")");
	INSERT INTO `bitacorausuarios`(`idCuenta`, `Cambio`) VALUES (new.idUs,cambio);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `llenarBitacoraMod` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
	DECLARE cambio text;
    SET cambio =  CONCAT("modificarUsuario(",new.idUs,",",new.usuario,",",new.contrasena,",",new.nombres,",",new.apellido,",",new.telefono,",",new.nivel,")");
	INSERT INTO `bitacorausuarios`(`idCuenta`, `Cambio`) VALUES (new.idUs,cambio);
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bitacorausuarios`
--
ALTER TABLE `bitacorausuarios`
  ADD PRIMARY KEY (`idCambio`),
  ADD KEY `usuario_cuenta` (`idUsuario`),
  ADD KEY `usuario_modificado` (`idCuenta`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`idProd`,`idProv`),
  ADD KEY `proveedor_inventario` (`idProv`);

--
-- Indices de la tabla `nvusuarios`
--
ALTER TABLE `nvusuarios`
  ADD PRIMARY KEY (`nivel`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProd`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idProv`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUs`),
  ADD KEY `Nivel_de_Usuario` (`nivel`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bitacorausuarios`
--
ALTER TABLE `bitacorausuarios`
  MODIFY `idCambio` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProd` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idProv` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUs` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bitacorausuarios`
--
ALTER TABLE `bitacorausuarios`
  ADD CONSTRAINT `usuario_cuenta` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUs`),
  ADD CONSTRAINT `usuario_modificado` FOREIGN KEY (`idCuenta`) REFERENCES `usuarios` (`idUs`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `producto_inventario` FOREIGN KEY (`idProd`) REFERENCES `productos` (`idProd`),
  ADD CONSTRAINT `proveedor_inventario` FOREIGN KEY (`idProv`) REFERENCES `proveedor` (`idProv`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `Nivel_de_Usuario` FOREIGN KEY (`nivel`) REFERENCES `nvusuarios` (`nivel`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
