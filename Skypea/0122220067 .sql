-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
DROP DATABASE IF EXISTS skypea;
CREATE DATABASE skypea;
use skypea;

-- Host: 34.211.237.34    Database: skypea
-- ------------------------------------------------------
-- Server version	5.5.62-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos` (
  `id_alumno` int(10) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(40) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `fecha_nac` date NOT NULL,
  `carrera` varchar(30) NOT NULL,
  `semestre` int(11) NOT NULL,
  `num_materias` int(2) NOT NULL,
  `tipo_curso` int(11) NOT NULL,
  `colegiatura` float NOT NULL,
  `estado` varchar(40) NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_alumno`),
  KEY `semestre` (`semestre`),
  KEY `tipo_curso` (`tipo_curso`),
  CONSTRAINT `alumnos_ibfk_1` FOREIGN KEY (`semestre`) REFERENCES `semestres` (`id_semestre`),
  CONSTRAINT `alumnos_ibfk_2` FOREIGN KEY (`tipo_curso`) REFERENCES `cursos` (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnos`
--

LOCK TABLES `alumnos` WRITE;
/*!40000 ALTER TABLE `alumnos` DISABLE KEYS */;
INSERT INTO `alumnos` VALUES (5,'Fernando ','Delgadillo','2022-12-20','Mecatronica',3,2,2,10600,'activo'),(6,'Paola','YaÃ±ez','2022-12-12','Arquitectura',3,0,1,0,'activo');
/*!40000 ALTER TABLE `alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asignacion_carga`
--

DROP TABLE IF EXISTS `asignacion_carga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignacion_carga` (
  `id_alumno` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `fecha_asignacion` datetime DEFAULT NULL,
  KEY `id_alumno` (`id_alumno`),
  KEY `id_materia` (`id_materia`),
  CONSTRAINT `asignacion_carga_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`) ON DELETE CASCADE,
  CONSTRAINT `asignacion_carga_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignacion_carga`
--

LOCK TABLES `asignacion_carga` WRITE;
/*!40000 ALTER TABLE `asignacion_carga` DISABLE KEYS */;
INSERT INTO `asignacion_carga` VALUES (5,14,'2022-12-02 07:26:44'),(5,7,'2022-12-02 07:27:01');
/*!40000 ALTER TABLE `asignacion_carga` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usUniva`@`%%`*/ /*!50003 trigger sumamaterias after insert on asignacion_carga for each row
begin
set @x = (select costo_materia from materias where id_materia = new.id_materia);
update alumnos set num_materias = alumnos.num_materias + 1 where id_alumno = new.id_alumno;
update alumnos set colegiatura = alumnos.colegiatura + @x where id_alumno = new.id_alumno ;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usUniva`@`%%`*/ /*!50003 trigger restamaterias after delete on asignacion_carga for each row
begin
set @x = (select costo_materia from materias where id_materia = old.id_materia);
update alumnos set num_materias = alumnos.num_materias - 1 where alumnos.id_alumno = old.id_alumno;
update alumnos set colegiatura = alumnos.colegiatura - @x where alumnos.id_alumno = old.id_alumno;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cuentas_por_cobrar`
--

DROP TABLE IF EXISTS `cuentas_por_cobrar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas_por_cobrar` (
  `id_alumno` int(10) NOT NULL,
  `semestre` int(11) NOT NULL,
  `total_pago` decimal(10,0) NOT NULL,
  KEY `id_alumno` (`id_alumno`),
  KEY `semestre` (`semestre`),
  CONSTRAINT `cuentas_por_cobrar_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`),
  CONSTRAINT `cuentas_por_cobrar_ibfk_2` FOREIGN KEY (`semestre`) REFERENCES `semestres` (`id_semestre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_por_cobrar`
--

LOCK TABLES `cuentas_por_cobrar` WRITE;
/*!40000 ALTER TABLE `cuentas_por_cobrar` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuentas_por_cobrar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id_curso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_curso` varchar(50) NOT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,'escolarizado'),(2,'en linea'),(3,'impulso'),(4,'maestria');
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias`
--

DROP TABLE IF EXISTS `materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materias` (
  `id_materia` int(10) NOT NULL AUTO_INCREMENT,
  `nombre_materia` varchar(100) NOT NULL,
  `num_creditos` int(2) NOT NULL,
  `rama` int(30) NOT NULL,
  `costo_materia` int(6) NOT NULL,
  PRIMARY KEY (`id_materia`),
  KEY `rama` (`rama`),
  CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`rama`) REFERENCES `ramas` (`id_rama`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (2,'matematicas discretas ii',40,1,8300),(3,'matematicas discretas iii',40,1,8300),(4,'seminario de ejercicios de programacion',25,1,5300),(5,'lengua extranjera i',20,5,3000),(6,'lengua extranjera ii',20,5,3000),(7,'lengua extranjera iii',20,5,3000),(8,'lengua extranjera iv',20,5,3000),(9,'lengua extranjera v',20,5,3000),(10,'validacion de metodos',30,1,8300),(11,'histologia',40,3,3000),(12,'introduccion a la anatomia humana',40,3,6000),(13,'mercados financieros',40,2,6000),(14,'estadistica en la economia',30,2,7600);
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesores`
--

DROP TABLE IF EXISTS `profesores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesores` (
  `id_profesor` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `segundo_nombre` varchar(40) DEFAULT NULL,
  `fecha_nac` date NOT NULL,
  `area` varchar(30) NOT NULL,
  PRIMARY KEY (`id_profesor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesores`
--

LOCK TABLES `profesores` WRITE;
/*!40000 ALTER TABLE `profesores` DISABLE KEYS */;
/*!40000 ALTER TABLE `profesores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramas`
--

DROP TABLE IF EXISTS `ramas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ramas` (
  `id_rama` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rama` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rama`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ramas`
--

LOCK TABLES `ramas` WRITE;
/*!40000 ALTER TABLE `ramas` DISABLE KEYS */;
INSERT INTO `ramas` VALUES (1,'ingenierias'),(2,'economico-administrativas'),(3,'ciencias de la salud'),(4,'sociales y humanidades'),(5,'tronco comun'),(6,'taller');
/*!40000 ALTER TABLE `ramas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semestres`
--

DROP TABLE IF EXISTS `semestres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semestres` (
  `id_semestre` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_semestre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_semestre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semestres`
--

LOCK TABLES `semestres` WRITE;
/*!40000 ALTER TABLE `semestres` DISABLE KEYS */;
INSERT INTO `semestres` VALUES (1,'primero'),(2,'segundo'),(3,'tercero'),(4,'cuarto'),(5,'quinto'),(6,'sexo'),(7,'septimo'),(8,'octavo'),(9,'noveno');
/*!40000 ALTER TABLE `semestres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'skypea'
--

--
-- Dumping routines for database 'skypea'
--
/*!50003 DROP FUNCTION IF EXISTS `asignarMateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` FUNCTION `asignarMateria`( pid_materia int (10), pid_alumno int (10)) RETURNS int(10) unsigned
    READS SQL DATA
    DETERMINISTIC
begin
declare contador int unsigned;
set contador = (select count(*) from asignacion_carga where id_alumno = pid_alumno and id_materia = pid_materia);
if contador = 0 then 
insert into asignacion_carga(id_alumno,id_materia,fecha_asignacion)values(pid_alumno,pid_materia,now());
end if;
return 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregaralumno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `agregaralumno`(in pnombres  varchar (40), in papellidos varchar (50), in pfecha_nac date, in pcarrera varchar (30), in psemestre varchar (40),in ptipo_curso varchar (30))
begin 
insert into alumnos (nombres, apellidos, fecha_nac, carrera, semestre,  tipo_curso)
values (pnombres, papellidos, pfecha_nac, pcarrera, psemestre, ptipo_curso);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agregarmateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `agregarmateria`(in pnombre_materia varchar (60), in pnum_creditos int,in prama varchar (50), in pcosto_materia int)
begin 
insert into materias (nombre_materia, num_creditos, rama, costo_materia)
values (pnombre_materia, pnum_creditos, prama, pcosto_materia);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `desasignarmateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `desasignarmateria`(in pid_materia int (10), in pid_alumno int (10))
begin 
delete from asignacion_carga where `asignacion_carga`.`id_materia` = pid_materia and `asignacion_carga`.`id_alumno` = pid_alumno;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editarAlumno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `editarAlumno`(in pid_alumno int (10),in pnombres VARCHAR (40),in papellidos VARCHAR (50), in pfecha_nac DATE, in pcarrera VARCHAR (30), psemestre VARCHAR (40),in ptipo_curso varchar (30))
begin 
if pnombres != "" then
update alumnos set nombres = pnombres where alumnos.id_alumno = pid_alumno;
end if;
if papellidos != "" then
update alumnos set apellidos = papellidos where alumnos.id_alumno = pid_alumno;
end if;
if pfecha_nac != 0000-00-00 then
update alumnos set fecha_nac = pfecha_nac where alumnos.id_alumno = pid_alumno;
end if;
if pcarrera != "" then
update alumnos set carrera = pcarrera where alumnos.id_alumno = pid_alumno;
end if;
if psemestre != 0 then
update alumnos set semestre = psemestre where alumnos.id_alumno = pid_alumno;
end if;
if ptipo_curso != 0 then
update alumnos set tipo_curso = ptipo_curso where alumnos.id_alumno = pid_alumno;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editarmateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `editarmateria`(in pid_materia int (10), in pnombre_materia VARCHAR (40), in pnum_creditos int (10), in prama INT (3), in pcosto_materia int (10))
begin 
if pnombre_materia != "" then
update materias set nombre_materia = pnombre_materia where materias.id_materia = pid_materia;
end if;
if pnum_creditos != "" then
update materias set nombre_materia = pnombre_materia where materias.id_materia = pid_materia;
end if;
if prama != 0 then
update materias set rama = prama where materias.id_materia = pid_materia;
end if;
if pcosto_materia != "" then
update materias set costo_materia = pcosto_materia where materias.id_materia = pid_materia;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminaralumno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `eliminaralumno`(in pid_alumno int (10))
begin 
delete from alumnos where `alumnos`.`id_alumno` = pid_alumno;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminarmateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `eliminarmateria`(in pid_materia int (10))
begin 
delete from asignacion_carga where id_materia = pid_materia;
delete from materias where `materias`.`id_materia` = pid_materia;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listaralumnos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `listaralumnos`()
begin 
select * from alumnos ; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listarmaterias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`usUniva`@`%%` PROCEDURE `listarmaterias`()
begin 
select * from materias ; 
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-02  1:31:45
