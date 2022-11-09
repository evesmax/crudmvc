

CREATE DATABASE IF NOT EXISTS `lamanzanilla_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `lamanzanilla_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
  idProducto int(10) NOT NULL AUTO_INCREMENT,
  nomprod varchar(100) DEFAULT NULL,
  cantidad int DEFAULT NULL,
  costo double(5,2) DEFAULT NULL,
  precio double(5,2) DEFAULT NULL,
  descrip varchar(200) DEFAULT NULL,
  peso float DEFAULT NULL,
  PRIMARY KEY(idProducto)
);

-- Estructura de tabla para la tabla `ventas`

DROP TABLE IF EXISTS ventas;
CREATE TABLE ventas (
  fecha datetime NOT NULL,
  bodega int DEFAULT NULL,
  idProducto int NOT NULL,
  cantidad int NOT NULL,
  costoUnitario float NOT NULL,
  total float DEFAULT 0
);

-- Estructura de tabla para la tabla `inventario`

DROP TABLE IF EXISTS inventario_movimientos;
CREATE TABLE inventario_movimientos (
  idMovimiento INT NOT NULL AUTO_INCREMENT,
  fecha datetime DEFAULT NULL,
  bodega int DEFAULT NULL,
  idProducto int DEFAULT NULL,
  cantidad int DEFAULT NULL,
  tipo VARCHAR(20) DEFAULT NULL,
  peso float DEFAULT NULL,
  activo TINYINT(1),
  PRIMARY KEY (idMovimiento)
);

DROP TABLE IF EXISTS inventario_saldos;
CREATE TABLE inventario_saldos (
  bodega int DEFAULT NULL,
  idProducto int NOT NULL,
  total_entradas int NOT NULL,
  total_salidas int NOT NULL,
  saldo int NOT NULL
);

-- Estructura de tabla para la tabla `proveedoresLeche`

DROP TABLE IF EXISTS proveedoresLeche;
CREATE TABLE proveedoresLeche (
  idProveedor int(10) NOT NULL AUTO_INCREMENT,
  nomProv varchar(100) DEFAULT NULL,
  precioLitro double(2,2) DEFAULT NULL,
  PRIMARY KEY(idProveedor)
);

-- Estructura de tabla para la tabla `reporteDiarioLeche`

DROP TABLE IF EXISTS reporteDiarioLeche;
CREATE TABLE reporteDiarioLeche (
  idProveedor int(10) NOT NULL,
  dia VARCHAR(20) DEFAULT NULL,
  fecha datetime DEFAULT NULL,
  cantidadLeche int DEFAULT 0
);

-- Estructura de tabla para la tabla `totalVentas`

DROP TABLE IF EXISTS totalVentas;
CREATE TABLE totalVentas (
  prod varchar(50) DEFAULT NULL,
  cantidad int DEFAULT NULL,
  precio int DEFAULT NULL,
  total double(10,2) DEFAULT NULL
);

--
-- Llaves primarias y foraneas
--

ALTER TABLE inventario_movimientos ADD CONSTRAINT `fk_inventarioMov_producto` 
FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

ALTER TABLE inventario_saldos ADD CONSTRAINT `fk_inventarioMov_Sal` 
FOREIGN KEY (`idProducto`) REFERENCES `inventario_movimientos` (`idProducto`);

ALTER TABLE ventas ADD CONSTRAINT `fk_inventarioMov_ventas` 
FOREIGN KEY (`idProducto`) REFERENCES `inventario_movimientos` (`idProducto`);



ALTER TABLE inventario_movimientos DROP FOREIGN KEY `fk_inventarioMov_producto`;

ALTER TABLE inventario_saldos DROP FOREIGN KEY `fk_inventarioMov_Sal`;

ALTER TABLE ventas DROP FOREIGN KEY `fk_inventarioMov_ventas`;

------Funciones-------

DROP FUNCTION IF EXISTS bajaProducto;
DELIMITER ;;
CREATE FUNCTION `bajaProducto`(idProducto INT)
	RETURNS VARCHAR(10)
BEGIN 
    UPDATE productos SET estatus = "INACTIVO" WHERE productos.idProducto = idProducto;
    RETURN "Dado de baja";
END ;;
DELIMITER ;



