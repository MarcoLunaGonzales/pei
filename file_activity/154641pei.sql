-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-09-2022 a las 15:36:01
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
-- Base de datos: `pei`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `codigo` int(255) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `cod_prioridad` int(255) DEFAULT NULL,
  `cod_estadokanban` int(255) DEFAULT NULL,
  `fecha_limite` date DEFAULT NULL,
  `cod_responsable` int(255) DEFAULT NULL,
  `cod_componentepei` int(255) DEFAULT NULL COMMENT 'El componente PEI es cualquier nivel de estructura dentro del PEI (objetivo, indicador, etc)',
  `cod_padre` int(255) DEFAULT NULL COMMENT 'Describe cuando una actividad se vuelve sub-actividad, el codPadre hace referencia a la misma tabla'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`codigo`, `nombre`, `observaciones`, `cod_prioridad`, `cod_estadokanban`, `fecha_limite`, `cod_responsable`, `cod_componentepei`, `cod_padre`) VALUES
(21, 'ERAERGAHERGHAER', NULL, 6, 1, '2022-09-01', 90, NULL, 20),
(22, 'NUEVA ACTIVIDAD', 'uneva descripción', 7, 4, '2022-09-30', 90, 6, NULL),
(23, 'NUEVO PROYECTO', 'Nueva Descripción', 7, 3, '2022-09-30', 182, 6, NULL),
(24, 'NUEVA DESCRIPCIÓN 2', 'Nueva descripción de proyecto', 7, 2, '2022-09-30', 47, 6, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_anotaciones`
--

CREATE TABLE `actividades_anotaciones` (
  `codigo` int(11) NOT NULL,
  `cod_actividad` int(11) NOT NULL,
  `cod_personal` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `anotacion` varchar(500) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_archivos`
--

CREATE TABLE `actividades_archivos` (
  `codigo` int(11) NOT NULL,
  `cod_actividad` int(11) NOT NULL,
  `cod_personal` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `ruta` varchar(200) DEFAULT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `filesize` varchar(10) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_cambios_estado`
--

CREATE TABLE `actividades_cambios_estado` (
  `codigo` int(11) NOT NULL,
  `cod_actividad` int(11) DEFAULT NULL,
  `cod_personal` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `cod_estadoactividad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `actividades_cambios_estado`
--

INSERT INTO `actividades_cambios_estado` (`codigo`, `cod_actividad`, `cod_personal`, `fecha`, `cod_estadoactividad`) VALUES
(54, 20, 90, '2022-09-16 13:58:46', 2),
(55, 20, 90, '2022-09-16 14:01:57', 3),
(56, 20, 90, '2022-09-16 14:01:59', 4),
(57, 22, 90, '2022-09-01 00:00:00', 1),
(58, 22, 90, '2022-09-16 14:06:10', 2),
(59, 22, 90, '2022-09-16 14:06:17', 3),
(60, 22, 90, '2022-09-16 18:53:24', 4),
(61, 23, 90, '2022-09-18 00:00:00', 1),
(62, 24, 90, '2022-09-01 00:00:00', 1),
(63, 24, 90, '2022-09-19 05:17:25', 2),
(64, 23, 90, '2022-09-19 05:17:29', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_colaboradores`
--

CREATE TABLE `actividades_colaboradores` (
  `cod_actividad` int(11) NOT NULL,
  `cod_personal` int(11) NOT NULL,
  `fecha_designacion` date DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `actividades_colaboradores`
--

INSERT INTO `actividades_colaboradores` (`cod_actividad`, `cod_personal`, `fecha_designacion`, `cod_estado`) VALUES
(20, 78, '2022-09-15', 1),
(23, 7, '2022-09-19', 1),
(23, 90, '2022-09-19', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_funciones_cargo`
--

CREATE TABLE `actividades_funciones_cargo` (
  `codigo` int(11) NOT NULL,
  `cod_actividad` int(11) NOT NULL,
  `cod_personal` int(11) NOT NULL,
  `cod_funcion_cargo` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `actividades_funciones_cargo`
--

INSERT INTO `actividades_funciones_cargo` (`codigo`, `cod_actividad`, `cod_personal`, `cod_funcion_cargo`, `fecha`, `cod_estado`) VALUES
(15, 20, 90, 21, '2022-09-15 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_hitos`
--

CREATE TABLE `actividades_hitos` (
  `codigo` int(11) NOT NULL,
  `cod_actividad` int(11) NOT NULL,
  `cod_personal` int(11) NOT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `fecha_hito` datetime DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `actividades_hitos`
--

INSERT INTO `actividades_hitos` (`codigo`, `cod_actividad`, `cod_personal`, `fecha_registro`, `fecha_hito`, `nombre`, `cod_estado`) VALUES
(3, 10, 90, '2022-09-14 01:06:29', '2022-09-14 01:06:33', 'Prueba', 1),
(4, 10, 90, '2022-09-14 00:00:00', '2022-09-01 00:00:00', 'prueba nuevo 1', 1),
(5, 10, 90, '2022-09-14 07:25:41', '2022-09-30 00:00:00', 'mas hitos', 1),
(6, 13, 0, '2022-09-14 23:23:05', '2022-09-15 00:00:00', 'nuevo hito', 1),
(8, 20, 90, '2022-09-15 16:52:50', '2022-10-14 00:00:00', 'sdbhsdrghsdrg', 1),
(9, 20, 90, '2022-09-15 16:56:41', '2022-09-22 00:00:00', 'prueba de hito', 1),
(10, 22, 90, '2022-09-16 14:13:08', '2022-09-20 00:00:00', 'Revisión 1', 1),
(11, 22, 90, '2022-09-16 14:13:23', '2022-09-26 00:00:00', 'Revisión 2', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_presupuestos`
--

CREATE TABLE `actividades_presupuestos` (
  `codigo` int(11) NOT NULL,
  `cod_actividad` int(11) NOT NULL,
  `cod_cuenta` int(11) NOT NULL,
  `fecha_ejecucion` date DEFAULT NULL,
  `monto` varchar(200) DEFAULT NULL,
  `cod_estado_presupuesto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `actividades_presupuestos`
--

INSERT INTO `actividades_presupuestos` (`codigo`, `cod_actividad`, `cod_cuenta`, `fecha_ejecucion`, `monto`, `cod_estado_presupuesto`) VALUES
(18, 10, 216, '2022-09-10', '150', 1),
(19, 13, 212, '2022-09-10', '123', 1),
(20, 20, 212, '2022-09-09', '15000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_prioridades`
--

CREATE TABLE `actividades_prioridades` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `abreviatura` varchar(50) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `actividades_prioridades`
--

INSERT INTO `actividades_prioridades` (`codigo`, `nombre`, `abreviatura`, `cod_estado`, `color`) VALUES
(6, 'Bajo', 'Bajo', 1, 'success'),
(7, 'Medio', 'Medio', 1, 'warning'),
(8, 'Alto', 'Alto', 1, 'danger');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `abreviatura` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `centro_costos` int(11) DEFAULT NULL,
  `observaciones` varchar(1000) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `distribucion_gastos` int(11) DEFAULT 0,
  `areas_ingreso` int(11) DEFAULT NULL,
  `cod_cuenta_ingreso` int(11) DEFAULT NULL,
  `area_servicio` int(11) NOT NULL COMMENT 'CAMPO PARA IDENTIFICAR LAS AREAS DE SERVICIO (OI,TCP, ETC)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`codigo`, `nombre`, `abreviatura`, `cod_estado`, `centro_costos`, `observaciones`, `created_at`, `created_by`, `modified_at`, `modified_by`, `distribucion_gastos`, `areas_ingreso`, `cod_cuenta_ingreso`, `area_servicio`) VALUES
(11, 'ORGANISMOS DE INSPECCION', 'OI', 1, 1, '-', NULL, 1, NULL, 1, 1, 1, 271, 1),
(12, 'NORMALIZACION', 'NO', 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 282, 0),
(13, 'FORMACION', 'FOR', 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 279, 0),
(14, 'POLITICAS Y RELACIONES INTERNACIONALES', 'PR', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(38, 'CERTIFICACION DE SISTEMAS', 'TCS', 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 275, 1),
(39, 'CERTIFICACION DE PRODUCTO', 'TCP', 1, 1, '', NULL, 1, NULL, 1, 1, 1, 274, 1),
(40, 'LABORATORIO', 'TLQ', 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 276, 1),
(78, 'DIRECCION REGIONAL', 'DR', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(137, 'NORMATECA', 'CD', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(273, 'DIRECCION NACIONAL DE ADMINISTRACION Y FINANZAS', 'DNAF', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(501, 'DIRECCION NACIONAL', 'DN', 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 289, 0),
(502, 'SERVICIOS ADMINISTRATIVOS', 'SA', 2, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0),
(826, 'TECNOLOGIA DE INFORMACION', 'TI', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(846, 'DIRECCION ASESORIA GENERAL', 'DAS', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(847, 'DIRECCION EJECUTIVA', 'DE', 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(871, 'GESTION ESTRATEGICA', 'GES', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(872, 'DIRECCION NACIONAL DE SERVICIOS', 'DNS', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(873, 'CERTIFICACION', 'CER', 2, 0, '', NULL, 1, NULL, 1, 0, NULL, NULL, 0),
(1200, 'DNS - GESTION INTEGRADA', 'GI', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(1235, 'PROYECTO SIS', 'SIS', 2, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(1236, 'SERVICIOS TECNICOS', 'ST', 2, 0, '', NULL, 1, NULL, 1, 0, NULL, NULL, 0),
(2848, 'AREAS EXTERNAS A IBNORCA', 'EXT', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(2956, 'DIRECCION NACIONAL DE FORMACION', 'DNFOR', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(2957, 'DIRECCION NACIONAL DE EVALUACION DE LA CONFORMIDAD', 'DNEC', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(2975, 'DIRECCION NACIONAL DE NORMALIZACION', 'DNN', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(2978, 'DIRECCION NACIONAL DE COMERCIALIZACION Y COMUNICACION', 'DNCC', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(4357, 'GESTIÓN DE CALIDAD', 'GC', 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0),
(5000, 'PROYECTO BSI', 'BSI', 2, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campos_disponibles`
--

CREATE TABLE `campos_disponibles` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `abreviatura` varchar(45) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `cod_tipocampo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `campos_disponibles`
--

INSERT INTO `campos_disponibles` (`codigo`, `nombre`, `abreviatura`, `cod_estado`, `cod_tipocampo`) VALUES
(1, 'Descripcion Larga', 'Desc Larga', 1, 4),
(2, 'Fecha de Inicio', 'FechaIni', 2, 2),
(3, 'Fecha de Fin', 'FechaFin', 1, 5),
(5, 'Descripcion Corta', 'Desc Corta', 1, 3),
(6, 'Hora Inicio', 'HIni', 1, 6),
(7, 'Hora Final', 'HFin', 1, 6),
(9, 'Fecha Limite', 'Flim', 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos`
--

CREATE TABLE `cargos` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `abreviatura` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_tipo_cargo` int(11) DEFAULT NULL,
  `cod_estadoreferencial` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `cargos`
--

INSERT INTO `cargos` (`codigo`, `nombre`, `abreviatura`, `cod_tipo_cargo`, `cod_estadoreferencial`, `created_at`, `created_by`, `modified_at`, `modified_by`) VALUES
(1, 'Director Nacional de Evaluación de la Conformidad', 'DN-EC', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(2, 'Profesional de Evaluación de la Conformidad (P-EC 1)', 'P-EC 1', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(3, 'Jefe de Evaluación de la Conformidad', 'J-EC', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(4, 'Profesional de Evaluación de la Conformidad', 'P-EC', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(5, 'Jefe de Laboratorio', 'J-TLQ', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(6, 'Profesional de Laboratorio', 'P-TLQ', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL),
(7, 'Director Nacional de Formación', 'DN-FOR', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(8, 'Profesional de Formación', 'P-FOR', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(9, 'Director Nacional de Normalización', 'DN-NO', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(10, 'Secretario Técnico de Normalización', 'ST-NO', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL),
(11, 'Asistente de la Dirección Nacional de Normalización', 'AS-NO', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(12, 'Director Nacional de Comercialización y Comunicación', 'DN-COM', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(13, 'Profesional de Comunicación Institucional', 'P-CI', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(14, 'Profesional de Marketing Digital', 'P-MKT', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL),
(15, 'Ejecutivo Comercial', 'E-COM', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(16, 'Jefe de Tecnología de la Información', 'J-TI', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(17, 'Profesional de Tecnología de la Información', 'P-TI', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL),
(18, 'Jefe de Gestión Estratégica', 'J-GES', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(19, 'Profesional de Gestión Estratégica (P-GES 1)', 'P-GES 1', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(20, 'Profesional de Gestión Estratégica (P-GES 2)', 'P-GES 2', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL),
(21, 'Director Nacional de Administración y Finanzas', 'DNAF', 1, 1, '2020-10-19 23:48:55', NULL, '2022-07-20 21:26:59', 1),
(22, 'Profesional Administrativo (P-ADM 1)', 'P-ADM 1', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(23, 'Profesional Administrativo (P-ADM 2)', 'P-ADM 2', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(24, 'Profesional Administrativo (P-ADM 3)', 'P-ADM 3', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(25, 'Profesional Administrativo (P-ADM 4)', 'P-ADM 4', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(26, 'Secretaria', 'S-ADM', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL),
(27, 'Mensajero/a', 'M-ADM', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL),
(28, 'Director Ejecutivo', 'DE', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL),
(29, 'Recepcionista', 'RECEP', 1, 1, '2021-07-29 22:48:47', NULL, '2021-07-29 22:50:26', NULL),
(30, 'Jefe Nacional de Contabilidad y Finanzas\r\n', 'J-NCF', 1, 1, '2021-07-29 22:50:05', NULL, '2021-07-29 22:50:22', NULL),
(31, 'Profesional  de Normalización \r\n', 'P-NO', 1, 1, '2021-07-29 22:52:12', NULL, '2021-07-29 22:52:53', NULL),
(32, 'Profesional Contable Financiero\r\n', 'P-CF', 1, 1, '2021-07-29 22:55:35', NULL, '2021-07-29 22:55:35', NULL),
(33, 'JEFE DE GESTIÓN DE CALIDAD', 'J-GC', 1, 1, '2022-02-24 15:42:02', 1, '2022-02-24 15:42:02', 1),
(34, 'PROFESIONAL DE GESTIÓN DE CALIDAD', 'P-GC', 1, 1, '2022-03-10 15:40:36', 1, '2022-03-10 15:40:36', 1),
(35, 'ASISTENTE ADMINISTRATIVA ', 'AS', 1, 1, '2022-07-28 16:56:49', 1, '2022-07-28 16:56:49', 1),
(36, 'PROFESIONAL ADMINISTRATIVO FINANCIERO', 'P-AF', 1, 1, '2022-07-28 16:59:52', 1, '2022-07-28 16:59:52', 1),
(37, 'LIDER ADMINISTRATIVO FINANCIERO', 'L-AF', 1, 1, '2022-07-28 17:00:36', 1, '2022-07-28 17:00:36', 1),
(38, 'LIDER DEL ORGANISMO DE INSPECCION ', 'L-OI', 1, 1, '2022-07-28 17:01:19', 1, '2022-07-28 17:01:19', 1),
(39, 'DIRECTORA NACIONAL DE COMERCIALIZACION ', 'DNC', 1, 1, '2022-07-28 21:46:12', 1, '2022-07-28 21:46:12', 1),
(40, 'JEFE COMERCIAL DE NORMALIZACION Y FORMACION ', 'JCNF', 1, 1, '2022-07-28 21:47:10', 1, '2022-07-28 21:47:10', 1),
(41, 'JEFE NACIONAL DE OPERACIONES DE NORMALIZACION ', 'JNON', 1, 1, '2022-07-28 21:47:58', 1, '2022-07-28 21:47:58', 1),
(42, 'JEFE COMERCIAL DE EVALUACION DE LA CONFORMIDAD', 'JCEC', 1, 1, '2022-07-28 21:49:36', 1, '2022-07-28 21:49:36', 1),
(43, 'Jefe Nacional de Certificación de Sistemas de Gestión y Producto ', 'JNC', 1, 1, '2022-07-28 21:50:44', 1, '2022-07-28 21:50:44', 1),
(44, 'JEFE NACIONAL DEL ORGANISMO DE INSPECCION', 'JNOI', 1, 1, '2022-07-28 21:51:38', 1, '2022-07-28 21:51:38', 1),
(45, 'JEFE NACIONAL ACADEMICO', 'JNA', 1, 1, '2022-07-28 21:52:21', 1, '2022-07-28 21:52:21', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos_funciones`
--

CREATE TABLE `cargos_funciones` (
  `cod_cargo` int(11) NOT NULL,
  `cod_funcion` int(11) NOT NULL,
  `nombre_funcion` varchar(500) COLLATE utf8_spanish_ci DEFAULT NULL,
  `peso` double DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `cargos_funciones`
--

INSERT INTO `cargos_funciones` (`cod_cargo`, `cod_funcion`, `nombre_funcion`, `peso`, `cod_estado`) VALUES
(12, 1, 'Planificar, ejecutar, dirigir y controlar el cumplimiento del POA y presupuesto del área de acuerdo a lineamientos establecidos', 0, 1),
(12, 2, 'Investigar, identificar y analizar las necesidades y nuevas tendencias del mercado para el desarrollo de nuevos servicios y/o mejora de los actuales en coordinación con las Direcciones Nacionales, además de realizar el análisis de factibilidad de los mismos.', 0, 1),
(12, 3, 'Establecer lineamientos y estrategias comerciales nacionales en coordinación con los directores nacionales. Además de medir su impacto para la toma de decisiones.', 0, 1),
(12, 4, 'Crear campañas de comercialización y comunicación para todos los servicios de IBNORCA, en coordinación con DE, Direccones nacionales y empresas de apoyo, con el objetivo de un crecimiento en el mercado.', 0, 1),
(12, 5, 'Organizar y participar en eventos estratégicos para el IBNORCA de carácter nacional (ferias, seminarios, talleres y otras actividades de relaciones públicas), en cooperación de las áreas que brindan los servicios principales de la institución para involucrar a las partes interesadas estratégicas.', 0, 1),
(12, 6, 'Administrar y monitorear la implementación de la red de contactos nacionales (CRM) de todos los servicios, que permita gestionar las acciones de seguimiento y control comercial con los clientes potenciales y actuales en todas las interacciones entre IBNORCA y los clientes.', 0, 1),
(12, 7, 'Gestionar y lograr afiliaciones de socios y convenios interinstitucionales a nivel nacional.', 0, 1),
(12, 8, 'Supervisar y controlar la creación de contenidos, diseños y el uso de marca, en medios sociales, página web y materiales promocionales, para garantizar que cumplan con las especificaciones previamente definidas', 0, 1),
(12, 9, 'Preparar planes y presupuesto de ventas, estableciendo metas y objetivos, para el cumplimiento de los objetivos de cada servicio.', 0, 1),
(12, 10, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, identificación de riesgos a la imparcialidad, entre otras)', 0, 1),
(12, 11, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1),
(13, 12, 'Apoyar en la planificación del POA y presupuesto del área y ejecutar las mismas de acuerdo a lo establecido.', 0, 1),
(13, 13, 'Planificar, ejecutar y monitorear las campañas comunicacionales a nivel nacional, en coordinación con las demás áreas de la institución', 0, 1),
(13, 14, 'Investigar, innovar, desarrollar, gestionar y coordinar la implementación, crecimiento y desarrollo de nuevos proyectos o servicios dentro del área.', 0, 1),
(13, 15, 'Identificar y establecer alianzas con los medios de comunicación para la implementación de la estrategia de posicionamiento nacional, además de definir los canales de comunicación a ser utilizados.', 0, 1),
(13, 16, 'Desarrollar, implementar y evaluar las estrategias de comunicación diseñadas para informar e involucrar a las partes interesadas en general acerca de las actividades realizadas por IBNORCA.', 0, 1),
(13, 17, 'Generar el desarrollo de materiales promocionales institucionales en coordinación con el P-MKT y las diferentes áreas.', 0, 1),
(13, 18, 'Coordinar y asistir a eventos con los medios, al igual que a reuniones con los clientes y otros organismos nacionales e internacionales.', 0, 1),
(13, 19, 'Análisis de tendencias de organismos homólogos, revisar noticias de prensa, reportes de tendencia, para la institución.', 0, 1),
(13, 20, 'Analizar el tema de afiliaciones (de los actuales), la renovación debería ser por normalización y nuevos afiliados por comercial.', 0, 1),
(13, 21, 'Administrar de convenios interinstitucionales a nivel nacional', 0, 1),
(13, 22, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1),
(14, 23, 'Apoyar en la planificación del POA y presupuesto del área y ejecutar las mismas de acuerdo a lo establecido.', 0, 1),
(14, 24, 'Planificar y ejecutar las campañas comerciales y comunicacionales en el ámbito digital.', 0, 1),
(14, 25, 'Informar al DN-COM sobre el estado de posicionamiento de la marca', 0, 1),
(14, 26, 'Administrar y monitorear el IBNORED, redes sociales, tienda virtual (Front - Backend) y la página web a nivel nacional.', 0, 1),
(14, 27, 'Crear, ajustar y definir el presupuesto de las publicaciones en los distintos medios digitales para atraer tráfico hacia la página web institucional en coordinación con el DN-COM.', 0, 1),
(14, 28, 'Crear contenido visual para las campañas digitales, en coordinación con empresas de apoyo (cuando corresponda)', 0, 1),
(14, 29, 'Identificar las nuevas tendencias y buenas prácticas en las redes sociales y herramientas digitales para fortalecer las estratégicas comerciales.', 0, 1),
(14, 30, 'Implementación, seguimeinto y reporte de las campañas y estrategias de marketing digital, en base a las métricas obtenidas para medir su impacto e influencia.', 0, 1),
(14, 31, 'Atender sugerencias y reclamos y ejecutar las medidas correctivas que permita dar soluciones adecuadas y oportunas a las plataformas digitales.', 0, 1),
(14, 32, 'Gestionar el proceso de contratación de las empresas de apoyo cuando corresponda, además de verificar y supervisar que todos los productos que sean presentados cumplan con todos los requisitos solicitados.', 0, 1),
(14, 33, 'Coordinar de manera continua con otras áreas, para el desarrollo de contenidos.', 0, 1),
(14, 34, 'Elaborar y actualizar documentos concernientes del área.', 0, 1),
(14, 35, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1),
(15, 36, 'Diseñar e implementar estrategias comerciales en base a lineamientos nacionales, segmentación e investigación de mercado para la venta de todos los servicios de IBNORCA', 0, 1),
(15, 37, 'Coadyuvar al Director Nacional de Comercialización y Comunicación con el desarrollo de proyectos innovadores, explorando nuevas oportunidades de negocio.', 0, 1),
(15, 38, 'Realizar visitas a actuales y potenciales clientes, proporcionando información oportuna acerca de la factibilidad y alcance de los servicios de IBNORCA. CAPTAR NUEVOS CLIENTES', 0, 1),
(15, 39, 'Gestionar las redes sociales (en la sección que corresponda) a nivel nacional.', 0, 1),
(15, 40, 'Realizar la gestión de quejas de manera oportuna y eficiente e informar sobre las mismas cuando corresponda.', 0, 1),
(15, 41, 'Realizar la inscripción de alumnos en el sistema de capacitación en base a la información proporcionada por el área de formación.', 0, 1),
(15, 42, 'Organizar y participar del desarrollo de eventos. (Ferias, seminarios talleres y otras actividades) y llevar un registro fotográfico de los mismos.', 0, 1),
(15, 43, 'Crear, actualizar e implementar nuevos documentos del área en coordinación con la DN-COM.', 0, 1),
(15, 44, 'Realizar la gestión de ventas para todos los servicios de IBNORCA.', 0, 1),
(15, 45, 'Elaborar y mantener actualizada la base de datos de clientes para todos los servicios.', 0, 1),
(15, 46, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1),
(1, 47, 'Planificar, ejecutar y supervisar la ejecución del Plan de Operaciones Anual y presupuesto TCS/TCP.', 0, 1),
(1, 48, 'Planificar y supervisar el POA y Presupuesto para el Organismo de Inspección y Laboratorio.', 0, 1),
(1, 49, 'Investigar, innovar, desarrollar, gestionar y coordinar la implementación, crecimiento y desarrollo de nuevos proyectos o servicios a nivel nacional en coordinación con las demás direcciones de IBNORCA y con los diferentes entes reguladores.', 0, 1),
(1, 50, 'Gestionar las decisiones de las certificaciones TCS/TCP (incluido el CONCER)', 0, 1),
(1, 51, 'Difundir los servicios a clientes estratégicos en coordinación con la Dirección Nacional de Comunicación y Comercialización', 0, 1),
(1, 52, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, identificación de riesgos a la imparcialidad, entre otras)', 0, 1),
(1, 53, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1),
(2, 54, 'Elaborar el Plan de Operaciones Anual y presupuesto TCS/TCP, y programación de auditorías por ciclo de certificación en coordinación con el DN-EC.', 0, 1),
(2, 55, 'Coordinar y gestionar las actividades para brindar el servicio de certificación (Designación del equipo auditor, logística de las auditorias, compilar detalles de ensayos con testigo para las cotizaciones, revisar y cargar los registros de auditoría al sistema y realizar el monitoreo correspondiente)', 0, 1),
(2, 56, 'Gestionar información con otros organismos internacionales de certificación (Informes, documentación y otros)', 0, 1),
(2, 57, 'Atender al cliente respecto a los servicios de TCS/TCP de manera oportuna y clara.', 0, 1),
(2, 58, 'Gestionar la elaboración y envío de ofertas de los servicios de TCS/TCP', 0, 1),
(2, 59, 'Gestionar con el cliente su registro en el sistema y mantener actualizada la información de los clientes certificados TCS/TCP.', 0, 1),
(2, 60, 'Realizar auditorías designadas conforme a la función asignada, incluyendo la realización de ensayos con testigo y todas las responsabilidades que ello conlleva. (Presentar los resultados al auditor líder, elaborar la cotización de los ensayos, etc.)', 0, 1),
(2, 61, 'Apoyar la ejecución de actividades del Organismo de Inspección.', 0, 1),
(2, 62, 'Revisar los expedientes de auditoría para decisión, asignados.', 0, 1),
(2, 63, 'Gestionar reuniones del CONCER de acuerdo a lo asignado.', 0, 1),
(2, 64, 'Realizar las solicitudes de recursos y de facturación relacionadas a los servicios TCS/TCP.', 0, 1),
(2, 65, 'Crear, actualizar e implementar nuevos documentos para TCS/TCP/OI.', 0, 1),
(2, 66, 'Participar en auditorías de acreditación y apoyar al DN-EC en la gestión de acciones correctivas.', 0, 1),
(2, 67, 'Difundir los servicios de EC y apoyar la gestión comercial (visitas a clientes, atención de consultas, etc.)', 0, 1),
(2, 68, 'Apoyar al DN-EC con el desarrollo de proyectos e implementación de nuevos servicios', 0, 1),
(2, 69, 'Informar a su inmediato superior sobre las actividades del área y el cumplimiento del trabajo asignado', 0, 1),
(2, 70, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1),
(3, 71, 'Planificar, ejecutar y controlar las actividades y presupuesto del Organismo de Inspección, de acuerdo a lineamientos establecidos.', 0, 1),
(3, 72, 'Elaborar, revisar, aprobar y enviar ofertas a clientes en base a tarifarios, contratos y convenios aprobados', 0, 1),
(3, 73, 'Asignar y ejecutar las diferentes inspecciones de acuerdo a competencia técnica y requerimiento de los clientes.', 0, 1),
(3, 74, 'Realizar las auditorias, con todas las actividades que conlleva.', 0, 1),
(3, 75, 'Implementar las estrategias comerciales para la promoción y difusión de los Servicios de EC en coordinación con la Dirección Nacional de Comercialización y Comunicación .', 0, 1),
(3, 76, 'Proponer proyectos y velar por su implementación en coordinación con DNEC y GES', 0, 1),
(3, 77, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. \r\n', 0, 1),
(3, 78, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1),
(4, 79, 'Apoyar en la elaboración del POA y presupuesto del área y ejecutar el mismo en coordinación con el J-EC', 0, 1),
(4, 80, 'Elaborar y enviar cotizaciones y propuestas al cliente, previa aprobación del J-EC', 0, 1),
(4, 81, 'Ejecutar las Evaluaciones de la Conformidad de acuerdo a competencia técnica y registrarlas en los documentos correspondientes.', 0, 1),
(4, 82, 'Realizar el 100% de las auditorias asignadas y todas las actividades que ello conlleva.', 0, 1),
(4, 83, 'Crear, actualizar e implementar nuevos documentos para el área ', 0, 1),
(4, 84, 'Participar en auditorías de acreditación y apoyar al J-EC en la gestión de quejas y reclamos', 0, 1),
(4, 85, 'Apoyar al J-EC con el desarrollo de proyectos e implementación de nuevos servicios', 0, 1),
(4, 86, 'Realizar la atención al cliente y apoyar en la gestión comercial del servicio.', 0, 1),
(4, 87, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1),
(5, 88, 'Planificar, ejecutar y controlar las actividades y presupuesto del Laboratorio, de acuerdo a lineamientos establecidos.', 0, 1),
(5, 89, 'Elaborar, revisar, aprobar y enviar ofertas a clientes en base a tarifarios aprobados', 0, 1),
(5, 90, 'Asignar y ejecutar los ensayos de acuerdo a competencia técnica y requerimiento de los clientes de manera independiente, imparcial, confidencial y eficiente, en cumplimiento a los procedimientos e instructivos aprobados', 0, 1),
(5, 91, 'Designar la responsabilidad de los equipos de laboratorio para el correcto funcionamiento e informar sus condiciones al DN-EC.', 0, 1),
(5, 92, 'Ejecutar las solicitudes de ensayos y toma de muestras', 0, 1),
(5, 93, 'Apoyar la ejecución de actividades de certificación TCS/TCP.', 0, 1),
(5, 94, 'Emitir y firmar los informes de ensayos realizados.', 0, 1),
(5, 95, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, identificación de riesgos a la imparcialidad, entre otras)', 0, 1),
(5, 96, 'Apoyar en la implementación de las estrategias comerciales para la promoción y difusión de los Servicios del Laboratorio en coordinación con la Dirección Nacional de Comercialización y Comunicación. ', 0, 1),
(5, 97, 'Proponer proyectos e implementar nuevos servicios en coordinación con DN -EC', 0, 1),
(5, 98, 'Informa a su inmediato superior sobre las actividades del área y el cumplimiento del trabajo asignado.', 0, 1),
(5, 99, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1),
(6, 100, 'Apoyar en la elaboración del Plan de Operaciones Anual y presupuesto del laboratorio y ejecutar el mismo en coordinación con el J-TLQ.', 0, 1),
(6, 101, 'Elaborar y enviar ofertas para aprobación del J-TLQ.', 0, 1),
(6, 102, 'Ejecutar las solicitudes de ensayo de acuerdo a competencia técnica y registrarlas en el sistema.', 0, 1),
(6, 103, 'Realizar el control de los equipos de laboratorio designados e informar sus condiciones al J-TLQ', 0, 1),
(6, 104, 'Apoyar la ejecución de actividades de Evaluación de la Conformidad, de acuerdo a lo asignado.', 0, 1),
(6, 105, 'Emitir informes de cada ensayo realizado, de forma precisa y completa en los formatos establecidos y enviar para aprobación del J-TLQ.', 0, 1),
(6, 106, 'Coadyuvar en la implementación y mantenimiento del SG y aportar en la actualización y revisión de la documentación de laboratorio', 0, 1),
(6, 107, 'Apoyar al J-TLQ con el desarrollo de proyectos e implementación de nuevos servicios', 0, 1),
(6, 108, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1),
(7, 109, 'Planificar, desarrollar, coordinar y controlar el programa anual - POA y el Presupuesto de los servicios del área.', 0, 1),
(7, 110, 'Dar lineamientos nacionales para la gestión de cursos en todas sus modalidades.', 0, 1),
(7, 111, 'Gestionar y coordinar la investigación, desarrollo e innovación de nuevos cursos de formación a nivel nacional.', 0, 1),
(7, 112, 'Fortalecer los canales de relacionamiento y coordinar acciones conjuntas con organismos internacionales para el desarrollo y oferta de cursos de formación.', 0, 1),
(7, 113, 'Coordinar con el área de Comercialización y comunicación en la promoción y difusión de los cursos a nivel nacional.', 0, 1),
(7, 114, 'Revisar, aprobar y garantizar la calidad de los contenidos académicos a nivel nacional.', 0, 1),
(7, 115, 'Garantizar la calidad de los servicios de formación en base a procedimientos establecidos.', 0, 1),
(7, 116, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1),
(8, 117, 'Apoyar en la elaboración del programa anual de formación, el POA y presupuesto del servicio de formación y ejecutar el mismo en coordinación con la DN- FOR, de acuerdo a lineamientos establecidos', 0, 1),
(8, 118, 'Investigar, innovar y desarrollar nuevos cursos en todas las modalidades (presencial y a distancia), cumpliendo requisitos y estándares de calidad establecidos, en coordinación con normalización, evaluación de la conformidad.', 0, 1),
(8, 119, 'Apoyar a la DN-FOR en el relacionamiento con organismos nacionales e internacionales, para el desarrollo de nuevos cursos de formación.', 0, 1),
(8, 120, 'Desarrollar, elaborar y enviar ofertas de cursos a clientes y/o empresas en coordinación con DN-FOR.', 0, 1),
(8, 121, 'Coordinar con el área de comercialización y comunicación, la programación, difusión y venta de los cursos de formación.', 0, 1),
(8, 122, 'Analizar las nuevas tendencias del mercado en cuanto a cursos de formación, en coordinación con el área de comercialización y comunicación', 0, 1),
(8, 123, 'Coordinar con expertos nacionales e internacionales para el desarrollo de proyectos de cursos de formación.', 0, 1),
(8, 124, 'Gestionar la ejecución de los cursos de formación de acuerdo a designación y procedimientos establecidos.', 0, 1),
(8, 125, 'Atender las consultas de los alumnos.', 0, 1),
(8, 126, 'Coadyuvar en la revisión de las mallas curriculares y todo el material de los cursos que brinda el IBNORCA, con la finalidad de que todo el servicio que brindamos sea de calidad.', 0, 1),
(8, 127, 'Realizar la evaluación y reportes de los resultados de la evaluación de satisfacción del cliente e informar de manera oportuna al DN-FOR los resultados de manera oportuna.', 0, 1),
(8, 128, 'Apoyar en la calificación de docentes a nivel nacional.', 0, 1),
(8, 129, 'Crear, actualizar e implementar nuevos documentos para el área de Formación en coordinación con DN-FOR.', 0, 1),
(8, 130, 'Gesionar las quejas y sujerencias de manera oportuna y eficiente con el DNFOR', 0, 1),
(8, 131, 'Gestionar la planifiación mensual de los cursos de formación', 0, 1),
(8, 132, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1),
(9, 133, 'Elaborar, monitorear y controlar el Programa Operativos de Normalización (PON); el Plan anual de Participación en Comités Internacionales y Regionales, el POA y presupuesto de normalización, velando por su estricto cumplimiento.', 0, 1),
(9, 134, 'Involucrar a las partes interesadas a través del relacionamiento con organismos nacionales para garantizar el funcionamiento de los CTN y la afiliación a IBNORCA, en coordinación con el área de comercialización y comunicación, como parte de la pre-normalización.', 0, 1),
(9, 135, 'Investigar, desarrollar e innovar proyectos en base a normas técnicas para el desarrollo de nuevos servicios en coordinación con las demás Direcciones Nacionales.', 0, 1),
(9, 136, 'Ejercer la Secretaría Técnica del Comité Nacional de Normalización – CONNOR y gestionar de manera eficiente y oportuna la aprobación de normas por parte de la Directiva de IBNORCA.', 0, 1),
(9, 137, 'Ejercer la Secretaría Ejecutiva del Codex Alimentarius con todas las responsabilidades que ello conlleva', 0, 1),
(9, 138, 'Participar en Comités Técnicos Internacionales, además de coordinar, monitorear y velar por el desarrollo eficiente de las Unidades Sectoriales y Comités Técnicos de Normalización a nivel nacional.', 0, 1),
(9, 139, 'Gestionar el relacionamiento internacional con organismos bilaterales y multilaterales de normalización para proyectos de intercambio de cooperación.', 0, 1),
(9, 140, 'Ejecutar y monitorear las actividades emergentes de proyectos internacionales en el ámbito de la normalización, además de coadyuvar con la planificación de actividades estratégicas.', 0, 1),
(9, 141, 'Realizar la promoción, difusión y venta de normas técnicas y afiliaciones a nivel nacional en coordinación con el área de comercialización y comunicación.', 0, 1),
(9, 142, 'Promover una cultura de calidad en busca de la mejora continua a través del diseño, implementación y actualización del Sistema de Gestión para todos los servicios del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, satisfacción del cliente, entre otras)', 0, 1),
(9, 143, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1),
(10, 144, 'Apoyar en la elaboración del programa operativo de normalización, el POA y presupuesto del servicio de normalización y ejecutar el mismo en coordinación con la DN- NO', 0, 1),
(10, 145, 'Identificar las partes interesadas y desarrollar eventos, participar de reuniones y otras actividades con el objetivo de involucrar a las mismas para ser parte de los CTN y formar parte de los afiliados IBNORCA, en coordinación con el área comercial y de comunicación.', 0, 1),
(10, 146, 'Elaborar y actualizar normas técnicas en el sistema (nacionales e internacionales), a través de la creación y gestión de Comités Técnicos. (Desde él envió de citaciones hasta el registro y archivo de la documentación del comité).', 0, 1),
(10, 147, 'Investigar, desarrollar e innovar proyectos en base a normas técnicas para el desarrollo de nuevos servicios.', 0, 1),
(10, 148, 'Realizar la promoción, difusión y venta de normas técnicas y afiliaciones a nivel nacional en coordinación con el área de comercialización y comunicación.', 0, 1),
(10, 149, 'Ejecutar y monitorear las actividades emergentes de proyectos internacionales en el ámbito de la normalización, además de coadyuvar con la planificación de actividades estratégicas.', 0, 1),
(10, 150, 'Realizar la gestión de quejas y sugerencias de manera oportuna y eficiente en coordinación con el DN-NO.', 0, 1),
(10, 151, 'Realizar el diseño y actualización correcta del Sistema de Gestión para los servicios de Normalización.', 0, 1),
(10, 152, 'Dar seguimiento a las unidades sectoriales y realizar el reporte del estado y aprobación de las normas técnicas.', 0, 1),
(10, 153, 'Apoyar e la inducción de Secretarios Técnicos 100% en el año', 0, 1),
(10, 154, 'Gestionar el desarrollo de artículos técnicos y eventos de difunción, en coordinación con el área de Comercialización y Comunicación.', 0, 1),
(10, 155, 'Descargar y subir las normas técnicas en el sistema informatico', 0, 1),
(10, 156, 'Otras funciones que sean asignadas para el cumplimiento de los objetivos del área.', 0, 1),
(11, 157, 'Apoyo en la organización de comités, eventos u otras actividades del área', 0, 1),
(11, 158, 'Elaborar cartas, invitaciones, actas, itinerarios de viajes y otros documentos que sean solicitados', 0, 1),
(11, 159, 'Mantener organizado, dar seguimiento y llevar un control adecuado de toda la documentación correspondiente al área, además del archivo digital y físico.', 0, 1),
(11, 160, 'Apoyar al DN-NO con la gestión de las reuniones del CONNOR ', 0, 1),
(11, 161, 'Registro de Información en el sistema de la normateca digital.', 0, 1),
(11, 162, 'Llevar el control de reclamos sobre normas observadas por los clientes para conocimiento y toma de decisiones de la DN-NO.', 0, 1),
(11, 163, 'Mantener actualizada la agenda de los participantes de los comités, proveedores y otros relacionados con el área de normalización.', 0, 1),
(11, 164, 'Realizar las actividades administrativas de solicitud de recursos relacionadas al área.', 0, 1),
(11, 165, 'Gestionar la contratación de consultores y empresas de apoyo para el área, en coordinación con el DN-NO', 0, 1),
(11, 166, 'Informar a su inmediato superior sobre las actividades del área y el cumplimiento del trabajo asignado', 0, 1),
(11, 167, 'Otras funciones que sean asignadas para el cumplimiento de los objetivos del área.', 0, 1),
(16, 168, 'Planificar, ejecutar, supervisar y controlar las actividades y presupuesto del área; velando por su estricto cumplimiento', 0, 1),
(16, 169, 'Desarrollar, implementar, coordinar y monitorear las políticas, planes, procedimientos, estrategias y lineamientos del área que garanticen el Sistema de Gestión de seguridad de la información de la Institución.', 0, 1),
(16, 170, 'Participar de manera activa en la elaboración de procedimientos de las áreas pertinentes para diseñar, documentar, coordinar, implementar y monitorear los sistemas informáticos de acuerdo a los requerimientos institucionales.', 0, 1),
(16, 171, 'Innovar, investigar y desarrollar nuevos proyectos de Tecnología de la Información.', 0, 1),
(16, 172, 'Atender sugerencias y recomendaciones de los clientes internos y externos.', 0, 1),
(16, 173, 'Supervisar y/o realizar la administración, mantenimiento y mejora de toda la infraestructura de hardware, software y la red de transmisión de datos de la institución.', 0, 1),
(16, 174, 'Coordinar y supervisar la atención eficiente de soporte técnico a nivel nacional.', 0, 1),
(16, 175, 'Realizar las descargar de normas del repositorio de la ISO.', 0, 1),
(16, 176, 'Supervisar y/o realizar la capacitación al personal de IBNORCA en el manejo adecuado de los recursos de tecnología de la información y comunicación.', 0, 1),
(16, 177, 'Promover y gestionar el uso eficiente de los recursos de la tecnología de la información en la institución.', 0, 1),
(16, 178, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, identificación de riesgos a la imparcialidad, entre otras)', 0, 1),
(16, 179, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos de la regional.', 0, 1),
(17, 180, 'Coadyuvar en la planificación y ejecución de las actividades (POA) y presupuesto del área, velando por su estricto cumplimiento.', 0, 1),
(17, 181, 'Realizar mantenimientos correctivos y preventivos de la infraestructura de hardware y software.', 0, 1),
(17, 182, 'Brindar apoyo al personal a nivel nacional, en temas relacionados a las tecnologías de la información.', 0, 1),
(17, 183, 'Capacitar al personal en la operación de sistemas informáticos o nuevos programas.', 0, 1),
(17, 184, 'Realizar tareas de mantenimiento y actualización a los sistemas informáticos y plataformas institucionales.', 0, 1),
(17, 185, 'Velar por la continuidad de los servicios comunicacionales (internet y redes LAN y WAN)', 0, 1),
(17, 186, 'Crear y desarrollar nuevos sistemas y realizar la programación de acuerdo a las necesidades institucionales.', 0, 1),
(17, 187, 'Resguardar la información, bases de datos y documentación digital a nivel nacional.', 0, 1),
(17, 188, 'Evaluar el desempeño de los sistemas actuales y nuevos, para aplicar mejoras y correcciones de funcionamiento, de acuerdo a requerimiento.', 0, 1),
(17, 189, 'Crear, actualizar e implementar nuevos documentos para TI.', 0, 1),
(17, 190, 'Gestión de aulas virtuales (envío de videos, y grabaciones)', 0, 1),
(17, 191, 'Atención a clientes externos con el uso de los sistemas institucionales. (tienda).', 0, 1),
(17, 192, 'Coordinar las actividades de desarrollo con los consultores externos.', 0, 1),
(17, 193, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuraciones`
--

CREATE TABLE `configuraciones` (
  `id_configuracion` int(11) NOT NULL,
  `valor_configuracion` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion_configuracion` varchar(1000) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `configuraciones`
--

INSERT INTO `configuraciones` (`id_configuracion`, `valor_configuracion`, `descripcion_configuracion`) VALUES
(-10, '1', 'TIPO LOGIN 1: FINANCIERO  2: SERVICIO WEB'),
(1, '1', 'ESTADO INICIAL CON QUE SE REGISTRA LAS ACTIVIDADES'),
(2, 'assets/imagenes_personal/', 'Directorio dinámico de Imagenes de Personal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `abreviatura` varchar(50) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`codigo`, `nombre`, `abreviatura`, `cod_estado`) VALUES
(1, 'IBNORCA 2023 2025', 'IBNO', 1),
(5, 'IBNORCA 2026 - 2029', '2026/29', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_actividades_presupuesto`
--

CREATE TABLE `estados_actividades_presupuesto` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `abreviatura` varchar(50) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `estado_etiqueta` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `estados_actividades_presupuesto`
--

INSERT INTO `estados_actividades_presupuesto` (`codigo`, `nombre`, `descripcion`, `abreviatura`, `cod_estado`, `estado_etiqueta`) VALUES
(1, 'Pendiente', 'Solicitado', 'SOL', 1, 'warning'),
(2, 'Proceso', 'Ejecución', 'EEJE', 1, 'primary'),
(9, 'Terminado', 'Ejecutado', 'EJE', 1, 'success');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_kanban`
--

CREATE TABLE `estados_kanban` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `abreviatura` varchar(50) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `estados_kanban`
--

INSERT INTO `estados_kanban` (`codigo`, `nombre`, `descripcion`, `abreviatura`, `cod_estado`) VALUES
(1, 'Planificado', 'Pila de actividades registradas pero pendientes de ejecucion. ', 'UpCom', 1),
(2, 'En Proceso', 'Pila de actividades en proceso de Ejecucion. ', 'InProg', 1),
(3, 'En Revisión', 'Pila de actividades en revisión.', 'Done', 1),
(4, 'Concluido', 'Pila de actividades concluidas. ', NULL, 1),
(5, 'Parado', 'Pila de actividades sin acciones', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivelesconf_camposdisponibles`
--

CREATE TABLE `nivelesconf_camposdisponibles` (
  `cod_nivelconfiguracion` int(11) NOT NULL,
  `cod_campodisponible` int(11) NOT NULL,
  `orden` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivelespei_unidadesareas`
--

CREATE TABLE `nivelespei_unidadesareas` (
  `cod_nivelpei` int(255) NOT NULL,
  `cod_unidadorganizacional` int(255) NOT NULL,
  `cod_area` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `nivelespei_unidadesareas`
--

INSERT INTO `nivelespei_unidadesareas` (`cod_nivelpei`, `cod_unidadorganizacional`, `cod_area`) VALUES
(6, 829, 273),
(6, 829, 826);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `niveles_configuracion`
--

CREATE TABLE `niveles_configuracion` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `abreviatura` varchar(50) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `nivel` int(11) DEFAULT NULL,
  `cod_padre` int(11) DEFAULT NULL COMMENT 'Hace referencia al nivel del cual depende en la misma tabla.',
  `cod_empresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `niveles_configuracion`
--

INSERT INTO `niveles_configuracion` (`codigo`, `nombre`, `abreviatura`, `cod_estado`, `nivel`, `cod_padre`, `cod_empresa`) VALUES
(1, 'PERSPECTIVAS', 'PERS', 1, 1, 0, 1),
(2, 'OBJETIVOS ESTRATEGICOS', 'OBJ EST', 1, 2, 1, 1),
(3, 'INDICADORES ESTRATEGICOS', 'IND EST', 1, 3, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `niveles_pei`
--

CREATE TABLE `niveles_pei` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `abreviatura` varchar(50) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `cod_padre` int(11) DEFAULT NULL COMMENT 'Hace referencia al nivel del cual depende en la misma tabla.',
  `cod_nivelconfiguracion` int(255) DEFAULT NULL,
  `bandera_actividades` int(255) DEFAULT 0 COMMENT 'Hace referencia si el nivel de PEI aceptara actividades de un POA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `niveles_pei`
--

INSERT INTO `niveles_pei` (`codigo`, `nombre`, `abreviatura`, `cod_estado`, `cod_padre`, `cod_nivelconfiguracion`, `bandera_actividades`) VALUES
(1, 'INSTITUCIONAL', 'INS', 1, 0, 1, 0),
(2, 'PROCESOS', 'PRO', 1, 0, 1, 0),
(3, 'FINANCIERA', 'FIN', 1, 0, 1, 0),
(4, 'TECNOLOGICA', 'TEC', 1, 0, 1, 0),
(5, 'FORTALECIMIENTO DEL AREA TECNOLOGICA DE IBNORCA', 'OBJTI1', 1, 4, 2, 0),
(6, 'CONSTRUCCION DEL DATACENTER IBNORCA', 'IE_TI_1', 1, 5, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `niveles_pei_adicionales`
--

CREATE TABLE `niveles_pei_adicionales` (
  `cod_nivelpei` int(255) NOT NULL,
  `cod_campodisponible` int(255) NOT NULL,
  `valor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `codigo` int(11) NOT NULL,
  `cod_tipo_identificacion` int(11) DEFAULT NULL,
  `tipo_identificacion_otro` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `identificacion` varchar(50) COLLATE utf8_spanish_ci DEFAULT '',
  `cod_lugar_emision` int(11) DEFAULT NULL,
  `lugar_emision_otro` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `cod_cargo` int(11) DEFAULT NULL,
  `cod_unidadorganizacional` int(11) DEFAULT NULL,
  `cod_area` int(11) DEFAULT NULL,
  `jubilado` int(11) DEFAULT NULL,
  `cod_genero` int(11) DEFAULT NULL,
  `cod_tipopersonal` int(11) DEFAULT NULL,
  `haber_basico` double DEFAULT NULL,
  `paterno` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `materno` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido_casada` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `primer_nombre` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `otros_nombres` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nua_cua_asignado` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `direccion` varchar(1000) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_tipoafp` int(11) DEFAULT NULL,
  `cod_tipoaporteafp` int(11) DEFAULT NULL,
  `nro_seguro` varchar(25) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_estadopersonal` int(11) DEFAULT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `celular` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `persona_contacto` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `cod_estadoreferencial` int(11) DEFAULT NULL,
  `cod_nacionalidad` int(11) DEFAULT NULL,
  `cod_estadocivil` int(11) DEFAULT NULL,
  `cod_pais` int(11) DEFAULT NULL,
  `cod_departamento` int(11) DEFAULT NULL,
  `cod_ciudad` int(11) DEFAULT NULL,
  `ciudad_otro` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_grado_academico` int(11) DEFAULT NULL,
  `ing_contr` date DEFAULT NULL,
  `ing_planilla` date DEFAULT NULL,
  `email_empresa` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `bandera` int(11) DEFAULT NULL,
  `personal_confianza` int(11) NOT NULL,
  `cuenta_bancaria` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`codigo`, `cod_tipo_identificacion`, `tipo_identificacion_otro`, `identificacion`, `cod_lugar_emision`, `lugar_emision_otro`, `fecha_nacimiento`, `cod_cargo`, `cod_unidadorganizacional`, `cod_area`, `jubilado`, `cod_genero`, `cod_tipopersonal`, `haber_basico`, `paterno`, `materno`, `apellido_casada`, `primer_nombre`, `otros_nombres`, `nua_cua_asignado`, `direccion`, `cod_tipoafp`, `cod_tipoaporteafp`, `nro_seguro`, `cod_estadopersonal`, `telefono`, `celular`, `email`, `persona_contacto`, `created_at`, `created_by`, `modified_at`, `modified_by`, `cod_estadoreferencial`, `cod_nacionalidad`, `cod_estadocivil`, `cod_pais`, `cod_departamento`, `cod_ciudad`, `ciudad_otro`, `cod_grado_academico`, `ing_contr`, `ing_planilla`, `email_empresa`, `bandera`, `personal_confianza`, `cuenta_bancaria`) VALUES
(0, 0, NULL, '0', 0, NULL, NULL, NULL, 829, NULL, NULL, NULL, 1, NULL, '-', '-', NULL, '-', NULL, NULL, '-', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, '2021-10-27 15:01:37', NULL, '2022-01-24 22:30:44', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(5, 1581, NULL, '2233839', 480, NULL, '1966-08-23', 16, 829, 826, 0, 73, 1, 10679.6, 'Miranda', 'Perez', '', 'Willy', '', '0', 'Calle Juan Manuel Loza # 1776', 1, 2, '0', 1, '', '77294955', 'imwilly@hotmail.com', '0', '2020-01-02 07:31:02', 1, '2022-07-28 17:18:30', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2015-04-13', '2015-04-13', 'willy.miranda@ibnorca.org', 1, 0, '1999014018'),
(7, 1581, NULL, '6094406', 480, NULL, '1985-03-07', 12, 829, 2978, 0, 74, 1, 7210, 'Prudencio', 'Caballero', '', 'Anneliese', '', '43868502', 'San Miguel Calle Javier Zalles N° 883 Edificio Tredinick Piso 7 Dpto 7B', 1, 2, '0', 1, '', '61003251', 'prudencioanneliese@gmail.com', '0', '2020-01-02 07:31:39', 1, '2022-07-28 21:55:01', 58, 1, 26, 0, 26, 480, 62, NULL, 4, '2018-05-10', '2018-05-10', 'anneliese.prudencio@ibnorca.org', 1, 0, '2705064019'),
(8, 0, NULL, '6746760', 480, NULL, '1987-11-21', 40, 829, 2978, 0, 73, 1, 4595.06, 'Cardozo', 'Portugal', '', 'Pedro Agustin', '', '0', 'c 6 N 385 Santiago II', 1, 2, '0', 1, '22809271', '67162671', 'pedro.cardozo2312@gmail.com', '0', '2020-01-02 07:31:21', 1, '2022-07-28 22:01:46', 58, 1, 26, 1575, 26, 480, 72, NULL, 4, '2014-10-01', '2014-10-01', 'pedro.cardozo@ibnorca.org', 1, 0, '4279804011'),
(9, 1581, NULL, '6089959', 480, NULL, '1989-04-20', 21, 829, 826, 0, 73, 1, 6, 'Romero', 'Rocha', '', 'Gonzalo Marcelo', '', '0', 'Llojeta Urbanizacion el Vergelito Calle K SN', 1, 2, '0', 2, '', '71224246', 'gonzalo.romero89@gmail.com', '0', '2020-01-02 07:31:03', 1, '2021-06-26 10:59:29', 90, 1, 26, 1576, 26, 480, 62, NULL, 4, '2016-01-04', '2016-01-04', '0', 1, 0, '0'),
(13, 1581, NULL, '3433771', 480, NULL, '1969-03-24', 4, 829, 11, 0, 73, 1, 5683.35, 'Castro', 'Parada', '', 'René', '', '37966807', 'Zona Sur- Alto Calacoto sector Pedregal', 2, 2, '0', 1, '-', '59173034330', 'rcastroparada@gmail.com', '0', '2020-01-02 07:31:12', 1, '2022-07-28 22:31:51', 58, 1, 26, 1576, 26, 480, 62, NULL, 2, '2012-07-17', '2012-07-17', 'rene.castro@ibnorca.org', 1, 0, '3158264012'),
(15, 1581, NULL, '5219994', 479, NULL, '1982-05-10', 17, 9, 826, 0, 74, 1, 6203.66, 'Mejia', 'Soliz', '', 'Claudia Cristina', '', '34913099', 'Calle jesus Aguayo Nº 1446', 1, 2, '0', 1, '4416183', '70373067', 'cristinac01@hotmail.com', '0', '2020-01-02 07:31:26', 1, '2022-08-02 11:32:20', 58, 1, 0, 1576, 26, 479, NULL, NULL, 2, '2007-07-02', '2007-07-02', 'cristina.mejia@ibnorca.org', 1, 0, '1313264013'),
(16, NULL, NULL, '3701778', 483, NULL, '1971-12-02', 15, 829, 872, 0, 74, 1, 10121.67, 'Llano', 'Navarro', '', 'Maria Roxana', '', '0', 'Chasquipampa Calle 45 No 45', 2, 1, '0', 2, '2147483647', '71559957', 'roxanallano@hotmail.com', '0', '2020-01-02 07:30:58', 1, '2020-09-16 12:01:34', 1, 1, 26, NULL, NULL, NULL, 62, NULL, 4, '2015-06-01', '2015-06-01', NULL, 1, 0, NULL),
(17, 1581, NULL, '6261962', 484, NULL, '1985-03-29', 4, 10, 2957, 0, 73, 1, 9514.93, 'CASTRO', 'SUAREZ', '', 'YSNAIDER', '', '41178002', 'Av. 3 pasos al frente 10mo anillo Urb. Leónidas B/ EL TOTAI', 2, 2, '0', 1, '68918480', '68918480', 'ysnaider.castro@gmail.com', '0', '2020-01-02 07:31:42', 1, '2022-08-05 12:56:54', 58, 1, 26, 1575, 26, 484, 65, NULL, 4, '2012-08-20', '2012-08-20', 'ysnaider.castro@ibnorca.org', 1, 0, '5866944018'),
(18, 1581, NULL, '5384121', 484, NULL, '1986-03-18', 8, 829, 13, 0, 74, 1, 5085.52, 'Nogales', '', '', 'Delcy Gabriela', '', '38867333', 'Av. Busch Calle 4 Nro. 17', 1, 2, '0', 1, '3572787', '59170839282', 'delcyg.nogales@gmail.com', '0', '2020-11-09 11:47:44', 1, '2022-08-02 10:51:33', 58, 1, 26, 1576, 26, 484, 65, NULL, 0, '2021-09-06', '2021-09-06', 'delcy.nogales@ibnorca.org ', 1, 0, '2344374018'),
(21, 1581, NULL, '1842448', 485, NULL, '1968-11-25', 15, 271, 2978, 0, 74, 1, 4696, 'Cayo', 'Ayarde', '', 'Janeth', '', '0', '00', 2, 2, '0', 2, '0', '75134656', 'taya.janeth@gmail.com', '0', '2020-07-17 17:37:18', 1, '2021-07-25 17:20:50', 90, 2, 0, NULL, 26, 485, NULL, NULL, 4, '2007-10-01', '2007-10-01', '0', 1, 0, '0'),
(22, 1581, NULL, '6277898', 484, NULL, '1985-04-16', 4, 10, 11, 0, 73, 1, 5683.35, 'Tejerina', 'Saavedra', '', 'Carlos Alberto', '', '41947371', 'Av. cumavi 9no anillo Urbanización El Buen Samaritano', 2, 2, '0', 1, 'N/A', '79903441', 'carlostejerina.cat@gmail.com', '0', '2020-01-02 07:31:43', 1, '2022-08-02 10:41:45', 58, 1, 26, 1575, 26, 484, 65, NULL, 2, '2014-03-17', '2014-03-17', 'carlos.tejerina@ibnorca.org', 1, 0, '3903914016'),
(23, 1581, NULL, '5859990', 484, NULL, '1980-09-19', 4, 10, 11, 0, 73, 1, 5683.35, 'Orellana', 'Flores', '', 'Justo', '', '0', 'Av.  Libertadores entre 8vo y 9no Anillo', 1, 2, '0', 1, '-', '77615549', 'justo.orellana@gmail.com', '0', '2020-01-02 07:31:44', 1, '2022-08-02 10:43:33', 58, 1, 26, 1575, 26, 484, 65, NULL, 4, '2015-08-01', '2015-08-01', 'justo.orellana@ibnorca.org', 1, 0, '5866944018'),
(26, NULL, NULL, '8984611', 477, NULL, '1990-02-14', 26, 10, 273, 0, 74, 1, 3627.67, 'Chavez', 'Solares', '', 'Graciela Efigenia', '', '0', NULL, 2, 2, '0', 1, '', '78187081', 'schon.fraug@gmail.com', '0', '2020-01-02 07:31:45', 1, '2022-08-02 10:19:11', 58, 1, NULL, NULL, NULL, 484, NULL, NULL, 2, '2015-07-22', '2015-07-22', 'graciela.chavez@ibnorca.org', 1, 0, '4718064011'),
(27, 0, NULL, '5515128', 483, NULL, '1984-03-21', 4, 271, 11, 0, 73, 1, 5683.35, 'Barroso', 'Cordova', '', 'Josue Antonio', '', '38196839', 'Av. Dorbigni No. 1740 casi Calle J. Espinoza', 2, 2, '0', 1, '77171161', '77171161', 'josue_bacor4@hotmail.com', '0', '2020-01-02 07:31:54', 1, '2022-08-02 11:37:00', 58, 1, 26, 1576, 26, 479, 64, NULL, 3, '2012-06-25', '2012-06-25', 'josue.barroso@ibnorca.org', 1, 0, '3157664017'),
(29, 1581, NULL, '8436683', 480, NULL, '1990-04-09', 8, 5, 13, 0, 73, 1, 4595.06, 'Serrudo', 'Cardozo', '', 'Carlos Freddy', '', '0', 'Zona Santiago II calle 5 Nº 462', 1, 2, '0', 1, '', '77296032', 'carlos.serrudo420@gmail.com', '0', '2020-01-02 07:31:21', 1, '2022-07-28 22:54:47', 58, 1, 0, 1576, 26, 480, NULL, NULL, 4, '2015-06-08', '2015-06-08', 'carlos.serrudo@ibnorca.org', 1, 0, '4621534012'),
(31, 1581, NULL, '2284758', 480, NULL, '1969-02-22', 0, 9, 502, 0, 74, 1, 1569.08, 'Beltran', 'Pacheco', '', 'Maria del Carmen', '', '0', 'Calle Chipaya esquina Apurimac Edificio Ichiban Depto 1B', 2, 2, '0', 2, '4020542', '72205558', 'beltranpachecocarmen@gmail.com', '0', '2020-01-02 07:31:23', 1, '2021-06-26 10:59:29', 90, 1, 26, 0, 26, 479, 64, NULL, 4, '2002-08-01', '2002-08-01', '00', 1, 0, '0'),
(32, 1581, NULL, '4778441', 480, NULL, '1976-09-30', 1, 829, 2957, 0, 73, 1, 16162.25, 'Palomo', 'Sainz', '', 'Julio Augusto', '', '36786226', 'Condominio Claveles del Sur - Bloque 27 - Achumani', 2, 2, '0', 1, '', '70779369 -72060', 'jpalomo30@yahoo.com', '0', '2020-01-02 07:30:55', 1, '2022-07-28 22:21:23', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2005-12-01', '2005-12-01', 'julio.palomo@ibnorca.org', 1, 0, '1032224012'),
(33, 1581, NULL, '2285914', 480, NULL, '1959-04-27', 0, 9, 39, 0, 74, 1, 11000, 'Linares', 'Ponce', '', 'Miriam', '', '0', 'Calle Las Dalias S/N - zona Norte', 1, 2, '0', 2, '4010775', '71460810', 'Mlinaresp27@gmail.com', '0', '2020-01-02 07:31:27', 1, '2022-07-13 12:44:15', 90, 1, 26, 1576, 26, 479, 64, NULL, 4, '2001-03-01', '2001-03-01', '0', 1, 0, '0'),
(34, 1581, NULL, '3570044', 479, NULL, '1974-02-16', 0, 0, 0, 0, 73, 0, 0, 'Torrico', 'Herbas ', '', 'Benjamin Joel', '', '', 'Calle Enrique Arze Nro. 2282 - Zona Cala Cala', 0, 0, '', 2, '4476267', '77492263', 'btorrico@gmail.com', '', '2020-01-02 07:31:29', 1, '2021-09-29 17:25:44', 1, 1, 26, 1576, 26, 479, 64, NULL, 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(35, 1581, NULL, '4380091', 479, NULL, '1975-07-23', 38, 9, 11, 0, 73, 1, 5960.47, 'Mejía', 'Navia', '', 'Jorge Daniel', '', '33916706', 'Calle Héroes Nacionales N° 293', 1, 2, '0', 1, '4280217', '70772592', 'jordanio123@hotmail.com', '0', '2020-01-02 07:31:30', 1, '2022-08-02 11:35:43', 58, 1, 26, 1575, 26, 479, 64, NULL, 4, '2010-01-04', '2010-01-04', 'jorge.mejia@ibnorca.org', 1, 0, '1032214025'),
(36, 0, NULL, '3529338', 481, NULL, '1983-02-08', 13, 9, 871, 0, 73, 1, 6270.04, 'Guerrero', 'Ayoroa', '', 'Daniel Alejandro', '', '0', 'Calle Irigoyen N° 100', 1, 2, '0', 1, '4219976', '75939993', 'guerrero.dani@gmail.com', '0', '2020-01-02 07:31:29', 1, '2022-08-08 15:14:38', 58, 1, 26, 0, 26, 479, 64, NULL, 4, '2010-05-05', '2010-05-05', 'daniel.guerrero@ibnorca.org', 1, 0, '2279094011'),
(37, 1581, NULL, '5232163', 479, NULL, '1980-02-22', 42, 10, 13, 0, 74, 1, 9582.1, 'Valdez', 'Cespedes', '', 'Doyna Gabriela', '', '36632661', 'CONDOMINIO SEVILLA LOS JARDINES - ZONA NORTE', 2, 2, '0', 1, '', '71751164', 'gabriela.valdezdc@gmail.com', '0', '2020-01-02 07:31:46', 1, '2022-08-02 10:24:14', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2007-02-13', '2007-02-13', 'gabriela.valdez@ibnorca.org', 1, 0, '1211994017'),
(40, 1581, NULL, '4832596', 480, NULL, '1983-01-06', 33, 829, 4357, 0, 73, 1, 9064, 'Rendon', 'Salas', '', 'Alejandro', '', '0', 'Calle Los Alamos N° 1070, Zona Alto Obrajes', 1, 2, '0', 1, '', '70673657', 'alejandro.rendon.s@gmail.com', '0', '2020-01-02 07:31:16', 1, '2022-08-08 15:34:38', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2015-08-03', '2015-08-03', 'alejandro.rendon@ibnorca.org ', 1, 0, '4813914013'),
(41, 1581, NULL, '3527730', 481, NULL, '1976-07-04', 37, 9, 273, 0, 74, 1, 8497.16, 'Castellon', 'Clavijo', '', 'Katia Mireya', '', '36025148', 'Tiquipaya Calle Tuska No.3', 2, 2, '0', 1, '4229663', '76417011', 'kat.cast407@gmail.com', '0', '2020-01-02 07:31:24', 1, '2022-08-02 11:25:37', 58, 1, 26, 1576, 26, 479, 64, NULL, 4, '2003-07-01', '2003-07-01', 'katia.castellon@ibnorca.org', 1, 0, '851604014'),
(42, 1581, NULL, '4527802', 479, NULL, '1978-05-02', 32, 829, 273, 0, 74, 1, 4595.06, 'Ramirez', 'Vargas', '', 'Roxana', '', '0', 'Calle Siglo XX- Sacaba', 1, 2, '0', 1, '4067875', '77036420', 'santiroxfre@gmail.com', '0', '2020-01-02 07:31:25', 1, '2022-08-08 14:52:12', 58, 1, 26, 1576, 26, 479, 48446, NULL, 2, '2010-09-07', '2010-09-07', 'roxana.ramirez@ibnorca.org', 1, 0, '2285414019'),
(43, 1581, NULL, '4085357', 478, NULL, '1980-09-12', 4, 5, 11, 0, 73, 1, 6363.24, 'Gómez', 'Zenteno', '', 'Ramiro Benjamín', '', '35344866', 'Calle Bolivar N° 942', 1, 2, '0', 1, '', '', 'ramiro.begoze@gmail.com', '0', '2020-01-02 07:31:54', 1, '2022-08-02 12:11:41', 58, 1, 26, 1576, 26, 478, 69, NULL, 4, '2008-07-07', '2008-07-07', 'ramiro.gomez@ibnorca.org', 1, 0, '1721104016'),
(44, 1581, NULL, '1112060', 478, NULL, '1969-07-07', 15, 270, 2978, 0, 74, 1, 4304.18, 'Bueno', 'Ipiña', '', 'Jhoselyn Ana', '', '0', 'Aniceto Arce # 345', 2, 2, '0', 2, '', '59172859172', 'ajbueno27@hotmail.com', '0', '2020-01-02 07:31:53', 1, '2021-07-25 17:15:46', 90, 2, 26, 1577, 26, 478, 69, NULL, 1, '2007-08-01', '2007-08-01', '0', 1, 0, '0'),
(47, 1581, NULL, '7693431', 484, NULL, '1989-02-20', 34, 829, 4357, 0, 74, 1, 6771.65, 'Linares', 'Aranda', '', 'Carla Daniela', '', '0', '5to anillo Radial 27', 1, 2, '0', 1, '', '72677614', 'clinaresaranda@gmail.com', '0', '2020-01-02 07:31:41', 1, '2022-08-02 10:21:27', 58, 1, 0, 0, 26, 484, 65, NULL, 4, '2015-11-03', '2015-11-03', 'carla.linares@ibnorca.org ', 1, 0, '4946874014'),
(48, 1581, NULL, '3658859', 478, NULL, '1978-11-25', 44, 10, 11, 0, 74, 1, 10171.04, 'Cuevas', 'Calderon', '', 'Silvia', '', '37054089', 'Av. Monseñor Costas Nº 635, Zona El trompillo', 2, 2, '0', 1, '3 525291', '77383273', 'silvicuevas@hotmail.com', '0', '2020-01-02 07:31:39', 1, '2022-08-02 10:38:19', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2006-08-29', '2006-08-29', 'silvia.cuevas@ibnorca.org', 1, 0, '1093034011'),
(49, 1581, NULL, '7464020', 478, NULL, '1986-06-25', 8, 10, 13, 0, 74, 1, 4595.06, 'Serrano', 'Núñez', '', 'María Angélica', '', '42756662', 'Final Av. Virgen de Luján B/San Cayetano', 2, 2, '0', 1, '', '69043886', 'anghicita2505@gmail.com', '0', '2020-01-02 07:31:37', 1, '2022-08-02 12:43:03', 58, 1, 26, 1575, 26, 484, 65, NULL, 2, '2015-10-13', '2015-10-13', 'maria.serrano@ibnorca.org', 1, 0, '4104274019'),
(50, 1581, NULL, '6317932', 484, NULL, '1989-08-24', 37, 829, 273, 0, 74, 1, 5683.35, 'Segovia', 'Vaca', '', 'Yessica Laura', '', '40951169', 'Km. 7 Doble Vía La Guardia B/Berea Panamericano Calle 4 N° 108', 1, 2, '0', 1, '', '70971858', 'yessica.segovia.vaca@gmail.com', '0', '2020-01-02 07:31:36', 1, '2022-08-05 12:56:06', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2016-03-01', '2016-03-01', 'yessica.segovia@ibnorca.org ', 1, 0, '1892714017'),
(51, 1581, NULL, '4891802', 480, NULL, '1976-10-13', 4, 5, 11, 0, 73, 1, 6180, 'Ballón', 'Guaygua', '', 'Miguel Angel', '', '0', 'Z. Bella Vista Av. Tomas Monje Pasaje B  Nº 100', 1, 2, '0', 1, '2786272', '70667775', 'mballonguaygua@gmail.com', '0', '2020-01-02 07:31:17', 1, '2022-07-28 23:08:01', 58, 1, 26, 1576, 26, 480, 62, NULL, 2, '2014-10-21', '2014-10-21', 'miguel.ballon@ibnorca.org', 1, 0, '699544027'),
(53, 0, NULL, '2689176', 480, NULL, '1964-04-11', 7, 10, 13, 0, 74, 1, 16161.4, 'Rodriguez', 'Salinas', '', 'Erika Florencia', '', '0', 'Urb. Villa Toscana N.16', 1, 2, '0', 1, '72100745', '72100745', 'erikkarosa@hotmail.com', '0', '2020-01-02 07:31:35', 1, '2022-08-02 10:49:27', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2010-04-07', '2010-04-07', 'erika.rodriguez@ibnorca.org', 1, 0, '2137074012'),
(54, 1581, NULL, '6382520', 484, NULL, '1987-04-22', 4, 10, 11, 0, 74, 1, 4595.06, 'Muñoz', 'Acosta', '', 'Gabriela', '', '45098797', 'Villa 1ro de Mayo B/Porvenir', 2, 2, '0', 1, '-', '75698501', 'yissel.yah@gmail.com', '0', '2020-01-02 07:31:40', 1, '2022-08-02 10:27:25', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2014-03-12', '2014-03-12', 'gabriela.muñoz@ibnorca.org', 1, 0, '3904664013'),
(58, 0, NULL, '4052068', 481, NULL, '1980-12-20', 32, 829, 273, 0, 74, 1, 7859.96, 'Solares', 'Brincil', '', 'Janis', '', '37615920', 'Calle Abdon Saavedra n°751 entre Guachalla y Chaco', 2, 2, '0', 1, '', '79406123', 'jasolbri@gmail.com', '0', '2020-01-02 07:31:50', 1, '2022-08-02 12:44:12', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2007-09-01', '2007-09-01', 'janis.solares@ibnorca.org', 1, 0, '1314114015'),
(59, 1581, NULL, '4022268', 481, NULL, '1979-02-11', 0, NULL, NULL, 0, 73, NULL, NULL, 'Arroyo', 'Mancilla', NULL, 'Jose Luis', NULL, NULL, ' La Paz # 5344 entre Herrera y 1ro de Noviembre', NULL, NULL, NULL, 2, '25258369', '72469217', 'jlam_pp3@hotmail.com', NULL, '2020-10-30 14:14:06', 1, '2022-06-13 14:24:25', 1, 1, 26, 1575, 26, 481, 66, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(62, 1581, NULL, '2709834', 480, NULL, '1966-09-25', 26, 829, 273, 0, 74, 1, 5702.78, 'Cuba', 'Aróstegui', '', 'María Teresa', '', '6587057', 'Plan 110 Manzano 346 Vivienda Nº 54 - Zona Villa Adela', 1, 2, '0', 1, '2833293', '75259903', 't.cuba2004@gmail.com', '0', '2020-01-02 07:31:20', 1, '2022-07-28 23:00:29', 58, 1, 26, 1575, 26, 480, 72, NULL, 1, '2003-09-01', '2003-09-01', 'teresa.cuba@ibnorca.org', 1, 0, '851904018'),
(68, 1581, NULL, '1861999', 485, NULL, '1979-07-23', 5, 5, 40, 0, 73, 1, 7696.71, 'Noriega', 'Salazar', '', 'Fabricio', '', '34557261', 'av. jose saravia Nº252 - Tembladerani', 1, 2, '0', 1, '0', '75808875', 'fabricio.noriega@gmail.com', '0', '2020-01-02 07:30:58', 1, '2022-08-08 15:12:47', 58, 1, 26, 1576, 26, 480, 62, NULL, 2, '2009-09-07', '2009-09-07', 'fabricio.noriega@ibnorca.org', 1, 0, '2045204017'),
(69, 1581, NULL, '4005778', 483, NULL, '1982-01-30', 31, 5, 40, 0, 73, 1, 4312.51, 'Davila', 'Abasto', '', 'Danny Willy', '', '0', 'Calle La Paz No 610 ', 2, 1, '00', 2, '6225503', '72887656', 'danny.davilamm@gmail.com', '0', '2020-01-02 07:31:14', 1, '2021-07-29 09:24:53', 1, 2, 26, 1576, 26, 483, 67, NULL, 2, '2010-07-26', '2010-07-26', NULL, 1, 0, NULL),
(70, 1581, NULL, '8447400', 480, NULL, '1989-04-26', 6, 5, 40, 0, 74, 1, 3627.67, 'Oropeza', 'Graneros', '', 'Katherin Amanda', '', '0', 'zona 1° de mayo N° 4  manzano P', 2, 2, '0', 1, '0', '63175538', 'katherinoro@hotmail.com', '0', '2020-01-02 07:31:15', 1, '2022-08-02 12:27:16', 58, 1, 26, 1576, 26, 480, 72, NULL, 2, '2014-08-01', '2014-08-01', 'katherine.amanda@ibnorca.org', 1, 0, '4299914017'),
(72, 1581, NULL, '3364992', 480, NULL, '1971-04-22', 36, 829, 273, 0, 73, 1, 4595.06, 'Larrea', 'Laguna', '', 'José Luis', '', '0', 'Z/ Villa San Antonio, Calle Mario Mercado N° 25', 2, 2, '0', 1, '', '71565758', 'pplarrea1971@gmail.com', '0', '2020-01-02 07:31:08', 1, '2022-07-28 17:03:01', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2014-02-01', '2014-02-01', 'jose.larrea@ibnorca.org ', 1, 0, '3918254012'),
(74, 1581, NULL, '3784578', 479, NULL, '1975-01-13', 3, 9, 11, 0, 73, 1, 8, 'Peredo', 'Rivas', '', 'Mirko Jean', '', '0', 'Calle Beni N° 235 Edif. Los Angeles depto. 3A', 1, 2, '0', 3, '4798718', '65713661', 'mirkoperedo@hotmail.com', '0', '2020-01-02 07:31:28', 1, '2022-07-28 22:57:33', 58, 1, 26, 1576, 26, 479, 64, NULL, 4, '2016-05-03', '2016-05-03', 'mirko-peredo@ibnorca.org', 1, 0, '0'),
(78, 1581, NULL, '6141327', 480, NULL, '1986-11-23', 41, 5, 12, 0, 74, 1, 9358.47, 'Torrelio', 'Aliaga', '', 'Alejandra Ariela', '', '0', 'Calle Demetrio Canelas Nro. 260 - Zona Obrajes', 1, 2, '0', 1, '0', '59170591546', 'alejandratorrelio@gmail.com', '0', '2020-01-02 07:31:11', 1, '2022-08-08 15:13:27', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2016-11-01', '2016-11-01', 'alejandra.torrelio@ibnorca.org ', 1, 0, '5016734014'),
(81, 1581, NULL, '4876883', 480, NULL, '1988-04-12', 9, 829, 12, 0, 74, 1, 14242.5, 'Sandi', 'Torrico', '', 'Andrea Stephanie', '', '0', 'Los Pinos Calle 2', 2, 1, '0', 2, '2422030', '72040770', 'andrea.sandit@gmail.com', '0', '2020-01-02 07:31:07', 1, '2021-09-30 15:50:50', 1, 1, 26, 1575, 26, 480, 62, NULL, 4, '2014-10-20', '2014-10-20', NULL, 1, 0, NULL),
(84, 0, NULL, '461774', 480, NULL, '1962-02-19', 28, 829, 847, 0, 73, 1, 28717.56, 'Durán ', 'Guillén', '', 'José Jorge', '', '0', 'La Paz', 1, 2, '0', 1, '0', '71548486', 'joseduranguillen@gmail.com', '0', '2020-01-02 07:30:50', 1, '2022-07-28 15:35:18', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2014-10-27', '2014-10-27', 'jose.duran@ibnorca.org ', 1, 0, '4287794024'),
(87, 0, NULL, '9358826', 479, NULL, '1995-02-21', 14, 9, 273, 0, 74, 1, 4000, 'Hinojosa', 'Cusicanqui', '', 'Helen', '', '0', 'Av. Fuerza Aérea Calle Patricia Lara', 1, 2, '0', 2, '79734635', '79734625', 'helenhinojosac@gmail.com', '0', '2020-01-02 07:31:25', 1, '2021-07-25 17:24:12', 90, 1, 26, 1575, 26, 479, 64, NULL, 2, '2017-04-03', '2017-04-03', '00', 1, 0, '0'),
(89, 1581, NULL, '5976118', 480, NULL, '1983-01-28', 30, 829, 273, 0, 73, 1, 9673.79, 'Mamani', 'Maji', '', 'Julio Alejandro', '', '32492327', 'Achumani, Zona Pantini Calle 6 de Agosto Nº 30 ', 2, 2, '19830128', 1, '', '78875720', 'alexander.mamani@gmail.com', '0', '2020-01-02 07:31:06', 1, '2022-08-08 14:50:57', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2002-03-01', '2002-03-01', 'julio.mamani@ibnorca.org', 1, 0, '0725294018'),
(90, 1581, NULL, '3358308', 480, NULL, '1970-08-28', 21, 829, 273, 0, 73, 1, 14922.17, 'Quenallata', 'Vega ', '', 'Juan Luis ', '', '31521721', 'Calle 8 N° 38 Villa San Antonio Bajo ', 2, 2, '0', 1, '2238301', '70567822', 'juanquenallata28@gmail.com', '0', '2020-01-02 07:31:05', 1, '2022-07-28 16:38:34', 58, 1, 26, 1576, 26, 480, 62, NULL, 1, '1999-03-01', '1999-03-01', 'juan.quenallata@ibnorca.org', 1, 0, '569494010'),
(91, NULL, NULL, '4937844', NULL, NULL, '0000-00-00', 7, 829, 847, 0, NULL, 1, 3840.2, 'Sierra', '', '', 'Sandra', '', '0', NULL, 1, 1, '0', 2, NULL, NULL, 'sasiviscarra@gmail.com', '0', '2020-01-02 07:30:51', 1, '2020-09-16 12:01:34', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2016-06-03', '2016-06-03', NULL, 1, 0, NULL),
(92, 1581, NULL, '5959142', 480, NULL, '0000-00-00', 28, 5, 39, 0, NULL, 1, 8218.03, 'Aldunate', 'Castedo', '', 'Carla Monica', '', '545421212', NULL, 1, 1, '545465654', 3, NULL, NULL, 'carla.aldunate@live.ca', 'JUAN PEREZ', '2020-01-02 07:31:09', 1, '2021-07-30 06:50:18', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 4, '2016-06-07', '2016-06-07', '', 1, 0, NULL),
(93, 1581, NULL, '5954152', 480, NULL, '1990-08-14', 18, 829, 871, 0, 74, 1, 8939.22, 'Gallardo', 'Strelli', '', 'Maria Renée', '', '0', 'Av. Arce esq. Montevideo N° 2081', 1, 2, '0', 1, '2440117', '70520736', 'mariareneegallardo@gmail.com', '0', '2020-01-02 07:30:52', 1, '2022-07-28 15:39:54', 58, 1, 0, 1575, 26, 480, NULL, NULL, 4, '2016-10-06', '2016-10-06', 'maria.gallardo@ibnorca.org ', 1, 0, '5369544014'),
(96, 1581, NULL, '8331509', 480, NULL, '1994-01-26', 4, 5, 2957, 0, 74, 1, 4232.28, 'OSCO', 'CESPEDES', '', 'Glicet', '', '0', 'Zona Ovejuyo Callejon Eucaliptos Nro 7', 1, 2, '0', 1, '0', '68065047', 'glis26cha@gmail.com', '0', '2020-01-02 07:30:57', 1, '2022-07-28 22:30:02', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2017-03-01', '2017-03-01', 'glicet.osco@ibnorca.org ', 1, 0, '5665884017'),
(97, 1581, NULL, '8411443', 0, NULL, '1992-05-20', 15, 829, 2978, 0, 74, 1, 4120, 'Cochi', 'Tarqui', '', 'Carla Noelia', '', '0', 'calle pio XII Nro 99 Bella Vista', 2, 2, '0', 1, '', '65633785', 'carli.noeli0520@gmail.com', '0', '2020-01-02 07:30:59', 1, '2022-07-28 22:03:46', 58, 1, 26, 1575, 26, 480, 62, NULL, 2, '2018-02-01', '2018-02-01', 'carla.cochi@ibnorca.org ', 1, 0, '6123664017'),
(99, 1581, NULL, '2763530', 481, NULL, '1969-02-12', 19, 829, 872, 0, 74, 1, 9360, 'Mendez', 'Leclere', '', 'Martha', '', '0', 'Av. Arce No. 2896, San Jorge', 2, 1, '0', 2, '2430051', '70687412', 'mml.12395@gmail.com', '0', '2020-01-02 07:31:02', 1, '2021-02-23 16:37:11', 1, 1, 26, 1576, 26, 480, 62, NULL, 4, '2018-02-01', '2018-02-01', NULL, 1, 0, NULL),
(101, 1581, NULL, '10325029', 478, NULL, '1992-02-04', 15, 270, 2978, 0, 74, 1, 3259.95, 'LLANQUIPACHA', 'ROJAS', '', 'VERONICA', '', '49283091', 'Sebastian Pagador Nro 81', 2, 2, '0', 1, '-', '74457742', 'verito123r@gmail.com', '0', '2020-01-02 07:31:52', 1, '2022-08-02 12:19:33', 58, 1, 26, 1575, 26, 478, 69, NULL, 4, '2017-05-02', '2017-05-02', 'veronica.llamquipacha.ibnorca.org ', 1, 0, '5226914023'),
(114, 0, NULL, '4079945', 477, NULL, '1969-12-31', 0, 0, 0, 0, 74, 0, 0, 'VILLARROEL', 'LARRAZABAL', '', 'JANET', '', '', '-', 0, 0, '', 2, '0', '72478279', 'janet_villarroel@hotmail.com', '', '2020-01-02 07:31:49', 1, '2020-09-16 12:01:34', 1, 1, 0, 0, 26, 484, 65, NULL, 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(118, 1581, NULL, '5211933', 479, NULL, '1980-11-10', 10, 9, 12, 0, 74, 1, 5, 'Almanza', 'Aguirre', '', 'Mariela Julia', '', '0', 'Circuito Bolivia / Calle 7  - Edificio Calicanto', 1, 2, '0', 3, '4506606', '72723122', 'mariela.almanza.aguirre@gmail.com', '0', '2020-01-02 07:31:32', 1, '2021-07-12 14:45:05', 195, 1, 26, 1576, 26, 479, 64, NULL, 4, '2010-09-13', '2010-09-13', 'SN', 1, 0, '0'),
(141, 1581, NULL, '6030222', 480, NULL, '1987-04-16', 38, 10, 11, 0, 73, 1, 5683.35, 'Padilla', 'Avalos', '', 'Iván', '', '0', 'Barrio Virgen de Guadalupe, Calle San Simón, Nro. 8370, Zona Norte', 2, 2, '0', 1, '', '75583591; 78475', 'ivan.padilla.avalos87@gmail.com', '0', '2020-01-02 07:31:43', 1, '2022-08-02 10:39:56', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2017-06-19', '2017-06-19', 'ivan.padilla@ibnorca.org ', 1, 0, '5866444015'),
(168, 1581, NULL, '3479988', 480, NULL, '1970-12-03', 35, 829, 273, 0, 74, 1, 3627.67, 'Mallea', 'Ortiz', '', 'Rocio', '', '11563591', 'Pampahasi, Calle 1 N° 60', 1, 2, '0', 1, '', '78804104', 'francymalleaortiz3@gmail.com', '0', '2020-01-02 07:31:01', 1, '2022-08-08 14:51:30', 58, 1, 26, 1575, 26, 480, 62, NULL, 2, '2007-09-01', '2007-09-01', 'rocio.mallea@ibnorca', 1, 0, '1312974017'),
(173, 1581, NULL, '4880453', 480, NULL, '1988-03-19', 38, 5, 11, 0, 73, 1, 4836.9, 'Zapata', 'Aviles', '', 'Jose', '', '0', 'Calle 60 Chasquipampa #10', 1, 2, '0', 1, '', '70530205', 'josezapataviles@gmail.com', '0', '2020-01-02 07:31:18', 1, '2022-07-28 23:03:54', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2018-03-01', '2018-03-01', 'jose.zapata@ibnorca.org ', 1, 0, '6175644014'),
(176, 1581, NULL, '8464972', 480, NULL, '1993-08-29', 9, 829, 12, 0, 73, 1, 6180, 'Vargas', 'Saucedo', '', 'Oscar Alejandro', '', '32492327', 'Av. Hugo Ernest, 48', 2, 2, '0', 1, '0', '79551284', 'oscarvargas.sa@gmail.com', '0', '2020-01-02 07:30:56', 1, '2022-07-28 22:05:58', 58, 1, 26, 0, 26, 480, 62, NULL, 4, '2018-03-01', '2018-03-01', 'oscar.vargas@ibnorca.org ', 1, 0, '6252374017'),
(177, 1581, NULL, '6699734', 483, NULL, '1990-02-19', 43, 829, 2957, 0, 74, 1, 6435.44, 'Zarate', 'Cazas', '', 'Cintya Marcela', '', '45102673', 'Calle 31 de achumani condominio claveles del sur 2da terraza', 2, 2, '0', 1, '', '73477524', 'cintycazas@gmail.com', '0', '2020-01-02 07:31:13', 1, '2022-07-28 22:24:10', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2018-03-15', '2018-03-15', 'cintya.zarate@ibnorca.org', 1, 0, '4577434013'),
(181, 1581, NULL, '3029088', 479, NULL, '1967-07-17', 26, 9, 273, 0, 74, 1, 4122.46, 'Sejas', 'Gallardo', '', 'Elizabeth', '', '34081859', 'Av. Capitan Ustaris Km 6 S/N', 1, 2, '0', 1, '4433589', '77988302', 'esg1717@hotmail.com', '0', '2020-01-02 07:31:31', 1, '2022-08-02 11:26:49', 58, 1, 26, 1577, 26, 479, 64, NULL, 1, '2005-01-03', '2005-01-03', 'elizabeth.sejas@ibnorca.org', 1, 0, '940904013'),
(182, 1581, NULL, '2396185', 480, NULL, '1971-02-22', 4, 5, 11, 0, 73, 1, 4595.06, 'Velásquez', 'Camargo', '', 'Edving Gustavo', '', '0', 'Cota Cota Calle 28 Nro 500', 2, 2, '0', 1, '', '69751350', 'edvingustavo@gmail.com', '0', '2020-01-02 07:31:19', 1, '2022-07-28 23:05:29', 58, 1, 26, 1576, 26, 480, 72, NULL, 2, '2018-05-02', '2018-05-02', 'edving.velasquez@ibnorca.org ', 1, 0, '2619234017'),
(183, 1581, NULL, '2380100', 480, NULL, '1963-10-30', 45, 829, 13, 0, 73, 1, 8569.6, 'Rojas', 'Urquizo', '', 'Luis Fernando', '', '0', 'Calle E. N° 1993. Irpavi 2', 2, 2, '0', 1, '2723814', '65170598', 'lfrojasu@gmail.com', '0', '2020-01-02 07:30:53', 1, '2022-07-28 22:52:37', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2018-03-12', '2018-03-12', 'luis.rojas@ibnorca.org ', 1, 0, '5851174011'),
(187, 0, NULL, '9336085', 479, NULL, '1994-11-08', 0, 9, 2978, 0, 74, 1, 3, 'Montan', 'Arze', '', 'Maria Laura', '', '0', 'Av. Heroes del boqueron', 2, 2, '0', 2, '', '', 'montanarzelaura@gmail.com', '0', '2020-01-02 07:31:34', 1, '2022-07-28 21:30:19', 58, 1, 26, 1575, 26, 479, 64, NULL, 2, '2018-06-04', '2018-06-04', 'laura.montan@ibnorca.org', 1, 0, '0'),
(195, 1581, NULL, '6832691', 480, NULL, '1994-03-07', 20, 829, 871, 0, 74, 1, 4243.6, 'Aruquipa', 'Choque', '', 'Iveth Tania', '', '32492327', 'Av. Entre Ríos, Zona Mariscal Santa Cruz', 1, 2, '0', 1, '', '63145042', 'taniaiveth2017@gmail.com', '0', '2020-01-02 07:30:53', 1, '2022-07-28 15:43:13', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2018-02-01', '2018-02-01', 'iveth.aruquipa@ibnorca.org ', 1, 0, '6163114010'),
(203, 0, NULL, '6692817', 483, NULL, '1991-01-17', 8, 5, 13, 0, 74, 1, 4, 'Campos', 'Poveda', '', 'Alejandra', '', '0', 'Av Pablo Sanchez 6318', 1, 2, '0', 3, '', '71810010', 'alegita268@gmail.com', '0', '2020-01-02 07:31:22', 1, '2022-07-19 15:39:30', 58, 2, 26, 1575, 26, 480, 62, NULL, 4, '2018-10-08', '2018-10-08', 'alejandra.campos@ibnorca.org', 1, 0, '0'),
(222, 1581, NULL, '7842974', 484, NULL, '1991-06-16', NULL, NULL, NULL, 0, 74, NULL, NULL, 'Flores', 'Chosco', NULL, 'Maribel', NULL, NULL, 'Zona Pampa de la Isla Barrio Urkupiña Calle 1', NULL, NULL, NULL, 2, '', '73167911', 'mfchosco1991@gmail.com', NULL, '2020-10-01 15:00:18', 1, '2020-10-01 15:00:18', 1, 1, 26, 1575, 26, 484, 65, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(226, NULL, NULL, 'CIVACIO', NULL, NULL, '0000-00-00', 0, 0, 0, 0, NULL, 0, 0, 'Duran', 'MartÃ­nez', '', 'Paola Andrea', '', '', NULL, 0, 0, '', 2, NULL, NULL, 'paola.duran@ibnorca.org', '', '2020-01-02 07:31:51', 1, '2021-07-25 17:22:48', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(227, 1581, NULL, '9253211', 480, NULL, '1994-02-09', 20, 829, 871, 0, 74, 1, 4232.27, 'Casas', 'Huanca', '', 'Ivonne Gloria', '', '0', 's/n', 2, 2, '0', 1, '', '63122448', 'ig.casas0294@gmail.com', '0', '2020-01-02 07:31:07', 1, '2022-07-28 15:48:56', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2019-02-01', '2019-02-01', 'ivonne.casas@ibnorca.org', 1, 0, '6751734016'),
(228, 1581, NULL, 'CIVACIO', 481, NULL, '1988-11-01', 0, 8, 502, 0, 74, 1, 3000, 'Peñaranda', 'Mariño', '', 'Carmen Andrea', '', '0', 'Av. 6 de Octubre N° 6113 entre Bolivar y Sucre', 1, 2, '0', 2, '5240414', '69584772', 'carmen.penaranda@ibnorca.org', '0', '2020-01-02 07:31:50', 1, '2020-09-16 12:01:34', 90, 1, 26, 1575, 26, 481, 66, NULL, 4, '2019-03-15', '2019-03-15', '0', 1, 0, '0'),
(241, 1581, NULL, '8557876', 483, NULL, '1991-05-27', 27, 5, 502, 0, 73, 1, 2600, 'Mamani', 'Javier', '', 'Ariel Teo', '', '0', 'Lidio Ustares Nro 384', 1, 1, '0', 2, '', '8557876', 'ariel_teo_adm@hotmail.com', '0', '2020-01-02 07:31:55', 1, '2020-09-16 12:01:34', 1, 1, 26, 1575, 26, 483, 67, NULL, 2, '2019-05-02', '2019-05-02', NULL, 1, 0, NULL),
(264, NULL, '', '9626984', 0, '', '1979-07-09', 0, 0, 0, 0, 0, 0, 0, 'Espinoza', 'Torrez', '', 'Adriana Lenin', '', '', 'Av. Villalobos #1883 Zona Miraflores', 0, 0, '', 2, '', '76301362', 'adrianita_lenin_10@hotmail.com', '', '2020-01-02 07:31:47', 1, '2020-09-16 12:01:34', 1, 1, NULL, NULL, NULL, NULL, NULL, '', 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(274, 1581, NULL, '9613128', 484, NULL, '1994-07-22', 0, 10, 13, 0, 73, 1, 3500, 'Peña', 'Gómez', '', 'Jorge Custodio', '', '0', 'C/Cap. Rodriguez 163', 1, 2, '0', 2, '', '75386252', 'jorgecustodiopenagomez@gmail.com', '0', '2020-01-02 07:31:47', 1, '2020-09-16 12:01:34', 90, 1, 26, 1575, 26, 484, 65, NULL, 2, '2019-06-03', '2019-06-03', '0', 1, 0, '0'),
(277, 1581, NULL, '6017633', 480, NULL, '1989-07-05', 17, 829, 826, 0, 73, 1, 5085.52, 'Gutierrez', 'Tambo', '', 'Luis Erwin', '', '0', 'Zona Cupilupaca Calle Rio Chapare N° 2064', 2, 2, '0', 1, '2852248', '78892941', 'legtforever@gmail.com', '0', '2020-01-02 07:31:04', 1, '2022-08-02 12:14:35', 58, 1, 26, 1575, 26, 480, 72, NULL, 4, '2019-05-02', '2019-05-02', 'luis.gutierrez@ibnorca.org ', 1, 0, '0'),
(286, 0, NULL, '3372876', 480, NULL, '1984-01-09', 10, 829, 871, 0, 74, 1, 6000, 'Diaz', 'Osuna', '', 'Fulvia', '', '0', 'JosÃ¯Â¿Â½ Montero 98', 1, 1, '0', 2, '2147483647', '72020888', 'fulviad@gmail.com', '0', '2020-01-02 07:30:54', 1, '2021-07-25 17:22:07', 1, 2, 0, 0, 26, 480, 62, NULL, 4, '2019-07-08', '2019-07-08', NULL, 1, 0, NULL),
(5414, 1581, NULL, '7737727', 484, NULL, '1988-09-24', 27, 10, 502, 0, 73, 1, 3, 'Alegre', 'Serrudo', '', 'Jorge Luis', '', '0', 'Urbanizacion jardin del sur', 1, 2, '0', 3, '59165037949', '59165037949', 'jorge.alegreserrudo@gmail.com', '0', '2020-09-30 11:14:20', 1, '2020-10-19 23:58:42', 90, 1, 26, 0, 26, 484, 65, NULL, 1, '2015-07-06', '2015-07-06', '0', 1, 0, '0'),
(10089, 1581, NULL, '5767034', 481, NULL, '1989-06-09', NULL, NULL, NULL, 0, 73, NULL, NULL, 'Flores', 'Colque', NULL, 'EFRAIN', NULL, NULL, 'Villa 14 de Septiembre', NULL, NULL, NULL, 2, '73845754', '73845754', 'efrain_susi@hotmail.com', NULL, '2020-07-06 21:38:40', 1, '2021-07-29 09:24:53', 1, 1, 26, 1576, 26, 479, 64, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(11942, 1581, NULL, '8446055', 480, NULL, '1991-03-27', 34, 829, 4357, 0, 74, 1, 3500, 'Krings', 'Castelo', '', 'Katheryn', '', '0', 'Zona El Kenko', 1, 2, '0', 1, '', '77710020', 'kattykrings@hotmail.com', '0', '2022-04-08 13:25:37', 1, '2022-07-28 16:36:28', 58, 1, 26, 1575, 26, 480, 72, NULL, 4, '2022-04-04', '2022-04-04', 'katheryn.krings@ibnorca.org', 1, 0, '8245154012'),
(12778, 0, NULL, '7888056', 0, NULL, '1988-07-11', 31, 5, 40, 0, 0, 1, 3000, 'Mamani', 'Bonifaz', '', 'Dimelsa', '', '0', 'c/Federico de Medina Nº 2915', 2, 1, '0', 2, '2845213', '79637699', 'melsadibonifaz23@gmail.com', '0', '2020-01-02 07:31:16', 1, '2020-09-16 12:01:34', 1, 1, 0, 0, 26, 480, 62, NULL, 2, '2019-07-01', '2019-07-01', NULL, 1, 0, NULL),
(14312, 1581, NULL, '6195776', 480, NULL, '1988-05-18', 0, 829, 871, 0, 73, 1, 7, 'Nemer', 'Kattan', '', 'Juan Pablo', '', '0', 'Av. 6 de agosto N 255', 1, 2, '0', 3, '2441788', '62512229', 'jpnemerkattan@gmail.com', '0', '2021-09-29 17:25:44', 1, '2022-07-28 21:30:40', 58, 1, 0, 1575, 26, 480, NULL, NULL, 0, '2021-05-10', '2021-05-10', 'juan.nemer@ibnorca.org ', 1, 0, '0'),
(14793, 1581, NULL, '4867125', 480, NULL, '1988-08-26', 31, 5, 12, 0, 73, 1, 5150, 'Pacheco', 'Paredes', '', 'Rodrigo Andres', '', '0', 'La Paz', 2, 2, '0', 1, '0', '77284228', 'rodrigo.a.pachpar@gmail.com', '0', '2020-01-02 07:31:00', 1, '2022-07-28 22:14:58', 58, 1, 26, 0, 26, 480, 62, NULL, 4, '2019-10-14', '2019-10-14', 'rodrigo.pacheco@ibnorca.org ', 1, 0, '6538144019'),
(17171, 1581, NULL, '8874038', 484, NULL, '1994-05-04', 0, 10, 502, 0, 74, 1, 3350, 'Saavedra', 'Flores', '', 'Leydi', '', '0', 'Plan 3000 Av. Paurito B/ San Agustin C/4', 2, 2, '0', 2, '0', '75334312', 'leydicita42@gmail.com', '0', '2020-07-07 18:26:03', 1, '2020-09-16 12:01:34', 90, 1, 26, 1575, 26, 484, 65, NULL, 4, '2019-06-17', '2019-06-17', '00', 1, 0, '0'),
(18391, 1581, NULL, '6402181', 479, NULL, '1984-08-29', 17, 10, 826, 0, 73, 1, 4520.46, 'TERRAZAS', 'ORELLANA', '', 'RUBEN', '', '43868502', 'Av. Repuclica s/n', 1, 2, '0', 1, '', '70391920', 'rubeggg@gmail.com', '0', '2020-01-02 07:31:38', 1, '2022-08-02 12:45:54', 58, 1, 26, 1575, 26, 484, 48387, NULL, 4, '2017-08-14', '2017-08-14', 'ruben.terrazas@ibnorca.org', 1, 0, '5866944018'),
(19862, 1581, NULL, '3788956', 479, NULL, '1971-09-25', 27, 9, 273, 0, 74, 1, 3433.9, 'Villegas', 'Zurita', '', 'Evelyn Amanda', '', '25751414', 'Av.Chapare Km 4  Barrio Fabril ', 2, 2, '0', 1, '0', '72259830', 'ev266494@gmail.com', '0', '2020-09-16 14:17:23', 1, '2022-08-02 11:27:45', 58, 1, 26, 1575, 26, 479, 48446, NULL, 1, '2007-07-02', '2007-07-02', 'evelyn.villegas@ibnorca.org', 1, 0, '1313574012'),
(19947, 0, NULL, '5032898', 485, NULL, '1979-11-08', 31, 829, 12, 0, 74, 1, 4635, 'YAÑEZ', 'BALANZA', '', 'CLAUDIA IRENE', '', '0', 'Av. Javier del Granado N° 101, Lomas de Achumani', 2, 2, '0', 1, '0', '78798895', 'yanez_clau@hotmail.com', '0', '2021-10-19 15:42:47', 1, '2022-07-28 22:17:47', 58, 1, 26, 1576, 26, 480, 62, NULL, 0, '2021-05-10', '2021-05-10', 'claudia.yañez@ibnorca.org ', 1, 0, '0'),
(30030, 1581, NULL, '7999000', 479, NULL, '2019-07-28', 0, 0, 0, 0, 73, 0, 0, 'Barrionuevo', 'Chileno', '', 'Edgar', '', '', 'av. circunvalacion', 0, 0, '', 2, '5914306368', '59165725642', 'barrionuevomario936@gmail.com', '', '2020-01-02 07:31:35', 1, '2020-09-16 12:01:34', 1, 1, 26, 0, 26, 479, 64, NULL, 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(30072, 1581, NULL, '6959046', 480, NULL, '2019-03-07', 21, 5, 502, 0, 73, 1, 3000, 'Flores', 'Ramirez', '', 'José Manuel', '', '0', 'c/mayor lopera #429 z/ villafatima', 1, 1, '0', 2, '76721610', '70595763', 'vandoleropepito@gmail.com', '0', '2020-01-02 07:31:10', 1, '2020-09-16 12:01:34', 1, 1, 26, 0, 26, 480, 62, NULL, 2, '2019-08-10', '2019-08-10', NULL, 1, 0, NULL),
(31386, 1581, NULL, '5313587', 479, NULL, '1989-09-23', 13, 9, 2978, 0, 74, 1, 7210, 'Teran', 'Castellon', '', 'Fabiola', '', '0', 'Edif. Torre San Francisco- Zona Tránsito', 2, 2, '0', 1, '', '59170723598', 'faby_teran_c@hotmail.com', '0', '2020-01-02 07:31:33', 1, '2022-08-02 10:54:42', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2019-09-02', '2019-09-02', 'fabiola.teran@ibnorca.org ', 1, 0, '7135174011'),
(31751, 1581, NULL, '4094431', 478, NULL, '1995-03-18', 0, 5, 11, 0, 73, 1, 3000, 'Yuras', 'Calbimonte', '', 'Vinko Stijepan ', '', '0', 'Av. Banzer 7mo Anillo, Condominio Milenium Nro. 10', 2, 2, '0', 2, '', '79496181', 'extreda@hotmail.com', '0', '2020-01-02 07:31:48', 1, '2020-10-30 12:48:20', 90, 1, 26, 0, 26, 484, 65, NULL, 4, '2019-09-09', '2019-09-09', '0', 1, 0, '0'),
(32173, 0, NULL, '10012140', 480, NULL, '1992-03-21', NULL, NULL, NULL, 0, 74, NULL, NULL, 'MITA', 'AIZA', NULL, 'INGRID', NULL, NULL, '-', NULL, NULL, NULL, 2, '0', '65597090', 'aiza.ingrid123@gmail.com', NULL, '2021-06-26 10:59:29', 1, '2021-06-26 10:59:29', 1, 1, 26, 1575, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(33070, 0, NULL, '92706992', 0, NULL, '1980-05-26', NULL, NULL, NULL, 0, 73, NULL, NULL, 'Norén', '', NULL, 'Jonas', NULL, NULL, 'Björnssonsgatan 141', NULL, NULL, NULL, 2, '0703572656', NULL, 'jonas.noren@norcon.se', NULL, '2020-10-30 12:48:20', 1, '2020-10-30 12:48:20', 1, 1, 0, 0, 211, 3416, 39186, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(33355, 1581, NULL, '4863668', 480, NULL, '1991-12-28', 4, 829, 2957, 0, 74, 1, 2575, 'Quisbert', 'Cabrera', '', 'Elena Andrea', '', '3158264012', 'Calle Casimiro Corrales 1078, Zona Miraflores', 2, 2, '0', 1, '2245035', '77564360', 'andreaqcabrera28@gmail.com', '0', '2021-10-19 15:42:46', 1, '2022-07-28 22:45:15', 58, 1, 26, 1575, 26, 480, 62, NULL, 0, '2021-08-02', '2021-08-02', 'elena.quisbert@ibnorca.org ', 1, 0, '4996354020'),
(34149, 1581, NULL, '3464298', 480, NULL, '1973-11-27', 27, 829, 273, 0, 74, 1, 4232.28, 'Ichuta', 'Triguero', '', 'Maria Elizabeth', '', '27097560', 'Calle C # 10 z. Amp. Alto ciudadela ', 1, 2, '0', 1, '2301875', '71914529', 'maria.ichutatemporal@ibnorca.org', '0', '2020-01-06 18:32:40', 1, '2022-07-28 17:04:45', 58, 1, 26, 1578, 26, 480, 62, NULL, 1, '1997-08-01', '1997-08-01', 'maria.ichuta@ibnorca.org', 1, 0, '569704014'),
(38166, 1581, NULL, '8333170', 480, NULL, '1991-04-15', 15, 10, 2978, 0, 74, 1, 2500, 'Estevez', 'Valverde', '', 'Isabel', '', '0', 'Av, San Martin, calle Hugo Wast oeste, 16.', 1, 2, '0', 1, '-', '63253645', 'isabest.val@gmail.com', '0', '2022-04-06 10:44:32', 1, '2022-08-08 15:14:38', 58, 1, 0, 0, 26, 484, NULL, NULL, 0, '2022-04-04', '2022-04-04', 'isabel.estevez@ibnorca.org', 1, 0, '8226824015'),
(41467, 1581, NULL, '6137694', 480, NULL, '1989-10-30', 31, 829, 12, 0, 74, 1, 5150, 'Gutierrez', 'Alcaraz', '', 'Mayra Daniela', '', '47171580', 'Achumani Urb. Huacollo Calle 8 Nº135', 2, 2, '0', 1, '', '59170590795', 'mayra.d.g.a@gmail.com', '0', '2021-09-29 17:25:44', 1, '2022-07-28 22:08:36', 58, 1, 26, 1576, 26, 480, 62, NULL, 0, '2021-04-01', '2021-04-01', 'mayra.gutierrez@ibnorca.org ', 1, 0, '0'),
(42820, 1581, NULL, '6326757', 484, NULL, '1988-07-07', NULL, NULL, NULL, 0, 74, NULL, NULL, 'Romero', 'Ayala', NULL, 'Claudia Victoria', NULL, NULL, 'Av. La Barranca 3er anillo Externo', NULL, NULL, NULL, 2, '', '75380038', 'claudiavictoriaromeroayala@gmail.com', NULL, '2021-06-26 10:59:29', 1, '2021-06-26 10:59:29', 1, 1, 26, 1576, 26, 484, 65, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(43686, 1581, NULL, '7010535', 480, NULL, '1976-11-13', 27, 829, 273, 0, 73, 1, 2678, 'Mamani', 'Coaquira', '', 'Jorge Javier', '', '0', 'Av. Tiahunacu #35', 1, 2, '0', 1, '', '77560892', 'jorge.mamani@ibnorca.org', '0', '2020-09-30 11:14:20', 1, '2022-07-28 23:01:53', 58, 1, 26, 1576, 26, 480, 72, NULL, 1, '2019-05-02', '2019-05-02', 'javier.mamani@ibnorca.org ', 1, 0, '923854019'),
(44953, 1581, NULL, '4961095', 480, NULL, '1978-06-30', 17, 829, 826, 0, 73, 1, 5665, 'CONDE', 'MERLO', '', 'JUAN JOSE ', '', '0', 'AV. JORGE CARRASCO # 58 Z.12 DE OCTUBRE', 1, 2, '0', 1, '', '72568220', 'juanjo.ose00@gmail.com', '0', '2021-06-26 10:59:29', 1, '2022-07-28 21:44:14', 58, 1, 26, 1575, 26, 480, 72, NULL, 4, '2021-06-14', '2021-06-14', 'jose.duran@ibnorca.org', 1, 0, '5684244011'),
(45902, 1581, NULL, '4868422', 480, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 'LUNA', 'GONZALES', NULL, 'MARCO ANTONIO ', NULL, NULL, 'Calle Alvarez Plata Nro. 32 Edificio Sin Nombre Piso 2 Depto. S/N', NULL, NULL, NULL, 2, '60503103', NULL, 'lunagonzalesmarco@gmail.com', NULL, '2022-03-03 11:03:09', 1, '2022-03-03 11:03:09', 1, 1, 26, 0, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(47770, 0, NULL, 'IBN0001', 480, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 'Externa', '', NULL, 'Consulta', NULL, NULL, 'Obrajes', NULL, NULL, NULL, 2, '', '', 'consultafinanzas@personal.com', NULL, '2021-02-23 16:37:11', 1, '2021-06-26 10:59:29', 1, 1, 26, 0, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(49337, 1581, NULL, '3422118', 480, NULL, '1983-10-31', 17, 829, 826, 0, 73, 1, 5665, 'Navia', 'Morant', '', 'Hernan Rene', '', '39094421', 'Armando Chirveches Nª 2079 Zona Sopocachi', 1, 2, '0', 1, '', '78777816', 'hernanrnaviam@gmail.com', '0', '2021-09-29 17:25:44', 1, '2022-07-28 21:42:28', 58, 1, 26, 1575, 26, 480, NULL, NULL, 0, '2021-06-08', '2021-06-08', 'hernan.navia@ibnorca.org', 1, 0, '2098174021'),
(51088, 1581, NULL, '4767218', 480, NULL, '1980-01-01', 14, 829, 2978, 0, 73, 1, 6180, 'VILLANUEVA', 'CAMPOS', '', 'MARCO ANTONIO', '', '39538850', 'Irpavi 2  Calle Jazmines, esquina Gorrión Edificio Gonzales Depto 103', 1, 2, '0', 1, '', '79524504', 'labodegavisual@gmail.com', '0', '2021-07-14 01:40:16', 1, '2022-07-28 21:58:50', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2021-06-28', '2021-06-28', 'marco.villanueva@ibnorca.org', 1, 0, '0'),
(52253, 1581, NULL, '7487210', 478, NULL, '1991-10-31', 14, 829, 2978, 0, 73, 1, 3, 'VEIZAGA', 'ESCOBAR', '', 'JOSE MANUEL', '', '0', 'Av. Emilio Mendizabal 174', 2, 2, '0', 3, '64-23245', '59175790670', 'josenolisco1@gmail.com', '0', '2021-07-29 12:59:20', 1, '2022-07-28 22:58:13', 58, 1, 26, 1575, 26, 478, 69, NULL, 1, '2021-07-26', '2021-07-26', '0', 1, 0, '0'),
(53050, 1581, NULL, '4841733', 480, NULL, '1992-11-07', 31, 829, 12, 0, 73, 1, 3605, 'Pardo', 'Velasco', '', 'Herlan Ariel', '', '47521739', 'calle vincentti#661 zona Sopocachi', 1, 2, '0', 1, '', '59167170885', 'arielhys73@gmail.com', '0', '2021-11-14 17:03:58', 1, '2022-07-28 22:20:13', 58, 1, 26, 1575, 26, 480, 0, NULL, 0, '2021-09-06', '2021-09-06', 'herlan.pardo@ibnorca.org ', 1, 0, '4318454014'),
(53175, 1581, NULL, '5686184', 478, NULL, '1994-11-05', NULL, NULL, NULL, 0, 73, NULL, NULL, 'Gómez', 'Andrade', NULL, 'Rodrigo', NULL, NULL, 'Ladislao Cabrera esquina Jaime Mendoza', NULL, NULL, NULL, 2, '', '59177123674', 'rodriigomezandrade@gmail.com', NULL, '2021-09-29 17:25:44', 1, '2021-09-29 17:25:44', 1, 1, 26, 1575, 26, 478, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(57982, 1581, NULL, '6943919', 480, NULL, '1990-12-08', NULL, NULL, NULL, 0, 73, NULL, NULL, 'Rodriguez', 'Alvarez', NULL, 'Jose Tiago', NULL, NULL, 'San Antonio Bajo Calle 9 N°555', NULL, NULL, NULL, 2, '2230936', '72563620', 'tiago.jra1303@gmail.com', NULL, '2022-04-06 10:44:31', 1, '2022-04-06 10:44:31', 1, 1, 26, 1575, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL),
(58493, 1581, NULL, '6961965', 480, NULL, '1997-08-17', 2, 829, 2957, 0, 74, 1, 4000, 'Sainz', 'Quiroga', '', 'Soraya Camila', '', '48506576', 'Achumani Calle 32 #55', 1, 2, '0', 1, '', '65604604', 'sainzsoraya@gmail.com', '0', '2022-04-06 10:44:31', 1, '2022-07-28 22:47:49', 58, 1, 26, 0, 26, 480, 62, NULL, 1, '2022-04-04', '2022-04-04', 'soraya.sainz@ibnorca.org', 1, 0, '3601674016'),
(58969, 1581, NULL, '2371102', 480, NULL, '2022-05-30', 14, 829, 2978, 0, 73, 1, 0, 'Montaño', 'Ortiz', '', 'Sandra Jimena', '', '0', 'Av Illimani N. 1908A', 1, 2, '0', 2, '', '72095591', 'sandrisortiz2018@gmail.com', '0', '2022-06-13 14:24:25', 1, '2022-07-28 21:28:35', 58, 1, 0, 0, 26, 480, NULL, NULL, 1, '2020-01-01', '2020-01-01', '0', 1, 0, '0'),
(59556, 1581, NULL, '8321377', 480, NULL, '1998-07-24', NULL, 829, NULL, 0, 74, NULL, NULL, 'Pinto', 'Quispe', NULL, 'Dailyn Belen', NULL, NULL, 'Bajo Llojeta Calle Los Nardos #77', NULL, NULL, NULL, 2, '', '61118740', 'dailynpinto77@gmail.com', NULL, '2022-06-13 14:24:25', 1, '2022-06-13 14:25:27', 1, 1, 26, 1575, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal2`
--

CREATE TABLE `personal2` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_area` int(11) DEFAULT NULL,
  `cod_unidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `personal2`
--

INSERT INTO `personal2` (`codigo`, `nombre`, `cod_area`, `cod_unidad`) VALUES
(1, 'ADM', 15, 1),
(5, 'WILLY MIRANDA', 826, 829),
(6, 'ADMT', 15, 1),
(7, 'ANNELIESSE PRUDENCIO', 13, 4),
(8, 'PEDRO CARDOZO', 13, 1624),
(9, 'GONZALO ROMERO', 826, 829),
(10, 'CONSULTA NORMAS', 137, 1),
(12, 'RODRIGO VELASCO', 873, 5),
(13, 'RENE CASTRO', 39, 1624),
(14, 'VALERIA ESPINOZA', 12, 5),
(15, 'CRISTINA MEJIA', 826, 1625),
(16, 'ROXANA LLANO', 12, 829),
(17, 'YSNAIDER CASTRO', 11, 4),
(20, 'EFRAIN MARISCAL', 13, 10),
(21, 'JANETH CAYO', 13, 271),
(22, 'CARLOS TEJERINA', 11, 10),
(23, 'JUSTO ORELLANA', 11, 10),
(26, 'GRACIELA CHAVEZ', 11, 10),
(27, 'JOSUE ANTONIO BARROSO CORDOVA', 11, 271),
(28, 'CARLOS ALARCON', 13, 5),
(29, 'CARLOS SERRUDO', 13, 1624),
(30, 'VICTOR AMURRIO', 13, 2),
(31, 'CARMEN BELTRAN', 78, 1625),
(32, 'JULIO PALOMO', 78, 2),
(33, 'MIRIAM LINARES', 78, 1625),
(34, 'BENJAMIN TORRICO', 11, 1625),
(35, 'JORGE MEJIA NAVIA', 11, 1625),
(36, 'DANIEL GUERRERO', 11, 9),
(37, 'GABRIELA VALDEZ', 13, 4),
(38, 'MARIANA VILLAFANE', 13, 1625),
(39, 'DIEGO ANTEZANA', 13, 3),
(40, 'ALEJANDRO RENDON', 11, 1624),
(41, 'KATIA CASTELLON', 874, 9),
(42, 'ROXANA RAMIREZ', 874, 9),
(43, 'RAMIRO GOMEZ', 11, 1625),
(44, 'ANA BUENO', 273, 270),
(45, 'ANA BUENO', 13, 270),
(46, 'RAMIRO GOMEZ', 13, 1625),
(47, 'CARLA LINARES', 39, 4),
(48, 'SILVIA CUEVAS', 38, 4),
(49, 'MARIA SERRANO', 874, 10),
(50, 'YESSICA SEGOVIA', 874, 10),
(51, 'MIGUEL BALLON', 11, 1624),
(53, 'ERIKA RODRIGUEZ', 78, 4),
(54, 'GABRIELA MUNOZ A', 38, 4),
(58, 'JANIS SOLARES', 874, 1624),
(59, 'JOSE LUIS ARROYO', 38, 8),
(60, 'JOSE LUIS ARROYO', 39, 1624),
(62, 'TERESA CUBA', 11, 5),
(63, 'MIRIAM LINARES', 39, 1625),
(64, 'MIRIAM LINARES', 38, 1625),
(65, 'JANIS SOLARES', 13, 1624),
(68, 'FABRICIO NORIEGA', 872, 829),
(69, 'DANNY DAVILA', 40, 5),
(70, 'KATHERIN OROPEZA', 40, 5),
(71, 'ANNELIESE PAUKNER', 872, 829),
(72, 'JOSE LARREA', 874, 5),
(73, 'GABRIELA TUDELA', 14, 1),
(74, 'MIRKO JEAN PEREDO RIVAS', 38, 9),
(75, 'MIRKO JEAN PEREDO RIVAS', 39, 9),
(77, 'LEONARDO BURGOS MENDOZA', 13, 10),
(78, 'ALEJANDRA TORRELIO (TCS)', 38, 1624),
(80, 'JANETH CAYO', 874, 271),
(81, 'ANDREA SANDI', 78, 1624),
(82, 'RAMIRO GOMEZ', 38, 1625),
(83, 'RAMIRO GOMEZ', 39, 1625),
(84, 'JOSE DURAN', 137, 1),
(85, 'INVITADO', 13, 5),
(86, 'RENE CASTRO', 38, 5),
(87, 'HELEN HINOJOSA CUSICANQUI', 13, 1625),
(89, 'JULIO MAMANI', 273, 829),
(90, 'JUAN QUENALLATA', 273, 829),
(91, 'SANDRA SIERRA', 847, 829),
(92, 'CARLA ALDUNATE', 1200, 1624),
(93, 'MARIA RENEE GALLARDO', 871, 829),
(94, 'JOSE LUIS ARROYO', 11, 8),
(96, 'GLICET OSCO', 872, 829),
(97, 'CARLA NOELIA COCHI TARQUI', 13, 5),
(98, 'ALEJANDRA TORRELIO (TCP)', 39, 1624),
(99, 'MARTHA MENDEZ LECLERE', 13, 1),
(101, 'VERONICA LLANQUIPACHA ROJAS', 874, 1625),
(114, 'JANET VILLARROEL', 12, 10),
(118, 'MARIELA ALMANZA AGUIRRE', 12, 9),
(126, 'SERGIO MALDONADO', 871, 829),
(127, 'SILVIA CUEVAS', 39, 4),
(141, 'IVAN PADILLA AVALOS', 11, 10),
(142, 'RODRIGO JAIMES PORTUGAL', 13, 5),
(143, 'CTN 329', 137, 1),
(156, 'OPERADOR VIRTUAL RLP', 13, 1103),
(157, 'OPERADOR VIRTUAL RSC', 13, 1103),
(158, 'OPERADOR VIRTUAL RCB', 13, 1103),
(168, 'ROCIO MALLEA ORTIZ', 874, 5),
(172, 'VALIDARLP', 13, 1103),
(173, 'JOSE ARMANDO ZAPATA AVILES', 11, 5),
(176, 'OSCAR VARGAS', 872, 829),
(177, 'CINTYA ZARATE CAZAS', 38, 1624),
(178, 'OSCAR VARGAS', 1235, 829),
(181, 'ELIZABETH SEJAS GALLARDO', 11, 9),
(182, 'EDVING GUSTAVO VELASQUEZ CAMARGO', 11, 5),
(183, 'LUIS FERNANDO ROJAS URQUIZO', 871, 5),
(185, 'NAIR PAMELA SANTA CRUZ QUISBERT', 13, 5),
(187, 'LAURA MONTAN ARCE', 13, 9),
(195, 'IVETH ARUQUIPA', 273, 829),
(203, 'ALEJANDRA CAMPOS', 13, 5),
(206, 'MAURICIO GONZALO CATACORA ROMERO', 12, 829),
(207, 'NORMATECARLP', 137, 5),
(208, 'NORMATECAROR', 137, 8),
(209, 'NORMATECARPT', 137, 272),
(210, 'NORMATECARCB', 137, 9),
(211, 'NORMATECARSC', 137, 10),
(212, 'NORMATECARCH', 137, 270),
(213, 'NORMATECARTJ', 137, 271),
(221, 'FRANCO GABIN MICHEL LUZARAZU', 13, 9),
(222, 'MARIBEL FLORES', 13, 10),
(224, 'ALEJANDRO RENDON (TCS)', 38, 1624),
(225, 'ALEJANDRO RENDON(P)', 39, 1624),
(226, 'PAOLA ANDREA DURAN MARTINEZ', 13, 8),
(227, 'IVONNE CASAS', 273, 829),
(228, 'CARMEN ANDREA PENARANDA MARINO', 874, 8),
(241, 'ARIEL TEO MAMANI JAVIER', 13, 272),
(243, 'ARIEL TEO MAMANI JAVIER', 11, 272),
(244, 'CINTYA ZARATE CAZAS', 39, 1624),
(251, 'ADRIAN CADIMA', 12, 829),
(252, 'CARLA LINARES', 11, 4),
(257, 'DANNY DAVILA', 78, 1624),
(264, 'ADRIANA LENIN ESPINOZA TORREZ', 13, 10),
(273, 'CECILIA ALEJANDRA JIMENEZ CUBA', 12, 829),
(274, 'JORGE CUSTODIO PENA GOMEZ', 13, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personalimagen`
--

CREATE TABLE `personalimagen` (
  `codigo` int(11) NOT NULL,
  `imagen` mediumtext COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=COMPACT;

--
-- Volcado de datos para la tabla `personalimagen`
--

INSERT INTO `personalimagen` (`codigo`, `imagen`) VALUES
(5, '23. Willy Miranda.jpg'),
(7, '29. Anneliese Prudencio.jpg'),
(8, '31. Pedro Cardozo.jpg'),
(13, '45. Rene Castro.jpg'),
(15, '28. Cristina Mejia.jpg'),
(17, '53. Ysnaider Castro.jpg'),
(18, '63. Delcy Nogales.jpg'),
(22, '51. Carlos Tejerina.jpg'),
(23, '52. Justo Orellana.jpg'),
(26, '19. Graciela Chavez.jpg'),
(27, '59. Josue Barroso.jpg'),
(29, '66. Carlos Serrudo.jpg'),
(32, '42. Julio Palomo.jpg'),
(35, '58. Jorge Mejia.jpg'),
(36, '5. Daniel Guerrero.jpg'),
(37, '32. Gabriela Valdez.jpg'),
(40, '6. Alejandro rendon.jpg'),
(41, '20. Katia Castellon.jpg'),
(42, '12. Roxana Ramirez.jpg'),
(43, '56. Ramiro Gomez.jpg'),
(47, '8. Carla Linares.jpg'),
(48, '49. Silvia Cuevas.jpg'),
(49, '65. María Serrano.jpg'),
(50, '18. Yessica Segovia.jpg'),
(51, '57. Miguel Ballon.jpg'),
(53, '62. Erika Rodriguez.jpg'),
(54, '48. Gabriela Muñoz.jpg'),
(58, '11. Janis Solares.jpg'),
(62, '16. Teresa Cuba.jpg'),
(68, '60. Fabricio Noriega.jpg'),
(70, '61. Katherine Oropeza.jpg'),
(72, 'JOSE LARREA.JPG'),
(78, '38. Alejandra Torrelio.jpg'),
(84, 'WhatsApp Image 2022-06-10 at 12.24.32 PM.jpeg'),
(89, '10. Julio Mamani.jpg'),
(90, '9. Juan Quenallata.jpg'),
(92, 'IMG-20180909-WA0000.jpg'),
(93, '1. maria renèe gallardo.jpg'),
(96, '44. Glicet Osco.jpg'),
(97, '33. Carla Cochi.jpg'),
(101, '34. Veronica Llanquipacha.jpg'),
(141, '50. Ivan Padilla.jpg'),
(168, '13. Rocio Mallea.jpg'),
(173, '54. José Zapata.jpg'),
(176, '36. Oscar Vargas.jpg'),
(177, '43. Cintya Zarate.jpg'),
(181, '21. Elizabeth Sejas.jpg'),
(182, '55. Edving Velasquez.jpg'),
(183, '64. Luis Rojas.jpg'),
(195, '2. Iveth Aruquipa.jpg'),
(227, '3. Ivonne casas.jpg'),
(277, '24. Luis Gutierrez.jpg'),
(11942, '7. Katheryn Krings.jpg'),
(14793, '39. Rodrigo Pacheco.jpg'),
(18391, '27. Rúben Terrazas.jpg'),
(19862, '22. Evelyn Villegas.jpg'),
(19947, '40. Claudia Yañez.jpg'),
(31386, '4. Fabiola Teran.jpg'),
(33355, '46.Elena Quisbert.jpg'),
(34149, '15. María Ichuta.jpg'),
(38166, '35. Isable Estevez.jpg'),
(41467, '37. Mayra Gutierrez.jpg'),
(43686, '17.  Javier Mamani.jpg'),
(44953, '26. Juan Conde.jpg'),
(49337, '25. Hernan Navia.jpg'),
(51088, '30. Marco Villanueva.jpg'),
(53050, '41. Herlan Pardo.jpg'),
(58493, '47. Soraya Sainz.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_datosadicionales`
--

CREATE TABLE `personal_datosadicionales` (
  `cod_personal` int(11) NOT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `perfil` int(11) DEFAULT NULL,
  `usuario` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `contrasena` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_cargo` int(11) DEFAULT NULL,
  `usuario_pon` int(11) DEFAULT 0 COMMENT '0 si no es pon y 1 si es usuario pon'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `personal_datosadicionales`
--

INSERT INTO `personal_datosadicionales` (`cod_personal`, `cod_estado`, `perfil`, `usuario`, `contrasena`, `cod_cargo`, `usuario_pon`) VALUES
(1, 1, 4, 'projectsis', '123', NULL, 0),
(5, 1, 2, 'wmiranda', '123', 5, 0),
(14, 1, 2, 'vespinoza', '123', 5, 1),
(16, 1, 2, 'rllano', '123', 5, 2),
(17, 1, 3, 'ycastro', '123', 5, 0),
(31, 1, 6, 'cbeltran', '123', 24, 0),
(32, 1, 2, 'jpalomo', 'jpalomo', 5, 0),
(34, 1, 3, 'btorrico', '123', 6, 0),
(37, 1, 3, 'gvaldez', '123', 5, 0),
(38, 1, 3, 'mvillafane', '123', 5, 0),
(40, 1, 3, 'arendon', '123', 5, 0),
(41, 1, 1, 'kcastellon', 'conta', 5, 0),
(48, 1, 3, 'scuevas', '123', 15, 0),
(50, 1, 1, 'ysegovia', 'conta', 5, 0),
(53, 1, 3, 'erodriguez', '123', 5, 0),
(58, 1, 1, 'jsolares', 'conta', 5, 0),
(63, 1, 3, 'mlinares', '123', 5, 0),
(68, 1, 1, 'fnoriega', 'fnoriega', 5, 0),
(71, 1, 2, 'apaukner', '123', 5, 0),
(72, 1, 1, 'jlarrea', 'conta', 5, 0),
(78, 1, 1, 'atorrelio', 'atorrelio', 5, 0),
(81, 1, 2, 'asandi', '123', NULL, 0),
(89, 1, 1, 'jmamani', '123', 5, 0),
(90, 1, 1, 'jquenallata', '123', 5, 0),
(92, 1, 3, 'caldunate', '123', 5, 0),
(93, 1, 2, 'mgallardo', '123', NULL, 0),
(96, 1, 1, 'gosco', 'gosco', 5, 0),
(99, 1, 2, 'mmendez', '123', 5, 0),
(114, 1, 3, 'jvillarroel', '123', 5, 0),
(118, 1, 3, 'malmanza', '123', 5, 0),
(177, 1, 1, 'czarate', 'czarate', 5, 0),
(178, 1, 2, 'ovargas', '123', 5, 1),
(183, 1, 1, 'lrojas', '123', 5, 2),
(195, 1, 1, 'iaruquipa', '123', 5, 0),
(227, 1, 1, 'icasas', '123', 5, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_cuentas`
--

CREATE TABLE `plan_cuentas` (
  `codigo` int(11) NOT NULL,
  `numero` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_padre` int(11) DEFAULT NULL,
  `cod_moneda` int(11) DEFAULT NULL,
  `cod_estadoreferencial` int(11) DEFAULT NULL,
  `cod_tipocuenta` int(11) DEFAULT NULL COMMENT 'cuenta de balance o de resultados',
  `nivel` int(11) DEFAULT NULL,
  `observaciones` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cuenta_auxiliar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `plan_cuentas`
--

INSERT INTO `plan_cuentas` (`codigo`, `numero`, `nombre`, `cod_padre`, `cod_moneda`, `cod_estadoreferencial`, `cod_tipocuenta`, `nivel`, `observaciones`, `cuenta_auxiliar`) VALUES
(1, '1000000000', 'ACTIVo', 0, 1, 1, 1, 1, NULL, 0),
(2, '2000000000', 'PASIVO', 0, 1, 1, 1, 1, NULL, 0),
(3, '3000000000', 'PATRIMONIO', 0, 1, 1, 1, 1, NULL, 0),
(4, '4000000000', 'INGRESOS', 0, 1, 1, 3, 1, NULL, 0),
(5, '5000000000', 'EGRESOS', 0, 1, 1, 3, 1, NULL, 0),
(6, '1010000000', 'ACTIVO CORRIENTE', 1, 1, 1, 1, 2, NULL, 0),
(7, '1010100000', 'DISPONIBLE', 6, 1, 1, 1, 3, NULL, 0),
(8, '1010101000', 'CAJA', 7, 1, 1, 1, 4, NULL, 0),
(9, '1010101001', 'Caja General', 8, 1, 1, 1, 5, NULL, 0),
(10, '1010102000', 'CAJA CHICA', 7, 1, 1, 1, 4, NULL, 0),
(11, '1010102001', 'Caja Chica La Paz', 10, 1, 1, 1, 5, NULL, 0),
(12, '1010102002', 'Caja Chica Santa Cruz', 10, 1, 1, 1, 5, NULL, 0),
(13, '1010102003', 'Caja Chica Cochabamba', 10, 1, 1, 1, 5, NULL, 0),
(14, '1010102004', 'Caja Chica Sucre', 10, 1, 1, 1, 5, NULL, 0),
(15, '1010102005', 'Caja Chica Tarija', 10, 1, 1, 1, 5, NULL, 0),
(16, '1010102006', 'Caja Chica Oruro', 10, 1, 1, 1, 5, NULL, 0),
(17, '1010103000', 'BANCOS', 7, 1, 1, 1, 4, NULL, 0),
(18, '1010103011', 'Banco BISA Cta. Cte. 0131670010 M/N', 17, 1, 1, 1, 5, '', NULL),
(19, '1010103012', 'Banco BISA Cta. Cte. 0131672012 M/E', 17, 1, 1, 1, 5, NULL, 0),
(20, '1010103013', 'Banco Unión Cta. Cte. 10000001578993 M/N', 17, 1, 1, 1, 5, NULL, 0),
(21, '1010103014', 'Banco Mercantil Santa Cruz Cta. Cte. 4010417532 M/N', 17, 1, 1, 1, 5, NULL, 0),
(22, '1010103024', 'Banco BISA Caja Ahorro 0131674015 M/N RLP', 17, 1, 1, 1, 5, NULL, 0),
(23, '1010103025', 'Banco BISA Caja Ahorro 0131674023 M/N RCB', 17, 1, 1, 1, 5, NULL, 0),
(24, '1010103027', 'Banco BISA Caja Ahorro 0131674031 M/N RSR', 17, 1, 1, 1, 5, NULL, 0),
(25, '1010103028', 'Banco BISA Caja Ahorro 0131674040 M/N RSC', 17, 1, 1, 1, 5, NULL, 0),
(26, '1010103029', 'Banco BISA Caja Ahorro 0131674058 M/N ROR', 17, 1, 1, 1, 5, NULL, 0),
(27, '1010103030', 'Banco BISA Caja Ahorro 0131674066 M/N RTJ', 17, 1, 1, 1, 5, NULL, 0),
(28, '1010104000', 'DEPOSITOS A PLAZO FIJO', 7, 1, 1, 1, 4, NULL, 0),
(29, '1010104012', 'DPF PRODEM S.A. M/N', 28, 1, 1, 1, 5, NULL, 0),
(30, '1010104011', 'DPF Banco BISA S.A. M/E', 28, 1, 1, 1, 5, NULL, 0),
(31, '1010104013', 'DPF Banco BISA S.A. M/N', 28, 1, 1, 1, 5, NULL, 0),
(32, '1010104014', 'DPF Banco BISA S.A. UFV', 28, 1, 1, 1, 5, NULL, 0),
(33, '1010320050', '(-) Previsión Material para la Venta', 70, 1, 2, 1, 5, NULL, 0),
(34, '7010101001', 'Norma ISO - Normateca', 310, 1, 2, 1, 5, NULL, 0),
(35, '8010101001', 'Norma ISO - Normateca', 321, 1, 2, 1, 5, NULL, 0),
(36, '1010200000', 'EXIGIBLE', 6, 1, 1, 1, 3, NULL, 0),
(37, '1010201000', 'CUENTAS POR COBRAR', 36, 1, 1, 1, 4, NULL, 0),
(38, '1010201012', 'Asociados Cuotas Personal', 37, 1, 1, 1, 5, NULL, 1),
(39, '1010201011', 'Asociados Cuotas Asociados', 37, 1, 1, 1, 5, NULL, 1),
(40, '1010201013', 'Aporte Socio Fundadores', 37, 1, 1, 1, 5, NULL, 1),
(41, '1010201024', 'Proyectos', 37, 1, 1, 1, 5, NULL, 1),
(42, '1010201035', 'Préstamos al Personal', 37, 1, 1, 1, 5, NULL, 1),
(43, '1010201046', 'Depósitos en Garantía', 37, 1, 1, 1, 5, NULL, 1),
(44, '1010201830', 'Otras Cuentas por Cobrar', 37, 1, 1, 1, 5, '', 1),
(45, '1010300000', 'BIENES DE CAMBIO O REALIZABLES', 6, 1, 1, 1, 3, NULL, 0),
(46, '1010310000', 'MATERIALES EN TRANSITO', 45, 1, 1, 1, 4, NULL, 0),
(47, '1010230000', 'OTRAS CUENTAS POR COBRAR', 36, 1, 1, 1, 4, NULL, 0),
(48, '1010230010', 'Cuentas por Cobra FOMIN', 47, 1, 2, 1, 5, NULL, 0),
(49, '1010230020', 'Cuentas por Cobrar NOREXPORT', 47, 1, 2, 1, 5, NULL, 0),
(50, '1010240000', 'ENTREGAS C/RENDICION', 36, 1, 1, 1, 4, NULL, 0),
(51, '1010240030', 'Otras entregas C/Rendición', 50, 1, 1, 1, 5, '', 1),
(52, '1010250000', 'CUENTAS INCOBRABLES', 36, 1, 1, 1, 4, NULL, 0),
(53, '1010250010', 'Cuentas Incobrables', 52, 1, 1, 1, 5, NULL, 1),
(54, '1010250020', '(-) Previsión Cuentas Incobrables', 52, 1, 1, 1, 5, NULL, 0),
(55, '1010260000', 'REGIONALES CTA. CTE.', 36, 1, 1, 1, 4, NULL, 0),
(56, '1010260011', 'Regional Cta. Cte. La Paz', 55, 1, 1, 1, 5, NULL, 0),
(57, '1010260012', 'Regional Cta. Cte. Santa Cruz', 55, 1, 1, 1, 5, NULL, 0),
(58, '1010260013', 'Regional Cta. Cte. Cochabamba', 55, 1, 1, 1, 5, NULL, 0),
(59, '1010260014', 'Regional Cta. Cte. Sucre', 55, 1, 1, 1, 5, NULL, 0),
(60, '1010260015', 'Regional Cta. Cte. Tarija', 55, 1, 1, 1, 5, NULL, 0),
(61, '1010260016', 'Regional Cta. Cte. Oruro', 55, 1, 1, 1, 5, NULL, 0),
(62, '1010270000', 'CREDITO FISCAL', 36, 1, 1, 1, 4, NULL, 0),
(63, '1010270010', 'Crédito Fiscal - IVA', 62, 1, 1, 1, 5, NULL, 0),
(64, '1010270020', 'Crédito Fiscal - IVA Diferido', 62, 1, 1, 1, 5, '', 1),
(65, '1010270030', 'Crédito Fiscal - IVA por Recuperar', 62, 1, 1, 1, 5, NULL, 0),
(66, '1010220000', 'CLIENTES', 36, 1, 1, 1, 4, NULL, 0),
(67, '1010220010', 'Clientes', 66, 1, 1, 1, 5, NULL, 1),
(68, '2015020030', 'Fondos a Rendir SIS-IBNORCA', 155, 1, 1, 1, 5, NULL, 0),
(69, '1010310010', 'Materiales en Transito', 46, 1, 1, 1, 5, NULL, 0),
(70, '1010320000', 'INVENTARIOS', 45, 1, 1, 1, 4, NULL, 0),
(71, '1010320011', 'Material para la Venta', 70, 1, 1, 1, 5, NULL, 0),
(72, '1010320012', '(-) Previsión Material para la Venta', 70, 1, 1, 1, 5, NULL, 0),
(73, '1010320013', 'Suministros y Material de Oficina', 70, 1, 1, 1, 5, NULL, 0),
(74, '1010320014', 'Precintos Metálicos (Garrafas)', 70, 1, 1, 1, 5, NULL, 0),
(75, '1010320015', 'Precintos Plasticos (Café)', 70, 1, 1, 1, 5, NULL, 0),
(76, '1010320016', 'Remaches para Garrafas', 70, 1, 1, 1, 5, NULL, 0),
(77, '1010320017', 'Precintos Plasticos (Refrig)', 70, 1, 1, 1, 5, NULL, 0),
(78, '1010320018', 'Película Radiografica', 70, 1, 1, 1, 5, NULL, 0),
(79, '1010320019', 'Material de Laboratorio', 70, 1, 1, 1, 5, NULL, 0),
(80, '1010320020', 'Sacos de Café', 70, 1, 1, 1, 5, NULL, 0),
(81, '1010330000', 'ANTICIPOS', 45, 1, 1, 1, 4, NULL, 0),
(82, '1010330011', 'Proveedores de Servicios', 81, 1, 1, 1, 5, NULL, 0),
(83, '1010330012', 'Depósitos en Garantía', 81, 1, 1, 1, 5, NULL, 0),
(84, '1010330013', 'Anticipo Sueldos', 81, 1, 1, 1, 5, NULL, 0),
(85, '1010330014', 'Alquileres', 81, 1, 1, 1, 5, NULL, 0),
(86, '1010330015', 'Impuesto a las Transacciones Financieras', 81, 1, 1, 1, 5, NULL, 0),
(87, '1010330030', 'Otros anticipos', 81, 1, 1, 1, 5, NULL, 0),
(88, '1020000000', 'ACTIVO NO CORRIENTE', 1, 1, 1, 1, 2, NULL, 0),
(89, '1020100000', 'BIENES DE USO', 88, 1, 1, 1, 3, NULL, 0),
(90, '1022000000', 'INTANGIBLES', 88, 1, 1, 1, 3, NULL, 0),
(91, '1022010000', 'LICENCIAS - DERECHOS OTROS', 90, 1, 1, 1, 4, NULL, 0),
(92, '1022010011', 'Paquete Contable', 91, 1, 2, 1, 5, NULL, 0),
(93, '1022010012', 'Acreditaciones', 91, 1, 2, 1, 5, NULL, 0),
(94, '1022010013', 'Licencias', 91, 1, 2, 1, 5, NULL, 0),
(95, '1022010030', 'Otros', 91, 1, 2, 1, 5, NULL, 0),
(96, '1023000000', 'INVERSIONES', 88, 1, 1, 1, 3, NULL, 0),
(97, '1023010000', 'PARTICIPACIONES', 96, 1, 1, 1, 4, NULL, 0),
(98, '1023010011', 'Cuotas de Participación COTEL', 97, 1, 1, 1, 5, NULL, 0),
(99, '1023010012', 'Cuotas de Participación COTAS', 97, 1, 1, 1, 5, NULL, 0),
(100, '1024000000', 'DIFERIDOS', 88, 1, 1, 1, 3, NULL, 0),
(101, '1024010000', 'GASTOS PAGADOS POR ANTICIPADO', 100, 1, 1, 1, 4, NULL, 0),
(102, '1024010011', 'Seguros', 101, 1, 1, 1, 5, NULL, 0),
(103, '1024010012', 'Suscripciones', 101, 1, 1, 1, 5, NULL, 0),
(104, '1024010013', 'Cuotas Anuales', 101, 1, 1, 1, 5, NULL, 0),
(105, '1024010014', 'Subsidios', 101, 1, 1, 1, 5, NULL, 0),
(106, '1024010030', 'Otros', 101, 1, 1, 1, 5, NULL, 0),
(107, '2010000000', 'PASIVO CORRIENTE', 2, 1, 1, 1, 2, NULL, 0),
(108, '2020000000', 'PASIVO NO CORRIENTE', 2, 1, 1, 1, 2, NULL, 0),
(109, '2011000000', 'OBLIGACIONES A CORTO PLAZO', 107, 1, 1, 1, 3, NULL, 0),
(110, '2011010000', 'OBLIGACIONES GENERALES', 109, 1, 1, 1, 4, NULL, 0),
(111, '2011010011', 'Sueldos por Pagar', 110, 1, 1, 1, 5, NULL, 0),
(112, '2011010012', 'Servicios Básicos', 110, 1, 1, 1, 5, NULL, 0),
(113, '2011010013', 'Honorarios Profesionales', 110, 1, 1, 1, 5, '', 1),
(114, '2011010014', 'Proyectos', 110, 1, 1, 1, 5, NULL, 0),
(115, '2011010015', 'Cuotas Anuales', 110, 1, 1, 1, 5, NULL, 0),
(116, '2011010016', 'Alquileres por Pagar', 110, 1, 1, 1, 5, '', 1),
(117, '2011010017', 'Descuentos al Personal', 110, 1, 1, 1, 5, NULL, 0),
(118, '2011010030', 'Otros', 110, 1, 1, 1, 5, NULL, 0),
(119, '2012000000', 'APORTES Y RETENCIONES', 107, 1, 1, 1, 3, NULL, 0),
(120, '2012010000', 'APORTES SOCIALES', 119, 1, 1, 1, 4, NULL, 0),
(121, '2012010011', 'Caja Petrolera', 120, 1, 1, 1, 5, NULL, 0),
(122, '2012010012', 'AFP-Previsión BBV', 120, 1, 1, 1, 5, NULL, 0),
(123, '2012010013', 'AFP-Futuro de Bolivia', 120, 1, 1, 1, 5, NULL, 0),
(124, '2012010014', 'Provivienda', 120, 1, 1, 1, 5, NULL, 0),
(125, '2012010015', 'INFOCAL', 120, 1, 1, 1, 5, NULL, 0),
(126, '2012010016', 'Aporte Solidario del Asegurado 0,5%', 120, 1, 2, 1, 5, NULL, 0),
(127, '2012010017', 'Aporte Nacional Solidario 1%, 5%, 10%', 120, 1, 2, 1, 5, NULL, 0),
(128, '2012020000', 'RETENCIONES', 119, 1, 1, 1, 4, NULL, 0),
(129, '2012020011', 'Retención IUE Servicios 12,5%', 128, 1, 1, 1, 5, NULL, 0),
(130, '2012020012', 'Retención IUE Compras 5%', 128, 1, 1, 1, 5, NULL, 0),
(131, '2012020013', 'Retención I.T. 3%', 128, 1, 1, 1, 5, NULL, 0),
(132, '2012020014', 'Retención RC-IVA 13%', 128, 1, 1, 1, 5, '', 1),
(133, '4010104010', 'Ingresos IRAM-IBNORCA SEC', 280, 1, 2, 3, 5, NULL, 0),
(134, '2013000000', 'OBLIGACIONES TRIBUTARIAS', 107, 1, 1, 1, 3, NULL, 0),
(135, '2013010000', 'IMPUESTOS POR PAGAR', 134, 1, 1, 1, 4, NULL, 0),
(136, '2013010011', 'Impuesto a las Transacciones', 135, 1, 1, 1, 5, NULL, 0),
(137, '2013010012', 'Remesas al Exterior', 135, 1, 1, 1, 5, NULL, 0),
(138, '2013010013', 'Impuesto a la Propiedad de Bienes Inmuebles y Vehículos', 135, 1, 1, 1, 5, '', NULL),
(139, '2013010014', 'Impuesto sobre las Utilidades', 135, 1, 1, 1, 5, NULL, 0),
(140, '2013010030', 'Otros Impuestos por Pagar', 135, 1, 1, 1, 5, NULL, 0),
(141, '2013020000', 'DEBITO FISCAL', 134, 1, 1, 1, 4, NULL, 0),
(142, '2013020011', 'Débito Fiscal IVA', 141, 1, 1, 1, 5, NULL, 0),
(143, '2013020012', 'Débito Fiscal Diferido', 141, 1, 1, 1, 5, NULL, 0),
(144, '2014000000', 'PROVISIONES', 107, 1, 1, 1, 3, NULL, 0),
(145, '2014010000', 'PROVISIONES PARA AGUINALDOS', 144, 1, 1, 1, 4, NULL, 0),
(146, '2014010010', 'Aguinaldos', 145, 1, 1, 1, 5, NULL, 0),
(147, '2014020000', 'PROVISIONES PRIMAS Y BONOS', 144, 1, 1, 1, 4, NULL, 0),
(148, '2014020010', 'Primas y Bonos', 147, 1, 1, 1, 5, NULL, 0),
(149, '2014030000', 'PROV. CUENTAS INCOBRABLES', 144, 1, 1, 1, 4, NULL, 0),
(150, '2014030011', 'Cuentas incobrables', 149, 1, 1, 1, 5, NULL, 0),
(151, '2015000000', 'OBLIGACIONES COMERCIALES', 107, 1, 1, 1, 3, NULL, 0),
(152, '2015010000', 'PROVEEDORES', 151, 1, 1, 1, 4, NULL, 0),
(153, '2015010010', 'Proveedores por Servicios', 152, 1, 1, 1, 5, '', 1),
(154, '2015010030', 'Otros proveedores', 152, 1, 1, 1, 5, '', 1),
(155, '2015020000', 'OTRAS CUENTAS POR PAGAR', 151, 1, 1, 1, 4, NULL, 0),
(156, '2015020011', 'Cuentas por Pagar FOMIN', 155, 1, 2, 1, 5, NULL, 0),
(157, '2015020012', 'Cuentas por Pagar NOREXPORT', 155, 1, 1, 1, 5, NULL, 0),
(158, '2015020013', 'Cuenta por Pagar FAT', 155, 1, 2, 1, 5, NULL, 0),
(159, '2016000000', 'INGRESOS ANTICIPADOS', 107, 1, 1, 1, 3, NULL, 0),
(160, '2016010000', 'ANTICIPO CLIENTES', 159, 1, 1, 1, 4, NULL, 0),
(161, '2016010011', 'Anticipo de Clientes', 160, 1, 1, 1, 5, '', 1),
(162, '2016010012', 'Depósitos por Identificar Cta. BISA Regional', 160, 1, 1, 1, 5, '', NULL),
(163, '2016010030', 'Otros Anticipos de Clientes', 160, 1, 1, 1, 5, NULL, 0),
(164, '2016020000', 'INGRESOS ANTICIPADOS', 159, 1, 1, 1, 4, NULL, 0),
(165, '2016020011', 'Ingresos por Capacitación', 164, 1, 1, 1, 5, NULL, 0),
(166, '2016020012', 'Ingresos por Servicios', 164, 1, 1, 1, 5, NULL, 0),
(167, '2016020030', 'Otros', 164, 1, 1, 1, 5, NULL, 0),
(168, '2017000000', 'OTRAS OBLIGACIONES', 107, 1, 1, 1, 3, NULL, 0),
(169, '2017010000', 'OTROS', 168, 1, 1, 1, 4, NULL, 0),
(170, '2017010011', 'Control C.F. Diferido', 169, 1, 1, 1, 5, NULL, 0),
(171, '2021000000', 'OBLIGACIONES A LARGO PLAZO', 108, 1, 1, 1, 3, NULL, 0),
(172, '2021010000', 'PREVISIONES', 171, 1, 1, 1, 4, NULL, 0),
(173, '2021010011', 'Previsión para Indemnizaciones', 172, 1, 1, 1, 5, NULL, 0),
(174, '2021010012', 'Previsión Futuros Contingentes', 172, 1, 1, 1, 5, NULL, 0),
(175, '2021010030', 'Otros', 172, 1, 1, 1, 5, '', 1),
(176, '3010000000', 'CAPITAL', 3, 1, 1, 1, 2, NULL, 0),
(177, '3010100000', 'CAPITAL SOCIAL', 176, 1, 1, 1, 3, NULL, 0),
(178, '3010101000', 'CAPITAL SOCIAL', 177, 1, 1, 1, 4, NULL, 0),
(179, '3010101001', 'Capital Social', 178, 1, 1, 1, 5, NULL, 0),
(180, '3010101002', 'Aporte por Donaciones', 178, 1, 1, 1, 5, NULL, 0),
(181, '3010101003', 'Donaciones', 178, 1, 1, 1, 5, NULL, 0),
(182, '3010200000', 'AJUSTE DE CAPITAL', 176, 1, 1, 1, 3, NULL, 0),
(183, '3010201000', 'AJUSTES DE CAPITAL', 182, 1, 1, 1, 4, NULL, 0),
(184, '3010201001', 'Ajuste de Capital', 183, 1, 1, 1, 5, NULL, 0),
(185, '3020000000', 'RESERVAS', 3, 1, 1, 1, 2, NULL, 0),
(186, '3020100000', 'RESERVA LEGAL', 185, 1, 1, 1, 3, NULL, 0),
(187, '3020101000', 'RESERVA LEGAL', 186, 1, 1, 1, 4, NULL, 0),
(188, '3020101001', 'Reserva Legal', 187, 1, 1, 1, 5, NULL, 0),
(189, '3020200000', 'RESERVA POR REVALUO TECNICO', 185, 1, 1, 1, 3, NULL, 0),
(190, '3020201000', 'RESERVA POR REVALUO TECNICO', 189, 1, 1, 1, 4, NULL, 0),
(191, '3020201001', 'Reserva por Revalúo Técnico', 190, 1, 1, 1, 5, NULL, 0),
(192, '3020300000', 'AJUSTE GLOBAL AL PATRIMONIO', 185, 1, 1, 1, 3, NULL, 0),
(193, '3020301000', 'AJUSTE GLOBAL AL PATRIMONIO', 192, 1, 1, 1, 4, NULL, 0),
(194, '3020301001', 'Ajustes Global al Patrimonio', 193, 1, 1, 1, 5, NULL, 0),
(195, '3020500000', 'AJUSTE DE RESERVAS DE CAPITAL', 185, 1, 1, 1, 3, NULL, 0),
(196, '3020501000', 'AJUSTES DE RESERVAS DE CAPITAL', 195, 1, 1, 1, 4, NULL, 0),
(197, '3020501001', 'Ajuste de Reservas de Capital', 196, 1, 1, 1, 5, NULL, 0),
(198, '3030000000', 'RESULTADOS', 3, 1, 1, 1, 2, NULL, 0),
(199, '3030100000', 'RESULTADOS ACUMULADOS', 198, 1, 1, 1, 3, NULL, 0),
(200, '3030101000', 'RESULTADOS ACUMULADOS', 199, 1, 1, 1, 4, NULL, 0),
(201, '3030101001', 'Resultados Acumulados', 200, 1, 1, 1, 5, NULL, 0),
(202, '3030200000', 'RESULTADO DE LA GESTION', 198, 1, 1, 1, 3, NULL, 0),
(203, '3030201000', 'RESULTADO DE LA GESTION', 202, 1, 1, 1, 4, NULL, 0),
(204, '3030201001', 'Resultado de Gestión', 203, 1, 1, 1, 5, NULL, 0),
(205, '5020000000', 'GASTOS', 5, 1, 1, 3, 2, NULL, 0),
(206, '5020100000', 'GASTOS OPERATIVOS', 205, 1, 1, 3, 3, NULL, 0),
(207, '5020106000', 'IMPUESTOS Y PATENTES', 206, 1, 1, 3, 4, NULL, 0),
(208, '4010000000', 'INGRESOS OPERATIVOS', 4, 1, 1, 3, 2, NULL, 0),
(209, '5010000000', 'CUENTAS DE COSTO', 5, 1, 1, 3, 2, NULL, 0),
(210, '5010100000', 'COSTO DE MATERIALES', 209, 1, 1, 3, 3, NULL, 0),
(211, '5010101000', 'COSTO DE VENTAS', 210, 1, 1, 3, 4, NULL, 0),
(212, '5010101001', 'Costo de materiales O.I.M.', 211, 1, 1, 3, 5, NULL, 0),
(213, '5010101002', 'Costo de materiales O.I.Q.', 211, 1, 1, 3, 5, NULL, 0),
(214, '5010101003', 'Costo de materiales para la venta', 211, 1, 1, 3, 5, NULL, 0),
(215, '5020101000', 'COSTOS DE SERVICIO', 206, 1, 1, 3, 4, NULL, 0),
(216, '5020101001', 'Honorarios Auditores Externos', 215, 1, 1, 3, 5, NULL, 0),
(217, '5020101002', 'Honorarios por Docencia', 215, 1, 1, 3, 5, NULL, 0),
(218, '5020101003', 'Servicios Externos', 215, 1, 1, 3, 5, NULL, 0),
(219, '5020101004', 'Alquiler Otros P/Servicios', 215, 1, 1, 3, 5, NULL, 0),
(220, '5020101005', 'Pasajes Viáticos por Servicios', 215, 1, 1, 3, 5, NULL, 0),
(221, '5020101006', 'Refrigerios Cursos - Comites y Otros', 215, 1, 1, 3, 5, NULL, 0),
(222, '5020101007', 'Servicios Publicitarios por Servicios', 215, 1, 1, 3, 5, NULL, 0),
(223, '5020101008', 'Gastos de Imprenta', 215, 1, 1, 3, 5, NULL, 0),
(224, '5020101010', 'Auspicios y Eventos', 215, 1, 1, 3, 5, NULL, 0),
(225, '5020101030', 'Otros Gastos', 215, 1, 2, 3, 5, NULL, 0),
(226, '5020102000', 'GASTOS EN PERSONAL DEPENDIENTE', 206, 1, 1, 3, 4, NULL, 0),
(227, '5020102001', 'Sueldos al Personal', 226, 1, 1, 3, 5, NULL, 0),
(228, '5020102002', 'Aportes', 226, 1, 1, 3, 5, NULL, 0),
(229, '5020102003', 'Aguinaldos', 226, 1, 1, 3, 5, NULL, 0),
(230, '5020102004', 'Indemnizaciones - Vacaciones', 226, 1, 1, 3, 5, NULL, 0),
(231, '5020102005', 'Desahucios', 226, 1, 1, 3, 5, NULL, 0),
(232, '5020102006', 'Subsidios', 226, 1, 1, 3, 5, NULL, 0),
(233, '5020102007', 'Refrigerios al Personal', 226, 1, 1, 3, 5, NULL, 0),
(234, '5020103000', 'GASTOS EN PERSONAL EXTERNO', 206, 1, 1, 3, 4, NULL, 0),
(235, '5020103001', 'Honorarios Profesionales', 234, 1, 1, 3, 5, NULL, 0),
(236, '5020103002', 'Refrigerios Personal Externo', 234, 1, 1, 3, 5, NULL, 0),
(237, '5020104000', 'GASTOS ADMINISTRATIVOS', 206, 1, 1, 3, 4, NULL, 0),
(238, '5020104001', 'Material de escritorio', 237, 1, 1, 3, 5, NULL, 0),
(239, '5020104002', 'Servicios de Courrier', 237, 1, 1, 3, 5, NULL, 0),
(240, '5020104003', 'Servicios y Comunicaciones', 237, 1, 1, 3, 5, NULL, 0),
(241, '5020104004', 'Servicios de Seguridad', 237, 1, 1, 3, 5, NULL, 0),
(242, '5020104005', 'Alquiler de Oficinas', 237, 1, 1, 3, 5, NULL, 0),
(243, '5020104006', 'Seguros', 237, 1, 1, 3, 5, NULL, 0),
(244, '5020104007', 'Servicios de Fotocopias, Anillados y Otros', 237, 1, 1, 3, 5, NULL, 0),
(245, '5020104008', 'Gastos de Imprenta, Enmarcados y Otros', 237, 1, 1, 3, 5, NULL, 0),
(246, '5020104009', 'Servicio y Material de Limpieza', 237, 1, 1, 3, 5, NULL, 0),
(247, '5020104010', 'Gastos de Movilidad', 237, 1, 1, 3, 5, NULL, 0),
(248, '5020104011', 'Gastos de representación', 237, 1, 1, 3, 5, NULL, 0),
(249, '5020104012', 'Suscripciones y Cuotas', 237, 1, 1, 3, 5, NULL, 0),
(250, '5020104013', 'Capacitación al Personal', 237, 1, 1, 3, 5, '', 1),
(251, '5020104014', 'Intereses y Multas', 237, 1, 1, 3, 5, NULL, 0),
(252, '5020104015', 'Gastos Bancarios', 237, 1, 1, 3, 5, NULL, 0),
(253, '5020104021', 'Mantenimiento y Reparación de Equipos', 237, 1, 1, 3, 5, '', NULL),
(254, '5020104022', 'Mantenimiento y Reparación de Instalaciones', 237, 1, 1, 3, 5, '', NULL),
(255, '5020104030', 'Gastos Varios', 237, 1, 1, 3, 5, NULL, 0),
(256, '5020105000', 'DEPRECIACIONES, AMORTIZACIONES', 206, 1, 1, 3, 4, NULL, 0),
(257, '5020105001', 'Depreciación de Activos Fijos', 256, 1, 1, 3, 5, NULL, 0),
(258, '5020105002', 'Amortización de Otros Activos', 256, 1, 1, 3, 5, NULL, 0),
(259, '5020106001', 'Impuesto a las Transacciones Financieras', 207, 1, 1, 3, 5, NULL, 0),
(260, '5020106002', 'Impuesto a las Utilidades', 207, 1, 1, 3, 5, NULL, 0),
(261, '5020106003', 'Impuesto a las Transacciones', 207, 1, 1, 3, 5, NULL, 0),
(262, '5020106004', 'Patentes y Licencias', 207, 1, 1, 3, 5, NULL, 0),
(263, '5020111000', 'EGRESOS POR PROYECTOS', 206, 1, 1, 3, 4, NULL, 0),
(264, '5020111004', 'Egresos NOREXPORT', 263, 1, 2, 3, 5, NULL, 0),
(265, '5020111005', 'Egresos IRAM - IBNORCA', 263, 1, 2, 3, 5, NULL, 0),
(266, '5020111006', 'Egresos Hecho a Mano', 263, 1, 2, 3, 5, NULL, 0),
(267, '5020111007', 'Egresos CBH - IBNORCA', 263, 1, 2, 3, 5, NULL, 0),
(268, '5020111008', 'Egresos FAT', 263, 1, 2, 3, 5, NULL, 0),
(269, '4010100000', 'INGRESOS POR SERVICIOS', 208, 1, 1, 3, 3, NULL, 0),
(270, '4010101000', 'INGRESOS OI', 269, 1, 1, 3, 4, NULL, 0),
(271, '4010101001', 'Ingresos por Certificación OIM', 270, 1, 1, 3, 5, NULL, 0),
(272, '4010101002', 'Ingresos por Certificación OIQ', 270, 1, 1, 3, 5, NULL, 0),
(273, '4010102000', 'INGRESOS SERVICIOS TECNICOS', 269, 1, 1, 3, 4, NULL, 0),
(274, '4010102001', 'Ingresos por Certificación SELLO', 273, 1, 1, 3, 5, NULL, 0),
(275, '4010102002', 'Ingresos por Certificación SISTEMAS', 273, 1, 1, 3, 5, NULL, 0),
(276, '4010102003', 'Ingresos por Laboratorio', 273, 1, 1, 3, 5, NULL, 0),
(277, '4010103000', 'INGRESOS VENTAS-NO', 269, 1, 1, 3, 4, NULL, 0),
(278, '4010103002', 'Auspicios y Eventos', 277, 1, 1, 3, 5, NULL, 0),
(279, '4010104001', 'Ingresos por Capacitación', 280, 1, 1, 3, 5, NULL, 0),
(280, '4010104000', 'INGRESOS SERVICIOS EXTERNOS', 269, 1, 1, 3, 4, NULL, 0),
(281, '4010103003', 'Ingresos cuotas Asociados', 277, 1, 1, 3, 5, '', NULL),
(282, '4010103001', 'Ingresos Ventas', 277, 1, 1, 3, 5, NULL, 0),
(283, '4020000000', 'INGRESOS NO OPERATIVOS', 4, 1, 1, 3, 2, NULL, 0),
(284, '4020100000', 'INGRESOS MONETARIOS', 283, 1, 1, 3, 3, NULL, 0),
(285, '4020101000', 'INGRESOS FINANCIEROS Y OTROS', 284, 1, 1, 3, 4, NULL, 0),
(286, '4020101001', 'Intereses Ganados', 285, 1, 1, 3, 5, NULL, 0),
(287, '4020101002', 'Comisiones Ganadas', 285, 1, 1, 3, 5, NULL, 0),
(288, '4020101003', 'Donaciones', 285, 1, 1, 3, 5, NULL, 0),
(289, '4020101010', 'Otros Ingresos', 285, 1, 1, 3, 5, NULL, 0),
(290, '4020200000', 'INGRESOS NO MONETARIOS', 283, 1, 1, 3, 3, NULL, 0),
(291, '4020210000', 'OTROS INGRESOS', 290, 1, 1, 3, 4, NULL, 0),
(292, '4020210030', 'Otros', 291, 1, 1, 3, 5, NULL, 0),
(293, '5100000000', 'OTROS INGRESOS Y/O EGRESOS NO OPERATIVOS', 5, 1, 1, 3, 2, NULL, 0),
(294, '5100100000', 'GANACIAS Y/O PERDIDAS EN VENTAS DE ACTIVOS FIJOS', 293, 1, 1, 3, 3, NULL, 0),
(295, '5100101000', 'VENTA ACTIVOS FIJOS', 294, 1, 1, 3, 4, NULL, 0),
(296, '5100101001', 'Venta Activos Fijos', 295, 1, 1, 3, 5, NULL, 0),
(297, '5100500000', 'AJUSTE POR REEXPRESION MONETARIA', 293, 1, 1, 3, 3, NULL, 0),
(298, '5100501000', 'AJUSTE POR INFLACION Y TENENCIA DE BIENES', 297, 1, 1, 3, 4, NULL, 0),
(299, '5100501001', 'Ajuste por Inflacion y Tenencia de Bienes', 298, 1, 1, 3, 5, NULL, 0),
(300, '5100501002', 'Resultados por Exposicion a la Inflacion', 298, 1, 1, 3, 5, NULL, 0),
(301, '5100501003', 'Ajuste por Diferencia de Cambio', 298, 1, 1, 3, 5, NULL, 0),
(302, '5100501004', 'Mantenimiento de Valor', 298, 1, 1, 3, 5, NULL, 0),
(303, '5100501005', 'Corrección Monetaria', 298, 1, 1, 3, 5, NULL, 0),
(304, '5100600000', 'PERDIDAS Y GANANCIAS', 293, 1, 1, 3, 3, NULL, 0),
(305, '5100601000', 'PERDIDAS Y GANANCIAS', 304, 1, 1, 3, 4, NULL, 0),
(306, '5100601001', 'Perdidas y Ganancias', 305, 1, 1, 3, 5, NULL, 0),
(308, '7010000000', 'CUENTAS DE ORDEN', 307, 1, 1, 1, 2, NULL, 0),
(309, '7010100000', 'CUENTAS DE ORDEN DEUDORAS', 308, 1, 1, 1, 3, NULL, 0),
(310, '7010101000', 'CUENTAS DE ORDEN REGIONALES', 309, 1, 1, 1, 4, NULL, 0),
(311, '7010101002', 'Regional Cochabamba', 310, 1, 1, 1, 5, NULL, 0),
(312, '7010101003', 'Regional Santa Cruz', 310, 1, 1, 1, 5, NULL, 0),
(313, '7010101004', 'Regional La Paz', 310, 1, 1, 1, 5, NULL, 0),
(314, '7010101005', 'Regional Chuquisaca', 310, 1, 1, 1, 5, NULL, 0),
(315, '7010101006', 'Regional Tarija', 310, 1, 1, 1, 5, NULL, 0),
(316, '7010101008', 'Regional Oruro', 310, 1, 1, 1, 5, NULL, 0),
(317, '7010101009', 'Regional El Alto', 310, 1, 1, 1, 5, NULL, 0),
(319, '8010000000', 'CUENTAS DE ORDEN', 318, 1, 1, 1, 2, NULL, 0),
(320, '8010100000', 'CUENTAS DE ORDEN ACREEDORAS', 319, 1, 1, 1, 3, NULL, 0),
(321, '8010101000', 'CUENTAS DE ORDEN REGIONALES', 320, 1, 1, 1, 4, NULL, 0),
(322, '8010101002', 'Regional Cochabamba', 321, 1, 1, 1, 5, NULL, 0),
(323, '8010101003', 'Regional Santa Cruz', 321, 1, 1, 1, 5, NULL, 0),
(324, '8010101004', 'Regional La Paz', 321, 1, 1, 1, 5, NULL, 0),
(325, '8010101005', 'Regional Chuquisaca', 321, 1, 1, 1, 5, NULL, 0),
(326, '8010101006', 'Regional Tarija', 321, 1, 1, 1, 5, NULL, 0),
(327, '8010101007', 'Regional Oruro', 321, 1, 1, 1, 5, NULL, 0),
(328, '8010101008', 'Regional El Alto', 321, 1, 1, 1, 5, NULL, 0),
(329, '1020101000', 'MUEBLES Y ENSERES', 89, 1, 1, 1, 4, NULL, 0),
(330, '1020101001', 'Muebles y Enseres', 329, 1, 1, 1, 5, NULL, 0),
(331, '1020101002', '(-) Dep. Acumulada Muebles y Enseres', 329, 1, 1, 1, 5, NULL, 0),
(332, '1020102000', 'EQUIPOS DE COMPUTACION', 89, 1, 1, 1, 4, NULL, 0),
(333, '1020102001', 'Equipos de Computación', 332, 1, 1, 1, 5, NULL, 0),
(334, '1020102002', '(-) Dep. Acumulada quipos de Computación', 332, 1, 1, 1, 5, NULL, 0),
(335, '1020103000', 'EQUIPOS DE COMUNICACION', 89, 1, 1, 1, 4, NULL, 0),
(336, '1020103001', 'Equipos de Comunicación', 335, 1, 1, 1, 5, NULL, 0),
(337, '1020103002', '(-) Dep. Acumulada Equipos de Comunicación', 335, 1, 1, 1, 5, NULL, 0),
(338, '1020104000', 'EQUIPOS DE OFICINA', 89, 1, 1, 1, 4, NULL, 0),
(339, '1020104001', 'Equipos de Oficina', 338, 1, 1, 1, 5, NULL, 0),
(340, '1020104002', '(-) Dep. Acumulada Equipos de oficina', 338, 1, 1, 1, 5, NULL, 0),
(341, '1020105000', 'EQUIPO CENT.NAC. DE SOLDADURA', 89, 1, 1, 1, 4, NULL, 0),
(342, '1020105001', 'Equipo Cent.Nac. de Soldadura', 341, 1, 1, 1, 5, NULL, 0),
(343, '1020105002', '(-) Dep. Acumulada Equipos Lab.Soldadura', 341, 1, 1, 1, 5, NULL, 0),
(344, '1020106000', 'EQUIPO DE LABORATORIO QUIMICO', 89, 1, 1, 1, 4, NULL, 0),
(345, '1020106001', 'Equipo de Laboratorio Quimico', 344, 1, 1, 1, 5, NULL, 0),
(346, '1020106002', '(-) Dep. Acumulada Equipo de Lab. Quimico', 344, 1, 1, 1, 5, NULL, 0),
(347, '1020107000', 'MATERIAL DE CONSULTA', 89, 1, 2, 1, 4, NULL, 0),
(348, '1020107001', 'Material de Consulta', 347, 1, 2, 1, 5, NULL, 0),
(349, '1020107002', '(-) Dep. Acumulada. Material de Consulta', 347, 1, 2, 1, 5, NULL, 0),
(350, '1020108000', 'MEJORAS EN PROPIEDAD ARRENDADA', 89, 1, 1, 1, 4, NULL, 0),
(351, '1020108001', 'Mejoras en Popiedad', 350, 1, 1, 1, 5, NULL, 0),
(352, '1020108002', '(-) Amortiz. Acumulda Mejoras en Propiedad', 350, 1, 1, 1, 5, NULL, 0),
(353, '1020109000', 'EDIFICACIONES', 89, 1, 1, 1, 4, NULL, 0),
(354, '1020109001', 'Edificaciones', 353, 1, 1, 1, 5, NULL, 0),
(355, '1020109002', '(-)Depreciación Acumulada Edificaciones', 353, 1, 1, 1, 5, NULL, 0),
(356, '1020110000', 'TERRENOS', 89, 1, 1, 1, 4, NULL, 0),
(357, '1020110001', 'Terrenos', 356, 1, 1, 1, 5, NULL, 0),
(358, '1020130000', 'OBRAS EN CONSTRUCCIÓN', 89, 1, 1, 1, 4, NULL, 0),
(359, '1020130001', 'Obras en Construcción', 358, 1, 1, 1, 5, NULL, 0),
(360, '1023010018', 'Cuotas de Participación COTEOR', 97, 1, 1, 1, 5, NULL, 0),
(361, '1010230030', 'Otras Cuentas por Cobrar', 47, 1, 1, 1, 5, NULL, 0),
(362, '1010103021', 'Banco BISA S.A. Cta. Cte. 0131670036 M/N PROY', 17, 1, 1, 1, 5, NULL, 0),
(363, '4010101010', 'Servicios IRAM-IBNORCA OI', 270, 1, 1, 3, 5, NULL, 0),
(364, '4010102010', 'Servicios IRAM-IBNORCA', 273, 1, 1, 3, 5, NULL, 0),
(365, '4010103010', 'Ingresos IRAM-IBNORCA NO', 277, 1, 1, 3, 5, NULL, 0),
(366, '1010103015', 'Banco Mercantil Santa Cruz Cta. Cte. 4010766046 M/E', 17, 1, 1, 1, 5, NULL, 0),
(367, '2021020000', 'PRESTAMOS A LARGO PLAZO', 171, 1, 1, 1, 4, NULL, 0),
(368, '2021020001', 'Prestamos Hipotecarios', 367, 1, 1, 1, 5, NULL, 0),
(369, '2015020001', 'Cuentas por Pagar UTILIDAD 40 % SERVICIOS IRAM', 155, 1, 1, 1, 5, '', 1),
(370, '5020111009', 'Proyecto CAF', 263, 1, 2, 3, 5, NULL, 0),
(371, '2021020002', 'Prestamos Bancarios', 367, 1, 1, 1, 5, NULL, 0),
(372, '2013010010', 'Impuestos por Pagar', 135, 1, 1, 1, 5, NULL, 0),
(373, '4010101020', 'Ingresos USAID - IBNORCA', 270, 1, 1, 3, 5, NULL, 0),
(374, '5020111010', 'Egresos Proyecto USAID', 263, 1, 2, 3, 5, NULL, 0),
(375, '1023010013', 'Cuotas de Participación COMTECO', 97, 1, 1, 1, 5, NULL, 0),
(376, '2016020013', 'Ingresos SEA', 164, 1, 1, 1, 5, NULL, 0),
(377, '2015020002', 'Cuentas por Pagar CAMARA DE INDUSTRIA ORURO', 155, 1, 1, 1, 5, NULL, 0),
(378, '1010230040', 'Cuentas Por Cobrar IRAM', 47, 1, 1, 1, 5, '', 1),
(379, '1023010014', 'Cuotas de Participacion COTES', 97, 1, 1, 1, 5, NULL, 0),
(380, '1010260020', 'Regional Prorrateos', 55, 1, 1, 1, 5, NULL, 0),
(381, '1010201950', 'Cuentas Transitorias', 37, 1, 1, 1, 5, NULL, 0),
(382, '1022010014', 'Marcas', 91, 1, 2, 1, 5, NULL, 0),
(383, '2017010012', 'Otras cuentas transitorias', 169, 1, 1, 1, 5, NULL, 0),
(384, '5020104040', 'Gastos Foro Calidad', 237, 1, 2, 3, 5, NULL, 0),
(385, '5020104041', 'Gastos Premio a la Calidad', 237, 1, 2, 3, 5, NULL, 0),
(386, '1010103040', 'Banco Bisa Libreta de Inversión 0131674074 M/N', 17, 1, 1, 1, 5, NULL, 0),
(387, '5020106005', 'Impuesto a la Propiedad de Bienes Inmuebles y Vehículos', 207, 1, 1, 3, 5, '', NULL),
(388, '1010230050', 'Cuentas por Cobrar Proyectos', 47, 1, 1, 1, 5, '', 1),
(389, '1022010015', 'Normateca', 91, 1, 2, 1, 5, NULL, 0),
(390, '2021030000', 'OTROS', 171, 1, 1, 1, 4, NULL, 0),
(391, '2021030001', 'Otras Obligaciones a Largo Plazo', 390, 1, 1, 1, 5, NULL, 0),
(392, '4010102020', 'Ingresos AFNOR-IBNORCA', 273, 1, 1, 3, 5, NULL, 0),
(393, '5020104050', 'Gastos AFNOR-IBNORCA', 237, 1, 2, 3, 5, NULL, 0),
(394, '1010103016', 'Banco Fortaleza S.A. Cta. Cte. 2041001930 M/N', 17, 1, 1, 1, 5, NULL, 0),
(395, '2021010013', 'Previsión para Responsabilidad Profesional', 172, 1, 1, 1, 5, NULL, 0),
(396, '1022010101', 'Paquete Contable y Software', 91, 1, 1, 1, 5, NULL, 0),
(397, '1022010102', '(-)Amortización Acumulada Paq.Contable y Software', 91, 1, 1, 1, 5, NULL, 0),
(398, '1022010201', 'Acreditaciones', 91, 1, 1, 1, 5, NULL, 0),
(399, '1022010202', '(-)Amortización Acumulada Acreditaciones', 91, 1, 1, 1, 5, NULL, 0),
(400, '1022010301', 'Marcas', 91, 1, 1, 1, 5, NULL, 0),
(401, '1022010302', '(-)Amortización Acumulada Marcas', 91, 1, 1, 1, 5, NULL, 0),
(402, '1022010401', 'Normateca', 91, 1, 1, 1, 5, NULL, 0),
(403, '2021010014', 'Previsión para Contingencias Laborales y Otros', 172, 1, 1, 1, 5, NULL, 0),
(404, '2015020003', 'Cuentas por Pagar AFNOR', 155, 1, 1, 1, 5, '', 1),
(405, '5020104023', 'Pérdidas en Cuentas Incobrables', 237, 1, 1, 3, 5, NULL, 0),
(406, '1022010402', '(-) Amortización Acumulada Normateca', 91, 1, 1, 1, 5, NULL, 0),
(407, '1010102050', 'Caja Chica Proyectos', 10, 1, 1, 1, 5, NULL, 0),
(408, '1010260017', 'Regional Cta. Cte. Potosi', 55, 1, 1, 1, 5, NULL, 0),
(409, '1010102007', 'Caja Chica Potosí', 10, 1, 1, 1, 5, NULL, 0),
(410, '2015030000', 'PRESTAMOS A CORTO PLAZO', 151, 1, 1, 1, 4, NULL, 0),
(411, '2015030001', 'Préstamos Hipotecarios', 410, 1, 1, 1, 5, NULL, 0),
(412, '2015030002', 'Préstamos Bancarios', 410, 1, 1, 1, 5, '', 1),
(413, '2016010013', 'Depósitos por Identificar Banco Unión M/N ', 160, 1, 1, 1, 5, '', NULL),
(414, '5020104016', 'Contingencias Laborales y Otros', 237, 1, 1, 3, 5, NULL, 0),
(415, '3010300000', 'PATRIMONIO EN BIENES', 176, 1, 1, 1, 3, NULL, 0),
(416, '3010301000', 'Patrimonio en Bienes', 415, 1, 1, 1, 4, NULL, 0),
(417, '4020101004', 'Contribuciones Proyectos', 285, 1, 1, 3, 5, NULL, 0),
(447, '5020104018', 'GASTOS SA*', 2147483647, 1, 1, 3, 5, '', NULL),
(448, '5020104019', 'Mantenimiento y Reparación de Vehículos', 237, 1, 1, 3, 5, '', NULL),
(449, '3010301001', 'Patrimonio en Bienes', 416, 1, 1, 3, 5, '', NULL),
(450, '2016010014', 'Depósitos por Identificar Cta. BISA Nacional', 160, 1, 1, 3, 5, '', NULL),
(451, '5020101040', 'Otros Pagos', 215, 1, 1, 3, 5, '', NULL),
(452, '2016010015', 'Depósitos por Identificar Banco Mercantil M/N', 160, 1, 1, 1, 5, '', NULL),
(453, '5020104040', 'Gastos por Contingencia Sanitaria', 237, 1, 2, 3, 5, '', NULL),
(454, '2015020050', 'Otros', 155, 1, 1, 1, 5, '', NULL),
(455, '1020107000', 'VEHICULOS', 89, 1, 1, 1, 4, '', 0),
(456, '1020107001', 'Vehiculos', 455, 1, 1, 1, 5, '', NULL),
(457, '1020107002', '(-) Dep. Acumulada Vehiculos', 455, 1, 1, 1, 5, '', NULL),
(458, '5020104017', 'Combustibles y lubricantes', 237, 1, 1, 3, 5, '', NULL),
(459, '5100200000', 'RESULTADOS DE GESTIONES ANTERIORES', 293, 1, 1, 3, 3, '', NULL),
(460, '5100201000', 'INGRESOS Y/O GASTOS GESTIONES ANTERIORES', 459, 1, 1, 3, 4, '', NULL),
(461, '5100201001', 'Ingresos y/o gastos gestiones anteriores', 460, 1, 1, 3, 5, '', NULL),
(462, '4010103004', 'Ingresos de FOR a NO', 277, 1, 2, 3, 5, '', NULL),
(463, '2015020031', 'Fondos a Rendir BSI-IBNORCA', 155, 1, 1, 1, 5, '', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_campo`
--

CREATE TABLE `tipos_campo` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `abreviatura` varchar(45) DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `string_formulario` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `tipos_campo`
--

INSERT INTO `tipos_campo` (`codigo`, `nombre`, `abreviatura`, `cod_estado`, `string_formulario`) VALUES
(1, 'NUMERO ENTERO', 'INT', 1, '<div class=\"form-group\">\r\n<input class=\"form-control\" type=\"number\" name=\"XXXXX\" id=\"XXXXX\" step=\"1\"/>\r\n</div>'),
(2, 'NUMERO DECIMAL', 'DEC', 1, '<div class=\"form-group\">\r\n<input class=\"form-control\" type=\"number\" name=\"XXXXX\" id=\"XXXXX\" step=\"0.1\"/>\r\n</div>'),
(3, 'TEXTO CORTO', 'SHORTTEXT', 1, '<div class=\"form-group\">\r\n<input class=\"form-control\" type=\"text\" name=\"XXXXX\" id=\"XXXXX\"  />\r\n</div>'),
(4, 'TEXTO LARGO', 'LARGETEXT', 1, '<div class=\"form-group\">\r\n<textarea class=\"form-control\" aria-label=\"With textarea\" name=\"XXXXX\" id=\"XXXXX\"></textarea>\r\n</div>'),
(5, 'FECHA', 'DATE', 1, '<div class=\"form-group\">\r\n<input class=\"form-control\" type=\"date\" name=\"XXXXX\" id=\"XXXXX\" />\r\n</div>'),
(6, 'HORA', 'HOUR', 1, '<div class=\"form-group\">\r\n<input class=\"form-control\" type=\"time\" name=\"XXXXX\" id=\"XXXXX\" />\r\n</div>'),
(7, 'BOOLEANO', 'BOOL', 1, '<div class=\"custom-control custom-switch\">\r\n<input type=\"checkbox\" class=\"custom-control-input\" id=\"XXXXX\" name=\"XXXXX\">\r\n<label class=\"custom-control-label\" for=\"XXXXX\"></label>\r\n</div>'),
(8, 'MARCO', 'SADASD', 2, NULL),
(9, 'WDQWFQW', 'FQWEF', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades_organizacionales`
--

CREATE TABLE `unidades_organizacionales` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `abreviatura` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cod_estado` int(11) DEFAULT NULL,
  `centro_costos` int(11) DEFAULT NULL,
  `observaciones` varchar(1000) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `cod_sucursal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `unidades_organizacionales`
--

INSERT INTO `unidades_organizacionales` (`codigo`, `nombre`, `abreviatura`, `cod_estado`, `centro_costos`, `observaciones`, `created_at`, `created_by`, `modified_at`, `modified_by`, `cod_sucursal`) VALUES
(1, 'IBNORCA', 'IBN', 2, 0, '', NULL, 1, NULL, 1, 1),
(5, 'OF LA PAZ', 'RLP', 1, 1, NULL, NULL, NULL, NULL, NULL, 1),
(8, 'OF ORURO', 'ROR', 1, 1, NULL, NULL, NULL, NULL, NULL, 1),
(9, 'OF COCHABAMBA', 'RCB', 1, 1, NULL, NULL, NULL, NULL, NULL, 1),
(10, 'OF SANTA CRUZ', 'RSC', 1, 1, NULL, NULL, NULL, NULL, NULL, 1),
(270, 'OF SUCRE', 'RCH', 1, 1, NULL, NULL, NULL, NULL, NULL, 1),
(271, 'OF TARIJA', 'RTJ', 1, 1, NULL, NULL, NULL, NULL, NULL, 1),
(272, 'OF POTOSI', 'RPT', 1, 1, NULL, NULL, NULL, NULL, NULL, 1),
(829, 'DIRECCION NACIONAL', 'DN', 1, 1, '', NULL, 1, NULL, 1, 1),
(1103, 'OF VIRTUAL', 'OV', 2, 0, NULL, NULL, NULL, NULL, NULL, 1),
(2692, 'OF. EL ALTO', 'REA', 1, 1, NULL, NULL, NULL, NULL, NULL, 1),
(3000, 'PROYECTO SIS', 'SIS', 2, 1, NULL, NULL, NULL, NULL, NULL, 1),
(4000, 'PROYECTO BSI', 'BSI', 2, 1, NULL, NULL, NULL, NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `actividades_anotaciones`
--
ALTER TABLE `actividades_anotaciones`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `actividades_archivos`
--
ALTER TABLE `actividades_archivos`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `actividades_cambios_estado`
--
ALTER TABLE `actividades_cambios_estado`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `actividades_colaboradores`
--
ALTER TABLE `actividades_colaboradores`
  ADD PRIMARY KEY (`cod_actividad`,`cod_personal`) USING BTREE;

--
-- Indices de la tabla `actividades_funciones_cargo`
--
ALTER TABLE `actividades_funciones_cargo`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `actividades_hitos`
--
ALTER TABLE `actividades_hitos`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `actividades_presupuestos`
--
ALTER TABLE `actividades_presupuestos`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `actividades_prioridades`
--
ALTER TABLE `actividades_prioridades`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `campos_disponibles`
--
ALTER TABLE `campos_disponibles`
  ADD PRIMARY KEY (`codigo`) USING BTREE,
  ADD KEY `fk_campos_disponibles_tipos_campo1` (`cod_tipocampo`) USING BTREE;

--
-- Indices de la tabla `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `cargos_funciones`
--
ALTER TABLE `cargos_funciones`
  ADD PRIMARY KEY (`cod_funcion`) USING BTREE,
  ADD KEY `cod_estadoreferencial` (`cod_estado`) USING BTREE,
  ADD KEY `cod_cargo` (`cod_cargo`) USING BTREE;

--
-- Indices de la tabla `configuraciones`
--
ALTER TABLE `configuraciones`
  ADD PRIMARY KEY (`id_configuracion`) USING BTREE;

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `estados_actividades_presupuesto`
--
ALTER TABLE `estados_actividades_presupuesto`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `estados_kanban`
--
ALTER TABLE `estados_kanban`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `nivelesconf_camposdisponibles`
--
ALTER TABLE `nivelesconf_camposdisponibles`
  ADD PRIMARY KEY (`cod_nivelconfiguracion`,`cod_campodisponible`) USING BTREE,
  ADD KEY `fk_nivelesconf_campos_campos_disponibles1` (`cod_campodisponible`) USING BTREE;

--
-- Indices de la tabla `nivelespei_unidadesareas`
--
ALTER TABLE `nivelespei_unidadesareas`
  ADD PRIMARY KEY (`cod_nivelpei`,`cod_unidadorganizacional`,`cod_area`) USING BTREE;

--
-- Indices de la tabla `niveles_configuracion`
--
ALTER TABLE `niveles_configuracion`
  ADD PRIMARY KEY (`codigo`) USING BTREE,
  ADD KEY `fk_niveles_configuracion_empresas` (`cod_empresa`) USING BTREE;

--
-- Indices de la tabla `niveles_pei`
--
ALTER TABLE `niveles_pei`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `niveles_pei_adicionales`
--
ALTER TABLE `niveles_pei_adicionales`
  ADD PRIMARY KEY (`cod_nivelpei`,`cod_campodisponible`) USING BTREE;

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`codigo`) USING BTREE,
  ADD KEY `codigo` (`codigo`) USING BTREE;

--
-- Indices de la tabla `personal2`
--
ALTER TABLE `personal2`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `personalimagen`
--
ALTER TABLE `personalimagen`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `personal_datosadicionales`
--
ALTER TABLE `personal_datosadicionales`
  ADD PRIMARY KEY (`cod_personal`) USING BTREE;

--
-- Indices de la tabla `plan_cuentas`
--
ALTER TABLE `plan_cuentas`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `tipos_campo`
--
ALTER TABLE `tipos_campo`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- Indices de la tabla `unidades_organizacionales`
--
ALTER TABLE `unidades_organizacionales`
  ADD PRIMARY KEY (`codigo`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `codigo` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `actividades_anotaciones`
--
ALTER TABLE `actividades_anotaciones`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `actividades_archivos`
--
ALTER TABLE `actividades_archivos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `actividades_cambios_estado`
--
ALTER TABLE `actividades_cambios_estado`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `actividades_colaboradores`
--
ALTER TABLE `actividades_colaboradores`
  MODIFY `cod_actividad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `actividades_funciones_cargo`
--
ALTER TABLE `actividades_funciones_cargo`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `actividades_hitos`
--
ALTER TABLE `actividades_hitos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `actividades_presupuestos`
--
ALTER TABLE `actividades_presupuestos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `actividades_prioridades`
--
ALTER TABLE `actividades_prioridades`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5001;

--
-- AUTO_INCREMENT de la tabla `campos_disponibles`
--
ALTER TABLE `campos_disponibles`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cargos`
--
ALTER TABLE `cargos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `cargos_funciones`
--
ALTER TABLE `cargos_funciones`
  MODIFY `cod_funcion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estados_actividades_presupuesto`
--
ALTER TABLE `estados_actividades_presupuesto`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `estados_kanban`
--
ALTER TABLE `estados_kanban`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `niveles_configuracion`
--
ALTER TABLE `niveles_configuracion`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `niveles_pei`
--
ALTER TABLE `niveles_pei`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `plan_cuentas`
--
ALTER TABLE `plan_cuentas`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=464;

--
-- AUTO_INCREMENT de la tabla `tipos_campo`
--
ALTER TABLE `tipos_campo`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `unidades_organizacionales`
--
ALTER TABLE `unidades_organizacionales`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4001;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `campos_disponibles`
--
ALTER TABLE `campos_disponibles`
  ADD CONSTRAINT `fk_campos_disponibles_tipos_campo1` FOREIGN KEY (`cod_tipocampo`) REFERENCES `tipos_campo` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cargos_funciones`
--
ALTER TABLE `cargos_funciones`
  ADD CONSTRAINT `cargos_funciones_ibfk_1` FOREIGN KEY (`cod_estado`) REFERENCES `estados_referenciales` (`codigo`),
  ADD CONSTRAINT `cargos_funciones_ibfk_2` FOREIGN KEY (`cod_cargo`) REFERENCES `cargos` (`codigo`);

--
-- Filtros para la tabla `nivelesconf_camposdisponibles`
--
ALTER TABLE `nivelesconf_camposdisponibles`
  ADD CONSTRAINT `fk_nivelesconf_campos_campos_disponibles1` FOREIGN KEY (`cod_campodisponible`) REFERENCES `campos_disponibles` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nivelesconf_campos_niveles_configuracion1` FOREIGN KEY (`cod_nivelconfiguracion`) REFERENCES `niveles_configuracion` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `niveles_configuracion`
--
ALTER TABLE `niveles_configuracion`
  ADD CONSTRAINT `fk_niveles_configuracion_empresas` FOREIGN KEY (`cod_empresa`) REFERENCES `empresas` (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
