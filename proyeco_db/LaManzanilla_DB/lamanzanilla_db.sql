-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-11-2022 a las 05:13:02
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lamanzanilla_db`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `altaProducto` (IN `nombreProd` VARCHAR(30), IN `costoProd` FLOAT)   BEGIN 
	DECLARE cont INT UNSIGNED;
    DECLARE name VARCHAR(30);
	SET cont = (SELECT COUNT(*) FROM productos);
    IF cont = 0 THEN 
		INSERT INTO productos (nombre, costo) VALUES (nombreProd, costoProd);
    ELSE
    	SET name = (SELECT nombre FROM productos WHERE productos.nombre = nombreProd);
        IF nombreProd = name THEN 
    		UPDATE productos SET estatus = "ACTIVO" WHERE productos.nombre = nombreProd;
        ELSE
        	INSERT INTO productos (nombre, costo) VALUES (nombreProd, costoProd);
    	END IF;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bajaProducto` (IN `idProd` INT)   BEGIN 
	SELECT bajaProducto(idProd);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarProducto` (IN `idProd` INT, IN `nombreProd` VARCHAR(30), `costoProd` FLOAT)   BEGIN 
    SELECT modificarProducto(idProd, nombreProd, costoProd);
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `bajaProducto` (`idProducto` INT) RETURNS VARCHAR(10) CHARSET utf8mb4  BEGIN 
    UPDATE productos SET estatus = "INACTIVO" WHERE productos.idProducto = idProducto;
    RETURN "Dado de baja";
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `modificarProducto` (`idProducto` INT, `nombreProd` VARCHAR(30), `costoProd` FLOAT) RETURNS VARCHAR(30) CHARSET utf8mb4  BEGIN 
	DECLARE prod INT UNSIGNED;
	SET prod = (SELECT idProducto FROM productos WHERE productos.idProducto = idProducto);
    
	IF idProducto = prod THEN 
    	IF nombreProd != "" THEN
			UPDATE productos SET nombre = nombreProd WHERE productos.idProducto = idProducto;
		END IF;
        IF costoProd != 0 THEN
        	UPDATE productos SET costo = costoProd WHERE productos.idProducto = idProducto;
        END IF;
	END IF;
    RETURN "Producto modificado";
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_movimientos`
--

CREATE TABLE `inventario_movimientos` (
  `idMovimiento` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `bodega` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `tipo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inventario_movimientos`
--

INSERT INTO `inventario_movimientos` (`idMovimiento`, `fecha`, `bodega`, `idProducto`, `cantidad`, `tipo`) VALUES
(1, '2022-11-05', 1, 1, 10, 'Entrada'),
(2, '2022-11-05', 1, 2, 5, 'Entrada'),
(3, '2022-11-05', 1, 3, 20, 'Entrada');

--
-- Disparadores `inventario_movimientos`
--
DELIMITER $$
CREATE TRIGGER `registrarInventarioSaldos` AFTER INSERT ON `inventario_movimientos` FOR EACH ROW BEGIN
  SET @idMovimiento = NEW.idMovimiento;
  SET @idProducto = NEW.idProducto;
  SET @idProd = (SELECT idProducto FROM inventario_saldos WHERE @idProducto = idProducto);
  SET @estat = (SELECT estatus FROM productos WHERE idProducto = @idProducto);
  IF @estat = "ACTIVO" THEN
  	IF @idProducto = @idProd THEN
  		SET @cantidad = (SELECT cantidad FROM inventario_movimientos WHERE @idProducto = idProducto AND @idMovimiento = idMovimiento);
    	SET @tipo = (SELECT tipo FROM inventario_movimientos WHERE @idProducto = idProducto AND @idMovimiento = idMovimiento);
    	IF @tipo = "Entrada" THEN 
  			UPDATE inventario_saldos SET total_entradas = total_entradas + @cantidad WHERE @idProducto = @idProd;
    		UPDATE inventario_saldos SET saldo = total_entradas - total_salidas WHERE @idProducto = @idProd;
    	ELSEIF @tipo = "Salida" THEN
    		UPDATE inventario_saldos SET total_salidas = total_salidas + @cantidad WHERE @idProducto = @idProd;
    		UPDATE inventario_saldos SET saldo = total_entradas - total_salidas WHERE @idProducto = @idProd;
    	END IF;
  	ELSE
  		SET @Id = (SELECT idProducto FROM inventario_movimientos WHERE @idProducto = idProducto);
  		SET @entradas = (SELECT cantidad FROM inventario_movimientos WHERE @idProducto = idProducto);
    	SET @bodega = (SELECT bodega FROM inventario_movimientos WHERE @idProducto = idProducto);
  		INSERT INTO inventario_saldos(bodega, idProducto, total_entradas, total_salidas, saldo) 
  		VALUES (@bodega, @Id, @entradas, 0, @entradas);
  	END IF;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_saldos`
--

CREATE TABLE `inventario_saldos` (
  `idSaldo` int(11) NOT NULL,
  `bodega` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `total_entradas` int(11) DEFAULT 0,
  `total_salidas` int(11) DEFAULT 0,
  `saldo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inventario_saldos`
--

INSERT INTO `inventario_saldos` (`idSaldo`, `bodega`, `idProducto`, `total_entradas`, `total_salidas`, `saldo`) VALUES
(1, 1, 1, 10, 0, 10),
(2, 1, 2, 5, 0, 5),
(3, 1, 3, 20, 0, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `costo` float NOT NULL,
  `estatus` varchar(10) DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProducto`, `nombre`, `costo`, `estatus`) VALUES
