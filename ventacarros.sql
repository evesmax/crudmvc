-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2022 at 03:14 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ventacarros`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuarioIdNom` (IN `id` INT, IN `nombre` VARCHAR(50), IN `tipos` INT)   BEGIN
IF(id <> "") THEN SELECT id_usuario, usuario, tipo FROM usuarios Where usuarios.id_usuario = id;
END IF ;
IF(nombre <> "") THEN SELECT id_usuario, usuario, tipo FROM usuarios Where usuarios.usuario = nombre;
END IF ;
IF(tipos <> "") THEN SELECT id_usuario, usuario, tipo FROM usuarios Where usuarios.tipo = tipos;
END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarUsuarios` ()   BEGIN 
SELECT usuario,tipo FROM usuarios Where us_Estatus <> 2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarUsuarios` (IN `id` INT)   BEGIN 
UPDATE usuarios SET us_Estatus = 2 WHERE id_usuario = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarUsuarios` (IN `nombre` VARCHAR(50), IN `clave` VARCHAR(50), IN `tipos` INT)   BEGIN
INSERT INTO usuarios(usuario, contrasena, tipo, us_Estatus) VALUES (nombre, clave, tipos,1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarUsuarioInsertar` (IN `usuarioUsa` INT)   BEGIN 
UPDATE logmovimientos SET id_usuario = usuarioUsa Where id_movimientos = (SELECT MAX(id_movimientos)FROM logmovimientos);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarUsuarios` (IN `id` INT, `nombre` VARCHAR(50), IN `clave` VARCHAR(50), IN `tipos` INT, IN `estatus` INT)   BEGIN 
IF(nombre <> "") THEN UPDATE usuarios SET usuarios.usuario = nombre WHERE usuarios.id_usuario = id;
END IF ;
IF (clave <> "") THEN UPDATE usuarios SET usuarios.contrasena = clave WHERE usuarios.id_usuario = id;
END IF ;
IF (tipos <> "") THEN UPDATE usuarios SET usuarios.tipo = tipos WHERE usuarios.id_usuario = id;
END IF ;
IF (estatus <> "") THEN UPDATE usuarios SET usuarios.us_Estatus = estatus WHERE usuarios.id_usuario = id;
END IF ;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `buscarUsuario` (`busqUsuario` VARCHAR(50), `busqContra` VARCHAR(50)) RETURNS TINYINT(1)  BEGIN
	DECLARE resultado int;
	SET resultado = (SELECT COUNT(usuarios.usuario) FROM usuarios WHERE usuarios.usuario = busqUsuario AND usuarios.contrasena = busqContra);
    IF(resultado = 1) THEN  RETURN TRUE;
    ELSE
    RETURN FALSE;
    END IF ;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `guardarUsuario` (`busqUsuario` VARCHAR(50), `busqContrasena` VARCHAR(50)) RETURNS INT(11)  BEGIN
	DECLARE resultado int;
	SET resultado = (SELECT id_usuario FROM usuarios WHERE usuarios.usuario = busqUsuario AND usuarios.contrasena = busqContrasena);
    RETURN resultado;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `estatus`
--

CREATE TABLE `estatus` (
  `id_tipoEstatus` int(11) NOT NULL,
  `tipo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `estatus`
--

INSERT INTO `estatus` (`id_tipoEstatus`, `tipo`) VALUES
(1, 'activo'),
(2, 'eliminado');

-- --------------------------------------------------------

--
-- Table structure for table `inventario`
--

