-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2022 at 05:10 AM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarUsuarioModificacion` (IN `id` INT, IN `nombre` VARCHAR(50), IN `tipos` INT)   BEGIN
IF(id <> "") THEN SELECT id_usuario, usuario, contrasena, tipo, us_Estatus FROM usuarios Where usuarios.id_usuario = id;
END IF ;
IF(nombre <> "") THEN SELECT id_usuario, usuario, contrasena, tipo, us_Estatus FROM usuarios Where usuarios.usuario = nombre;
END IF ;
IF(tipos <> "") THEN SELECT id_usuario, usuario, contrasena, tipo, us_Estatus FROM usuarios Where usuarios.tipo = tipos;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Inventario_insertar` (IN `iiProv` INT, `iiNombre` VARCHAR(50), `iiAño` INT, `iiModelo` INT, `iiCantidad` INT, `iiPC` FLOAT, `iiPV` FLOAT)   BEGIN 
INSERT INTO inventario (id_proveedor, nombre, año, modelo, cantidad, precio_compra, precio_venta, inv_Estatus) VALUES (iiProv, iiNombre, iiAño, iiModelo, iiCantidad, iiPC, iiPV, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarUsuarioInsertar` (IN `usuarioUsa` INT)   BEGIN 
UPDATE logmovimientos SET id_usuario = usuarioUsa Where id_movimientos = (SELECT MAX(id_movimientos)FROM logmovimientos);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarUsuarioModificar` (IN `usuarioUsa` INT)   BEGIN 
UPDATE logmovimientos SET id_usuario = usuarioUsa, cambio_generado = "Se modifico un proveedor." Where id_movimientos = (SELECT MAX(id_movimientos)FROM logmovimientos);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `llenarUsuarioModificarUsuario` (IN `usuarioUsa` INT)   BEGIN 
UPDATE logmovimientos SET id_usuario = usuarioUsa, cambio_generado = "Se modifico un usuario." Where id_movimientos = (SELECT MAX(id_movimientos)FROM logmovimientos);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarUsuarios` (IN `id` INT, IN `nombre` VARCHAR(50), IN `clave` VARCHAR(50), IN `tipos` INT, IN `estatus` INT)   BEGIN 
UPDATE usuarios SET usuarios.usuario = nombre, usuarios.contrasena = clave, usuarios.tipo = tipos, usuarios.us_Estatus = estatus WHERE usuarios.id_usuario = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Producto_consultarEspecifico` (IN `bbid` INT, `bbnombre` VARCHAR(50), `bbproveedor` INT, `bbmodelo` INT)   BEGIN
IF(bbid <> "") THEN SELECT id_productos, id_proveedor, nombre, año, modelo, cantidad, precio_compra, precio_venta FROM inventario Where inventario.id_productos = bbid AND inventario.inv_Estatus <> 2;
END IF ;
IF(bbnombre <> "") THEN SELECT id_productos, id_proveedor, nombre, año, modelo, cantidad, precio_compra, precio_venta FROM inventario Where inventario.nombre = bbnombre AND inventario.inv_Estatus <> 2;
END IF ;
IF(bbproveedor <> "") THEN SELECT id_productos, id_proveedor, nombre, año, modelo, cantidad, precio_compra, precio_venta FROM inventario Where inventario.id_proveedor = bbproveedor AND inventario.inv_Estatus <> 2;
END IF ;
IF(bbmodelo <> "") THEN SELECT id_productos, id_proveedor, nombre, año, modelo, cantidad, precio_compra, precio_venta FROM inventario Where inventario.modelo = bbmodelo AND inventario.inv_Estatus <> 2;
END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Producto_consultarGeneral` ()   BEGIN
SELECT id_productos, id_proveedor, nombre, año, modelo, cantidad FROM inventario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Producto_eliminar` (IN `id` INT)   BEGIN 
UPDATE inventario SET inv_Estatus = 2 WHERE id_productos = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Producto_insertar` (IN `iiid_proveedor` INT, IN `iinombre` VARCHAR(50), IN `iiaño` INT, IN `iimodelo` INT, IN `iicantidad` INT, IN `iiprecio_compra` FLOAT, IN `iiprecio_venta` FLOAT, IN `iiinv_Estatus` INT)   BEGIN
INSERT INTO inventario(id_proveedor, nombre, año, modelo, cantidad, precio_compra, precio_venta, inv_Estatus) VALUES ( iiid_proveedor, iinombre, iiaño, iimodelo, iicantidad, iiprecio_compra, iiprecio_venta, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Producto_modificar` (IN `mmid` INT, `mmProveedor` INT, IN `mmNombre` VARCHAR(50), IN `mmAño` INT, IN `mmModelo` INT, IN `mmCantidad` INT, IN `mmPC` FLOAT, IN `mmPV` FLOAT)   BEGIN 
UPDATE inventario SET inventario.id_proveedor = mmProveedor, inventario.nombre = mmNombre, inventario.año = mmAño, inventario.modelo = mmModelo, inventario.cantidad = mmCantidad, inventario.precio_compra = mmPC, inventario.precio_venta = mmPV WHERE inventario.id_productos = mmid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proovedor_consultarEspecifico` (IN `ccId` INT, IN `ccEmpresa` VARCHAR(50), IN `ccDireccion` VARCHAR(50))   BEGIN
IF(ccId <> "") THEN SELECT id_proveedor, empresa, telefono, correo, direccion FROM proveedor Where proveedor.id_proveedor = ccid;
END IF ;
IF(ccEmpresa <> "") THEN SELECT id_proveedor, empresa, telefono, correo, direccion FROM proveedor Where proveedor.empresa = ccEmpresa;
END IF ;
IF(ccDireccion <> "") THEN SELECT id_proveedor, empresa, telefono, correo, direccion FROM proveedor Where proveedor.direccion = ccDireccion;
END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proovedor_consultarGeneral` ()   BEGIN 
SELECT empresa, correo, telefono FROM proveedor Where prov_Estatus <> 2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proovedor_eliminar` (IN `id` INT)   BEGIN 
UPDATE proveedor SET prov_Estatus = 2 WHERE id_proveedor = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proovedor_insertar` (IN `iiEmpresa` VARCHAR(50), `iiTelefono` INT, `iiCorreo` VARCHAR(50), `iiDireccion` VARCHAR(50))   BEGIN 
INSERT INTO proveedor (empresa, telefono, correo, direccion, prov_Estatus) VALUES (iiEmpresa, iiTelefono, iiCorreo, iiDireccion, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proovedor_modificar` (IN `id` INT, `mmEmpresa` VARCHAR(50), IN `mmTelefono` INT, IN `mmCorreo` VARCHAR(50), IN `mmDireccion` VARCHAR(50))   BEGIN 
UPDATE proveedor SET proveedor.empresa = mmEmpresa, proveedor.correo = mmEmpresa, proveedor.telefono = mmTelefono, proveedor.correo = mmCorreo, proveedor.direccion = mmDireccion WHERE proveedor.id_proveedor = id;
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

--
-- Dumping data for table `inventario`
--

INSERT INTO `inventario` (`id_productos`, `id_proveedor`, `nombre`, `año`, `modelo`, `cantidad`, `precio_compra`, `precio_venta`, `inv_Estatus`) VALUES
(2, 1, 'Ford F150', 2022, 9, 2, 200000.00, 500000.00, 1),
(3, 3, 'Prueba', 2022, 10, 1, 20000.00, 30000.00, 1),
(4, 1, 'Prueba2', 2, 10, 26, 26.00, 1.00, 1),
(5, 1, 'Payi', 2021, 1, 2, 30000.00, 40000.00, 1);

--
-- Triggers `inventario`
--
DELIMITER $$
CREATE TRIGGER `ingresarMovInventario` AFTER INSERT ON `inventario` FOR EACH ROW BEGIN 
INSERT INTO logmovimientos(cambio_generado, fecha) VALUES ("Se inserto un producto.", now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ingresarMovimientoEliminacionInventario` AFTER UPDATE ON `inventario` FOR EACH ROW BEGIN 
INSERT INTO logmovimientos(cambio_generado, fecha) VALUES ("Se elimino un producto.", now());
END
$$
DELIMITER ;

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
(1, 1, 'Se inserto un usuario', '2022-11-08 20:12:43'),
(2, 1, 'Se inserto un proveedor', '2022-11-21 21:01:27'),
(3, 1, 'Se modifico un proveedor.', '2022-11-21 21:01:53'),
(4, NULL, 'Se elimino un usuario.', '2022-11-21 21:37:23'),
(5, NULL, 'Se elimino un usuario.', '2022-11-21 21:37:24'),
(6, NULL, 'Se elimino un usuario.', '2022-11-21 21:37:24'),
(7, 1, 'Se modifico un usuario.', '2022-11-21 21:37:24'),
(8, NULL, 'Se elimino un usuario.', '2022-11-21 21:43:33'),
(9, NULL, 'Se elimino un usuario.', '2022-11-21 21:43:33'),
(10, NULL, 'Se elimino un usuario.', '2022-11-21 21:43:33'),
(11, 1, 'Se modifico un usuario.', '2022-11-21 21:43:33'),
(12, 1, 'Se modifico un usuario.', '2022-11-21 21:50:58'),
(13, NULL, 'Se inserto un producto.', '2022-11-22 19:45:19'),
(14, NULL, 'Se inserto un producto.', '2022-11-22 19:48:08'),
(15, NULL, 'Se inserto un producto.', '2022-11-22 20:55:40'),
(16, NULL, 'Se elimino un producto.', '2022-11-22 21:57:12'),
(17, NULL, 'Se elimino un producto.', '2022-11-22 21:59:04'),
(18, NULL, 'Se inserto un producto.', '2022-11-22 22:09:29');

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

--
-- Dumping data for table `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `empresa`, `telefono`, `correo`, `direccion`, `prov_Estatus`) VALUES
(1, 'Ford', 2147483647, 'ford@gmail.com', 'Av.Ford', 2),
(2, 'Nissan', 2147483647, 'Nissan@gmail.com', 'Av.Nissan', 1),
(3, 'Peugeot', 2147483647, 'peugeot@gmail.com', 'Av.Peugeot', 1);

--
-- Triggers `proveedor`
--
DELIMITER $$
CREATE TRIGGER `ingresarMovProv` AFTER INSERT ON `proveedor` FOR EACH ROW BEGIN 
INSERT INTO logmovimientos(cambio_generado, fecha) VALUES ("Se inserto un proveedor", now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ingresarMovimientoEliminacionProv` AFTER UPDATE ON `proveedor` FOR EACH ROW BEGIN 
INSERT INTO logmovimientos(cambio_generado, fecha) VALUES ("Se elimino un proveedor.", now());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tipocarro`
--

CREATE TABLE `tipocarro` (
  `id_tipoCarro` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipocarro`
--

INSERT INTO `tipocarro` (`id_tipoCarro`, `tipo`) VALUES
(1, 'SUV'),
(2, 'Hatchback'),
(3, 'Crossover'),
(4, 'Convertible'),
(5, 'Sedan'),
(6, 'Sports_Car'),
(7, 'Coupe'),
(8, 'Minivan'),
(9, 'Station_Wagon'),
(10, 'Pickup');

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
(2, 'Modificacion3', 'Modificacion3', 1, 2),
(3, 'Prueba2', 'Prueba2', 2, 2),
(4, 'Prueba3', 'Prueba3', 1, 1),
(5, 'SegundaModificacion', 'SegundaModificacion', 2, 1),
(6, 'Prueba5', 'Prueba5', 2, 1),
(7, 'PruebaModificada', 'Modificacion', 2, 1),
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
  MODIFY `id_productos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `logmovimientos`
--
ALTER TABLE `logmovimientos`
  MODIFY `id_movimientos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tipocarro`
--
ALTER TABLE `tipocarro`
  MODIFY `id_tipoCarro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
