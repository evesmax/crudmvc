-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-12-2022 a las 21:46:49
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `ventasTotal` ()   BEGIN 
SELECT ventasTotal();
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

CREATE DEFINER=`root`@`localhost` FUNCTION `ventasTotal` () RETURNS VARCHAR(30) CHARSET utf8mb4  BEGIN 
	DECLARE cant INT;
	DECLARE totalV FLOAT;
	DECLARE cost FLOAT;
	DECLARE idP INT;
        DECLARE idV INT;
    SET idV = (SELECT MAX(idOrden) FROM ventas);
    SET idP = (SELECT idProducto FROM ventas WHERE idOrden = idV);
    SET cost = (SELECT costo FROM productos WHERE productos.idProducto = idP);
    SET cant = (SELECT cantidad FROM ventas WHERE idOrden = idV);
    SET totalV = cost * cant;
    UPDATE ventas SET costoUnitario = cost  WHERE idOrden = idV;
    UPDATE ventas SET total = totalV WHERE idOrden = idV;
    RETURN "Venta modificada";
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
(3, '2022-11-05', 1, 3, 20, 'Entrada'),
(4, '2022-11-21', 1, 3, 5, 'Salida'),
(5, '2022-11-21', 1, 1, 5, 'Salida'),
(6, '2022-11-21', 1, 3, 7, 'Salida'),
(7, '2022-11-21', 1, 1, 12, 'Entrada'),
(8, '2022-11-22', 1, 2, 3, 'Entrada'),
(9, '2022-11-22', 1, 2, 2, 'Entrada'),
(10, '2022-11-25', 1, 15, 9, 'Entrada'),
(11, '2022-11-25', 1, 14, 5, 'Entrada'),
(12, '2022-11-25', 1, 14, 9, 'Entrada'),
(13, '2022-11-25', 1, 4, 1, 'Entrada'),
(14, '2022-11-25', 1, 3, 5, 'Salida'),
(15, '2022-11-27', 1, 8, 20, 'ENTRADA'),
(16, '2022-11-27', 1, 8, 10, 'Salida'),
(17, '2022-11-27', 1, 8, 2, 'Salida'),
(18, '2022-11-27', 1, 8, 2, 'Salida'),
(19, '2022-11-27', 1, 8, 2, 'Salida'),
(20, '2022-11-28', 1, 8, 1, 'Salida'),
(21, '2022-11-28', 1, 2, 2, 'Salida'),
(22, '2022-11-28', 1, 3, 5, 'Salida'),
(23, '2022-11-28', 1, 15, 3, 'Salida'),
(24, '2022-11-28', 1, 8, 1, 'Salida'),
(25, '2022-11-28', 1, 15, 5, 'Salida'),
(26, '2022-11-28', 1, 1, 4, 'Salida'),
(27, '2022-11-30', 1, 4, 10, 'Entrada'),
(28, '2022-11-30', 1, 3, 3, 'Salida'),
(29, '2022-11-30', 1, 3, 1, 'Salida'),
(30, '2022-11-30', 1, 1, 2, 'Salida'),
(31, '2022-11-30', 1, 1, 1, 'Salida'),
(32, '2022-11-30', 1, 1, 1, 'Salida'),
(33, '2022-11-30', 1, 2, 1, 'Salida'),
(34, '2022-11-30', 1, 2, 2, 'Salida'),
(35, '2022-11-30', 1, 2, 1, 'Salida'),
(36, '2022-11-30', 1, 1, 1, 'Salida'),
(37, '2022-11-30', 1, 2, 2, 'Salida'),
(38, '2022-11-30', 1, 3, 1, 'Salida'),
(39, '2022-12-01', 1, 1, 1, 'Salida'),
(40, '2022-12-01', 1, 3, 1, 'Salida'),
(41, '2022-12-01', 1, 3, 1, 'Salida'),
(42, '2022-12-01', 1, 3, 1, 'Salida'),
(43, '2022-12-01', 1, 3, 2, 'Salida'),
(44, '2022-12-01', 1, 3, 1, 'Salida'),
(45, '2022-12-01', 1, 2, 10, 'Entrada'),
(46, '2022-12-01', 1, 2, 10, 'Entrada'),
(47, '2022-12-01', 1, 2, 10, 'Salida'),
(48, '2022-12-01', 1, 1, 2, 'Salida');

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
  			UPDATE inventario_saldos SET total_entradas = total_entradas + @cantidad WHERE @idProd = idProducto;
    		UPDATE inventario_saldos SET saldo = total_entradas - total_salidas WHERE @idProd = idProducto;
    	ELSEIF @tipo = "Salida" THEN
    		UPDATE inventario_saldos SET total_salidas = total_salidas + @cantidad WHERE @idProd = idProducto;
    		UPDATE inventario_saldos SET saldo = total_entradas - total_salidas WHERE @idProd = idProducto;
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
(1, 1, 1, 36, 34, 2),
(2, 1, 2, 51, 40, 11),
(3, 1, 3, 46, 38, 8),
(4, 1, 15, 18, 13, 5),
(5, 1, 14, 14, 5, 9),
(6, 1, 4, 11, 5, 6),
(7, 1, 8, 20, 18, 2);

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
(1, 'Queso de Fundir 1kg', 130, 'ACTIVO'),
(2, 'Adobera Queso de Mesa 1kg', 120, 'ACTIVO'),
(3, 'Queso Panela 1kg', 80, 'ACTIVO'),
(4, 'Requeson 1kg', 65.5, 'ACTIVO'),
(5, 'Queso Cotija', 130, 'INACTIVO'),
(6, '', 0, 'INACTIVO'),
(7, 'Queso oaxaca', 120, 'INACTIVO'),
(8, 'Crema 1Kg', 80, 'ACTIVO'),
(9, 'Leche 1L', 12, 'INACTIVO'),
(10, 'Leche 2L', 30, 'INACTIVO'),
(11, 'Crema agria 1l', 100, 'INACTIVO'),
(12, 'Leche 1L', 12, 'INACTIVO'),
(13, 'Queso Azul', 201, 'INACTIVO'),
(14, 'Queso Añejo', 130, 'INACTIVO'),
(15, 'Queso Fundir 1/4Kg', 120, 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `totalventas`
--

CREATE TABLE `totalventas` (
  `idVenta` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `bodega` int(11) NOT NULL,
  `total` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `totalventas`
--

INSERT INTO `totalventas` (`idVenta`, `fecha`, `bodega`, `total`) VALUES
(2, '2022-11-28', 1, 700),
(3, '2022-11-28', 1, 1080),
(4, '2022-11-30', 1, 240),
(5, '2022-11-30', 1, 80),
(6, '2022-11-30', 1, 240),
(7, '2022-11-30', 1, 120),
(8, '2022-11-30', 1, 120),
(9, '2022-11-30', 1, 120),
(10, '2022-11-30', 1, 1000),
(11, '2022-12-01', 1, 160),
(12, '2022-12-01', 1, 240),
(13, '2022-12-01', 1, 1460);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idOrden` int(11) NOT NULL,
  `idVenta` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `bodega` int(11) DEFAULT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costoUnitario` float DEFAULT 0,
  `total` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idOrden`, `idVenta`, `fecha`, `bodega`, `idProducto`, `cantidad`, `costoUnitario`, `total`) VALUES
(1, 1, '2022-11-28', 1, 2, 2, 120, 240),
(2, 1, '2022-11-28', 1, 3, 5, 80, 400),
(3, 2, '2022-11-28', 1, 15, 3, 120, 360),
(4, 2, '2022-11-28', 1, 14, 2, 130, 260),
(5, 2, '2022-11-28', 1, 8, 1, 80, 80),
(6, 3, '2022-11-28', 1, 15, 5, 120, 600),
(7, 3, '2022-11-28', 1, 1, 4, 120, 480),
(8, 4, '2022-11-30', 1, 3, 3, 80, 240),
(9, 5, '2022-11-30', 1, 3, 1, 80, 80),
(10, 6, '2022-11-30', 1, 1, 2, 120, 240),
(11, 7, '2022-11-30', 1, 1, 1, 120, 120),
(12, 8, '2022-11-30', 1, 1, 1, 120, 120),
(13, 9, '2022-11-30', 1, 2, 1, 120, 120),
(14, 10, '2022-11-30', 1, 2, 2, 120, 240),
(15, 10, '2022-11-30', 1, 2, 1, 120, 120),
(16, 10, '2022-11-30', 1, 1, 1, 120, 120),
(17, 10, '2022-11-30', 1, 2, 2, 120, 240),
(18, 10, '2022-11-30', 1, 3, 1, 80, 80),
(19, 10, '2022-12-01', 1, 1, 1, 120, 120),
(20, 10, '2022-12-01', 1, 3, 1, 80, 80),
(21, 11, '2022-12-01', 1, 3, 1, 80, 80),
(22, 11, '2022-12-01', 1, 3, 1, 80, 80),
(23, 12, '2022-12-01', 1, 3, 2, 80, 160),
(24, 12, '2022-12-01', 1, 3, 1, 80, 80),
(25, 13, '2022-12-01', 1, 2, 10, 120, 1200),
(26, 13, '2022-12-01', 1, 1, 2, 130, 260);

--
-- Disparadores `ventas`
--
DELIMITER $$
CREATE TRIGGER `insertarVentasTotal` AFTER UPDATE ON `ventas` FOR EACH ROW BEGIN
  SET @idOrden = NEW.idOrden;
  SET @idVenta = NEW.idVenta;
  SET @idProducto = NEW.idProducto;
  SET @idV = (SELECT idVenta FROM totalventas WHERE idVenta = @idVenta);
  SET @estat = (SELECT estatus FROM productos WHERE idProducto = @idProducto);
  IF @estat = "ACTIVO" THEN
    SET @fecha = (SELECT fecha FROM ventas WHERE @idProducto = idProducto AND @idOrden = idOrden);
  	SET @salidas = (SELECT cantidad FROM ventas WHERE @idProducto = idProducto AND @idOrden = idOrden);
   	SET @bodega = (SELECT bodega FROM ventas WHERE @idProducto = idProducto AND @idOrden = idOrden);
	SET @saldo = (SELECT saldo FROM inventario_saldos WHERE @idProducto = idProducto);
	IF @salidas <= @saldo THEN
    	IF @idVenta = @idV THEN
	    SET @totalV = (SELECT SUM(total) FROM ventas WHERE idVenta = @idVenta);
            UPDATE totalventas SET total = @totalV WHERE idVenta = @idVenta;
        ELSE
        	SET @total = (SELECT total FROM ventas WHERE idOrden = @idOrden);
        	INSERT INTO totalventas(idVenta, fecha, bodega, total) 
            VALUES (@idVenta, @fecha, @bodega, @total);
        END IF;
	END IF;
   END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `registrarInventarioMovimientosVentas` AFTER INSERT ON `ventas` FOR EACH ROW BEGIN
  SET @idOrden = NEW.idOrden;
  SET @idProducto = NEW.idProducto;
  SET @estat = (SELECT estatus FROM productos WHERE idProducto = @idProducto);
  IF @estat = "ACTIVO" THEN
  	SET @Id = (SELECT idProducto FROM ventas WHERE @idProducto = idProducto AND idOrden = @idOrden);
        SET @fecha = (SELECT fecha FROM ventas WHERE @idProducto = idProducto AND idOrden = @idOrden);
  	SET @salidas = (SELECT cantidad FROM ventas WHERE @idProducto = idProducto AND idOrden = @idOrden);
    	SET @bodega = (SELECT bodega FROM ventas WHERE @idProducto = idProducto AND idOrden = @idOrden);
	SET @saldo = (SELECT saldo FROM inventario_saldos WHERE @idProducto = idProducto);
	IF @salidas <= @saldo THEN
  		INSERT INTO inventario_movimientos(fecha, bodega, idProducto, cantidad, tipo) 
  		VALUES (@fecha, @bodega, @Id, @salidas, 'Salida');
	END IF;
   END IF;
END
$$
DELIMITER ;

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
-- Indices de la tabla `totalventas`
--
ALTER TABLE `totalventas`
  ADD PRIMARY KEY (`idVenta`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idOrden`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  MODIFY `idMovimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `inventario_saldos`
--
ALTER TABLE `inventario_saldos`
  MODIFY `idSaldo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idOrden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;