CREATE TABLE `inventario` (
  `id_productos` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `año` int(4) NOT NULL,
  `modelo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` float(12,2) NOT NULL,
  `precio_venta` float(12,2) NOT NULL,
  `inv_Estatus` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `logmovimientos`
--

CREATE TABLE `logmovimientos` (
  `id_movimientos` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `cambio_generado` varchar(100) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logmovimientos`
--

INSERT INTO `logmovimientos` (`id_movimientos`, `id_usuario`, `cambio_generado`, `fecha`) VALUES
(1, 1, 'Se inserto un usuario', '2022-11-08 20:12:43');

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `empresa` varchar(50) NOT NULL,
  `telefono` int(10) NOT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) NOT NULL,
  `prov_Estatus` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tipocarro`
--

CREATE TABLE `tipocarro` (
  `id_tipoCarro` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tipousuarios`
--

CREATE TABLE `tipousuarios` (
  `id_tipoUsuario` int(11) NOT NULL,
  `tipo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipousuarios`
--

INSERT INTO `tipousuarios` (`id_tipoUsuario`, `tipo`) VALUES
(1, 'administra'),
(2, 'usuario'),
(3, 'desactivad');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(50) NOT NULL,
  `tipo` int(11) DEFAULT NULL,
  `us_Estatus` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `usuario`, `contrasena`, `tipo`, `us_Estatus`) VALUES
(1, 'Payi', 'Payi', 1, 2),
(2, 'Prueba', 'Prueba', 1, 2),
(3, 'Prueba2', 'Prueba2', 2, 2),
(4, 'Prueba3', 'Prueba3', 1, 1),
(5, 'Prueba4', 'Prueba4', 2, 1),
(6, 'Prueba5', 'Prueba5', 2, 1),
(7, 'Prueba6', 'Prueba6', 2, 1),
(8, 'Prueba7', 'Prueba7', 1, 1),
(9, 'Prueba8', 'Prueba8', 1, 1),
(10, 'Prueba9', 'Prueba9', 1, 1),
(11, 'Prueba10', 'Prueba10', 1, 1),
(12, 'Prueba11', 'Prueba11', 1, 1),
(13, 'Prueba12', 'Prueba12', 1, 1);

--
-- Triggers `usuarios`
--
DELIMITER $$
CREATE TRIGGER `ingresarMovimiento` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN 
INSERT INTO logmovimientos(cambio_generado, fecha) VALUES ("Se inserto un usuario", now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ingresarMovimientoEliminacionUsuario` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN 
INSERT INTO logmovimientos(cambio_generado, fecha) VALUES ("Se elimino un usuario.", now());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `venproductos`
--

CREATE TABLE `venproductos` (
  `id_venProd` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ventas`
--

CREATE TABLE `ventas` (
  `id_ventas` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_venProd` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `total` float(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `estatus`
--
ALTER TABLE `estatus`
  ADD PRIMARY KEY (`id_tipoEstatus`);

--
-- Indexes for table `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_productos`),
  ADD KEY `fk_productos` (`id_proveedor`),
  ADD KEY `fk_estatusInventario` (`inv_Estatus`),
  ADD KEY `fk_modelo` (`modelo`);

--
-- Indexes for table `logmovimientos`
--
ALTER TABLE `logmovimientos`
  ADD PRIMARY KEY (`id_movimientos`),
  ADD KEY `fk_usuarioMov` (`id_usuario`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`),
  ADD KEY `fk_estatus` (`prov_Estatus`);

--
-- Indexes for table `tipocarro`
--
ALTER TABLE `tipocarro`
  ADD PRIMARY KEY (`id_tipoCarro`);

--
-- Indexes for table `tipousuarios`
--
ALTER TABLE `tipousuarios`
  ADD PRIMARY KEY (`id_tipoUsuario`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `fk_tipo` (`tipo`),
  ADD KEY `fk_estatusUsuarios` (`us_Estatus`);

--
-- Indexes for table `venproductos`
--
ALTER TABLE `venproductos`
  ADD PRIMARY KEY (`id_venProd`,`id_producto`),
  ADD KEY `fk_producto` (`id_producto`);

--
-- Indexes for table `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_ventas`),
  ADD KEY `fk_venproductos` (`id_venProd`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `estatus`
--
ALTER TABLE `estatus`
  MODIFY `id_tipoEstatus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_productos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logmovimientos`
--
ALTER TABLE `logmovimientos`
  MODIFY `id_movimientos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipocarro`
--
ALTER TABLE `tipocarro`
  MODIFY `id_tipoCarro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipousuarios`
--
ALTER TABLE `tipousuarios`
  MODIFY `id_tipoUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_ventas` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_estatusInventario` FOREIGN KEY (`inv_Estatus`) REFERENCES `estatus` (`id_tipoEstatus`),
  ADD CONSTRAINT `fk_modelo` FOREIGN KEY (`modelo`) REFERENCES `tipocarro` (`id_tipoCarro`),
  ADD CONSTRAINT `fk_productos` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);

--
-- Constraints for table `logmovimientos`
--
ALTER TABLE `logmovimientos`
  ADD CONSTRAINT `fk_usuarioMov` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Constraints for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `fk_estatus` FOREIGN KEY (`prov_Estatus`) REFERENCES `estatus` (`id_tipoEstatus`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_estatusUsuarios` FOREIGN KEY (`us_Estatus`) REFERENCES `estatus` (`id_tipoEstatus`),
  ADD CONSTRAINT `fk_tipo` FOREIGN KEY (`tipo`) REFERENCES `tipousuarios` (`id_tipoUsuario`);

--
-- Constraints for table `venproductos`
--
ALTER TABLE `venproductos`
  ADD CONSTRAINT `fk_producto` FOREIGN KEY (`id_producto`) REFERENCES `inventario` (`id_productos`);

--
-- Constraints for table `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_venproductos` FOREIGN KEY (`id_venProd`) REFERENCES `venproductos` (`id_venProd`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