(1, 'Queso de Fundir 1kg', 120, 'ACTIVO'),
(2, 'Adobera Queso de Mesa 1k', 120, 'ACTIVO'),
(3, 'Queso Panela 1kg', 75.5, 'ACTIVO'),
(4, 'Requeson 1kg', 65.5, 'ACTIVO'),
(5, 'Queso Cotija', 130, 'INACTIVO'),
(6, '', 0, 'INACTIVO'),
(7, 'Queso oaxaca', 120, 'INACTIVO'),
(8, 'Crema 1L', 80, 'ACTIVO'),
(9, 'Leche 1L', 12, 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedoresleche`
--

CREATE TABLE `proveedoresleche` (
  `idProveedor` int(10) NOT NULL,
  `nomProv` varchar(100) DEFAULT NULL,
  `precioLitro` double(2,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportediarioleche`
--

CREATE TABLE `reportediarioleche` (
  `idProveedor` int(10) NOT NULL,
  `dia` varchar(20) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `cantidadLeche` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `totalventas`
--

CREATE TABLE `totalventas` (
  `prod` varchar(50) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL,
  `total` double(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idVenta` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `bodega` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costoUnitario` float DEFAULT 0,
  `total` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD PRIMARY KEY (`idMovimiento`),
  ADD KEY `fk_inventarioMov_producto` (`idProducto`);

--
-- Indices de la tabla `inventario_saldos`
--
ALTER TABLE `inventario_saldos`
  ADD PRIMARY KEY (`idSaldo`),
  ADD KEY `fk_inventarioMov_Sal` (`idProducto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`);

--
-- Indices de la tabla `proveedoresleche`
--
ALTER TABLE `proveedoresleche`
  ADD PRIMARY KEY (`idProveedor`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idVenta`),
  ADD KEY `fk_inventarioMov_ventas` (`idProducto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  MODIFY `idMovimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inventario_saldos`
--
ALTER TABLE `inventario_saldos`
  MODIFY `idSaldo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `proveedoresleche`
--
ALTER TABLE `proveedoresleche`
  MODIFY `idProveedor` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idVenta` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD CONSTRAINT `fk_inventarioMov_producto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

--
-- Filtros para la tabla `inventario_saldos`
--
ALTER TABLE `inventario_saldos`
  ADD CONSTRAINT `fk_inventarioMov_Sal` FOREIGN KEY (`idProducto`) REFERENCES `inventario_movimientos` (`idProducto`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_inventarioMov_ventas` FOREIGN KEY (`idProducto`) REFERENCES `inventario_movimientos` (`idProducto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
