-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-11-2022 a las 05:18:41
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
-- Base de datos: `skypea`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarAlumno` (IN `pnombres` VARCHAR(40), IN `papellidos` VARCHAR(50), IN `pfecha_nac` DATE, IN `pcarrera` VARCHAR(30), IN `psemestre` VARCHAR(40), IN `ptipo_curso` VARCHAR(30))   BEGIN 
INSERT INTO alumnos (nombres, apellidos, fecha_nac, carrera, semestre,  tipo_curso)
VALUES (pnombres, papellidos, pfecha_nac, pcarrera, psemestre, ptipo_curso);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarAlumnos` ()   BEGIN 
SELECT * FROM ALUMNOS ; 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `id_alumno` int(10) NOT NULL,
  `nombres` varchar(40) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `fecha_nac` date NOT NULL,
  `carrera` varchar(30) NOT NULL,
  `semestre` int(11) NOT NULL,
  `num_materias` int(2) NOT NULL,
  `tipo_curso` int(11) NOT NULL,
  `colegiatura` float NOT NULL,
  `estado` varchar(40) NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_carga`
--

CREATE TABLE `asignacion_carga` (
  `id_alumno` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_por_cobrar`
--

CREATE TABLE `cuentas_por_cobrar` (
  `id_alumno` int(10) NOT NULL,
  `semestre` int(11) NOT NULL,
  `total_pago` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id_curso` int(11) NOT NULL,
  `nombre_curso` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id_curso`, `nombre_curso`) VALUES
(1, 'Escolarizado'),
(2, 'En linea'),
(3, 'Impulso'),
(4, 'Maestria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `id_materia` int(10) NOT NULL,
  `nombre_materia` varchar(100) NOT NULL,
  `num_creditos` int(2) NOT NULL,
  `rama` varchar(30) NOT NULL,
  `costo_materia` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`id_materia`, `nombre_materia`, `num_creditos`, `rama`, `costo_materia`) VALUES
(1, 'Matematicas Discretas', 40, 'Ingenieria', 8300),
(2, 'Matematicas Discretas II', 40, 'Ingenieria', 8300),
(3, 'Matematicas Discretas III', 40, 'Ingenieria', 8300),
(4, 'Seminario de Ejercicios de Programacion', 25, 'Ingenieria', 5300),
(5, 'Lengua Extranjera I', 20, 'Tronco Comun', 3000),
(6, 'Lengua Extranjera II', 20, 'Tronco Comun', 3000),
(7, 'Lengua Extranjera III', 20, 'Tronco Comun', 3000),
(8, 'Lengua Extranjera IV', 20, 'Tronco Comun', 3000),
(9, 'Lengua Extranjera V', 20, 'Tronco Comun', 3000),
(10, 'Validacion de Metodos', 30, 'Ingeneria', 8300),
(11, 'Histologia', 40, 'Ciencias Salud', 3000),
(12, 'Introduccion a la Anatomia Humana', 40, 'Ciencias Salud', 6000),
(13, 'Mercados financieros', 40, 'Economico-Administrativas', 6000),
(14, 'Estadistica en la economia', 30, 'Economico-Administrativas', 7600);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

CREATE TABLE `profesores` (
  `id_profesor` int(10) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `segundo_nombre` varchar(40) DEFAULT NULL,
  `fecha_nac` date NOT NULL,
  `area` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `semestres`
--

CREATE TABLE `semestres` (
  `id_semestre` int(11) NOT NULL,
  `nombre_semestre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `semestres`
--

INSERT INTO `semestres` (`id_semestre`, `nombre_semestre`) VALUES
(1, 'Primero'),
(2, 'Segundo'),
(3, 'Tercero'),
(4, 'Cuarto'),
(5, 'Quinto'),
(6, 'Sexo'),
(7, 'Septimo'),
(8, 'Octavo'),
(9, 'Noveno');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`id_alumno`),
  ADD KEY `semestre` (`semestre`),
  ADD KEY `tipo_curso` (`tipo_curso`);

--
-- Indices de la tabla `asignacion_carga`
--
ALTER TABLE `asignacion_carga`
  ADD KEY `id_alumno` (`id_alumno`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `cuentas_por_cobrar`
--
ALTER TABLE `cuentas_por_cobrar`
  ADD KEY `id_alumno` (`id_alumno`),
  ADD KEY `semestre` (`semestre`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id_curso`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`id_materia`);

--
-- Indices de la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD PRIMARY KEY (`id_profesor`);

--
-- Indices de la tabla `semestres`
--
ALTER TABLE `semestres`
  ADD PRIMARY KEY (`id_semestre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  MODIFY `id_alumno` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `id_materia` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `profesores`
--
ALTER TABLE `profesores`
  MODIFY `id_profesor` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `semestres`
--
ALTER TABLE `semestres`
  MODIFY `id_semestre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD CONSTRAINT `alumnos_ibfk_1` FOREIGN KEY (`semestre`) REFERENCES `semestres` (`id_semestre`),
  ADD CONSTRAINT `alumnos_ibfk_2` FOREIGN KEY (`tipo_curso`) REFERENCES `cursos` (`id_curso`);

--
-- Filtros para la tabla `asignacion_carga`
--
ALTER TABLE `asignacion_carga`
  ADD CONSTRAINT `asignacion_carga_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`),
  ADD CONSTRAINT `asignacion_carga_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`);

--
-- Filtros para la tabla `cuentas_por_cobrar`
--
ALTER TABLE `cuentas_por_cobrar`
  ADD CONSTRAINT `cuentas_por_cobrar_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`),
  ADD CONSTRAINT `cuentas_por_cobrar_ibfk_2` FOREIGN KEY (`semestre`) REFERENCES `semestres` (`id_semestre`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