DROP FUNCTION IF EXISTS modificarProducto;
DELIMITER ;;
CREATE FUNCTION `modificarProducto`(idProducto INT, nombreProd VARCHAR(30), costoProd FLOAT)
	RETURNS VARCHAR(30)
BEGIN 
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
END ;;
DELIMITER ;


----Triger inventario_movimientos
/*DROP TRIGGER IF EXISTS registrarInventarioMovimientos;
DELIMITER ;;
CREATE TRIGGER `registrarInventarioMovimientos` AFTER INSERT ON `productos` FOR EACH ROW 
BEGIN
  SET @idProducto = NEW.idProducto;
  SET @Id = (SELECT @idProducto AS idProducto FROM productos WHERE @idProducto = idProducto);
  SET @cantidad = (SELECT cantidad FROM productos WHERE @idProducto = idProducto);
  SET @peso = (SELECT peso FROM productos WHERE @idProducto = idProducto);
  INSERT INTO inventario_movimientos(fecha, bodega, idProducto, cantidad, tipo, peso) 
  VALUES (now(), 1, @Id, @cantidad, "Entrada", @peso);
END ;;
DELIMITER ;

DROP TRIGGER IF EXISTS registrarProductoInventarioSaldos;
DELIMITER ;;
CREATE TRIGGER `registrarProductoInventarioSaldos` AFTER INSERT ON `productos` FOR EACH ROW 
BEGIN
  SET @idProducto = NEW.idProducto;
  SET @idInvProd = (SELECT idProducto FROM inventario_saldos WHERE @idProducto = idProducto);
  IF @idProducto = @idInvProd THEN
  	UPDATE inventario_saldos SET total_entradas = total_entradas + cantidad WHERE @idProducto = @idInvProd;
    UPDATE inventario_saldos SET saldo = total_entradas - total_salidas WHERE @idProducto = @idInvProd;
  ELSE
  	SET @Id = (SELECT @idProducto AS idProducto FROM productos WHERE @idProducto = idProducto);
  	SET @entradas = (SELECT cantidad FROM productos WHERE @idProducto = idProducto);
  	INSERT INTO inventario_saldos(bodega, idProducto, total_entradas, total_salidas, saldo) 
  	VALUES (1, @Id, @entradas, 0, @entradas);
  END IF;
END ;;
DELIMITER ;*/



------Procedures-----

DROP PROCEDURE IF EXISTS altaProducto;
DELIMITER ;;
CREATE PROCEDURE `altaProducto`(IN nombreProd VARCHAR(30), IN costoProd FLOAT)
BEGIN 
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
END ;;
DELIMITER ;

CALL altaProducto('Leche 1L', 30.50);
CALL altaProducto('Galletas', 15);
CALL altaProducto('Jabon', 20.50);

DROP PROCEDURE IF EXISTS bajaProducto;
DELIMITER ;;
CREATE PROCEDURE `bajaProducto`(IN idProd INT)
BEGIN 
	SELECT bajaProducto(idProd);
END ;;
DELIMITER ;

CALL bajaProducto(1);


DROP PROCEDURE IF EXISTS modificarProducto;
DELIMITER ;;
CREATE PROCEDURE `modificarProducto`(IN idProd INT, IN nombreProd VARCHAR(30), costoProd FLOAT)
BEGIN 
    SELECT modificarProducto(idProd, nombreProd, costoProd);
END ;;
DELIMITER ;

CALL modificarProducto(1, 'Harina', 70.0);

---------INSERTAR VALORES------------

INSERT INTO productos (nomprod, cantidad, costo, precio, descrip, peso) 
VALUES ('Adobera de mesa',5,  80.0, 120.0, 'Adobera de mesa de 1 kg', 1);

INSERT INTO productos (nomprod, cantidad, costo, precio, descrip, peso) 
VALUES ('Adobera de fundir',10,  90.0, 130.0, 'Adobera de fundir de 1/2 kg', 0.5);

INSERT INTO productos (nomprod, cantidad, costo, precio, descrip, peso) 
VALUES ('Queso Panela', 10,  40.0, 60.0, 'Queso panela de 1/2 kg', 0.5);

INSERT INTO productos (nomprod, cantidad, costo, precio, descrip, peso) 
VALUES ('Queso Cotija', 8,  110.0, 130.0, 'Queso Cotija de 15 kg', 15);

