/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 100424
 Source Host           : localhost:3306
 Source Schema         : pei

 Target Server Type    : MySQL
 Target Server Version : 100424
 File Encoding         : 65001

 Date: 21/09/2022 17:50:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for actividades
-- ----------------------------
DROP TABLE IF EXISTS `actividades`;
CREATE TABLE `actividades`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_prioridad` int NULL DEFAULT NULL,
  `cod_estadokanban` int NULL DEFAULT NULL,
  `fecha_limite` date NULL DEFAULT NULL,
  `cod_responsable` int NULL DEFAULT NULL,
  `cod_componentepei` int NULL DEFAULT NULL COMMENT 'El componente PEI es cualquier nivel de estructura dentro del PEI (objetivo, indicador, etc)',
  `cod_padre` int NULL DEFAULT NULL COMMENT 'Describe cuando una actividad se vuelve sub-actividad, el codPadre hace referencia a la misma tabla',
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actividades
-- ----------------------------
INSERT INTO `actividades` VALUES (21, 'ERAERGAHERGHAER', NULL, 6, 1, '2022-09-01', 90, NULL, 20);
INSERT INTO `actividades` VALUES (22, 'NUEVA ACTIVIDAD', 'uneva descripción', 7, 4, '2022-09-30', 90, 6, NULL);
INSERT INTO `actividades` VALUES (23, 'NUEVO PROYECTO', '2022-09-16', 7, 5, '2022-10-02', 177, 6, NULL);
INSERT INTO `actividades` VALUES (24, 'NUEVA DESCRIPCIÓN 2', 'Nueva descripción de proyecto', 7, 2, '2022-09-30', 47, 6, NULL);

-- ----------------------------
-- Table structure for actividades_anotaciones
-- ----------------------------
DROP TABLE IF EXISTS `actividades_anotaciones`;
CREATE TABLE `actividades_anotaciones`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `cod_actividad` int NOT NULL,
  `cod_personal` int NOT NULL,
  `fecha` date NULL DEFAULT NULL,
  `anotacion` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for actividades_archivos
-- ----------------------------
DROP TABLE IF EXISTS `actividades_archivos`;
CREATE TABLE `actividades_archivos`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `cod_actividad` int NOT NULL,
  `cod_personal` int NOT NULL,
  `detalle` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `fecha` date NULL DEFAULT NULL,
  `ruta` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `extension` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filesize` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for actividades_cambios_estado
-- ----------------------------
DROP TABLE IF EXISTS `actividades_cambios_estado`;
CREATE TABLE `actividades_cambios_estado`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `cod_actividad` int NULL DEFAULT NULL,
  `cod_personal` int NULL DEFAULT NULL,
  `fecha` datetime NULL DEFAULT NULL,
  `cod_estadoactividad` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actividades_cambios_estado
-- ----------------------------
INSERT INTO `actividades_cambios_estado` VALUES (54, 20, 90, '2022-09-16 13:58:46', 2);
INSERT INTO `actividades_cambios_estado` VALUES (55, 20, 90, '2022-09-16 14:01:57', 3);
INSERT INTO `actividades_cambios_estado` VALUES (56, 20, 90, '2022-09-16 14:01:59', 4);
INSERT INTO `actividades_cambios_estado` VALUES (57, 22, 90, '2022-09-02 00:00:00', 1);
INSERT INTO `actividades_cambios_estado` VALUES (58, 22, 90, '2022-09-16 14:06:10', 2);
INSERT INTO `actividades_cambios_estado` VALUES (59, 22, 90, '2022-09-16 14:06:17', 3);
INSERT INTO `actividades_cambios_estado` VALUES (60, 22, 90, '2022-09-16 18:53:24', 4);
INSERT INTO `actividades_cambios_estado` VALUES (61, 23, 90, '2022-09-02 00:00:00', 1);
INSERT INTO `actividades_cambios_estado` VALUES (62, 24, 90, '2022-09-01 00:00:00', 1);
INSERT INTO `actividades_cambios_estado` VALUES (63, 24, 90, '2022-09-19 05:17:25', 2);
INSERT INTO `actividades_cambios_estado` VALUES (64, 23, 90, '2022-09-19 05:17:29', 3);
INSERT INTO `actividades_cambios_estado` VALUES (65, 23, 90, '2022-09-21 06:55:30', 5);
INSERT INTO `actividades_cambios_estado` VALUES (66, 23, 90, '2022-09-21 06:56:00', 2);
INSERT INTO `actividades_cambios_estado` VALUES (67, 23, 90, '2022-09-21 07:09:24', 5);

-- ----------------------------
-- Table structure for actividades_colaboradores
-- ----------------------------
DROP TABLE IF EXISTS `actividades_colaboradores`;
CREATE TABLE `actividades_colaboradores`  (
  `cod_actividad` int NOT NULL AUTO_INCREMENT,
  `cod_personal` int NOT NULL,
  `fecha_designacion` date NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  PRIMARY KEY (`cod_actividad`, `cod_personal`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actividades_colaboradores
-- ----------------------------
INSERT INTO `actividades_colaboradores` VALUES (20, 78, '2022-09-15', 1);
INSERT INTO `actividades_colaboradores` VALUES (23, 7, '2022-09-19', 1);
INSERT INTO `actividades_colaboradores` VALUES (23, 90, '2022-09-19', 1);

-- ----------------------------
-- Table structure for actividades_funciones_cargo
-- ----------------------------
DROP TABLE IF EXISTS `actividades_funciones_cargo`;
CREATE TABLE `actividades_funciones_cargo`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `cod_actividad` int NOT NULL,
  `cod_personal` int NOT NULL,
  `cod_funcion_cargo` int NOT NULL,
  `fecha` datetime NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actividades_funciones_cargo
-- ----------------------------
INSERT INTO `actividades_funciones_cargo` VALUES (15, 20, 90, 21, '2022-09-15 00:00:00', 1);

-- ----------------------------
-- Table structure for actividades_hitos
-- ----------------------------
DROP TABLE IF EXISTS `actividades_hitos`;
CREATE TABLE `actividades_hitos`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `cod_actividad` int NOT NULL,
  `cod_personal` int NOT NULL,
  `fecha_registro` datetime NULL DEFAULT NULL,
  `fecha_hito` datetime NULL DEFAULT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actividades_hitos
-- ----------------------------
INSERT INTO `actividades_hitos` VALUES (3, 10, 90, '2022-09-14 01:06:29', '2022-09-14 01:06:33', 'Prueba', 1);
INSERT INTO `actividades_hitos` VALUES (4, 10, 90, '2022-09-14 00:00:00', '2022-09-01 00:00:00', 'prueba nuevo 1', 1);
INSERT INTO `actividades_hitos` VALUES (5, 10, 90, '2022-09-14 07:25:41', '2022-09-30 00:00:00', 'mas hitos', 1);
INSERT INTO `actividades_hitos` VALUES (6, 13, 0, '2022-09-14 23:23:05', '2022-09-15 00:00:00', 'nuevo hito', 1);
INSERT INTO `actividades_hitos` VALUES (8, 20, 90, '2022-09-15 16:52:50', '2022-10-14 00:00:00', 'sdbhsdrghsdrg', 1);
INSERT INTO `actividades_hitos` VALUES (9, 20, 90, '2022-09-15 16:56:41', '2022-09-22 00:00:00', 'prueba de hito', 1);
INSERT INTO `actividades_hitos` VALUES (10, 22, 90, '2022-09-16 14:13:08', '2022-09-20 00:00:00', 'Revisión 1', 1);
INSERT INTO `actividades_hitos` VALUES (11, 22, 90, '2022-09-16 14:13:23', '2022-09-26 00:00:00', 'Revisión 2', 1);

-- ----------------------------
-- Table structure for actividades_presupuestos
-- ----------------------------
DROP TABLE IF EXISTS `actividades_presupuestos`;
CREATE TABLE `actividades_presupuestos`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `cod_actividad` int NOT NULL,
  `cod_cuenta` int NOT NULL,
  `fecha_ejecucion` date NULL DEFAULT NULL,
  `monto` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cod_estado_presupuesto` int NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `cod_financiador` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actividades_presupuestos
-- ----------------------------
INSERT INTO `actividades_presupuestos` VALUES (18, 10, 216, '2022-09-10', '150', 1, 1, NULL);
INSERT INTO `actividades_presupuestos` VALUES (19, 13, 212, '2022-09-10', '123', 1, 1, NULL);
INSERT INTO `actividades_presupuestos` VALUES (20, 20, 212, '2022-09-09', '15000', 1, 1, NULL);
INSERT INTO `actividades_presupuestos` VALUES (23, 22, 212, '2022-09-22', '12312', 1, 2, NULL);
INSERT INTO `actividades_presupuestos` VALUES (24, 22, 212, '2022-09-30', '1111', 1, 2, NULL);
INSERT INTO `actividades_presupuestos` VALUES (25, 22, 212, '2022-09-21', '123', 1, 1, NULL);
INSERT INTO `actividades_presupuestos` VALUES (26, 22, 212, '2022-09-30', '5000', 1, 1, 0);
INSERT INTO `actividades_presupuestos` VALUES (27, 22, 212, '2022-09-30', '800', 1, 1, 1);

-- ----------------------------
-- Table structure for actividades_prioridades
-- ----------------------------
DROP TABLE IF EXISTS `actividades_prioridades`;
CREATE TABLE `actividades_prioridades`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `color` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actividades_prioridades
-- ----------------------------
INSERT INTO `actividades_prioridades` VALUES (6, 'Bajo', 'Bajo', 1, 'success');
INSERT INTO `actividades_prioridades` VALUES (7, 'Medio', 'Medio', 1, 'warning');
INSERT INTO `actividades_prioridades` VALUES (8, 'Alto', 'Alto', 1, 'danger');

-- ----------------------------
-- Table structure for areas
-- ----------------------------
DROP TABLE IF EXISTS `areas`;
CREATE TABLE `areas`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `abreviatura` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `centro_costos` int NULL DEFAULT NULL,
  `observaciones` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `modified_at` datetime NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `distribucion_gastos` int NULL DEFAULT 0,
  `areas_ingreso` int NULL DEFAULT NULL,
  `cod_cuenta_ingreso` int NULL DEFAULT NULL,
  `area_servicio` int NOT NULL COMMENT 'CAMPO PARA IDENTIFICAR LAS AREAS DE SERVICIO (OI,TCP, ETC)',
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5001 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of areas
-- ----------------------------
INSERT INTO `areas` VALUES (11, 'ORGANISMOS DE INSPECCION', 'OI', 1, 1, '-', NULL, 1, NULL, 1, 1, 1, 271, 1);
INSERT INTO `areas` VALUES (12, 'NORMALIZACION', 'NO', 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 282, 0);
INSERT INTO `areas` VALUES (13, 'FORMACION', 'FOR', 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 279, 0);
INSERT INTO `areas` VALUES (14, 'POLITICAS Y RELACIONES INTERNACIONALES', 'PR', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (38, 'CERTIFICACION DE SISTEMAS', 'TCS', 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 275, 1);
INSERT INTO `areas` VALUES (39, 'CERTIFICACION DE PRODUCTO', 'TCP', 1, 1, '', NULL, 1, NULL, 1, 1, 1, 274, 1);
INSERT INTO `areas` VALUES (40, 'LABORATORIO', 'TLQ', 1, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 276, 1);
INSERT INTO `areas` VALUES (78, 'DIRECCION REGIONAL', 'DR', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (137, 'NORMATECA', 'CD', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (273, 'DIRECCION NACIONAL DE ADMINISTRACION Y FINANZAS', 'DNAF', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (501, 'DIRECCION NACIONAL', 'DN', 1, 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 289, 0);
INSERT INTO `areas` VALUES (502, 'SERVICIOS ADMINISTRATIVOS', 'SA', 2, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0);
INSERT INTO `areas` VALUES (826, 'TECNOLOGIA DE INFORMACION', 'TI', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (846, 'DIRECCION ASESORIA GENERAL', 'DAS', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (847, 'DIRECCION EJECUTIVA', 'DE', 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (871, 'GESTION ESTRATEGICA', 'GES', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (872, 'DIRECCION NACIONAL DE SERVICIOS', 'DNS', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (873, 'CERTIFICACION', 'CER', 2, 0, '', NULL, 1, NULL, 1, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (1200, 'DNS - GESTION INTEGRADA', 'GI', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (1235, 'PROYECTO SIS', 'SIS', 2, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (1236, 'SERVICIOS TECNICOS', 'ST', 2, 0, '', NULL, 1, NULL, 1, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (2848, 'AREAS EXTERNAS A IBNORCA', 'EXT', 2, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (2956, 'DIRECCION NACIONAL DE FORMACION', 'DNFOR', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (2957, 'DIRECCION NACIONAL DE EVALUACION DE LA CONFORMIDAD', 'DNEC', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (2975, 'DIRECCION NACIONAL DE NORMALIZACION', 'DNN', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (2978, 'DIRECCION NACIONAL DE COMERCIALIZACION Y COMUNICACION', 'DNCC', 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (4357, 'GESTIÓN DE CALIDAD', 'GC', 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);
INSERT INTO `areas` VALUES (5000, 'PROYECTO BSI', 'BSI', 2, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0);

-- ----------------------------
-- Table structure for campos_disponibles
-- ----------------------------
DROP TABLE IF EXISTS `campos_disponibles`;
CREATE TABLE `campos_disponibles`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `abreviatura` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `cod_tipocampo` int NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `fk_campos_disponibles_tipos_campo1`(`cod_tipocampo`) USING BTREE,
  CONSTRAINT `fk_campos_disponibles_tipos_campo1` FOREIGN KEY (`cod_tipocampo`) REFERENCES `tipos_campo` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campos_disponibles
-- ----------------------------
INSERT INTO `campos_disponibles` VALUES (1, 'Descripcion Larga', 'Desc Larga', 1, 4);
INSERT INTO `campos_disponibles` VALUES (2, 'Fecha de Inicio', 'FechaIni', 2, 2);
INSERT INTO `campos_disponibles` VALUES (3, 'Fecha de Fin', 'FechaFin', 1, 5);
INSERT INTO `campos_disponibles` VALUES (5, 'Descripcion Corta', 'Desc Corta', 1, 3);
INSERT INTO `campos_disponibles` VALUES (6, 'Hora Inicio', 'HIni', 1, 6);
INSERT INTO `campos_disponibles` VALUES (7, 'Hora Final', 'HFin', 1, 6);
INSERT INTO `campos_disponibles` VALUES (9, 'Fecha Limite', 'Flim', 1, 5);
INSERT INTO `campos_disponibles` VALUES (10, 'PRUEBA', 'PR', 1, 5);

-- ----------------------------
-- Table structure for cargos
-- ----------------------------
DROP TABLE IF EXISTS `cargos`;
CREATE TABLE `cargos`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_tipo_cargo` int NULL DEFAULT NULL,
  `cod_estadoreferencial` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  `created_by` int NULL DEFAULT NULL,
  `modified_at` datetime NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cargos
-- ----------------------------
INSERT INTO `cargos` VALUES (1, 'Director Nacional de Evaluación de la Conformidad', 'DN-EC', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (2, 'Profesional de Evaluación de la Conformidad (P-EC 1)', 'P-EC 1', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (3, 'Jefe de Evaluación de la Conformidad', 'J-EC', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (4, 'Profesional de Evaluación de la Conformidad', 'P-EC', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (5, 'Jefe de Laboratorio', 'J-TLQ', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (6, 'Profesional de Laboratorio', 'P-TLQ', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (7, 'Director Nacional de Formación', 'DN-FOR', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (8, 'Profesional de Formación', 'P-FOR', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (9, 'Director Nacional de Normalización', 'DN-NO', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (10, 'Secretario Técnico de Normalización', 'ST-NO', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (11, 'Asistente de la Dirección Nacional de Normalización', 'AS-NO', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (12, 'Director Nacional de Comercialización y Comunicación', 'DN-COM', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (13, 'Profesional de Comunicación Institucional', 'P-CI', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (14, 'Profesional de Marketing Digital', 'P-MKT', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (15, 'Ejecutivo Comercial', 'E-COM', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (16, 'Jefe de Tecnología de la Información', 'J-TI', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (17, 'Profesional de Tecnología de la Información', 'P-TI', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (18, 'Jefe de Gestión Estratégica', 'J-GES', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (19, 'Profesional de Gestión Estratégica (P-GES 1)', 'P-GES 1', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (20, 'Profesional de Gestión Estratégica (P-GES 2)', 'P-GES 2', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (21, 'Director Nacional de Administración y Finanzas', 'DNAF', 1, 1, '2020-10-19 23:48:55', NULL, '2022-07-20 21:26:59', 1);
INSERT INTO `cargos` VALUES (22, 'Profesional Administrativo (P-ADM 1)', 'P-ADM 1', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (23, 'Profesional Administrativo (P-ADM 2)', 'P-ADM 2', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (24, 'Profesional Administrativo (P-ADM 3)', 'P-ADM 3', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (25, 'Profesional Administrativo (P-ADM 4)', 'P-ADM 4', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (26, 'Secretaria', 'S-ADM', 1, 1, '2020-10-19 23:48:57', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (27, 'Mensajero/a', 'M-ADM', 1, 1, '2020-10-19 23:48:56', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (28, 'Director Ejecutivo', 'DE', 1, 1, '2020-10-19 23:48:55', NULL, '2020-10-19 23:49:15', NULL);
INSERT INTO `cargos` VALUES (29, 'Recepcionista', 'RECEP', 1, 1, '2021-07-29 22:48:47', NULL, '2021-07-29 22:50:26', NULL);
INSERT INTO `cargos` VALUES (30, 'Jefe Nacional de Contabilidad y Finanzas\r\n', 'J-NCF', 1, 1, '2021-07-29 22:50:05', NULL, '2021-07-29 22:50:22', NULL);
INSERT INTO `cargos` VALUES (31, 'Profesional  de Normalización \r\n', 'P-NO', 1, 1, '2021-07-29 22:52:12', NULL, '2021-07-29 22:52:53', NULL);
INSERT INTO `cargos` VALUES (32, 'Profesional Contable Financiero\r\n', 'P-CF', 1, 1, '2021-07-29 22:55:35', NULL, '2021-07-29 22:55:35', NULL);
INSERT INTO `cargos` VALUES (33, 'JEFE DE GESTIÓN DE CALIDAD', 'J-GC', 1, 1, '2022-02-24 15:42:02', 1, '2022-02-24 15:42:02', 1);
INSERT INTO `cargos` VALUES (34, 'PROFESIONAL DE GESTIÓN DE CALIDAD', 'P-GC', 1, 1, '2022-03-10 15:40:36', 1, '2022-03-10 15:40:36', 1);
INSERT INTO `cargos` VALUES (35, 'ASISTENTE ADMINISTRATIVA ', 'AS', 1, 1, '2022-07-28 16:56:49', 1, '2022-07-28 16:56:49', 1);
INSERT INTO `cargos` VALUES (36, 'PROFESIONAL ADMINISTRATIVO FINANCIERO', 'P-AF', 1, 1, '2022-07-28 16:59:52', 1, '2022-07-28 16:59:52', 1);
INSERT INTO `cargos` VALUES (37, 'LIDER ADMINISTRATIVO FINANCIERO', 'L-AF', 1, 1, '2022-07-28 17:00:36', 1, '2022-07-28 17:00:36', 1);
INSERT INTO `cargos` VALUES (38, 'LIDER DEL ORGANISMO DE INSPECCION ', 'L-OI', 1, 1, '2022-07-28 17:01:19', 1, '2022-07-28 17:01:19', 1);
INSERT INTO `cargos` VALUES (39, 'DIRECTORA NACIONAL DE COMERCIALIZACION ', 'DNC', 1, 1, '2022-07-28 21:46:12', 1, '2022-07-28 21:46:12', 1);
INSERT INTO `cargos` VALUES (40, 'JEFE COMERCIAL DE NORMALIZACION Y FORMACION ', 'JCNF', 1, 1, '2022-07-28 21:47:10', 1, '2022-07-28 21:47:10', 1);
INSERT INTO `cargos` VALUES (41, 'JEFE NACIONAL DE OPERACIONES DE NORMALIZACION ', 'JNON', 1, 1, '2022-07-28 21:47:58', 1, '2022-07-28 21:47:58', 1);
INSERT INTO `cargos` VALUES (42, 'JEFE COMERCIAL DE EVALUACION DE LA CONFORMIDAD', 'JCEC', 1, 1, '2022-07-28 21:49:36', 1, '2022-07-28 21:49:36', 1);
INSERT INTO `cargos` VALUES (43, 'Jefe Nacional de Certificación de Sistemas de Gestión y Producto ', 'JNC', 1, 1, '2022-07-28 21:50:44', 1, '2022-07-28 21:50:44', 1);
INSERT INTO `cargos` VALUES (44, 'JEFE NACIONAL DEL ORGANISMO DE INSPECCION', 'JNOI', 1, 1, '2022-07-28 21:51:38', 1, '2022-07-28 21:51:38', 1);
INSERT INTO `cargos` VALUES (45, 'JEFE NACIONAL ACADEMICO', 'JNA', 1, 1, '2022-07-28 21:52:21', 1, '2022-07-28 21:52:21', 1);

-- ----------------------------
-- Table structure for cargos_funciones
-- ----------------------------
DROP TABLE IF EXISTS `cargos_funciones`;
CREATE TABLE `cargos_funciones`  (
  `cod_cargo` int NOT NULL,
  `cod_funcion` int NOT NULL AUTO_INCREMENT,
  `nombre_funcion` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `peso` double NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  PRIMARY KEY (`cod_funcion`) USING BTREE,
  INDEX `cod_estadoreferencial`(`cod_estado`) USING BTREE,
  INDEX `cod_cargo`(`cod_cargo`) USING BTREE,
  CONSTRAINT `cargos_funciones_ibfk_1` FOREIGN KEY (`cod_estado`) REFERENCES `estados_referenciales` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cargos_funciones_ibfk_2` FOREIGN KEY (`cod_cargo`) REFERENCES `cargos` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 194 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cargos_funciones
-- ----------------------------
INSERT INTO `cargos_funciones` VALUES (12, 1, 'Planificar, ejecutar, dirigir y controlar el cumplimiento del POA y presupuesto del área de acuerdo a lineamientos establecidos', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 2, 'Investigar, identificar y analizar las necesidades y nuevas tendencias del mercado para el desarrollo de nuevos servicios y/o mejora de los actuales en coordinación con las Direcciones Nacionales, además de realizar el análisis de factibilidad de los mismos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 3, 'Establecer lineamientos y estrategias comerciales nacionales en coordinación con los directores nacionales. Además de medir su impacto para la toma de decisiones.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 4, 'Crear campañas de comercialización y comunicación para todos los servicios de IBNORCA, en coordinación con DE, Direccones nacionales y empresas de apoyo, con el objetivo de un crecimiento en el mercado.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 5, 'Organizar y participar en eventos estratégicos para el IBNORCA de carácter nacional (ferias, seminarios, talleres y otras actividades de relaciones públicas), en cooperación de las áreas que brindan los servicios principales de la institución para involucrar a las partes interesadas estratégicas.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 6, 'Administrar y monitorear la implementación de la red de contactos nacionales (CRM) de todos los servicios, que permita gestionar las acciones de seguimiento y control comercial con los clientes potenciales y actuales en todas las interacciones entre IBNORCA y los clientes.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 7, 'Gestionar y lograr afiliaciones de socios y convenios interinstitucionales a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 8, 'Supervisar y controlar la creación de contenidos, diseños y el uso de marca, en medios sociales, página web y materiales promocionales, para garantizar que cumplan con las especificaciones previamente definidas', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 9, 'Preparar planes y presupuesto de ventas, estableciendo metas y objetivos, para el cumplimiento de los objetivos de cada servicio.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 10, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, identificación de riesgos a la imparcialidad, entre otras)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (12, 11, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 12, 'Apoyar en la planificación del POA y presupuesto del área y ejecutar las mismas de acuerdo a lo establecido.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 13, 'Planificar, ejecutar y monitorear las campañas comunicacionales a nivel nacional, en coordinación con las demás áreas de la institución', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 14, 'Investigar, innovar, desarrollar, gestionar y coordinar la implementación, crecimiento y desarrollo de nuevos proyectos o servicios dentro del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 15, 'Identificar y establecer alianzas con los medios de comunicación para la implementación de la estrategia de posicionamiento nacional, además de definir los canales de comunicación a ser utilizados.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 16, 'Desarrollar, implementar y evaluar las estrategias de comunicación diseñadas para informar e involucrar a las partes interesadas en general acerca de las actividades realizadas por IBNORCA.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 17, 'Generar el desarrollo de materiales promocionales institucionales en coordinación con el P-MKT y las diferentes áreas.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 18, 'Coordinar y asistir a eventos con los medios, al igual que a reuniones con los clientes y otros organismos nacionales e internacionales.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 19, 'Análisis de tendencias de organismos homólogos, revisar noticias de prensa, reportes de tendencia, para la institución.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 20, 'Analizar el tema de afiliaciones (de los actuales), la renovación debería ser por normalización y nuevos afiliados por comercial.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 21, 'Administrar de convenios interinstitucionales a nivel nacional', 0, 1);
INSERT INTO `cargos_funciones` VALUES (13, 22, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 23, 'Apoyar en la planificación del POA y presupuesto del área y ejecutar las mismas de acuerdo a lo establecido.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 24, 'Planificar y ejecutar las campañas comerciales y comunicacionales en el ámbito digital.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 25, 'Informar al DN-COM sobre el estado de posicionamiento de la marca', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 26, 'Administrar y monitorear el IBNORED, redes sociales, tienda virtual (Front - Backend) y la página web a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 27, 'Crear, ajustar y definir el presupuesto de las publicaciones en los distintos medios digitales para atraer tráfico hacia la página web institucional en coordinación con el DN-COM.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 28, 'Crear contenido visual para las campañas digitales, en coordinación con empresas de apoyo (cuando corresponda)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 29, 'Identificar las nuevas tendencias y buenas prácticas en las redes sociales y herramientas digitales para fortalecer las estratégicas comerciales.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 30, 'Implementación, seguimeinto y reporte de las campañas y estrategias de marketing digital, en base a las métricas obtenidas para medir su impacto e influencia.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 31, 'Atender sugerencias y reclamos y ejecutar las medidas correctivas que permita dar soluciones adecuadas y oportunas a las plataformas digitales.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 32, 'Gestionar el proceso de contratación de las empresas de apoyo cuando corresponda, además de verificar y supervisar que todos los productos que sean presentados cumplan con todos los requisitos solicitados.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 33, 'Coordinar de manera continua con otras áreas, para el desarrollo de contenidos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 34, 'Elaborar y actualizar documentos concernientes del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (14, 35, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 36, 'Diseñar e implementar estrategias comerciales en base a lineamientos nacionales, segmentación e investigación de mercado para la venta de todos los servicios de IBNORCA', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 37, 'Coadyuvar al Director Nacional de Comercialización y Comunicación con el desarrollo de proyectos innovadores, explorando nuevas oportunidades de negocio.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 38, 'Realizar visitas a actuales y potenciales clientes, proporcionando información oportuna acerca de la factibilidad y alcance de los servicios de IBNORCA. CAPTAR NUEVOS CLIENTES', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 39, 'Gestionar las redes sociales (en la sección que corresponda) a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 40, 'Realizar la gestión de quejas de manera oportuna y eficiente e informar sobre las mismas cuando corresponda.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 41, 'Realizar la inscripción de alumnos en el sistema de capacitación en base a la información proporcionada por el área de formación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 42, 'Organizar y participar del desarrollo de eventos. (Ferias, seminarios talleres y otras actividades) y llevar un registro fotográfico de los mismos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 43, 'Crear, actualizar e implementar nuevos documentos del área en coordinación con la DN-COM.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 44, 'Realizar la gestión de ventas para todos los servicios de IBNORCA.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 45, 'Elaborar y mantener actualizada la base de datos de clientes para todos los servicios.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (15, 46, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1);
INSERT INTO `cargos_funciones` VALUES (1, 47, 'Planificar, ejecutar y supervisar la ejecución del Plan de Operaciones Anual y presupuesto TCS/TCP.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (1, 48, 'Planificar y supervisar el POA y Presupuesto para el Organismo de Inspección y Laboratorio.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (1, 49, 'Investigar, innovar, desarrollar, gestionar y coordinar la implementación, crecimiento y desarrollo de nuevos proyectos o servicios a nivel nacional en coordinación con las demás direcciones de IBNORCA y con los diferentes entes reguladores.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (1, 50, 'Gestionar las decisiones de las certificaciones TCS/TCP (incluido el CONCER)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (1, 51, 'Difundir los servicios a clientes estratégicos en coordinación con la Dirección Nacional de Comunicación y Comercialización', 0, 1);
INSERT INTO `cargos_funciones` VALUES (1, 52, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, identificación de riesgos a la imparcialidad, entre otras)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (1, 53, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 54, 'Elaborar el Plan de Operaciones Anual y presupuesto TCS/TCP, y programación de auditorías por ciclo de certificación en coordinación con el DN-EC.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 55, 'Coordinar y gestionar las actividades para brindar el servicio de certificación (Designación del equipo auditor, logística de las auditorias, compilar detalles de ensayos con testigo para las cotizaciones, revisar y cargar los registros de auditoría al sistema y realizar el monitoreo correspondiente)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 56, 'Gestionar información con otros organismos internacionales de certificación (Informes, documentación y otros)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 57, 'Atender al cliente respecto a los servicios de TCS/TCP de manera oportuna y clara.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 58, 'Gestionar la elaboración y envío de ofertas de los servicios de TCS/TCP', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 59, 'Gestionar con el cliente su registro en el sistema y mantener actualizada la información de los clientes certificados TCS/TCP.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 60, 'Realizar auditorías designadas conforme a la función asignada, incluyendo la realización de ensayos con testigo y todas las responsabilidades que ello conlleva. (Presentar los resultados al auditor líder, elaborar la cotización de los ensayos, etc.)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 61, 'Apoyar la ejecución de actividades del Organismo de Inspección.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 62, 'Revisar los expedientes de auditoría para decisión, asignados.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 63, 'Gestionar reuniones del CONCER de acuerdo a lo asignado.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 64, 'Realizar las solicitudes de recursos y de facturación relacionadas a los servicios TCS/TCP.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 65, 'Crear, actualizar e implementar nuevos documentos para TCS/TCP/OI.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 66, 'Participar en auditorías de acreditación y apoyar al DN-EC en la gestión de acciones correctivas.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 67, 'Difundir los servicios de EC y apoyar la gestión comercial (visitas a clientes, atención de consultas, etc.)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 68, 'Apoyar al DN-EC con el desarrollo de proyectos e implementación de nuevos servicios', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 69, 'Informar a su inmediato superior sobre las actividades del área y el cumplimiento del trabajo asignado', 0, 1);
INSERT INTO `cargos_funciones` VALUES (2, 70, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1);
INSERT INTO `cargos_funciones` VALUES (3, 71, 'Planificar, ejecutar y controlar las actividades y presupuesto del Organismo de Inspección, de acuerdo a lineamientos establecidos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (3, 72, 'Elaborar, revisar, aprobar y enviar ofertas a clientes en base a tarifarios, contratos y convenios aprobados', 0, 1);
INSERT INTO `cargos_funciones` VALUES (3, 73, 'Asignar y ejecutar las diferentes inspecciones de acuerdo a competencia técnica y requerimiento de los clientes.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (3, 74, 'Realizar las auditorias, con todas las actividades que conlleva.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (3, 75, 'Implementar las estrategias comerciales para la promoción y difusión de los Servicios de EC en coordinación con la Dirección Nacional de Comercialización y Comunicación .', 0, 1);
INSERT INTO `cargos_funciones` VALUES (3, 76, 'Proponer proyectos y velar por su implementación en coordinación con DNEC y GES', 0, 1);
INSERT INTO `cargos_funciones` VALUES (3, 77, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. \r\n', 0, 1);
INSERT INTO `cargos_funciones` VALUES (3, 78, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 79, 'Apoyar en la elaboración del POA y presupuesto del área y ejecutar el mismo en coordinación con el J-EC', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 80, 'Elaborar y enviar cotizaciones y propuestas al cliente, previa aprobación del J-EC', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 81, 'Ejecutar las Evaluaciones de la Conformidad de acuerdo a competencia técnica y registrarlas en los documentos correspondientes.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 82, 'Realizar el 100% de las auditorias asignadas y todas las actividades que ello conlleva.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 83, 'Crear, actualizar e implementar nuevos documentos para el área ', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 84, 'Participar en auditorías de acreditación y apoyar al J-EC en la gestión de quejas y reclamos', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 85, 'Apoyar al J-EC con el desarrollo de proyectos e implementación de nuevos servicios', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 86, 'Realizar la atención al cliente y apoyar en la gestión comercial del servicio.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (4, 87, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 88, 'Planificar, ejecutar y controlar las actividades y presupuesto del Laboratorio, de acuerdo a lineamientos establecidos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 89, 'Elaborar, revisar, aprobar y enviar ofertas a clientes en base a tarifarios aprobados', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 90, 'Asignar y ejecutar los ensayos de acuerdo a competencia técnica y requerimiento de los clientes de manera independiente, imparcial, confidencial y eficiente, en cumplimiento a los procedimientos e instructivos aprobados', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 91, 'Designar la responsabilidad de los equipos de laboratorio para el correcto funcionamiento e informar sus condiciones al DN-EC.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 92, 'Ejecutar las solicitudes de ensayos y toma de muestras', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 93, 'Apoyar la ejecución de actividades de certificación TCS/TCP.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 94, 'Emitir y firmar los informes de ensayos realizados.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 95, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, identificación de riesgos a la imparcialidad, entre otras)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 96, 'Apoyar en la implementación de las estrategias comerciales para la promoción y difusión de los Servicios del Laboratorio en coordinación con la Dirección Nacional de Comercialización y Comunicación. ', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 97, 'Proponer proyectos e implementar nuevos servicios en coordinación con DN -EC', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 98, 'Informa a su inmediato superior sobre las actividades del área y el cumplimiento del trabajo asignado.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (5, 99, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 100, 'Apoyar en la elaboración del Plan de Operaciones Anual y presupuesto del laboratorio y ejecutar el mismo en coordinación con el J-TLQ.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 101, 'Elaborar y enviar ofertas para aprobación del J-TLQ.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 102, 'Ejecutar las solicitudes de ensayo de acuerdo a competencia técnica y registrarlas en el sistema.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 103, 'Realizar el control de los equipos de laboratorio designados e informar sus condiciones al J-TLQ', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 104, 'Apoyar la ejecución de actividades de Evaluación de la Conformidad, de acuerdo a lo asignado.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 105, 'Emitir informes de cada ensayo realizado, de forma precisa y completa en los formatos establecidos y enviar para aprobación del J-TLQ.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 106, 'Coadyuvar en la implementación y mantenimiento del SG y aportar en la actualización y revisión de la documentación de laboratorio', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 107, 'Apoyar al J-TLQ con el desarrollo de proyectos e implementación de nuevos servicios', 0, 1);
INSERT INTO `cargos_funciones` VALUES (6, 108, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (7, 109, 'Planificar, desarrollar, coordinar y controlar el programa anual - POA y el Presupuesto de los servicios del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (7, 110, 'Dar lineamientos nacionales para la gestión de cursos en todas sus modalidades.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (7, 111, 'Gestionar y coordinar la investigación, desarrollo e innovación de nuevos cursos de formación a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (7, 112, 'Fortalecer los canales de relacionamiento y coordinar acciones conjuntas con organismos internacionales para el desarrollo y oferta de cursos de formación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (7, 113, 'Coordinar con el área de Comercialización y comunicación en la promoción y difusión de los cursos a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (7, 114, 'Revisar, aprobar y garantizar la calidad de los contenidos académicos a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (7, 115, 'Garantizar la calidad de los servicios de formación en base a procedimientos establecidos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (7, 116, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 117, 'Apoyar en la elaboración del programa anual de formación, el POA y presupuesto del servicio de formación y ejecutar el mismo en coordinación con la DN- FOR, de acuerdo a lineamientos establecidos', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 118, 'Investigar, innovar y desarrollar nuevos cursos en todas las modalidades (presencial y a distancia), cumpliendo requisitos y estándares de calidad establecidos, en coordinación con normalización, evaluación de la conformidad.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 119, 'Apoyar a la DN-FOR en el relacionamiento con organismos nacionales e internacionales, para el desarrollo de nuevos cursos de formación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 120, 'Desarrollar, elaborar y enviar ofertas de cursos a clientes y/o empresas en coordinación con DN-FOR.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 121, 'Coordinar con el área de comercialización y comunicación, la programación, difusión y venta de los cursos de formación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 122, 'Analizar las nuevas tendencias del mercado en cuanto a cursos de formación, en coordinación con el área de comercialización y comunicación', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 123, 'Coordinar con expertos nacionales e internacionales para el desarrollo de proyectos de cursos de formación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 124, 'Gestionar la ejecución de los cursos de formación de acuerdo a designación y procedimientos establecidos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 125, 'Atender las consultas de los alumnos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 126, 'Coadyuvar en la revisión de las mallas curriculares y todo el material de los cursos que brinda el IBNORCA, con la finalidad de que todo el servicio que brindamos sea de calidad.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 127, 'Realizar la evaluación y reportes de los resultados de la evaluación de satisfacción del cliente e informar de manera oportuna al DN-FOR los resultados de manera oportuna.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 128, 'Apoyar en la calificación de docentes a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 129, 'Crear, actualizar e implementar nuevos documentos para el área de Formación en coordinación con DN-FOR.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 130, 'Gesionar las quejas y sujerencias de manera oportuna y eficiente con el DNFOR', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 131, 'Gestionar la planifiación mensual de los cursos de formación', 0, 1);
INSERT INTO `cargos_funciones` VALUES (8, 132, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 133, 'Elaborar, monitorear y controlar el Programa Operativos de Normalización (PON); el Plan anual de Participación en Comités Internacionales y Regionales, el POA y presupuesto de normalización, velando por su estricto cumplimiento.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 134, 'Involucrar a las partes interesadas a través del relacionamiento con organismos nacionales para garantizar el funcionamiento de los CTN y la afiliación a IBNORCA, en coordinación con el área de comercialización y comunicación, como parte de la pre-normalización.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 135, 'Investigar, desarrollar e innovar proyectos en base a normas técnicas para el desarrollo de nuevos servicios en coordinación con las demás Direcciones Nacionales.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 136, 'Ejercer la Secretaría Técnica del Comité Nacional de Normalización – CONNOR y gestionar de manera eficiente y oportuna la aprobación de normas por parte de la Directiva de IBNORCA.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 137, 'Ejercer la Secretaría Ejecutiva del Codex Alimentarius con todas las responsabilidades que ello conlleva', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 138, 'Participar en Comités Técnicos Internacionales, además de coordinar, monitorear y velar por el desarrollo eficiente de las Unidades Sectoriales y Comités Técnicos de Normalización a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 139, 'Gestionar el relacionamiento internacional con organismos bilaterales y multilaterales de normalización para proyectos de intercambio de cooperación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 140, 'Ejecutar y monitorear las actividades emergentes de proyectos internacionales en el ámbito de la normalización, además de coadyuvar con la planificación de actividades estratégicas.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 141, 'Realizar la promoción, difusión y venta de normas técnicas y afiliaciones a nivel nacional en coordinación con el área de comercialización y comunicación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 142, 'Promover una cultura de calidad en busca de la mejora continua a través del diseño, implementación y actualización del Sistema de Gestión para todos los servicios del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, satisfacción del cliente, entre otras)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (9, 143, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 144, 'Apoyar en la elaboración del programa operativo de normalización, el POA y presupuesto del servicio de normalización y ejecutar el mismo en coordinación con la DN- NO', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 145, 'Identificar las partes interesadas y desarrollar eventos, participar de reuniones y otras actividades con el objetivo de involucrar a las mismas para ser parte de los CTN y formar parte de los afiliados IBNORCA, en coordinación con el área comercial y de comunicación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 146, 'Elaborar y actualizar normas técnicas en el sistema (nacionales e internacionales), a través de la creación y gestión de Comités Técnicos. (Desde él envió de citaciones hasta el registro y archivo de la documentación del comité).', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 147, 'Investigar, desarrollar e innovar proyectos en base a normas técnicas para el desarrollo de nuevos servicios.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 148, 'Realizar la promoción, difusión y venta de normas técnicas y afiliaciones a nivel nacional en coordinación con el área de comercialización y comunicación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 149, 'Ejecutar y monitorear las actividades emergentes de proyectos internacionales en el ámbito de la normalización, además de coadyuvar con la planificación de actividades estratégicas.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 150, 'Realizar la gestión de quejas y sugerencias de manera oportuna y eficiente en coordinación con el DN-NO.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 151, 'Realizar el diseño y actualización correcta del Sistema de Gestión para los servicios de Normalización.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 152, 'Dar seguimiento a las unidades sectoriales y realizar el reporte del estado y aprobación de las normas técnicas.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 153, 'Apoyar e la inducción de Secretarios Técnicos 100% en el año', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 154, 'Gestionar el desarrollo de artículos técnicos y eventos de difunción, en coordinación con el área de Comercialización y Comunicación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 155, 'Descargar y subir las normas técnicas en el sistema informatico', 0, 1);
INSERT INTO `cargos_funciones` VALUES (10, 156, 'Otras funciones que sean asignadas para el cumplimiento de los objetivos del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 157, 'Apoyo en la organización de comités, eventos u otras actividades del área', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 158, 'Elaborar cartas, invitaciones, actas, itinerarios de viajes y otros documentos que sean solicitados', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 159, 'Mantener organizado, dar seguimiento y llevar un control adecuado de toda la documentación correspondiente al área, además del archivo digital y físico.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 160, 'Apoyar al DN-NO con la gestión de las reuniones del CONNOR ', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 161, 'Registro de Información en el sistema de la normateca digital.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 162, 'Llevar el control de reclamos sobre normas observadas por los clientes para conocimiento y toma de decisiones de la DN-NO.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 163, 'Mantener actualizada la agenda de los participantes de los comités, proveedores y otros relacionados con el área de normalización.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 164, 'Realizar las actividades administrativas de solicitud de recursos relacionadas al área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 165, 'Gestionar la contratación de consultores y empresas de apoyo para el área, en coordinación con el DN-NO', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 166, 'Informar a su inmediato superior sobre las actividades del área y el cumplimiento del trabajo asignado', 0, 1);
INSERT INTO `cargos_funciones` VALUES (11, 167, 'Otras funciones que sean asignadas para el cumplimiento de los objetivos del área.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 168, 'Planificar, ejecutar, supervisar y controlar las actividades y presupuesto del área; velando por su estricto cumplimiento', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 169, 'Desarrollar, implementar, coordinar y monitorear las políticas, planes, procedimientos, estrategias y lineamientos del área que garanticen el Sistema de Gestión de seguridad de la información de la Institución.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 170, 'Participar de manera activa en la elaboración de procedimientos de las áreas pertinentes para diseñar, documentar, coordinar, implementar y monitorear los sistemas informáticos de acuerdo a los requerimientos institucionales.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 171, 'Innovar, investigar y desarrollar nuevos proyectos de Tecnología de la Información.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 172, 'Atender sugerencias y recomendaciones de los clientes internos y externos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 173, 'Supervisar y/o realizar la administración, mantenimiento y mejora de toda la infraestructura de hardware, software y la red de transmisión de datos de la institución.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 174, 'Coordinar y supervisar la atención eficiente de soporte técnico a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 175, 'Realizar las descargar de normas del repositorio de la ISO.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 176, 'Supervisar y/o realizar la capacitación al personal de IBNORCA en el manejo adecuado de los recursos de tecnología de la información y comunicación.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 177, 'Promover y gestionar el uso eficiente de los recursos de la tecnología de la información en la institución.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 178, 'Contribuir al mejoramiento continuo y el aseguramiento de la calidad de los servicios prestados, a través del diseño, implementación y mantenimiento del Sistema de Gestión del área. (Gestión documental, participación en auditorías internas, gestión de quejas y acciones correctivas, identificación de riesgos a la imparcialidad, entre otras)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (16, 179, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos de la regional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 180, 'Coadyuvar en la planificación y ejecución de las actividades (POA) y presupuesto del área, velando por su estricto cumplimiento.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 181, 'Realizar mantenimientos correctivos y preventivos de la infraestructura de hardware y software.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 182, 'Brindar apoyo al personal a nivel nacional, en temas relacionados a las tecnologías de la información.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 183, 'Capacitar al personal en la operación de sistemas informáticos o nuevos programas.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 184, 'Realizar tareas de mantenimiento y actualización a los sistemas informáticos y plataformas institucionales.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 185, 'Velar por la continuidad de los servicios comunicacionales (internet y redes LAN y WAN)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 186, 'Crear y desarrollar nuevos sistemas y realizar la programación de acuerdo a las necesidades institucionales.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 187, 'Resguardar la información, bases de datos y documentación digital a nivel nacional.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 188, 'Evaluar el desempeño de los sistemas actuales y nuevos, para aplicar mejoras y correcciones de funcionamiento, de acuerdo a requerimiento.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 189, 'Crear, actualizar e implementar nuevos documentos para TI.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 190, 'Gestión de aulas virtuales (envío de videos, y grabaciones)', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 191, 'Atención a clientes externos con el uso de los sistemas institucionales. (tienda).', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 192, 'Coordinar las actividades de desarrollo con los consultores externos.', 0, 1);
INSERT INTO `cargos_funciones` VALUES (17, 193, 'Otras asignadas por su inmediato superior para el cumplimiento de objetivos del área.', 0, 1);

-- ----------------------------
-- Table structure for configuraciones
-- ----------------------------
DROP TABLE IF EXISTS `configuraciones`;
CREATE TABLE `configuraciones`  (
  `id_configuracion` int NOT NULL,
  `valor_configuracion` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `descripcion_configuracion` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_configuracion`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of configuraciones
-- ----------------------------
INSERT INTO `configuraciones` VALUES (-10, '1', 'TIPO LOGIN 1: FINANCIERO  2: SERVICIO WEB');
INSERT INTO `configuraciones` VALUES (1, '1', 'ESTADO INICIAL CON QUE SE REGISTRA LAS ACTIVIDADES');
INSERT INTO `configuraciones` VALUES (2, 'assets/imagenes_personal/', 'Directorio dinámico de Imagenes de Personal');

-- ----------------------------
-- Table structure for empresas
-- ----------------------------
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empresas
-- ----------------------------
INSERT INTO `empresas` VALUES (1, 'IBNORCA 2023 2025', 'IBNO', 1);
INSERT INTO `empresas` VALUES (5, 'IBNORCA 2026 - 2029', '2026/29', 2);

-- ----------------------------
-- Table structure for estados_actividades_presupuesto
-- ----------------------------
DROP TABLE IF EXISTS `estados_actividades_presupuesto`;
CREATE TABLE `estados_actividades_presupuesto`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `estado_etiqueta` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of estados_actividades_presupuesto
-- ----------------------------
INSERT INTO `estados_actividades_presupuesto` VALUES (1, 'Pendiente', 'Solicitado', 'SOL', 1, 'warning');
INSERT INTO `estados_actividades_presupuesto` VALUES (2, 'Proceso', 'Ejecución', 'EEJE', 1, 'primary');
INSERT INTO `estados_actividades_presupuesto` VALUES (9, 'Terminado', 'Ejecutado', 'EJE', 1, 'success');

-- ----------------------------
-- Table structure for estados_kanban
-- ----------------------------
DROP TABLE IF EXISTS `estados_kanban`;
CREATE TABLE `estados_kanban`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of estados_kanban
-- ----------------------------
INSERT INTO `estados_kanban` VALUES (1, 'Planificado', 'Pila de actividades registradas pero pendientes de ejecucion. ', 'UpCom', 1, 'secondary', 'fe-folder-plus');
INSERT INTO `estados_kanban` VALUES (2, 'En Proceso', 'Pila de actividades en proceso de Ejecucion. ', 'InProg', 1, 'primary', 'fe-loader');
INSERT INTO `estados_kanban` VALUES (3, 'En Revisión', 'Pila de actividades en revisión.', 'Done', 1, 'warning', 'fe-feather');
INSERT INTO `estados_kanban` VALUES (4, 'Concluido', 'Pila de actividades concluidas. ', NULL, 1, 'success', 'fe-check-circle');
INSERT INTO `estados_kanban` VALUES (5, 'Parado', 'Pila de actividades sin acciones', NULL, 1, 'danger', 'fe-alert-circle');

-- ----------------------------
-- Table structure for eventos
-- ----------------------------
DROP TABLE IF EXISTS `eventos`;
CREATE TABLE `eventos`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `cod_personal` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detalle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `observacion` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `fecha_inicio` datetime NULL DEFAULT NULL,
  `fecha_fin` datetime NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eventos
-- ----------------------------
INSERT INTO `eventos` VALUES (1, '90', 'Nuevo Evento personal', NULL, '2022-09-28 22:00:00', '2022-09-28 23:00:00', 1);
INSERT INTO `eventos` VALUES (26, '90', 'xtyjdctyj', NULL, '2022-09-20 02:40:00', '2022-09-20 02:40:00', 1);
INSERT INTO `eventos` VALUES (27, '90', 'tbhszert', NULL, '2022-09-23 01:41:00', '2022-09-23 02:41:00', 1);
INSERT INTO `eventos` VALUES (28, '90', 'djydtyjtyjd', NULL, '2022-09-30 03:47:00', '2022-09-30 06:47:00', 1);
INSERT INTO `eventos` VALUES (29, '90', 'asdasfcasc', NULL, '2022-09-21 07:00:00', '2022-09-21 07:30:00', 1);
INSERT INTO `eventos` VALUES (30, '90', 'dtydyyyeeryedy', NULL, '2022-09-22 06:50:00', '2022-09-22 08:10:00', 1);
INSERT INTO `eventos` VALUES (31, '90', 'zdbhdb', NULL, '2022-09-22 08:30:00', '2022-09-22 09:00:00', 1);
INSERT INTO `eventos` VALUES (32, '90', 'asrvfgarg', NULL, '2022-09-29 05:00:00', '2022-09-29 15:16:00', 1);
INSERT INTO `eventos` VALUES (36, '90', 'Nuevo Evento de prueba', NULL, '2022-09-10 06:00:00', '2022-09-10 07:05:00', 1);
INSERT INTO `eventos` VALUES (37, '90', 'ASDASD', NULL, '2022-09-24 03:00:00', '2022-09-24 20:34:00', 1);
INSERT INTO `eventos` VALUES (38, '90', 'ASDASD', NULL, '2022-09-22 15:00:00', '2022-09-22 10:34:00', 1);
INSERT INTO `eventos` VALUES (39, '90', 'asdas', NULL, '2022-09-08 00:00:00', '2022-09-08 18:36:00', 1);
INSERT INTO `eventos` VALUES (40, '90', 'asdasd', 'asdasdas', '2022-08-31 00:00:00', '2022-08-31 20:22:00', 1);
INSERT INTO `eventos` VALUES (41, '90', 'sgsge', 'drfhdr', '2022-09-09 00:00:00', '2022-09-09 18:23:00', 1);
INSERT INTO `eventos` VALUES (42, '90', 'asdasdasd', 'asdasd', '2022-10-01 05:00:00', '2022-10-01 08:25:00', 1);
INSERT INTO `eventos` VALUES (43, '90', 'asdasdasd', 'asdasd', '2022-09-24 00:00:00', '2022-09-24 08:25:00', 1);
INSERT INTO `eventos` VALUES (44, '90', 'adsd', 'asdasd', '2022-09-17 08:00:00', '2022-09-17 10:26:00', 1);
INSERT INTO `eventos` VALUES (45, '90', 'fffff', 'fffff', '2022-09-17 10:00:00', '2022-09-17 04:27:00', 1);
INSERT INTO `eventos` VALUES (46, '90', 'asdasdasd', 'asdasdas', '2022-10-01 15:00:00', '2022-10-01 20:27:00', 1);
INSERT INTO `eventos` VALUES (47, '90', 'prueba', 'observacción', '2022-09-03 06:00:00', '2022-09-03 08:38:00', 1);

-- ----------------------------
-- Table structure for niveles_configuracion
-- ----------------------------
DROP TABLE IF EXISTS `niveles_configuracion`;
CREATE TABLE `niveles_configuracion`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `nivel` int NULL DEFAULT NULL,
  `cod_padre` int NULL DEFAULT NULL COMMENT 'Hace referencia al nivel del cual depende en la misma tabla.',
  `cod_empresa` int NOT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `fk_niveles_configuracion_empresas`(`cod_empresa`) USING BTREE,
  CONSTRAINT `fk_niveles_configuracion_empresas` FOREIGN KEY (`cod_empresa`) REFERENCES `empresas` (`codigo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of niveles_configuracion
-- ----------------------------
INSERT INTO `niveles_configuracion` VALUES (1, 'PERSPECTIVAS', 'PERS', 1, 1, 0, 1);
INSERT INTO `niveles_configuracion` VALUES (2, 'OBJETIVOS ESTRATEGICOS', 'OBJ EST', 1, 2, 1, 1);
INSERT INTO `niveles_configuracion` VALUES (3, 'INDICADORES ESTRATEGICOS', 'IND EST', 1, 3, 2, 1);

-- ----------------------------
-- Table structure for niveles_pei
-- ----------------------------
DROP TABLE IF EXISTS `niveles_pei`;
CREATE TABLE `niveles_pei`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `cod_padre` int NULL DEFAULT NULL COMMENT 'Hace referencia al nivel del cual depende en la misma tabla.',
  `cod_nivelconfiguracion` int NULL DEFAULT NULL,
  `bandera_actividades` int NULL DEFAULT 0 COMMENT 'Hace referencia si el nivel de PEI aceptara actividades de un POA',
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of niveles_pei
-- ----------------------------
INSERT INTO `niveles_pei` VALUES (1, 'INSTITUCIONAL', 'INS', 1, 0, 1, 0);
INSERT INTO `niveles_pei` VALUES (2, 'PROCESOS', 'PRO', 1, 0, 1, 0);
INSERT INTO `niveles_pei` VALUES (3, 'FINANCIERA', 'FIN', 1, 0, 1, 0);
INSERT INTO `niveles_pei` VALUES (4, 'TECNOLOGICA', 'TEC', 1, 0, 1, 0);
INSERT INTO `niveles_pei` VALUES (5, 'FORTALECIMIENTO DEL AREA TECNOLOGICA DE IBNORCA', 'OBJTI1', 1, 4, 2, 0);
INSERT INTO `niveles_pei` VALUES (6, 'CONSTRUCCION DEL DATACENTER IBNORCA', 'IE_TI_1', 1, 5, 3, 1);
INSERT INTO `niveles_pei` VALUES (7, 'PRUEBA', '2121', 1, 1, 2, 0);
INSERT INTO `niveles_pei` VALUES (8, 'ASDASD', 'ASDASD', 1, 0, 1, 0);
INSERT INTO `niveles_pei` VALUES (10, 'DASD', 'ASDASD', 1, 8, 1, 0);
INSERT INTO `niveles_pei` VALUES (11, 'SSSSS', 'DDDDD', 1, 0, 1, 1);

-- ----------------------------
-- Table structure for niveles_pei_adicionales
-- ----------------------------
DROP TABLE IF EXISTS `niveles_pei_adicionales`;
CREATE TABLE `niveles_pei_adicionales`  (
  `cod_nivelpei` int NOT NULL,
  `cod_campodisponible` int NOT NULL,
  `valor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cod_nivelpei`, `cod_campodisponible`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of niveles_pei_adicionales
-- ----------------------------
INSERT INTO `niveles_pei_adicionales` VALUES (9, 1, '   0ssss');
INSERT INTO `niveles_pei_adicionales` VALUES (9, 5, '2ssss');
INSERT INTO `niveles_pei_adicionales` VALUES (11, 1, 'ASDA1321321321');
INSERT INTO `niveles_pei_adicionales` VALUES (11, 5, '6843165');

-- ----------------------------
-- Table structure for nivelesconf_camposdisponibles
-- ----------------------------
DROP TABLE IF EXISTS `nivelesconf_camposdisponibles`;
CREATE TABLE `nivelesconf_camposdisponibles`  (
  `cod_nivelconfiguracion` int NOT NULL,
  `cod_campodisponible` int NOT NULL,
  `orden` int NULL DEFAULT NULL,
  PRIMARY KEY (`cod_nivelconfiguracion`, `cod_campodisponible`) USING BTREE,
  INDEX `fk_nivelesconf_campos_campos_disponibles1`(`cod_campodisponible`) USING BTREE,
  CONSTRAINT `fk_nivelesconf_campos_campos_disponibles1` FOREIGN KEY (`cod_campodisponible`) REFERENCES `campos_disponibles` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_nivelesconf_campos_niveles_configuracion1` FOREIGN KEY (`cod_nivelconfiguracion`) REFERENCES `niveles_configuracion` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nivelesconf_camposdisponibles
-- ----------------------------
INSERT INTO `nivelesconf_camposdisponibles` VALUES (1, 1, 20);
INSERT INTO `nivelesconf_camposdisponibles` VALUES (1, 5, 20);

-- ----------------------------
-- Table structure for nivelespei_unidadesareas
-- ----------------------------
DROP TABLE IF EXISTS `nivelespei_unidadesareas`;
CREATE TABLE `nivelespei_unidadesareas`  (
  `cod_nivelpei` int NOT NULL,
  `cod_unidadorganizacional` int NOT NULL,
  `cod_area` int NOT NULL,
  PRIMARY KEY (`cod_nivelpei`, `cod_unidadorganizacional`, `cod_area`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nivelespei_unidadesareas
-- ----------------------------
INSERT INTO `nivelespei_unidadesareas` VALUES (6, 829, 273);
INSERT INTO `nivelespei_unidadesareas` VALUES (6, 829, 826);

-- ----------------------------
-- Table structure for personal
-- ----------------------------
DROP TABLE IF EXISTS `personal`;
CREATE TABLE `personal`  (
  `codigo` int NOT NULL,
  `cod_tipo_identificacion` int NULL DEFAULT NULL,
  `tipo_identificacion_otro` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `identificacion` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT '',
  `cod_lugar_emision` int NULL DEFAULT NULL,
  `lugar_emision_otro` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `fecha_nacimiento` date NULL DEFAULT NULL,
  `cod_cargo` int NULL DEFAULT NULL,
  `cod_unidadorganizacional` int NULL DEFAULT NULL,
  `cod_area` int NULL DEFAULT NULL,
  `jubilado` int NULL DEFAULT NULL,
  `cod_genero` int NULL DEFAULT NULL,
  `cod_tipopersonal` int NULL DEFAULT NULL,
  `haber_basico` double NULL DEFAULT NULL,
  `paterno` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `materno` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `apellido_casada` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `primer_nombre` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `otros_nombres` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nua_cua_asignado` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `direccion` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_tipoafp` int NULL DEFAULT NULL,
  `cod_tipoaporteafp` int NULL DEFAULT NULL,
  `nro_seguro` varchar(25) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_estadopersonal` int NULL DEFAULT NULL,
  `telefono` varchar(15) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `celular` varchar(15) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `persona_contacto` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  `created_by` int NULL DEFAULT NULL,
  `modified_at` datetime NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int NULL DEFAULT NULL,
  `cod_estadoreferencial` int NULL DEFAULT NULL,
  `cod_nacionalidad` int NULL DEFAULT NULL,
  `cod_estadocivil` int NULL DEFAULT NULL,
  `cod_pais` int NULL DEFAULT NULL,
  `cod_departamento` int NULL DEFAULT NULL,
  `cod_ciudad` int NULL DEFAULT NULL,
  `ciudad_otro` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_grado_academico` int NULL DEFAULT NULL,
  `ing_contr` date NULL DEFAULT NULL,
  `ing_planilla` date NULL DEFAULT NULL,
  `email_empresa` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `bandera` int NULL DEFAULT NULL,
  `personal_confianza` int NOT NULL,
  `cuenta_bancaria` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  INDEX `codigo`(`codigo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal
-- ----------------------------
INSERT INTO `personal` VALUES (0, 0, NULL, '0', 0, NULL, NULL, NULL, 829, NULL, NULL, NULL, 1, NULL, '-', '-', NULL, '-', NULL, NULL, '-', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, '2021-10-27 15:01:37', NULL, '2022-01-24 22:30:44', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `personal` VALUES (5, 1581, NULL, '2233839', 480, NULL, '1966-08-23', 16, 829, 826, 0, 73, 1, 10679.6, 'Miranda', 'Perez', '', 'Willy', '', '0', 'Calle Juan Manuel Loza # 1776', 1, 2, '0', 1, '', '77294955', 'imwilly@hotmail.com', '0', '2020-01-02 07:31:02', 1, '2022-07-28 17:18:30', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2015-04-13', '2015-04-13', 'willy.miranda@ibnorca.org', 1, 0, '1999014018');
INSERT INTO `personal` VALUES (7, 1581, NULL, '6094406', 480, NULL, '1985-03-07', 12, 829, 2978, 0, 74, 1, 7210, 'Prudencio', 'Caballero', '', 'Anneliese', '', '43868502', 'San Miguel Calle Javier Zalles N° 883 Edificio Tredinick Piso 7 Dpto 7B', 1, 2, '0', 1, '', '61003251', 'prudencioanneliese@gmail.com', '0', '2020-01-02 07:31:39', 1, '2022-07-28 21:55:01', 58, 1, 26, 0, 26, 480, 62, NULL, 4, '2018-05-10', '2018-05-10', 'anneliese.prudencio@ibnorca.org', 1, 0, '2705064019');
INSERT INTO `personal` VALUES (8, 0, NULL, '6746760', 480, NULL, '1987-11-21', 40, 829, 2978, 0, 73, 1, 4595.06, 'Cardozo', 'Portugal', '', 'Pedro Agustin', '', '0', 'c 6 N 385 Santiago II', 1, 2, '0', 1, '22809271', '67162671', 'pedro.cardozo2312@gmail.com', '0', '2020-01-02 07:31:21', 1, '2022-07-28 22:01:46', 58, 1, 26, 1575, 26, 480, 72, NULL, 4, '2014-10-01', '2014-10-01', 'pedro.cardozo@ibnorca.org', 1, 0, '4279804011');
INSERT INTO `personal` VALUES (9, 1581, NULL, '6089959', 480, NULL, '1989-04-20', 21, 829, 826, 0, 73, 1, 6, 'Romero', 'Rocha', '', 'Gonzalo Marcelo', '', '0', 'Llojeta Urbanizacion el Vergelito Calle K SN', 1, 2, '0', 2, '', '71224246', 'gonzalo.romero89@gmail.com', '0', '2020-01-02 07:31:03', 1, '2021-06-26 10:59:29', 90, 1, 26, 1576, 26, 480, 62, NULL, 4, '2016-01-04', '2016-01-04', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (13, 1581, NULL, '3433771', 480, NULL, '1969-03-24', 4, 829, 11, 0, 73, 1, 5683.35, 'Castro', 'Parada', '', 'René', '', '37966807', 'Zona Sur- Alto Calacoto sector Pedregal', 2, 2, '0', 1, '-', '59173034330', 'rcastroparada@gmail.com', '0', '2020-01-02 07:31:12', 1, '2022-07-28 22:31:51', 58, 1, 26, 1576, 26, 480, 62, NULL, 2, '2012-07-17', '2012-07-17', 'rene.castro@ibnorca.org', 1, 0, '3158264012');
INSERT INTO `personal` VALUES (15, 1581, NULL, '5219994', 479, NULL, '1982-05-10', 17, 9, 826, 0, 74, 1, 6203.66, 'Mejia', 'Soliz', '', 'Claudia Cristina', '', '34913099', 'Calle jesus Aguayo Nº 1446', 1, 2, '0', 1, '4416183', '70373067', 'cristinac01@hotmail.com', '0', '2020-01-02 07:31:26', 1, '2022-08-02 11:32:20', 58, 1, 0, 1576, 26, 479, NULL, NULL, 2, '2007-07-02', '2007-07-02', 'cristina.mejia@ibnorca.org', 1, 0, '1313264013');
INSERT INTO `personal` VALUES (16, NULL, NULL, '3701778', 483, NULL, '1971-12-02', 15, 829, 872, 0, 74, 1, 10121.67, 'Llano', 'Navarro', '', 'Maria Roxana', '', '0', 'Chasquipampa Calle 45 No 45', 2, 1, '0', 2, '2147483647', '71559957', 'roxanallano@hotmail.com', '0', '2020-01-02 07:30:58', 1, '2020-09-16 12:01:34', 1, 1, 26, NULL, NULL, NULL, 62, NULL, 4, '2015-06-01', '2015-06-01', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (17, 1581, NULL, '6261962', 484, NULL, '1985-03-29', 4, 10, 2957, 0, 73, 1, 9514.93, 'CASTRO', 'SUAREZ', '', 'YSNAIDER', '', '41178002', 'Av. 3 pasos al frente 10mo anillo Urb. Leónidas B/ EL TOTAI', 2, 2, '0', 1, '68918480', '68918480', 'ysnaider.castro@gmail.com', '0', '2020-01-02 07:31:42', 1, '2022-08-05 12:56:54', 58, 1, 26, 1575, 26, 484, 65, NULL, 4, '2012-08-20', '2012-08-20', 'ysnaider.castro@ibnorca.org', 1, 0, '5866944018');
INSERT INTO `personal` VALUES (18, 1581, NULL, '5384121', 484, NULL, '1986-03-18', 8, 829, 13, 0, 74, 1, 5085.52, 'Nogales', '', '', 'Delcy Gabriela', '', '38867333', 'Av. Busch Calle 4 Nro. 17', 1, 2, '0', 1, '3572787', '59170839282', 'delcyg.nogales@gmail.com', '0', '2020-11-09 11:47:44', 1, '2022-08-02 10:51:33', 58, 1, 26, 1576, 26, 484, 65, NULL, 0, '2021-09-06', '2021-09-06', 'delcy.nogales@ibnorca.org ', 1, 0, '2344374018');
INSERT INTO `personal` VALUES (21, 1581, NULL, '1842448', 485, NULL, '1968-11-25', 15, 271, 2978, 0, 74, 1, 4696, 'Cayo', 'Ayarde', '', 'Janeth', '', '0', '00', 2, 2, '0', 2, '0', '75134656', 'taya.janeth@gmail.com', '0', '2020-07-17 17:37:18', 1, '2021-07-25 17:20:50', 90, 2, 0, NULL, 26, 485, NULL, NULL, 4, '2007-10-01', '2007-10-01', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (22, 1581, NULL, '6277898', 484, NULL, '1985-04-16', 4, 10, 11, 0, 73, 1, 5683.35, 'Tejerina', 'Saavedra', '', 'Carlos Alberto', '', '41947371', 'Av. cumavi 9no anillo Urbanización El Buen Samaritano', 2, 2, '0', 1, 'N/A', '79903441', 'carlostejerina.cat@gmail.com', '0', '2020-01-02 07:31:43', 1, '2022-08-02 10:41:45', 58, 1, 26, 1575, 26, 484, 65, NULL, 2, '2014-03-17', '2014-03-17', 'carlos.tejerina@ibnorca.org', 1, 0, '3903914016');
INSERT INTO `personal` VALUES (23, 1581, NULL, '5859990', 484, NULL, '1980-09-19', 4, 10, 11, 0, 73, 1, 5683.35, 'Orellana', 'Flores', '', 'Justo', '', '0', 'Av.  Libertadores entre 8vo y 9no Anillo', 1, 2, '0', 1, '-', '77615549', 'justo.orellana@gmail.com', '0', '2020-01-02 07:31:44', 1, '2022-08-02 10:43:33', 58, 1, 26, 1575, 26, 484, 65, NULL, 4, '2015-08-01', '2015-08-01', 'justo.orellana@ibnorca.org', 1, 0, '5866944018');
INSERT INTO `personal` VALUES (26, NULL, NULL, '8984611', 477, NULL, '1990-02-14', 26, 10, 273, 0, 74, 1, 3627.67, 'Chavez', 'Solares', '', 'Graciela Efigenia', '', '0', NULL, 2, 2, '0', 1, '', '78187081', 'schon.fraug@gmail.com', '0', '2020-01-02 07:31:45', 1, '2022-08-02 10:19:11', 58, 1, NULL, NULL, NULL, 484, NULL, NULL, 2, '2015-07-22', '2015-07-22', 'graciela.chavez@ibnorca.org', 1, 0, '4718064011');
INSERT INTO `personal` VALUES (27, 0, NULL, '5515128', 483, NULL, '1984-03-21', 4, 271, 11, 0, 73, 1, 5683.35, 'Barroso', 'Cordova', '', 'Josue Antonio', '', '38196839', 'Av. Dorbigni No. 1740 casi Calle J. Espinoza', 2, 2, '0', 1, '77171161', '77171161', 'josue_bacor4@hotmail.com', '0', '2020-01-02 07:31:54', 1, '2022-08-02 11:37:00', 58, 1, 26, 1576, 26, 479, 64, NULL, 3, '2012-06-25', '2012-06-25', 'josue.barroso@ibnorca.org', 1, 0, '3157664017');
INSERT INTO `personal` VALUES (29, 1581, NULL, '8436683', 480, NULL, '1990-04-09', 8, 5, 13, 0, 73, 1, 4595.06, 'Serrudo', 'Cardozo', '', 'Carlos Freddy', '', '0', 'Zona Santiago II calle 5 Nº 462', 1, 2, '0', 1, '', '77296032', 'carlos.serrudo420@gmail.com', '0', '2020-01-02 07:31:21', 1, '2022-07-28 22:54:47', 58, 1, 0, 1576, 26, 480, NULL, NULL, 4, '2015-06-08', '2015-06-08', 'carlos.serrudo@ibnorca.org', 1, 0, '4621534012');
INSERT INTO `personal` VALUES (31, 1581, NULL, '2284758', 480, NULL, '1969-02-22', 0, 9, 502, 0, 74, 1, 1569.08, 'Beltran', 'Pacheco', '', 'Maria del Carmen', '', '0', 'Calle Chipaya esquina Apurimac Edificio Ichiban Depto 1B', 2, 2, '0', 2, '4020542', '72205558', 'beltranpachecocarmen@gmail.com', '0', '2020-01-02 07:31:23', 1, '2021-06-26 10:59:29', 90, 1, 26, 0, 26, 479, 64, NULL, 4, '2002-08-01', '2002-08-01', '00', 1, 0, '0');
INSERT INTO `personal` VALUES (32, 1581, NULL, '4778441', 480, NULL, '1976-09-30', 1, 829, 2957, 0, 73, 1, 16162.25, 'Palomo', 'Sainz', '', 'Julio Augusto', '', '36786226', 'Condominio Claveles del Sur - Bloque 27 - Achumani', 2, 2, '0', 1, '', '70779369 -72060', 'jpalomo30@yahoo.com', '0', '2020-01-02 07:30:55', 1, '2022-07-28 22:21:23', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2005-12-01', '2005-12-01', 'julio.palomo@ibnorca.org', 1, 0, '1032224012');
INSERT INTO `personal` VALUES (33, 1581, NULL, '2285914', 480, NULL, '1959-04-27', 0, 9, 39, 0, 74, 1, 11000, 'Linares', 'Ponce', '', 'Miriam', '', '0', 'Calle Las Dalias S/N - zona Norte', 1, 2, '0', 2, '4010775', '71460810', 'Mlinaresp27@gmail.com', '0', '2020-01-02 07:31:27', 1, '2022-07-13 12:44:15', 90, 1, 26, 1576, 26, 479, 64, NULL, 4, '2001-03-01', '2001-03-01', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (34, 1581, NULL, '3570044', 479, NULL, '1974-02-16', 0, 0, 0, 0, 73, 0, 0, 'Torrico', 'Herbas ', '', 'Benjamin Joel', '', '', 'Calle Enrique Arze Nro. 2282 - Zona Cala Cala', 0, 0, '', 2, '4476267', '77492263', 'btorrico@gmail.com', '', '2020-01-02 07:31:29', 1, '2021-09-29 17:25:44', 1, 1, 26, 1576, 26, 479, 64, NULL, 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (35, 1581, NULL, '4380091', 479, NULL, '1975-07-23', 38, 9, 11, 0, 73, 1, 5960.47, 'Mejía', 'Navia', '', 'Jorge Daniel', '', '33916706', 'Calle Héroes Nacionales N° 293', 1, 2, '0', 1, '4280217', '70772592', 'jordanio123@hotmail.com', '0', '2020-01-02 07:31:30', 1, '2022-08-02 11:35:43', 58, 1, 26, 1575, 26, 479, 64, NULL, 4, '2010-01-04', '2010-01-04', 'jorge.mejia@ibnorca.org', 1, 0, '1032214025');
INSERT INTO `personal` VALUES (36, 0, NULL, '3529338', 481, NULL, '1983-02-08', 13, 9, 871, 0, 73, 1, 6270.04, 'Guerrero', 'Ayoroa', '', 'Daniel Alejandro', '', '0', 'Calle Irigoyen N° 100', 1, 2, '0', 1, '4219976', '75939993', 'guerrero.dani@gmail.com', '0', '2020-01-02 07:31:29', 1, '2022-08-08 15:14:38', 58, 1, 26, 0, 26, 479, 64, NULL, 4, '2010-05-05', '2010-05-05', 'daniel.guerrero@ibnorca.org', 1, 0, '2279094011');
INSERT INTO `personal` VALUES (37, 1581, NULL, '5232163', 479, NULL, '1980-02-22', 42, 10, 13, 0, 74, 1, 9582.1, 'Valdez', 'Cespedes', '', 'Doyna Gabriela', '', '36632661', 'CONDOMINIO SEVILLA LOS JARDINES - ZONA NORTE', 2, 2, '0', 1, '', '71751164', 'gabriela.valdezdc@gmail.com', '0', '2020-01-02 07:31:46', 1, '2022-08-02 10:24:14', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2007-02-13', '2007-02-13', 'gabriela.valdez@ibnorca.org', 1, 0, '1211994017');
INSERT INTO `personal` VALUES (40, 1581, NULL, '4832596', 480, NULL, '1983-01-06', 33, 829, 4357, 0, 73, 1, 9064, 'Rendon', 'Salas', '', 'Alejandro', '', '0', 'Calle Los Alamos N° 1070, Zona Alto Obrajes', 1, 2, '0', 1, '', '70673657', 'alejandro.rendon.s@gmail.com', '0', '2020-01-02 07:31:16', 1, '2022-08-08 15:34:38', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2015-08-03', '2015-08-03', 'alejandro.rendon@ibnorca.org ', 1, 0, '4813914013');
INSERT INTO `personal` VALUES (41, 1581, NULL, '3527730', 481, NULL, '1976-07-04', 37, 9, 273, 0, 74, 1, 8497.16, 'Castellon', 'Clavijo', '', 'Katia Mireya', '', '36025148', 'Tiquipaya Calle Tuska No.3', 2, 2, '0', 1, '4229663', '76417011', 'kat.cast407@gmail.com', '0', '2020-01-02 07:31:24', 1, '2022-08-02 11:25:37', 58, 1, 26, 1576, 26, 479, 64, NULL, 4, '2003-07-01', '2003-07-01', 'katia.castellon@ibnorca.org', 1, 0, '851604014');
INSERT INTO `personal` VALUES (42, 1581, NULL, '4527802', 479, NULL, '1978-05-02', 32, 829, 273, 0, 74, 1, 4595.06, 'Ramirez', 'Vargas', '', 'Roxana', '', '0', 'Calle Siglo XX- Sacaba', 1, 2, '0', 1, '4067875', '77036420', 'santiroxfre@gmail.com', '0', '2020-01-02 07:31:25', 1, '2022-08-08 14:52:12', 58, 1, 26, 1576, 26, 479, 48446, NULL, 2, '2010-09-07', '2010-09-07', 'roxana.ramirez@ibnorca.org', 1, 0, '2285414019');
INSERT INTO `personal` VALUES (43, 1581, NULL, '4085357', 478, NULL, '1980-09-12', 4, 5, 11, 0, 73, 1, 6363.24, 'Gómez', 'Zenteno', '', 'Ramiro Benjamín', '', '35344866', 'Calle Bolivar N° 942', 1, 2, '0', 1, '', '', 'ramiro.begoze@gmail.com', '0', '2020-01-02 07:31:54', 1, '2022-08-02 12:11:41', 58, 1, 26, 1576, 26, 478, 69, NULL, 4, '2008-07-07', '2008-07-07', 'ramiro.gomez@ibnorca.org', 1, 0, '1721104016');
INSERT INTO `personal` VALUES (44, 1581, NULL, '1112060', 478, NULL, '1969-07-07', 15, 270, 2978, 0, 74, 1, 4304.18, 'Bueno', 'Ipiña', '', 'Jhoselyn Ana', '', '0', 'Aniceto Arce # 345', 2, 2, '0', 2, '', '59172859172', 'ajbueno27@hotmail.com', '0', '2020-01-02 07:31:53', 1, '2021-07-25 17:15:46', 90, 2, 26, 1577, 26, 478, 69, NULL, 1, '2007-08-01', '2007-08-01', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (47, 1581, NULL, '7693431', 484, NULL, '1989-02-20', 34, 829, 4357, 0, 74, 1, 6771.65, 'Linares', 'Aranda', '', 'Carla Daniela', '', '0', '5to anillo Radial 27', 1, 2, '0', 1, '', '72677614', 'clinaresaranda@gmail.com', '0', '2020-01-02 07:31:41', 1, '2022-08-02 10:21:27', 58, 1, 0, 0, 26, 484, 65, NULL, 4, '2015-11-03', '2015-11-03', 'carla.linares@ibnorca.org ', 1, 0, '4946874014');
INSERT INTO `personal` VALUES (48, 1581, NULL, '3658859', 478, NULL, '1978-11-25', 44, 10, 11, 0, 74, 1, 10171.04, 'Cuevas', 'Calderon', '', 'Silvia', '', '37054089', 'Av. Monseñor Costas Nº 635, Zona El trompillo', 2, 2, '0', 1, '3 525291', '77383273', 'silvicuevas@hotmail.com', '0', '2020-01-02 07:31:39', 1, '2022-08-02 10:38:19', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2006-08-29', '2006-08-29', 'silvia.cuevas@ibnorca.org', 1, 0, '1093034011');
INSERT INTO `personal` VALUES (49, 1581, NULL, '7464020', 478, NULL, '1986-06-25', 8, 10, 13, 0, 74, 1, 4595.06, 'Serrano', 'Núñez', '', 'María Angélica', '', '42756662', 'Final Av. Virgen de Luján B/San Cayetano', 2, 2, '0', 1, '', '69043886', 'anghicita2505@gmail.com', '0', '2020-01-02 07:31:37', 1, '2022-08-02 12:43:03', 58, 1, 26, 1575, 26, 484, 65, NULL, 2, '2015-10-13', '2015-10-13', 'maria.serrano@ibnorca.org', 1, 0, '4104274019');
INSERT INTO `personal` VALUES (50, 1581, NULL, '6317932', 484, NULL, '1989-08-24', 37, 829, 273, 0, 74, 1, 5683.35, 'Segovia', 'Vaca', '', 'Yessica Laura', '', '40951169', 'Km. 7 Doble Vía La Guardia B/Berea Panamericano Calle 4 N° 108', 1, 2, '0', 1, '', '70971858', 'yessica.segovia.vaca@gmail.com', '0', '2020-01-02 07:31:36', 1, '2022-08-05 12:56:06', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2016-03-01', '2016-03-01', 'yessica.segovia@ibnorca.org ', 1, 0, '1892714017');
INSERT INTO `personal` VALUES (51, 1581, NULL, '4891802', 480, NULL, '1976-10-13', 4, 5, 11, 0, 73, 1, 6180, 'Ballón', 'Guaygua', '', 'Miguel Angel', '', '0', 'Z. Bella Vista Av. Tomas Monje Pasaje B  Nº 100', 1, 2, '0', 1, '2786272', '70667775', 'mballonguaygua@gmail.com', '0', '2020-01-02 07:31:17', 1, '2022-07-28 23:08:01', 58, 1, 26, 1576, 26, 480, 62, NULL, 2, '2014-10-21', '2014-10-21', 'miguel.ballon@ibnorca.org', 1, 0, '699544027');
INSERT INTO `personal` VALUES (53, 0, NULL, '2689176', 480, NULL, '1964-04-11', 7, 10, 13, 0, 74, 1, 16161.4, 'Rodriguez', 'Salinas', '', 'Erika Florencia', '', '0', 'Urb. Villa Toscana N.16', 1, 2, '0', 1, '72100745', '72100745', 'erikkarosa@hotmail.com', '0', '2020-01-02 07:31:35', 1, '2022-08-02 10:49:27', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2010-04-07', '2010-04-07', 'erika.rodriguez@ibnorca.org', 1, 0, '2137074012');
INSERT INTO `personal` VALUES (54, 1581, NULL, '6382520', 484, NULL, '1987-04-22', 4, 10, 11, 0, 74, 1, 4595.06, 'Muñoz', 'Acosta', '', 'Gabriela', '', '45098797', 'Villa 1ro de Mayo B/Porvenir', 2, 2, '0', 1, '-', '75698501', 'yissel.yah@gmail.com', '0', '2020-01-02 07:31:40', 1, '2022-08-02 10:27:25', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2014-03-12', '2014-03-12', 'gabriela.muñoz@ibnorca.org', 1, 0, '3904664013');
INSERT INTO `personal` VALUES (58, 0, NULL, '4052068', 481, NULL, '1980-12-20', 32, 829, 273, 0, 74, 1, 7859.96, 'Solares', 'Brincil', '', 'Janis', '', '37615920', 'Calle Abdon Saavedra n°751 entre Guachalla y Chaco', 2, 2, '0', 1, '', '79406123', 'jasolbri@gmail.com', '0', '2020-01-02 07:31:50', 1, '2022-08-02 12:44:12', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2007-09-01', '2007-09-01', 'janis.solares@ibnorca.org', 1, 0, '1314114015');
INSERT INTO `personal` VALUES (59, 1581, NULL, '4022268', 481, NULL, '1979-02-11', 0, NULL, NULL, 0, 73, NULL, NULL, 'Arroyo', 'Mancilla', NULL, 'Jose Luis', NULL, NULL, ' La Paz # 5344 entre Herrera y 1ro de Noviembre', NULL, NULL, NULL, 2, '25258369', '72469217', 'jlam_pp3@hotmail.com', NULL, '2020-10-30 14:14:06', 1, '2022-06-13 14:24:25', 1, 1, 26, 1575, 26, 481, 66, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (62, 1581, NULL, '2709834', 480, NULL, '1966-09-25', 26, 829, 273, 0, 74, 1, 5702.78, 'Cuba', 'Aróstegui', '', 'María Teresa', '', '6587057', 'Plan 110 Manzano 346 Vivienda Nº 54 - Zona Villa Adela', 1, 2, '0', 1, '2833293', '75259903', 't.cuba2004@gmail.com', '0', '2020-01-02 07:31:20', 1, '2022-07-28 23:00:29', 58, 1, 26, 1575, 26, 480, 72, NULL, 1, '2003-09-01', '2003-09-01', 'teresa.cuba@ibnorca.org', 1, 0, '851904018');
INSERT INTO `personal` VALUES (68, 1581, NULL, '1861999', 485, NULL, '1979-07-23', 5, 5, 40, 0, 73, 1, 7696.71, 'Noriega', 'Salazar', '', 'Fabricio', '', '34557261', 'av. jose saravia Nº252 - Tembladerani', 1, 2, '0', 1, '0', '75808875', 'fabricio.noriega@gmail.com', '0', '2020-01-02 07:30:58', 1, '2022-08-08 15:12:47', 58, 1, 26, 1576, 26, 480, 62, NULL, 2, '2009-09-07', '2009-09-07', 'fabricio.noriega@ibnorca.org', 1, 0, '2045204017');
INSERT INTO `personal` VALUES (69, 1581, NULL, '4005778', 483, NULL, '1982-01-30', 31, 5, 40, 0, 73, 1, 4312.51, 'Davila', 'Abasto', '', 'Danny Willy', '', '0', 'Calle La Paz No 610 ', 2, 1, '00', 2, '6225503', '72887656', 'danny.davilamm@gmail.com', '0', '2020-01-02 07:31:14', 1, '2021-07-29 09:24:53', 1, 2, 26, 1576, 26, 483, 67, NULL, 2, '2010-07-26', '2010-07-26', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (70, 1581, NULL, '8447400', 480, NULL, '1989-04-26', 6, 5, 40, 0, 74, 1, 3627.67, 'Oropeza', 'Graneros', '', 'Katherin Amanda', '', '0', 'zona 1° de mayo N° 4  manzano P', 2, 2, '0', 1, '0', '63175538', 'katherinoro@hotmail.com', '0', '2020-01-02 07:31:15', 1, '2022-08-02 12:27:16', 58, 1, 26, 1576, 26, 480, 72, NULL, 2, '2014-08-01', '2014-08-01', 'katherine.amanda@ibnorca.org', 1, 0, '4299914017');
INSERT INTO `personal` VALUES (72, 1581, NULL, '3364992', 480, NULL, '1971-04-22', 36, 829, 273, 0, 73, 1, 4595.06, 'Larrea', 'Laguna', '', 'José Luis', '', '0', 'Z/ Villa San Antonio, Calle Mario Mercado N° 25', 2, 2, '0', 1, '', '71565758', 'pplarrea1971@gmail.com', '0', '2020-01-02 07:31:08', 1, '2022-07-28 17:03:01', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2014-02-01', '2014-02-01', 'jose.larrea@ibnorca.org ', 1, 0, '3918254012');
INSERT INTO `personal` VALUES (74, 1581, NULL, '3784578', 479, NULL, '1975-01-13', 3, 9, 11, 0, 73, 1, 8, 'Peredo', 'Rivas', '', 'Mirko Jean', '', '0', 'Calle Beni N° 235 Edif. Los Angeles depto. 3A', 1, 2, '0', 3, '4798718', '65713661', 'mirkoperedo@hotmail.com', '0', '2020-01-02 07:31:28', 1, '2022-07-28 22:57:33', 58, 1, 26, 1576, 26, 479, 64, NULL, 4, '2016-05-03', '2016-05-03', 'mirko-peredo@ibnorca.org', 1, 0, '0');
INSERT INTO `personal` VALUES (78, 1581, NULL, '6141327', 480, NULL, '1986-11-23', 41, 5, 12, 0, 74, 1, 9358.47, 'Torrelio', 'Aliaga', '', 'Alejandra Ariela', '', '0', 'Calle Demetrio Canelas Nro. 260 - Zona Obrajes', 1, 2, '0', 1, '0', '59170591546', 'alejandratorrelio@gmail.com', '0', '2020-01-02 07:31:11', 1, '2022-08-08 15:13:27', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2016-11-01', '2016-11-01', 'alejandra.torrelio@ibnorca.org ', 1, 0, '5016734014');
INSERT INTO `personal` VALUES (81, 1581, NULL, '4876883', 480, NULL, '1988-04-12', 9, 829, 12, 0, 74, 1, 14242.5, 'Sandi', 'Torrico', '', 'Andrea Stephanie', '', '0', 'Los Pinos Calle 2', 2, 1, '0', 2, '2422030', '72040770', 'andrea.sandit@gmail.com', '0', '2020-01-02 07:31:07', 1, '2021-09-30 15:50:50', 1, 1, 26, 1575, 26, 480, 62, NULL, 4, '2014-10-20', '2014-10-20', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (84, 0, NULL, '461774', 480, NULL, '1962-02-19', 28, 829, 847, 0, 73, 1, 28717.56, 'Durán ', 'Guillén', '', 'José Jorge', '', '0', 'La Paz', 1, 2, '0', 1, '0', '71548486', 'joseduranguillen@gmail.com', '0', '2020-01-02 07:30:50', 1, '2022-07-28 15:35:18', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2014-10-27', '2014-10-27', 'jose.duran@ibnorca.org ', 1, 0, '4287794024');
INSERT INTO `personal` VALUES (87, 0, NULL, '9358826', 479, NULL, '1995-02-21', 14, 9, 273, 0, 74, 1, 4000, 'Hinojosa', 'Cusicanqui', '', 'Helen', '', '0', 'Av. Fuerza Aérea Calle Patricia Lara', 1, 2, '0', 2, '79734635', '79734625', 'helenhinojosac@gmail.com', '0', '2020-01-02 07:31:25', 1, '2021-07-25 17:24:12', 90, 1, 26, 1575, 26, 479, 64, NULL, 2, '2017-04-03', '2017-04-03', '00', 1, 0, '0');
INSERT INTO `personal` VALUES (89, 1581, NULL, '5976118', 480, NULL, '1983-01-28', 30, 829, 273, 0, 73, 1, 9673.79, 'Mamani', 'Maji', '', 'Julio Alejandro', '', '32492327', 'Achumani, Zona Pantini Calle 6 de Agosto Nº 30 ', 2, 2, '19830128', 1, '', '78875720', 'alexander.mamani@gmail.com', '0', '2020-01-02 07:31:06', 1, '2022-08-08 14:50:57', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2002-03-01', '2002-03-01', 'julio.mamani@ibnorca.org', 1, 0, '0725294018');
INSERT INTO `personal` VALUES (90, 1581, NULL, '3358308', 480, NULL, '1970-08-28', 21, 829, 273, 0, 73, 1, 14922.17, 'Quenallata', 'Vega ', '', 'Juan Luis ', '', '31521721', 'Calle 8 N° 38 Villa San Antonio Bajo ', 2, 2, '0', 1, '2238301', '70567822', 'juanquenallata28@gmail.com', '0', '2020-01-02 07:31:05', 1, '2022-07-28 16:38:34', 58, 1, 26, 1576, 26, 480, 62, NULL, 1, '1999-03-01', '1999-03-01', 'juan.quenallata@ibnorca.org', 1, 0, '569494010');
INSERT INTO `personal` VALUES (91, NULL, NULL, '4937844', NULL, NULL, '0000-00-00', 7, 829, 847, 0, NULL, 1, 3840.2, 'Sierra', '', '', 'Sandra', '', '0', NULL, 1, 1, '0', 2, NULL, NULL, 'sasiviscarra@gmail.com', '0', '2020-01-02 07:30:51', 1, '2020-09-16 12:01:34', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2016-06-03', '2016-06-03', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (92, 1581, NULL, '5959142', 480, NULL, '0000-00-00', 28, 5, 39, 0, NULL, 1, 8218.03, 'Aldunate', 'Castedo', '', 'Carla Monica', '', '545421212', NULL, 1, 1, '545465654', 3, NULL, NULL, 'carla.aldunate@live.ca', 'JUAN PEREZ', '2020-01-02 07:31:09', 1, '2021-07-30 06:50:18', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 4, '2016-06-07', '2016-06-07', '', 1, 0, NULL);
INSERT INTO `personal` VALUES (93, 1581, NULL, '5954152', 480, NULL, '1990-08-14', 18, 829, 871, 0, 74, 1, 8939.22, 'Gallardo', 'Strelli', '', 'Maria Renée', '', '0', 'Av. Arce esq. Montevideo N° 2081', 1, 2, '0', 1, '2440117', '70520736', 'mariareneegallardo@gmail.com', '0', '2020-01-02 07:30:52', 1, '2022-07-28 15:39:54', 58, 1, 0, 1575, 26, 480, NULL, NULL, 4, '2016-10-06', '2016-10-06', 'maria.gallardo@ibnorca.org ', 1, 0, '5369544014');
INSERT INTO `personal` VALUES (96, 1581, NULL, '8331509', 480, NULL, '1994-01-26', 4, 5, 2957, 0, 74, 1, 4232.28, 'OSCO', 'CESPEDES', '', 'Glicet', '', '0', 'Zona Ovejuyo Callejon Eucaliptos Nro 7', 1, 2, '0', 1, '0', '68065047', 'glis26cha@gmail.com', '0', '2020-01-02 07:30:57', 1, '2022-07-28 22:30:02', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2017-03-01', '2017-03-01', 'glicet.osco@ibnorca.org ', 1, 0, '5665884017');
INSERT INTO `personal` VALUES (97, 1581, NULL, '8411443', 0, NULL, '1992-05-20', 15, 829, 2978, 0, 74, 1, 4120, 'Cochi', 'Tarqui', '', 'Carla Noelia', '', '0', 'calle pio XII Nro 99 Bella Vista', 2, 2, '0', 1, '', '65633785', 'carli.noeli0520@gmail.com', '0', '2020-01-02 07:30:59', 1, '2022-07-28 22:03:46', 58, 1, 26, 1575, 26, 480, 62, NULL, 2, '2018-02-01', '2018-02-01', 'carla.cochi@ibnorca.org ', 1, 0, '6123664017');
INSERT INTO `personal` VALUES (99, 1581, NULL, '2763530', 481, NULL, '1969-02-12', 19, 829, 872, 0, 74, 1, 9360, 'Mendez', 'Leclere', '', 'Martha', '', '0', 'Av. Arce No. 2896, San Jorge', 2, 1, '0', 2, '2430051', '70687412', 'mml.12395@gmail.com', '0', '2020-01-02 07:31:02', 1, '2021-02-23 16:37:11', 1, 1, 26, 1576, 26, 480, 62, NULL, 4, '2018-02-01', '2018-02-01', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (101, 1581, NULL, '10325029', 478, NULL, '1992-02-04', 15, 270, 2978, 0, 74, 1, 3259.95, 'LLANQUIPACHA', 'ROJAS', '', 'VERONICA', '', '49283091', 'Sebastian Pagador Nro 81', 2, 2, '0', 1, '-', '74457742', 'verito123r@gmail.com', '0', '2020-01-02 07:31:52', 1, '2022-08-02 12:19:33', 58, 1, 26, 1575, 26, 478, 69, NULL, 4, '2017-05-02', '2017-05-02', 'veronica.llamquipacha.ibnorca.org ', 1, 0, '5226914023');
INSERT INTO `personal` VALUES (114, 0, NULL, '4079945', 477, NULL, '1969-12-31', 0, 0, 0, 0, 74, 0, 0, 'VILLARROEL', 'LARRAZABAL', '', 'JANET', '', '', '-', 0, 0, '', 2, '0', '72478279', 'janet_villarroel@hotmail.com', '', '2020-01-02 07:31:49', 1, '2020-09-16 12:01:34', 1, 1, 0, 0, 26, 484, 65, NULL, 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (118, 1581, NULL, '5211933', 479, NULL, '1980-11-10', 10, 9, 12, 0, 74, 1, 5, 'Almanza', 'Aguirre', '', 'Mariela Julia', '', '0', 'Circuito Bolivia / Calle 7  - Edificio Calicanto', 1, 2, '0', 3, '4506606', '72723122', 'mariela.almanza.aguirre@gmail.com', '0', '2020-01-02 07:31:32', 1, '2021-07-12 14:45:05', 195, 1, 26, 1576, 26, 479, 64, NULL, 4, '2010-09-13', '2010-09-13', 'SN', 1, 0, '0');
INSERT INTO `personal` VALUES (141, 1581, NULL, '6030222', 480, NULL, '1987-04-16', 38, 10, 11, 0, 73, 1, 5683.35, 'Padilla', 'Avalos', '', 'Iván', '', '0', 'Barrio Virgen de Guadalupe, Calle San Simón, Nro. 8370, Zona Norte', 2, 2, '0', 1, '', '75583591; 78475', 'ivan.padilla.avalos87@gmail.com', '0', '2020-01-02 07:31:43', 1, '2022-08-02 10:39:56', 58, 1, 26, 1576, 26, 484, 65, NULL, 4, '2017-06-19', '2017-06-19', 'ivan.padilla@ibnorca.org ', 1, 0, '5866444015');
INSERT INTO `personal` VALUES (168, 1581, NULL, '3479988', 480, NULL, '1970-12-03', 35, 829, 273, 0, 74, 1, 3627.67, 'Mallea', 'Ortiz', '', 'Rocio', '', '11563591', 'Pampahasi, Calle 1 N° 60', 1, 2, '0', 1, '', '78804104', 'francymalleaortiz3@gmail.com', '0', '2020-01-02 07:31:01', 1, '2022-08-08 14:51:30', 58, 1, 26, 1575, 26, 480, 62, NULL, 2, '2007-09-01', '2007-09-01', 'rocio.mallea@ibnorca', 1, 0, '1312974017');
INSERT INTO `personal` VALUES (173, 1581, NULL, '4880453', 480, NULL, '1988-03-19', 38, 5, 11, 0, 73, 1, 4836.9, 'Zapata', 'Aviles', '', 'Jose', '', '0', 'Calle 60 Chasquipampa #10', 1, 2, '0', 1, '', '70530205', 'josezapataviles@gmail.com', '0', '2020-01-02 07:31:18', 1, '2022-07-28 23:03:54', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2018-03-01', '2018-03-01', 'jose.zapata@ibnorca.org ', 1, 0, '6175644014');
INSERT INTO `personal` VALUES (176, 1581, NULL, '8464972', 480, NULL, '1993-08-29', 9, 829, 12, 0, 73, 1, 6180, 'Vargas', 'Saucedo', '', 'Oscar Alejandro', '', '32492327', 'Av. Hugo Ernest, 48', 2, 2, '0', 1, '0', '79551284', 'oscarvargas.sa@gmail.com', '0', '2020-01-02 07:30:56', 1, '2022-07-28 22:05:58', 58, 1, 26, 0, 26, 480, 62, NULL, 4, '2018-03-01', '2018-03-01', 'oscar.vargas@ibnorca.org ', 1, 0, '6252374017');
INSERT INTO `personal` VALUES (177, 1581, NULL, '6699734', 483, NULL, '1990-02-19', 43, 829, 2957, 0, 74, 1, 6435.44, 'Zarate', 'Cazas', '', 'Cintya Marcela', '', '45102673', 'Calle 31 de achumani condominio claveles del sur 2da terraza', 2, 2, '0', 1, '', '73477524', 'cintycazas@gmail.com', '0', '2020-01-02 07:31:13', 1, '2022-07-28 22:24:10', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2018-03-15', '2018-03-15', 'cintya.zarate@ibnorca.org', 1, 0, '4577434013');
INSERT INTO `personal` VALUES (181, 1581, NULL, '3029088', 479, NULL, '1967-07-17', 26, 9, 273, 0, 74, 1, 4122.46, 'Sejas', 'Gallardo', '', 'Elizabeth', '', '34081859', 'Av. Capitan Ustaris Km 6 S/N', 1, 2, '0', 1, '4433589', '77988302', 'esg1717@hotmail.com', '0', '2020-01-02 07:31:31', 1, '2022-08-02 11:26:49', 58, 1, 26, 1577, 26, 479, 64, NULL, 1, '2005-01-03', '2005-01-03', 'elizabeth.sejas@ibnorca.org', 1, 0, '940904013');
INSERT INTO `personal` VALUES (182, 1581, NULL, '2396185', 480, NULL, '1971-02-22', 4, 5, 11, 0, 73, 1, 4595.06, 'Velásquez', 'Camargo', '', 'Edving Gustavo', '', '0', 'Cota Cota Calle 28 Nro 500', 2, 2, '0', 1, '', '69751350', 'edvingustavo@gmail.com', '0', '2020-01-02 07:31:19', 1, '2022-07-28 23:05:29', 58, 1, 26, 1576, 26, 480, 72, NULL, 2, '2018-05-02', '2018-05-02', 'edving.velasquez@ibnorca.org ', 1, 0, '2619234017');
INSERT INTO `personal` VALUES (183, 1581, NULL, '2380100', 480, NULL, '1963-10-30', 45, 829, 13, 0, 73, 1, 8569.6, 'Rojas', 'Urquizo', '', 'Luis Fernando', '', '0', 'Calle E. N° 1993. Irpavi 2', 2, 2, '0', 1, '2723814', '65170598', 'lfrojasu@gmail.com', '0', '2020-01-02 07:30:53', 1, '2022-07-28 22:52:37', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2018-03-12', '2018-03-12', 'luis.rojas@ibnorca.org ', 1, 0, '5851174011');
INSERT INTO `personal` VALUES (187, 0, NULL, '9336085', 479, NULL, '1994-11-08', 0, 9, 2978, 0, 74, 1, 3, 'Montan', 'Arze', '', 'Maria Laura', '', '0', 'Av. Heroes del boqueron', 2, 2, '0', 2, '', '', 'montanarzelaura@gmail.com', '0', '2020-01-02 07:31:34', 1, '2022-07-28 21:30:19', 58, 1, 26, 1575, 26, 479, 64, NULL, 2, '2018-06-04', '2018-06-04', 'laura.montan@ibnorca.org', 1, 0, '0');
INSERT INTO `personal` VALUES (195, 1581, NULL, '6832691', 480, NULL, '1994-03-07', 20, 829, 871, 0, 74, 1, 4243.6, 'Aruquipa', 'Choque', '', 'Iveth Tania', '', '32492327', 'Av. Entre Ríos, Zona Mariscal Santa Cruz', 1, 2, '0', 1, '', '63145042', 'taniaiveth2017@gmail.com', '0', '2020-01-02 07:30:53', 1, '2022-07-28 15:43:13', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2018-02-01', '2018-02-01', 'iveth.aruquipa@ibnorca.org ', 1, 0, '6163114010');
INSERT INTO `personal` VALUES (203, 0, NULL, '6692817', 483, NULL, '1991-01-17', 8, 5, 13, 0, 74, 1, 4, 'Campos', 'Poveda', '', 'Alejandra', '', '0', 'Av Pablo Sanchez 6318', 1, 2, '0', 3, '', '71810010', 'alegita268@gmail.com', '0', '2020-01-02 07:31:22', 1, '2022-07-19 15:39:30', 58, 2, 26, 1575, 26, 480, 62, NULL, 4, '2018-10-08', '2018-10-08', 'alejandra.campos@ibnorca.org', 1, 0, '0');
INSERT INTO `personal` VALUES (222, 1581, NULL, '7842974', 484, NULL, '1991-06-16', NULL, NULL, NULL, 0, 74, NULL, NULL, 'Flores', 'Chosco', NULL, 'Maribel', NULL, NULL, 'Zona Pampa de la Isla Barrio Urkupiña Calle 1', NULL, NULL, NULL, 2, '', '73167911', 'mfchosco1991@gmail.com', NULL, '2020-10-01 15:00:18', 1, '2020-10-01 15:00:18', 1, 1, 26, 1575, 26, 484, 65, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (226, NULL, NULL, 'CIVACIO', NULL, NULL, '0000-00-00', 0, 0, 0, 0, NULL, 0, 0, 'Duran', 'MartÃ­nez', '', 'Paola Andrea', '', '', NULL, 0, 0, '', 2, NULL, NULL, 'paola.duran@ibnorca.org', '', '2020-01-02 07:31:51', 1, '2021-07-25 17:22:48', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (227, 1581, NULL, '9253211', 480, NULL, '1994-02-09', 20, 829, 871, 0, 74, 1, 4232.27, 'Casas', 'Huanca', '', 'Ivonne Gloria', '', '0', 's/n', 2, 2, '0', 1, '', '63122448', 'ig.casas0294@gmail.com', '0', '2020-01-02 07:31:07', 1, '2022-07-28 15:48:56', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2019-02-01', '2019-02-01', 'ivonne.casas@ibnorca.org', 1, 0, '6751734016');
INSERT INTO `personal` VALUES (228, 1581, NULL, 'CIVACIO', 481, NULL, '1988-11-01', 0, 8, 502, 0, 74, 1, 3000, 'Peñaranda', 'Mariño', '', 'Carmen Andrea', '', '0', 'Av. 6 de Octubre N° 6113 entre Bolivar y Sucre', 1, 2, '0', 2, '5240414', '69584772', 'carmen.penaranda@ibnorca.org', '0', '2020-01-02 07:31:50', 1, '2020-09-16 12:01:34', 90, 1, 26, 1575, 26, 481, 66, NULL, 4, '2019-03-15', '2019-03-15', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (241, 1581, NULL, '8557876', 483, NULL, '1991-05-27', 27, 5, 502, 0, 73, 1, 2600, 'Mamani', 'Javier', '', 'Ariel Teo', '', '0', 'Lidio Ustares Nro 384', 1, 1, '0', 2, '', '8557876', 'ariel_teo_adm@hotmail.com', '0', '2020-01-02 07:31:55', 1, '2020-09-16 12:01:34', 1, 1, 26, 1575, 26, 483, 67, NULL, 2, '2019-05-02', '2019-05-02', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (264, NULL, '', '9626984', 0, '', '1979-07-09', 0, 0, 0, 0, 0, 0, 0, 'Espinoza', 'Torrez', '', 'Adriana Lenin', '', '', 'Av. Villalobos #1883 Zona Miraflores', 0, 0, '', 2, '', '76301362', 'adrianita_lenin_10@hotmail.com', '', '2020-01-02 07:31:47', 1, '2020-09-16 12:01:34', 1, 1, NULL, NULL, NULL, NULL, NULL, '', 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (274, 1581, NULL, '9613128', 484, NULL, '1994-07-22', 0, 10, 13, 0, 73, 1, 3500, 'Peña', 'Gómez', '', 'Jorge Custodio', '', '0', 'C/Cap. Rodriguez 163', 1, 2, '0', 2, '', '75386252', 'jorgecustodiopenagomez@gmail.com', '0', '2020-01-02 07:31:47', 1, '2020-09-16 12:01:34', 90, 1, 26, 1575, 26, 484, 65, NULL, 2, '2019-06-03', '2019-06-03', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (277, 1581, NULL, '6017633', 480, NULL, '1989-07-05', 17, 829, 826, 0, 73, 1, 5085.52, 'Gutierrez', 'Tambo', '', 'Luis Erwin', '', '0', 'Zona Cupilupaca Calle Rio Chapare N° 2064', 2, 2, '0', 1, '2852248', '78892941', 'legtforever@gmail.com', '0', '2020-01-02 07:31:04', 1, '2022-08-02 12:14:35', 58, 1, 26, 1575, 26, 480, 72, NULL, 4, '2019-05-02', '2019-05-02', 'luis.gutierrez@ibnorca.org ', 1, 0, '0');
INSERT INTO `personal` VALUES (286, 0, NULL, '3372876', 480, NULL, '1984-01-09', 10, 829, 871, 0, 74, 1, 6000, 'Diaz', 'Osuna', '', 'Fulvia', '', '0', 'JosÃ¯Â¿Â½ Montero 98', 1, 1, '0', 2, '2147483647', '72020888', 'fulviad@gmail.com', '0', '2020-01-02 07:30:54', 1, '2021-07-25 17:22:07', 1, 2, 0, 0, 26, 480, 62, NULL, 4, '2019-07-08', '2019-07-08', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (5414, 1581, NULL, '7737727', 484, NULL, '1988-09-24', 27, 10, 502, 0, 73, 1, 3, 'Alegre', 'Serrudo', '', 'Jorge Luis', '', '0', 'Urbanizacion jardin del sur', 1, 2, '0', 3, '59165037949', '59165037949', 'jorge.alegreserrudo@gmail.com', '0', '2020-09-30 11:14:20', 1, '2020-10-19 23:58:42', 90, 1, 26, 0, 26, 484, 65, NULL, 1, '2015-07-06', '2015-07-06', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (10089, 1581, NULL, '5767034', 481, NULL, '1989-06-09', NULL, NULL, NULL, 0, 73, NULL, NULL, 'Flores', 'Colque', NULL, 'EFRAIN', NULL, NULL, 'Villa 14 de Septiembre', NULL, NULL, NULL, 2, '73845754', '73845754', 'efrain_susi@hotmail.com', NULL, '2020-07-06 21:38:40', 1, '2021-07-29 09:24:53', 1, 1, 26, 1576, 26, 479, 64, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (11942, 1581, NULL, '8446055', 480, NULL, '1991-03-27', 34, 829, 4357, 0, 74, 1, 3500, 'Krings', 'Castelo', '', 'Katheryn', '', '0', 'Zona El Kenko', 1, 2, '0', 1, '', '77710020', 'kattykrings@hotmail.com', '0', '2022-04-08 13:25:37', 1, '2022-07-28 16:36:28', 58, 1, 26, 1575, 26, 480, 72, NULL, 4, '2022-04-04', '2022-04-04', 'katheryn.krings@ibnorca.org', 1, 0, '8245154012');
INSERT INTO `personal` VALUES (12778, 0, NULL, '7888056', 0, NULL, '1988-07-11', 31, 5, 40, 0, 0, 1, 3000, 'Mamani', 'Bonifaz', '', 'Dimelsa', '', '0', 'c/Federico de Medina Nº 2915', 2, 1, '0', 2, '2845213', '79637699', 'melsadibonifaz23@gmail.com', '0', '2020-01-02 07:31:16', 1, '2020-09-16 12:01:34', 1, 1, 0, 0, 26, 480, 62, NULL, 2, '2019-07-01', '2019-07-01', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (14312, 1581, NULL, '6195776', 480, NULL, '1988-05-18', 0, 829, 871, 0, 73, 1, 7, 'Nemer', 'Kattan', '', 'Juan Pablo', '', '0', 'Av. 6 de agosto N 255', 1, 2, '0', 3, '2441788', '62512229', 'jpnemerkattan@gmail.com', '0', '2021-09-29 17:25:44', 1, '2022-07-28 21:30:40', 58, 1, 0, 1575, 26, 480, NULL, NULL, 0, '2021-05-10', '2021-05-10', 'juan.nemer@ibnorca.org ', 1, 0, '0');
INSERT INTO `personal` VALUES (14793, 1581, NULL, '4867125', 480, NULL, '1988-08-26', 31, 5, 12, 0, 73, 1, 5150, 'Pacheco', 'Paredes', '', 'Rodrigo Andres', '', '0', 'La Paz', 2, 2, '0', 1, '0', '77284228', 'rodrigo.a.pachpar@gmail.com', '0', '2020-01-02 07:31:00', 1, '2022-07-28 22:14:58', 58, 1, 26, 0, 26, 480, 62, NULL, 4, '2019-10-14', '2019-10-14', 'rodrigo.pacheco@ibnorca.org ', 1, 0, '6538144019');
INSERT INTO `personal` VALUES (17171, 1581, NULL, '8874038', 484, NULL, '1994-05-04', 0, 10, 502, 0, 74, 1, 3350, 'Saavedra', 'Flores', '', 'Leydi', '', '0', 'Plan 3000 Av. Paurito B/ San Agustin C/4', 2, 2, '0', 2, '0', '75334312', 'leydicita42@gmail.com', '0', '2020-07-07 18:26:03', 1, '2020-09-16 12:01:34', 90, 1, 26, 1575, 26, 484, 65, NULL, 4, '2019-06-17', '2019-06-17', '00', 1, 0, '0');
INSERT INTO `personal` VALUES (18391, 1581, NULL, '6402181', 479, NULL, '1984-08-29', 17, 10, 826, 0, 73, 1, 4520.46, 'TERRAZAS', 'ORELLANA', '', 'RUBEN', '', '43868502', 'Av. Repuclica s/n', 1, 2, '0', 1, '', '70391920', 'rubeggg@gmail.com', '0', '2020-01-02 07:31:38', 1, '2022-08-02 12:45:54', 58, 1, 26, 1575, 26, 484, 48387, NULL, 4, '2017-08-14', '2017-08-14', 'ruben.terrazas@ibnorca.org', 1, 0, '5866944018');
INSERT INTO `personal` VALUES (19862, 1581, NULL, '3788956', 479, NULL, '1971-09-25', 27, 9, 273, 0, 74, 1, 3433.9, 'Villegas', 'Zurita', '', 'Evelyn Amanda', '', '25751414', 'Av.Chapare Km 4  Barrio Fabril ', 2, 2, '0', 1, '0', '72259830', 'ev266494@gmail.com', '0', '2020-09-16 14:17:23', 1, '2022-08-02 11:27:45', 58, 1, 26, 1575, 26, 479, 48446, NULL, 1, '2007-07-02', '2007-07-02', 'evelyn.villegas@ibnorca.org', 1, 0, '1313574012');
INSERT INTO `personal` VALUES (19947, 0, NULL, '5032898', 485, NULL, '1979-11-08', 31, 829, 12, 0, 74, 1, 4635, 'YAÑEZ', 'BALANZA', '', 'CLAUDIA IRENE', '', '0', 'Av. Javier del Granado N° 101, Lomas de Achumani', 2, 2, '0', 1, '0', '78798895', 'yanez_clau@hotmail.com', '0', '2021-10-19 15:42:47', 1, '2022-07-28 22:17:47', 58, 1, 26, 1576, 26, 480, 62, NULL, 0, '2021-05-10', '2021-05-10', 'claudia.yañez@ibnorca.org ', 1, 0, '0');
INSERT INTO `personal` VALUES (30030, 1581, NULL, '7999000', 479, NULL, '2019-07-28', 0, 0, 0, 0, 73, 0, 0, 'Barrionuevo', 'Chileno', '', 'Edgar', '', '', 'av. circunvalacion', 0, 0, '', 2, '5914306368', '59165725642', 'barrionuevomario936@gmail.com', '', '2020-01-02 07:31:35', 1, '2020-09-16 12:01:34', 1, 1, 26, 0, 26, 479, 64, NULL, 0, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (30072, 1581, NULL, '6959046', 480, NULL, '2019-03-07', 21, 5, 502, 0, 73, 1, 3000, 'Flores', 'Ramirez', '', 'José Manuel', '', '0', 'c/mayor lopera #429 z/ villafatima', 1, 1, '0', 2, '76721610', '70595763', 'vandoleropepito@gmail.com', '0', '2020-01-02 07:31:10', 1, '2020-09-16 12:01:34', 1, 1, 26, 0, 26, 480, 62, NULL, 2, '2019-08-10', '2019-08-10', NULL, 1, 0, NULL);
INSERT INTO `personal` VALUES (31386, 1581, NULL, '5313587', 479, NULL, '1989-09-23', 13, 9, 2978, 0, 74, 1, 7210, 'Teran', 'Castellon', '', 'Fabiola', '', '0', 'Edif. Torre San Francisco- Zona Tránsito', 2, 2, '0', 1, '', '59170723598', 'faby_teran_c@hotmail.com', '0', '2020-01-02 07:31:33', 1, '2022-08-02 10:54:42', 58, 1, 26, 1576, 26, 480, 62, NULL, 4, '2019-09-02', '2019-09-02', 'fabiola.teran@ibnorca.org ', 1, 0, '7135174011');
INSERT INTO `personal` VALUES (31751, 1581, NULL, '4094431', 478, NULL, '1995-03-18', 0, 5, 11, 0, 73, 1, 3000, 'Yuras', 'Calbimonte', '', 'Vinko Stijepan ', '', '0', 'Av. Banzer 7mo Anillo, Condominio Milenium Nro. 10', 2, 2, '0', 2, '', '79496181', 'extreda@hotmail.com', '0', '2020-01-02 07:31:48', 1, '2020-10-30 12:48:20', 90, 1, 26, 0, 26, 484, 65, NULL, 4, '2019-09-09', '2019-09-09', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (32173, 0, NULL, '10012140', 480, NULL, '1992-03-21', NULL, NULL, NULL, 0, 74, NULL, NULL, 'MITA', 'AIZA', NULL, 'INGRID', NULL, NULL, '-', NULL, NULL, NULL, 2, '0', '65597090', 'aiza.ingrid123@gmail.com', NULL, '2021-06-26 10:59:29', 1, '2021-06-26 10:59:29', 1, 1, 26, 1575, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (33070, 0, NULL, '92706992', 0, NULL, '1980-05-26', NULL, NULL, NULL, 0, 73, NULL, NULL, 'Norén', '', NULL, 'Jonas', NULL, NULL, 'Björnssonsgatan 141', NULL, NULL, NULL, 2, '0703572656', NULL, 'jonas.noren@norcon.se', NULL, '2020-10-30 12:48:20', 1, '2020-10-30 12:48:20', 1, 1, 0, 0, 211, 3416, 39186, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (33355, 1581, NULL, '4863668', 480, NULL, '1991-12-28', 4, 829, 2957, 0, 74, 1, 2575, 'Quisbert', 'Cabrera', '', 'Elena Andrea', '', '3158264012', 'Calle Casimiro Corrales 1078, Zona Miraflores', 2, 2, '0', 1, '2245035', '77564360', 'andreaqcabrera28@gmail.com', '0', '2021-10-19 15:42:46', 1, '2022-07-28 22:45:15', 58, 1, 26, 1575, 26, 480, 62, NULL, 0, '2021-08-02', '2021-08-02', 'elena.quisbert@ibnorca.org ', 1, 0, '4996354020');
INSERT INTO `personal` VALUES (34149, 1581, NULL, '3464298', 480, NULL, '1973-11-27', 27, 829, 273, 0, 74, 1, 4232.28, 'Ichuta', 'Triguero', '', 'Maria Elizabeth', '', '27097560', 'Calle C # 10 z. Amp. Alto ciudadela ', 1, 2, '0', 1, '2301875', '71914529', 'maria.ichutatemporal@ibnorca.org', '0', '2020-01-06 18:32:40', 1, '2022-07-28 17:04:45', 58, 1, 26, 1578, 26, 480, 62, NULL, 1, '1997-08-01', '1997-08-01', 'maria.ichuta@ibnorca.org', 1, 0, '569704014');
INSERT INTO `personal` VALUES (38166, 1581, NULL, '8333170', 480, NULL, '1991-04-15', 15, 10, 2978, 0, 74, 1, 2500, 'Estevez', 'Valverde', '', 'Isabel', '', '0', 'Av, San Martin, calle Hugo Wast oeste, 16.', 1, 2, '0', 1, '-', '63253645', 'isabest.val@gmail.com', '0', '2022-04-06 10:44:32', 1, '2022-08-08 15:14:38', 58, 1, 0, 0, 26, 484, NULL, NULL, 0, '2022-04-04', '2022-04-04', 'isabel.estevez@ibnorca.org', 1, 0, '8226824015');
INSERT INTO `personal` VALUES (41467, 1581, NULL, '6137694', 480, NULL, '1989-10-30', 31, 829, 12, 0, 74, 1, 5150, 'Gutierrez', 'Alcaraz', '', 'Mayra Daniela', '', '47171580', 'Achumani Urb. Huacollo Calle 8 Nº135', 2, 2, '0', 1, '', '59170590795', 'mayra.d.g.a@gmail.com', '0', '2021-09-29 17:25:44', 1, '2022-07-28 22:08:36', 58, 1, 26, 1576, 26, 480, 62, NULL, 0, '2021-04-01', '2021-04-01', 'mayra.gutierrez@ibnorca.org ', 1, 0, '0');
INSERT INTO `personal` VALUES (42820, 1581, NULL, '6326757', 484, NULL, '1988-07-07', NULL, NULL, NULL, 0, 74, NULL, NULL, 'Romero', 'Ayala', NULL, 'Claudia Victoria', NULL, NULL, 'Av. La Barranca 3er anillo Externo', NULL, NULL, NULL, 2, '', '75380038', 'claudiavictoriaromeroayala@gmail.com', NULL, '2021-06-26 10:59:29', 1, '2021-06-26 10:59:29', 1, 1, 26, 1576, 26, 484, 65, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (43686, 1581, NULL, '7010535', 480, NULL, '1976-11-13', 27, 829, 273, 0, 73, 1, 2678, 'Mamani', 'Coaquira', '', 'Jorge Javier', '', '0', 'Av. Tiahunacu #35', 1, 2, '0', 1, '', '77560892', 'jorge.mamani@ibnorca.org', '0', '2020-09-30 11:14:20', 1, '2022-07-28 23:01:53', 58, 1, 26, 1576, 26, 480, 72, NULL, 1, '2019-05-02', '2019-05-02', 'javier.mamani@ibnorca.org ', 1, 0, '923854019');
INSERT INTO `personal` VALUES (44953, 1581, NULL, '4961095', 480, NULL, '1978-06-30', 17, 829, 826, 0, 73, 1, 5665, 'CONDE', 'MERLO', '', 'JUAN JOSE ', '', '0', 'AV. JORGE CARRASCO # 58 Z.12 DE OCTUBRE', 1, 2, '0', 1, '', '72568220', 'juanjo.ose00@gmail.com', '0', '2021-06-26 10:59:29', 1, '2022-07-28 21:44:14', 58, 1, 26, 1575, 26, 480, 72, NULL, 4, '2021-06-14', '2021-06-14', 'jose.duran@ibnorca.org', 1, 0, '5684244011');
INSERT INTO `personal` VALUES (45902, 1581, NULL, '4868422', 480, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 'LUNA', 'GONZALES', NULL, 'MARCO ANTONIO ', NULL, NULL, 'Calle Alvarez Plata Nro. 32 Edificio Sin Nombre Piso 2 Depto. S/N', NULL, NULL, NULL, 2, '60503103', NULL, 'lunagonzalesmarco@gmail.com', NULL, '2022-03-03 11:03:09', 1, '2022-03-03 11:03:09', 1, 1, 26, 0, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (47770, 0, NULL, 'IBN0001', 480, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 'Externa', '', NULL, 'Consulta', NULL, NULL, 'Obrajes', NULL, NULL, NULL, 2, '', '', 'consultafinanzas@personal.com', NULL, '2021-02-23 16:37:11', 1, '2021-06-26 10:59:29', 1, 1, 26, 0, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (49337, 1581, NULL, '3422118', 480, NULL, '1983-10-31', 17, 829, 826, 0, 73, 1, 5665, 'Navia', 'Morant', '', 'Hernan Rene', '', '39094421', 'Armando Chirveches Nª 2079 Zona Sopocachi', 1, 2, '0', 1, '', '78777816', 'hernanrnaviam@gmail.com', '0', '2021-09-29 17:25:44', 1, '2022-07-28 21:42:28', 58, 1, 26, 1575, 26, 480, NULL, NULL, 0, '2021-06-08', '2021-06-08', 'hernan.navia@ibnorca.org', 1, 0, '2098174021');
INSERT INTO `personal` VALUES (51088, 1581, NULL, '4767218', 480, NULL, '1980-01-01', 14, 829, 2978, 0, 73, 1, 6180, 'VILLANUEVA', 'CAMPOS', '', 'MARCO ANTONIO', '', '39538850', 'Irpavi 2  Calle Jazmines, esquina Gorrión Edificio Gonzales Depto 103', 1, 2, '0', 1, '', '79524504', 'labodegavisual@gmail.com', '0', '2021-07-14 01:40:16', 1, '2022-07-28 21:58:50', 58, 1, 26, 1575, 26, 480, 62, NULL, 4, '2021-06-28', '2021-06-28', 'marco.villanueva@ibnorca.org', 1, 0, '0');
INSERT INTO `personal` VALUES (52253, 1581, NULL, '7487210', 478, NULL, '1991-10-31', 14, 829, 2978, 0, 73, 1, 3, 'VEIZAGA', 'ESCOBAR', '', 'JOSE MANUEL', '', '0', 'Av. Emilio Mendizabal 174', 2, 2, '0', 3, '64-23245', '59175790670', 'josenolisco1@gmail.com', '0', '2021-07-29 12:59:20', 1, '2022-07-28 22:58:13', 58, 1, 26, 1575, 26, 478, 69, NULL, 1, '2021-07-26', '2021-07-26', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (53050, 1581, NULL, '4841733', 480, NULL, '1992-11-07', 31, 829, 12, 0, 73, 1, 3605, 'Pardo', 'Velasco', '', 'Herlan Ariel', '', '47521739', 'calle vincentti#661 zona Sopocachi', 1, 2, '0', 1, '', '59167170885', 'arielhys73@gmail.com', '0', '2021-11-14 17:03:58', 1, '2022-07-28 22:20:13', 58, 1, 26, 1575, 26, 480, 0, NULL, 0, '2021-09-06', '2021-09-06', 'herlan.pardo@ibnorca.org ', 1, 0, '4318454014');
INSERT INTO `personal` VALUES (53175, 1581, NULL, '5686184', 478, NULL, '1994-11-05', NULL, NULL, NULL, 0, 73, NULL, NULL, 'Gómez', 'Andrade', NULL, 'Rodrigo', NULL, NULL, 'Ladislao Cabrera esquina Jaime Mendoza', NULL, NULL, NULL, 2, '', '59177123674', 'rodriigomezandrade@gmail.com', NULL, '2021-09-29 17:25:44', 1, '2021-09-29 17:25:44', 1, 1, 26, 1575, 26, 478, NULL, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (57982, 1581, NULL, '6943919', 480, NULL, '1990-12-08', NULL, NULL, NULL, 0, 73, NULL, NULL, 'Rodriguez', 'Alvarez', NULL, 'Jose Tiago', NULL, NULL, 'San Antonio Bajo Calle 9 N°555', NULL, NULL, NULL, 2, '2230936', '72563620', 'tiago.jra1303@gmail.com', NULL, '2022-04-06 10:44:31', 1, '2022-04-06 10:44:31', 1, 1, 26, 1575, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);
INSERT INTO `personal` VALUES (58493, 1581, NULL, '6961965', 480, NULL, '1997-08-17', 2, 829, 2957, 0, 74, 1, 4000, 'Sainz', 'Quiroga', '', 'Soraya Camila', '', '48506576', 'Achumani Calle 32 #55', 1, 2, '0', 1, '', '65604604', 'sainzsoraya@gmail.com', '0', '2022-04-06 10:44:31', 1, '2022-07-28 22:47:49', 58, 1, 26, 0, 26, 480, 62, NULL, 1, '2022-04-04', '2022-04-04', 'soraya.sainz@ibnorca.org', 1, 0, '3601674016');
INSERT INTO `personal` VALUES (58969, 1581, NULL, '2371102', 480, NULL, '2022-05-30', 14, 829, 2978, 0, 73, 1, 0, 'Montaño', 'Ortiz', '', 'Sandra Jimena', '', '0', 'Av Illimani N. 1908A', 1, 2, '0', 2, '', '72095591', 'sandrisortiz2018@gmail.com', '0', '2022-06-13 14:24:25', 1, '2022-07-28 21:28:35', 58, 1, 0, 0, 26, 480, NULL, NULL, 1, '2020-01-01', '2020-01-01', '0', 1, 0, '0');
INSERT INTO `personal` VALUES (59556, 1581, NULL, '8321377', 480, NULL, '1998-07-24', NULL, 829, NULL, 0, 74, NULL, NULL, 'Pinto', 'Quispe', NULL, 'Dailyn Belen', NULL, NULL, 'Bajo Llojeta Calle Los Nardos #77', NULL, NULL, NULL, 2, '', '61118740', 'dailynpinto77@gmail.com', NULL, '2022-06-13 14:24:25', 1, '2022-06-13 14:25:27', 1, 1, 26, 1575, 26, 480, 62, NULL, NULL, '0000-00-00', '0000-00-00', NULL, 0, 0, NULL);

-- ----------------------------
-- Table structure for personal2
-- ----------------------------
DROP TABLE IF EXISTS `personal2`;
CREATE TABLE `personal2`  (
  `codigo` int NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_area` int NULL DEFAULT NULL,
  `cod_unidad` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal2
-- ----------------------------
INSERT INTO `personal2` VALUES (1, 'ADM', 15, 1);
INSERT INTO `personal2` VALUES (5, 'WILLY MIRANDA', 826, 829);
INSERT INTO `personal2` VALUES (6, 'ADMT', 15, 1);
INSERT INTO `personal2` VALUES (7, 'ANNELIESSE PRUDENCIO', 13, 4);
INSERT INTO `personal2` VALUES (8, 'PEDRO CARDOZO', 13, 1624);
INSERT INTO `personal2` VALUES (9, 'GONZALO ROMERO', 826, 829);
INSERT INTO `personal2` VALUES (10, 'CONSULTA NORMAS', 137, 1);
INSERT INTO `personal2` VALUES (12, 'RODRIGO VELASCO', 873, 5);
INSERT INTO `personal2` VALUES (13, 'RENE CASTRO', 39, 1624);
INSERT INTO `personal2` VALUES (14, 'VALERIA ESPINOZA', 12, 5);
INSERT INTO `personal2` VALUES (15, 'CRISTINA MEJIA', 826, 1625);
INSERT INTO `personal2` VALUES (16, 'ROXANA LLANO', 12, 829);
INSERT INTO `personal2` VALUES (17, 'YSNAIDER CASTRO', 11, 4);
INSERT INTO `personal2` VALUES (20, 'EFRAIN MARISCAL', 13, 10);
INSERT INTO `personal2` VALUES (21, 'JANETH CAYO', 13, 271);
INSERT INTO `personal2` VALUES (22, 'CARLOS TEJERINA', 11, 10);
INSERT INTO `personal2` VALUES (23, 'JUSTO ORELLANA', 11, 10);
INSERT INTO `personal2` VALUES (26, 'GRACIELA CHAVEZ', 11, 10);
INSERT INTO `personal2` VALUES (27, 'JOSUE ANTONIO BARROSO CORDOVA', 11, 271);
INSERT INTO `personal2` VALUES (28, 'CARLOS ALARCON', 13, 5);
INSERT INTO `personal2` VALUES (29, 'CARLOS SERRUDO', 13, 1624);
INSERT INTO `personal2` VALUES (30, 'VICTOR AMURRIO', 13, 2);
INSERT INTO `personal2` VALUES (31, 'CARMEN BELTRAN', 78, 1625);
INSERT INTO `personal2` VALUES (32, 'JULIO PALOMO', 78, 2);
INSERT INTO `personal2` VALUES (33, 'MIRIAM LINARES', 78, 1625);
INSERT INTO `personal2` VALUES (34, 'BENJAMIN TORRICO', 11, 1625);
INSERT INTO `personal2` VALUES (35, 'JORGE MEJIA NAVIA', 11, 1625);
INSERT INTO `personal2` VALUES (36, 'DANIEL GUERRERO', 11, 9);
INSERT INTO `personal2` VALUES (37, 'GABRIELA VALDEZ', 13, 4);
INSERT INTO `personal2` VALUES (38, 'MARIANA VILLAFANE', 13, 1625);
INSERT INTO `personal2` VALUES (39, 'DIEGO ANTEZANA', 13, 3);
INSERT INTO `personal2` VALUES (40, 'ALEJANDRO RENDON', 11, 1624);
INSERT INTO `personal2` VALUES (41, 'KATIA CASTELLON', 874, 9);
INSERT INTO `personal2` VALUES (42, 'ROXANA RAMIREZ', 874, 9);
INSERT INTO `personal2` VALUES (43, 'RAMIRO GOMEZ', 11, 1625);
INSERT INTO `personal2` VALUES (44, 'ANA BUENO', 273, 270);
INSERT INTO `personal2` VALUES (45, 'ANA BUENO', 13, 270);
INSERT INTO `personal2` VALUES (46, 'RAMIRO GOMEZ', 13, 1625);
INSERT INTO `personal2` VALUES (47, 'CARLA LINARES', 39, 4);
INSERT INTO `personal2` VALUES (48, 'SILVIA CUEVAS', 38, 4);
INSERT INTO `personal2` VALUES (49, 'MARIA SERRANO', 874, 10);
INSERT INTO `personal2` VALUES (50, 'YESSICA SEGOVIA', 874, 10);
INSERT INTO `personal2` VALUES (51, 'MIGUEL BALLON', 11, 1624);
INSERT INTO `personal2` VALUES (53, 'ERIKA RODRIGUEZ', 78, 4);
INSERT INTO `personal2` VALUES (54, 'GABRIELA MUNOZ A', 38, 4);
INSERT INTO `personal2` VALUES (58, 'JANIS SOLARES', 874, 1624);
INSERT INTO `personal2` VALUES (59, 'JOSE LUIS ARROYO', 38, 8);
INSERT INTO `personal2` VALUES (60, 'JOSE LUIS ARROYO', 39, 1624);
INSERT INTO `personal2` VALUES (62, 'TERESA CUBA', 11, 5);
INSERT INTO `personal2` VALUES (63, 'MIRIAM LINARES', 39, 1625);
INSERT INTO `personal2` VALUES (64, 'MIRIAM LINARES', 38, 1625);
INSERT INTO `personal2` VALUES (65, 'JANIS SOLARES', 13, 1624);
INSERT INTO `personal2` VALUES (68, 'FABRICIO NORIEGA', 872, 829);
INSERT INTO `personal2` VALUES (69, 'DANNY DAVILA', 40, 5);
INSERT INTO `personal2` VALUES (70, 'KATHERIN OROPEZA', 40, 5);
INSERT INTO `personal2` VALUES (71, 'ANNELIESE PAUKNER', 872, 829);
INSERT INTO `personal2` VALUES (72, 'JOSE LARREA', 874, 5);
INSERT INTO `personal2` VALUES (73, 'GABRIELA TUDELA', 14, 1);
INSERT INTO `personal2` VALUES (74, 'MIRKO JEAN PEREDO RIVAS', 38, 9);
INSERT INTO `personal2` VALUES (75, 'MIRKO JEAN PEREDO RIVAS', 39, 9);
INSERT INTO `personal2` VALUES (77, 'LEONARDO BURGOS MENDOZA', 13, 10);
INSERT INTO `personal2` VALUES (78, 'ALEJANDRA TORRELIO (TCS)', 38, 1624);
INSERT INTO `personal2` VALUES (80, 'JANETH CAYO', 874, 271);
INSERT INTO `personal2` VALUES (81, 'ANDREA SANDI', 78, 1624);
INSERT INTO `personal2` VALUES (82, 'RAMIRO GOMEZ', 38, 1625);
INSERT INTO `personal2` VALUES (83, 'RAMIRO GOMEZ', 39, 1625);
INSERT INTO `personal2` VALUES (84, 'JOSE DURAN', 137, 1);
INSERT INTO `personal2` VALUES (85, 'INVITADO', 13, 5);
INSERT INTO `personal2` VALUES (86, 'RENE CASTRO', 38, 5);
INSERT INTO `personal2` VALUES (87, 'HELEN HINOJOSA CUSICANQUI', 13, 1625);
INSERT INTO `personal2` VALUES (89, 'JULIO MAMANI', 273, 829);
INSERT INTO `personal2` VALUES (90, 'JUAN QUENALLATA', 273, 829);
INSERT INTO `personal2` VALUES (91, 'SANDRA SIERRA', 847, 829);
INSERT INTO `personal2` VALUES (92, 'CARLA ALDUNATE', 1200, 1624);
INSERT INTO `personal2` VALUES (93, 'MARIA RENEE GALLARDO', 871, 829);
INSERT INTO `personal2` VALUES (94, 'JOSE LUIS ARROYO', 11, 8);
INSERT INTO `personal2` VALUES (96, 'GLICET OSCO', 872, 829);
INSERT INTO `personal2` VALUES (97, 'CARLA NOELIA COCHI TARQUI', 13, 5);
INSERT INTO `personal2` VALUES (98, 'ALEJANDRA TORRELIO (TCP)', 39, 1624);
INSERT INTO `personal2` VALUES (99, 'MARTHA MENDEZ LECLERE', 13, 1);
INSERT INTO `personal2` VALUES (101, 'VERONICA LLANQUIPACHA ROJAS', 874, 1625);
INSERT INTO `personal2` VALUES (114, 'JANET VILLARROEL', 12, 10);
INSERT INTO `personal2` VALUES (118, 'MARIELA ALMANZA AGUIRRE', 12, 9);
INSERT INTO `personal2` VALUES (126, 'SERGIO MALDONADO', 871, 829);
INSERT INTO `personal2` VALUES (127, 'SILVIA CUEVAS', 39, 4);
INSERT INTO `personal2` VALUES (141, 'IVAN PADILLA AVALOS', 11, 10);
INSERT INTO `personal2` VALUES (142, 'RODRIGO JAIMES PORTUGAL', 13, 5);
INSERT INTO `personal2` VALUES (143, 'CTN 329', 137, 1);
INSERT INTO `personal2` VALUES (156, 'OPERADOR VIRTUAL RLP', 13, 1103);
INSERT INTO `personal2` VALUES (157, 'OPERADOR VIRTUAL RSC', 13, 1103);
INSERT INTO `personal2` VALUES (158, 'OPERADOR VIRTUAL RCB', 13, 1103);
INSERT INTO `personal2` VALUES (168, 'ROCIO MALLEA ORTIZ', 874, 5);
INSERT INTO `personal2` VALUES (172, 'VALIDARLP', 13, 1103);
INSERT INTO `personal2` VALUES (173, 'JOSE ARMANDO ZAPATA AVILES', 11, 5);
INSERT INTO `personal2` VALUES (176, 'OSCAR VARGAS', 872, 829);
INSERT INTO `personal2` VALUES (177, 'CINTYA ZARATE CAZAS', 38, 1624);
INSERT INTO `personal2` VALUES (178, 'OSCAR VARGAS', 1235, 829);
INSERT INTO `personal2` VALUES (181, 'ELIZABETH SEJAS GALLARDO', 11, 9);
INSERT INTO `personal2` VALUES (182, 'EDVING GUSTAVO VELASQUEZ CAMARGO', 11, 5);
INSERT INTO `personal2` VALUES (183, 'LUIS FERNANDO ROJAS URQUIZO', 871, 5);
INSERT INTO `personal2` VALUES (185, 'NAIR PAMELA SANTA CRUZ QUISBERT', 13, 5);
INSERT INTO `personal2` VALUES (187, 'LAURA MONTAN ARCE', 13, 9);
INSERT INTO `personal2` VALUES (195, 'IVETH ARUQUIPA', 273, 829);
INSERT INTO `personal2` VALUES (203, 'ALEJANDRA CAMPOS', 13, 5);
INSERT INTO `personal2` VALUES (206, 'MAURICIO GONZALO CATACORA ROMERO', 12, 829);
INSERT INTO `personal2` VALUES (207, 'NORMATECARLP', 137, 5);
INSERT INTO `personal2` VALUES (208, 'NORMATECAROR', 137, 8);
INSERT INTO `personal2` VALUES (209, 'NORMATECARPT', 137, 272);
INSERT INTO `personal2` VALUES (210, 'NORMATECARCB', 137, 9);
INSERT INTO `personal2` VALUES (211, 'NORMATECARSC', 137, 10);
INSERT INTO `personal2` VALUES (212, 'NORMATECARCH', 137, 270);
INSERT INTO `personal2` VALUES (213, 'NORMATECARTJ', 137, 271);
INSERT INTO `personal2` VALUES (221, 'FRANCO GABIN MICHEL LUZARAZU', 13, 9);
INSERT INTO `personal2` VALUES (222, 'MARIBEL FLORES', 13, 10);
INSERT INTO `personal2` VALUES (224, 'ALEJANDRO RENDON (TCS)', 38, 1624);
INSERT INTO `personal2` VALUES (225, 'ALEJANDRO RENDON(P)', 39, 1624);
INSERT INTO `personal2` VALUES (226, 'PAOLA ANDREA DURAN MARTINEZ', 13, 8);
INSERT INTO `personal2` VALUES (227, 'IVONNE CASAS', 273, 829);
INSERT INTO `personal2` VALUES (228, 'CARMEN ANDREA PENARANDA MARINO', 874, 8);
INSERT INTO `personal2` VALUES (241, 'ARIEL TEO MAMANI JAVIER', 13, 272);
INSERT INTO `personal2` VALUES (243, 'ARIEL TEO MAMANI JAVIER', 11, 272);
INSERT INTO `personal2` VALUES (244, 'CINTYA ZARATE CAZAS', 39, 1624);
INSERT INTO `personal2` VALUES (251, 'ADRIAN CADIMA', 12, 829);
INSERT INTO `personal2` VALUES (252, 'CARLA LINARES', 11, 4);
INSERT INTO `personal2` VALUES (257, 'DANNY DAVILA', 78, 1624);
INSERT INTO `personal2` VALUES (264, 'ADRIANA LENIN ESPINOZA TORREZ', 13, 10);
INSERT INTO `personal2` VALUES (273, 'CECILIA ALEJANDRA JIMENEZ CUBA', 12, 829);
INSERT INTO `personal2` VALUES (274, 'JORGE CUSTODIO PENA GOMEZ', 13, 10);

-- ----------------------------
-- Table structure for personal_datosadicionales
-- ----------------------------
DROP TABLE IF EXISTS `personal_datosadicionales`;
CREATE TABLE `personal_datosadicionales`  (
  `cod_personal` int NOT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `perfil` int NULL DEFAULT NULL,
  `usuario` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `contrasena` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_cargo` int NULL DEFAULT NULL,
  `usuario_pon` int NULL DEFAULT 0 COMMENT '0 si no es pon y 1 si es usuario pon',
  PRIMARY KEY (`cod_personal`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_datosadicionales
-- ----------------------------
INSERT INTO `personal_datosadicionales` VALUES (1, 1, 4, 'projectsis', '123', NULL, 0);
INSERT INTO `personal_datosadicionales` VALUES (5, 1, 2, 'wmiranda', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (14, 1, 2, 'vespinoza', '123', 5, 1);
INSERT INTO `personal_datosadicionales` VALUES (16, 1, 2, 'rllano', '123', 5, 2);
INSERT INTO `personal_datosadicionales` VALUES (17, 1, 3, 'ycastro', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (31, 1, 6, 'cbeltran', '123', 24, 0);
INSERT INTO `personal_datosadicionales` VALUES (32, 1, 2, 'jpalomo', 'jpalomo', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (34, 1, 3, 'btorrico', '123', 6, 0);
INSERT INTO `personal_datosadicionales` VALUES (37, 1, 3, 'gvaldez', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (38, 1, 3, 'mvillafane', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (40, 1, 3, 'arendon', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (41, 1, 1, 'kcastellon', 'conta', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (48, 1, 3, 'scuevas', '123', 15, 0);
INSERT INTO `personal_datosadicionales` VALUES (50, 1, 1, 'ysegovia', 'conta', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (53, 1, 3, 'erodriguez', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (58, 1, 1, 'jsolares', 'conta', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (63, 1, 3, 'mlinares', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (68, 1, 1, 'fnoriega', 'fnoriega', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (71, 1, 2, 'apaukner', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (72, 1, 1, 'jlarrea', 'conta', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (78, 1, 1, 'atorrelio', 'atorrelio', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (81, 1, 2, 'asandi', '123', NULL, 0);
INSERT INTO `personal_datosadicionales` VALUES (89, 1, 1, 'jmamani', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (90, 1, 1, 'jquenallata', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (92, 1, 3, 'caldunate', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (93, 1, 2, 'mgallardo', '123', NULL, 0);
INSERT INTO `personal_datosadicionales` VALUES (96, 1, 1, 'gosco', 'gosco', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (99, 1, 2, 'mmendez', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (114, 1, 3, 'jvillarroel', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (118, 1, 3, 'malmanza', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (177, 1, 1, 'czarate', 'czarate', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (178, 1, 2, 'ovargas', '123', 5, 1);
INSERT INTO `personal_datosadicionales` VALUES (183, 1, 1, 'lrojas', '123', 5, 2);
INSERT INTO `personal_datosadicionales` VALUES (195, 1, 1, 'iaruquipa', '123', 5, 0);
INSERT INTO `personal_datosadicionales` VALUES (227, 1, 1, 'icasas', '123', 5, 0);

-- ----------------------------
-- Table structure for personalimagen
-- ----------------------------
DROP TABLE IF EXISTS `personalimagen`;
CREATE TABLE `personalimagen`  (
  `codigo` int NOT NULL,
  `imagen` mediumtext CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of personalimagen
-- ----------------------------
INSERT INTO `personalimagen` VALUES (5, '23. Willy Miranda.jpg');
INSERT INTO `personalimagen` VALUES (7, '29. Anneliese Prudencio.jpg');
INSERT INTO `personalimagen` VALUES (8, '31. Pedro Cardozo.jpg');
INSERT INTO `personalimagen` VALUES (13, '45. Rene Castro.jpg');
INSERT INTO `personalimagen` VALUES (15, '28. Cristina Mejia.jpg');
INSERT INTO `personalimagen` VALUES (17, '53. Ysnaider Castro.jpg');
INSERT INTO `personalimagen` VALUES (18, '63. Delcy Nogales.jpg');
INSERT INTO `personalimagen` VALUES (22, '51. Carlos Tejerina.jpg');
INSERT INTO `personalimagen` VALUES (23, '52. Justo Orellana.jpg');
INSERT INTO `personalimagen` VALUES (26, '19. Graciela Chavez.jpg');
INSERT INTO `personalimagen` VALUES (27, '59. Josue Barroso.jpg');
INSERT INTO `personalimagen` VALUES (29, '66. Carlos Serrudo.jpg');
INSERT INTO `personalimagen` VALUES (32, '42. Julio Palomo.jpg');
INSERT INTO `personalimagen` VALUES (35, '58. Jorge Mejia.jpg');
INSERT INTO `personalimagen` VALUES (36, '5. Daniel Guerrero.jpg');
INSERT INTO `personalimagen` VALUES (37, '32. Gabriela Valdez.jpg');
INSERT INTO `personalimagen` VALUES (40, '6. Alejandro rendon.jpg');
INSERT INTO `personalimagen` VALUES (41, '20. Katia Castellon.jpg');
INSERT INTO `personalimagen` VALUES (42, '12. Roxana Ramirez.jpg');
INSERT INTO `personalimagen` VALUES (43, '56. Ramiro Gomez.jpg');
INSERT INTO `personalimagen` VALUES (47, '8. Carla Linares.jpg');
INSERT INTO `personalimagen` VALUES (48, '49. Silvia Cuevas.jpg');
INSERT INTO `personalimagen` VALUES (49, '65. María Serrano.jpg');
INSERT INTO `personalimagen` VALUES (50, '18. Yessica Segovia.jpg');
INSERT INTO `personalimagen` VALUES (51, '57. Miguel Ballon.jpg');
INSERT INTO `personalimagen` VALUES (53, '62. Erika Rodriguez.jpg');
INSERT INTO `personalimagen` VALUES (54, '48. Gabriela Muñoz.jpg');
INSERT INTO `personalimagen` VALUES (58, '11. Janis Solares.jpg');
INSERT INTO `personalimagen` VALUES (62, '16. Teresa Cuba.jpg');
INSERT INTO `personalimagen` VALUES (68, '60. Fabricio Noriega.jpg');
INSERT INTO `personalimagen` VALUES (70, '61. Katherine Oropeza.jpg');
INSERT INTO `personalimagen` VALUES (72, 'JOSE LARREA.JPG');
INSERT INTO `personalimagen` VALUES (78, '38. Alejandra Torrelio.jpg');
INSERT INTO `personalimagen` VALUES (84, 'WhatsApp Image 2022-06-10 at 12.24.32 PM.jpeg');
INSERT INTO `personalimagen` VALUES (89, '10. Julio Mamani.jpg');
INSERT INTO `personalimagen` VALUES (90, '9. Juan Quenallata.jpg');
INSERT INTO `personalimagen` VALUES (92, 'IMG-20180909-WA0000.jpg');
INSERT INTO `personalimagen` VALUES (93, '1. maria renèe gallardo.jpg');
INSERT INTO `personalimagen` VALUES (96, '44. Glicet Osco.jpg');
INSERT INTO `personalimagen` VALUES (97, '33. Carla Cochi.jpg');
INSERT INTO `personalimagen` VALUES (101, '34. Veronica Llanquipacha.jpg');
INSERT INTO `personalimagen` VALUES (141, '50. Ivan Padilla.jpg');
INSERT INTO `personalimagen` VALUES (168, '13. Rocio Mallea.jpg');
INSERT INTO `personalimagen` VALUES (173, '54. José Zapata.jpg');
INSERT INTO `personalimagen` VALUES (176, '36. Oscar Vargas.jpg');
INSERT INTO `personalimagen` VALUES (177, '43. Cintya Zarate.jpg');
INSERT INTO `personalimagen` VALUES (181, '21. Elizabeth Sejas.jpg');
INSERT INTO `personalimagen` VALUES (182, '55. Edving Velasquez.jpg');
INSERT INTO `personalimagen` VALUES (183, '64. Luis Rojas.jpg');
INSERT INTO `personalimagen` VALUES (195, '2. Iveth Aruquipa.jpg');
INSERT INTO `personalimagen` VALUES (227, '3. Ivonne casas.jpg');
INSERT INTO `personalimagen` VALUES (277, '24. Luis Gutierrez.jpg');
INSERT INTO `personalimagen` VALUES (11942, '7. Katheryn Krings.jpg');
INSERT INTO `personalimagen` VALUES (14793, '39. Rodrigo Pacheco.jpg');
INSERT INTO `personalimagen` VALUES (18391, '27. Rúben Terrazas.jpg');
INSERT INTO `personalimagen` VALUES (19862, '22. Evelyn Villegas.jpg');
INSERT INTO `personalimagen` VALUES (19947, '40. Claudia Yañez.jpg');
INSERT INTO `personalimagen` VALUES (31386, '4. Fabiola Teran.jpg');
INSERT INTO `personalimagen` VALUES (33355, '46.Elena Quisbert.jpg');
INSERT INTO `personalimagen` VALUES (34149, '15. María Ichuta.jpg');
INSERT INTO `personalimagen` VALUES (38166, '35. Isable Estevez.jpg');
INSERT INTO `personalimagen` VALUES (41467, '37. Mayra Gutierrez.jpg');
INSERT INTO `personalimagen` VALUES (43686, '17.  Javier Mamani.jpg');
INSERT INTO `personalimagen` VALUES (44953, '26. Juan Conde.jpg');
INSERT INTO `personalimagen` VALUES (49337, '25. Hernan Navia.jpg');
INSERT INTO `personalimagen` VALUES (51088, '30. Marco Villanueva.jpg');
INSERT INTO `personalimagen` VALUES (53050, '41. Herlan Pardo.jpg');
INSERT INTO `personalimagen` VALUES (58493, '47. Soraya Sainz.jpg');

-- ----------------------------
-- Table structure for plan_cuentas
-- ----------------------------
DROP TABLE IF EXISTS `plan_cuentas`;
CREATE TABLE `plan_cuentas`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_padre` int NULL DEFAULT NULL,
  `cod_moneda` int NULL DEFAULT NULL,
  `cod_estadoreferencial` int NULL DEFAULT NULL,
  `cod_tipocuenta` int NULL DEFAULT NULL COMMENT 'cuenta de balance o de resultados',
  `nivel` int NULL DEFAULT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cuenta_auxiliar` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 464 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plan_cuentas
-- ----------------------------
INSERT INTO `plan_cuentas` VALUES (1, '1000000000', 'ACTIVo', 0, 1, 1, 1, 1, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (2, '2000000000', 'PASIVO', 0, 1, 1, 1, 1, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (3, '3000000000', 'PATRIMONIO', 0, 1, 1, 1, 1, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (4, '4000000000', 'INGRESOS', 0, 1, 1, 3, 1, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (5, '5000000000', 'EGRESOS', 0, 1, 1, 3, 1, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (6, '1010000000', 'ACTIVO CORRIENTE', 1, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (7, '1010100000', 'DISPONIBLE', 6, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (8, '1010101000', 'CAJA', 7, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (9, '1010101001', 'Caja General', 8, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (10, '1010102000', 'CAJA CHICA', 7, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (11, '1010102001', 'Caja Chica La Paz', 10, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (12, '1010102002', 'Caja Chica Santa Cruz', 10, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (13, '1010102003', 'Caja Chica Cochabamba', 10, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (14, '1010102004', 'Caja Chica Sucre', 10, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (15, '1010102005', 'Caja Chica Tarija', 10, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (16, '1010102006', 'Caja Chica Oruro', 10, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (17, '1010103000', 'BANCOS', 7, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (18, '1010103011', 'Banco BISA Cta. Cte. 0131670010 M/N', 17, 1, 1, 1, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (19, '1010103012', 'Banco BISA Cta. Cte. 0131672012 M/E', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (20, '1010103013', 'Banco Unión Cta. Cte. 10000001578993 M/N', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (21, '1010103014', 'Banco Mercantil Santa Cruz Cta. Cte. 4010417532 M/N', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (22, '1010103024', 'Banco BISA Caja Ahorro 0131674015 M/N RLP', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (23, '1010103025', 'Banco BISA Caja Ahorro 0131674023 M/N RCB', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (24, '1010103027', 'Banco BISA Caja Ahorro 0131674031 M/N RSR', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (25, '1010103028', 'Banco BISA Caja Ahorro 0131674040 M/N RSC', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (26, '1010103029', 'Banco BISA Caja Ahorro 0131674058 M/N ROR', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (27, '1010103030', 'Banco BISA Caja Ahorro 0131674066 M/N RTJ', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (28, '1010104000', 'DEPOSITOS A PLAZO FIJO', 7, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (29, '1010104012', 'DPF PRODEM S.A. M/N', 28, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (30, '1010104011', 'DPF Banco BISA S.A. M/E', 28, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (31, '1010104013', 'DPF Banco BISA S.A. M/N', 28, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (32, '1010104014', 'DPF Banco BISA S.A. UFV', 28, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (33, '1010320050', '(-) Previsión Material para la Venta', 70, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (34, '7010101001', 'Norma ISO - Normateca', 310, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (35, '8010101001', 'Norma ISO - Normateca', 321, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (36, '1010200000', 'EXIGIBLE', 6, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (37, '1010201000', 'CUENTAS POR COBRAR', 36, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (38, '1010201012', 'Asociados Cuotas Personal', 37, 1, 1, 1, 5, NULL, 1);
INSERT INTO `plan_cuentas` VALUES (39, '1010201011', 'Asociados Cuotas Asociados', 37, 1, 1, 1, 5, NULL, 1);
INSERT INTO `plan_cuentas` VALUES (40, '1010201013', 'Aporte Socio Fundadores', 37, 1, 1, 1, 5, NULL, 1);
INSERT INTO `plan_cuentas` VALUES (41, '1010201024', 'Proyectos', 37, 1, 1, 1, 5, NULL, 1);
INSERT INTO `plan_cuentas` VALUES (42, '1010201035', 'Préstamos al Personal', 37, 1, 1, 1, 5, NULL, 1);
INSERT INTO `plan_cuentas` VALUES (43, '1010201046', 'Depósitos en Garantía', 37, 1, 1, 1, 5, NULL, 1);
INSERT INTO `plan_cuentas` VALUES (44, '1010201830', 'Otras Cuentas por Cobrar', 37, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (45, '1010300000', 'BIENES DE CAMBIO O REALIZABLES', 6, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (46, '1010310000', 'MATERIALES EN TRANSITO', 45, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (47, '1010230000', 'OTRAS CUENTAS POR COBRAR', 36, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (48, '1010230010', 'Cuentas por Cobra FOMIN', 47, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (49, '1010230020', 'Cuentas por Cobrar NOREXPORT', 47, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (50, '1010240000', 'ENTREGAS C/RENDICION', 36, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (51, '1010240030', 'Otras entregas C/Rendición', 50, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (52, '1010250000', 'CUENTAS INCOBRABLES', 36, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (53, '1010250010', 'Cuentas Incobrables', 52, 1, 1, 1, 5, NULL, 1);
INSERT INTO `plan_cuentas` VALUES (54, '1010250020', '(-) Previsión Cuentas Incobrables', 52, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (55, '1010260000', 'REGIONALES CTA. CTE.', 36, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (56, '1010260011', 'Regional Cta. Cte. La Paz', 55, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (57, '1010260012', 'Regional Cta. Cte. Santa Cruz', 55, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (58, '1010260013', 'Regional Cta. Cte. Cochabamba', 55, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (59, '1010260014', 'Regional Cta. Cte. Sucre', 55, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (60, '1010260015', 'Regional Cta. Cte. Tarija', 55, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (61, '1010260016', 'Regional Cta. Cte. Oruro', 55, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (62, '1010270000', 'CREDITO FISCAL', 36, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (63, '1010270010', 'Crédito Fiscal - IVA', 62, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (64, '1010270020', 'Crédito Fiscal - IVA Diferido', 62, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (65, '1010270030', 'Crédito Fiscal - IVA por Recuperar', 62, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (66, '1010220000', 'CLIENTES', 36, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (67, '1010220010', 'Clientes', 66, 1, 1, 1, 5, NULL, 1);
INSERT INTO `plan_cuentas` VALUES (68, '2015020030', 'Fondos a Rendir SIS-IBNORCA', 155, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (69, '1010310010', 'Materiales en Transito', 46, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (70, '1010320000', 'INVENTARIOS', 45, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (71, '1010320011', 'Material para la Venta', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (72, '1010320012', '(-) Previsión Material para la Venta', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (73, '1010320013', 'Suministros y Material de Oficina', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (74, '1010320014', 'Precintos Metálicos (Garrafas)', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (75, '1010320015', 'Precintos Plasticos (Café)', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (76, '1010320016', 'Remaches para Garrafas', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (77, '1010320017', 'Precintos Plasticos (Refrig)', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (78, '1010320018', 'Película Radiografica', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (79, '1010320019', 'Material de Laboratorio', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (80, '1010320020', 'Sacos de Café', 70, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (81, '1010330000', 'ANTICIPOS', 45, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (82, '1010330011', 'Proveedores de Servicios', 81, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (83, '1010330012', 'Depósitos en Garantía', 81, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (84, '1010330013', 'Anticipo Sueldos', 81, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (85, '1010330014', 'Alquileres', 81, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (86, '1010330015', 'Impuesto a las Transacciones Financieras', 81, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (87, '1010330030', 'Otros anticipos', 81, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (88, '1020000000', 'ACTIVO NO CORRIENTE', 1, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (89, '1020100000', 'BIENES DE USO', 88, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (90, '1022000000', 'INTANGIBLES', 88, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (91, '1022010000', 'LICENCIAS - DERECHOS OTROS', 90, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (92, '1022010011', 'Paquete Contable', 91, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (93, '1022010012', 'Acreditaciones', 91, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (94, '1022010013', 'Licencias', 91, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (95, '1022010030', 'Otros', 91, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (96, '1023000000', 'INVERSIONES', 88, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (97, '1023010000', 'PARTICIPACIONES', 96, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (98, '1023010011', 'Cuotas de Participación COTEL', 97, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (99, '1023010012', 'Cuotas de Participación COTAS', 97, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (100, '1024000000', 'DIFERIDOS', 88, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (101, '1024010000', 'GASTOS PAGADOS POR ANTICIPADO', 100, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (102, '1024010011', 'Seguros', 101, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (103, '1024010012', 'Suscripciones', 101, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (104, '1024010013', 'Cuotas Anuales', 101, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (105, '1024010014', 'Subsidios', 101, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (106, '1024010030', 'Otros', 101, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (107, '2010000000', 'PASIVO CORRIENTE', 2, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (108, '2020000000', 'PASIVO NO CORRIENTE', 2, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (109, '2011000000', 'OBLIGACIONES A CORTO PLAZO', 107, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (110, '2011010000', 'OBLIGACIONES GENERALES', 109, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (111, '2011010011', 'Sueldos por Pagar', 110, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (112, '2011010012', 'Servicios Básicos', 110, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (113, '2011010013', 'Honorarios Profesionales', 110, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (114, '2011010014', 'Proyectos', 110, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (115, '2011010015', 'Cuotas Anuales', 110, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (116, '2011010016', 'Alquileres por Pagar', 110, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (117, '2011010017', 'Descuentos al Personal', 110, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (118, '2011010030', 'Otros', 110, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (119, '2012000000', 'APORTES Y RETENCIONES', 107, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (120, '2012010000', 'APORTES SOCIALES', 119, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (121, '2012010011', 'Caja Petrolera', 120, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (122, '2012010012', 'AFP-Previsión BBV', 120, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (123, '2012010013', 'AFP-Futuro de Bolivia', 120, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (124, '2012010014', 'Provivienda', 120, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (125, '2012010015', 'INFOCAL', 120, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (126, '2012010016', 'Aporte Solidario del Asegurado 0,5%', 120, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (127, '2012010017', 'Aporte Nacional Solidario 1%, 5%, 10%', 120, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (128, '2012020000', 'RETENCIONES', 119, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (129, '2012020011', 'Retención IUE Servicios 12,5%', 128, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (130, '2012020012', 'Retención IUE Compras 5%', 128, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (131, '2012020013', 'Retención I.T. 3%', 128, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (132, '2012020014', 'Retención RC-IVA 13%', 128, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (133, '4010104010', 'Ingresos IRAM-IBNORCA SEC', 280, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (134, '2013000000', 'OBLIGACIONES TRIBUTARIAS', 107, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (135, '2013010000', 'IMPUESTOS POR PAGAR', 134, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (136, '2013010011', 'Impuesto a las Transacciones', 135, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (137, '2013010012', 'Remesas al Exterior', 135, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (138, '2013010013', 'Impuesto a la Propiedad de Bienes Inmuebles y Vehículos', 135, 1, 1, 1, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (139, '2013010014', 'Impuesto sobre las Utilidades', 135, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (140, '2013010030', 'Otros Impuestos por Pagar', 135, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (141, '2013020000', 'DEBITO FISCAL', 134, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (142, '2013020011', 'Débito Fiscal IVA', 141, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (143, '2013020012', 'Débito Fiscal Diferido', 141, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (144, '2014000000', 'PROVISIONES', 107, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (145, '2014010000', 'PROVISIONES PARA AGUINALDOS', 144, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (146, '2014010010', 'Aguinaldos', 145, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (147, '2014020000', 'PROVISIONES PRIMAS Y BONOS', 144, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (148, '2014020010', 'Primas y Bonos', 147, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (149, '2014030000', 'PROV. CUENTAS INCOBRABLES', 144, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (150, '2014030011', 'Cuentas incobrables', 149, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (151, '2015000000', 'OBLIGACIONES COMERCIALES', 107, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (152, '2015010000', 'PROVEEDORES', 151, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (153, '2015010010', 'Proveedores por Servicios', 152, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (154, '2015010030', 'Otros proveedores', 152, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (155, '2015020000', 'OTRAS CUENTAS POR PAGAR', 151, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (156, '2015020011', 'Cuentas por Pagar FOMIN', 155, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (157, '2015020012', 'Cuentas por Pagar NOREXPORT', 155, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (158, '2015020013', 'Cuenta por Pagar FAT', 155, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (159, '2016000000', 'INGRESOS ANTICIPADOS', 107, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (160, '2016010000', 'ANTICIPO CLIENTES', 159, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (161, '2016010011', 'Anticipo de Clientes', 160, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (162, '2016010012', 'Depósitos por Identificar Cta. BISA Regional', 160, 1, 1, 1, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (163, '2016010030', 'Otros Anticipos de Clientes', 160, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (164, '2016020000', 'INGRESOS ANTICIPADOS', 159, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (165, '2016020011', 'Ingresos por Capacitación', 164, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (166, '2016020012', 'Ingresos por Servicios', 164, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (167, '2016020030', 'Otros', 164, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (168, '2017000000', 'OTRAS OBLIGACIONES', 107, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (169, '2017010000', 'OTROS', 168, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (170, '2017010011', 'Control C.F. Diferido', 169, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (171, '2021000000', 'OBLIGACIONES A LARGO PLAZO', 108, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (172, '2021010000', 'PREVISIONES', 171, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (173, '2021010011', 'Previsión para Indemnizaciones', 172, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (174, '2021010012', 'Previsión Futuros Contingentes', 172, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (175, '2021010030', 'Otros', 172, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (176, '3010000000', 'CAPITAL', 3, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (177, '3010100000', 'CAPITAL SOCIAL', 176, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (178, '3010101000', 'CAPITAL SOCIAL', 177, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (179, '3010101001', 'Capital Social', 178, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (180, '3010101002', 'Aporte por Donaciones', 178, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (181, '3010101003', 'Donaciones', 178, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (182, '3010200000', 'AJUSTE DE CAPITAL', 176, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (183, '3010201000', 'AJUSTES DE CAPITAL', 182, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (184, '3010201001', 'Ajuste de Capital', 183, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (185, '3020000000', 'RESERVAS', 3, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (186, '3020100000', 'RESERVA LEGAL', 185, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (187, '3020101000', 'RESERVA LEGAL', 186, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (188, '3020101001', 'Reserva Legal', 187, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (189, '3020200000', 'RESERVA POR REVALUO TECNICO', 185, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (190, '3020201000', 'RESERVA POR REVALUO TECNICO', 189, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (191, '3020201001', 'Reserva por Revalúo Técnico', 190, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (192, '3020300000', 'AJUSTE GLOBAL AL PATRIMONIO', 185, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (193, '3020301000', 'AJUSTE GLOBAL AL PATRIMONIO', 192, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (194, '3020301001', 'Ajustes Global al Patrimonio', 193, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (195, '3020500000', 'AJUSTE DE RESERVAS DE CAPITAL', 185, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (196, '3020501000', 'AJUSTES DE RESERVAS DE CAPITAL', 195, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (197, '3020501001', 'Ajuste de Reservas de Capital', 196, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (198, '3030000000', 'RESULTADOS', 3, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (199, '3030100000', 'RESULTADOS ACUMULADOS', 198, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (200, '3030101000', 'RESULTADOS ACUMULADOS', 199, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (201, '3030101001', 'Resultados Acumulados', 200, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (202, '3030200000', 'RESULTADO DE LA GESTION', 198, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (203, '3030201000', 'RESULTADO DE LA GESTION', 202, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (204, '3030201001', 'Resultado de Gestión', 203, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (205, '5020000000', 'GASTOS', 5, 1, 1, 3, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (206, '5020100000', 'GASTOS OPERATIVOS', 205, 1, 1, 3, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (207, '5020106000', 'IMPUESTOS Y PATENTES', 206, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (208, '4010000000', 'INGRESOS OPERATIVOS', 4, 1, 1, 3, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (209, '5010000000', 'CUENTAS DE COSTO', 5, 1, 1, 3, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (210, '5010100000', 'COSTO DE MATERIALES', 209, 1, 1, 3, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (211, '5010101000', 'COSTO DE VENTAS', 210, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (212, '5010101001', 'Costo de materiales O.I.M.', 211, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (213, '5010101002', 'Costo de materiales O.I.Q.', 211, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (214, '5010101003', 'Costo de materiales para la venta', 211, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (215, '5020101000', 'COSTOS DE SERVICIO', 206, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (216, '5020101001', 'Honorarios Auditores Externos', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (217, '5020101002', 'Honorarios por Docencia', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (218, '5020101003', 'Servicios Externos', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (219, '5020101004', 'Alquiler Otros P/Servicios', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (220, '5020101005', 'Pasajes Viáticos por Servicios', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (221, '5020101006', 'Refrigerios Cursos - Comites y Otros', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (222, '5020101007', 'Servicios Publicitarios por Servicios', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (223, '5020101008', 'Gastos de Imprenta', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (224, '5020101010', 'Auspicios y Eventos', 215, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (225, '5020101030', 'Otros Gastos', 215, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (226, '5020102000', 'GASTOS EN PERSONAL DEPENDIENTE', 206, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (227, '5020102001', 'Sueldos al Personal', 226, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (228, '5020102002', 'Aportes', 226, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (229, '5020102003', 'Aguinaldos', 226, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (230, '5020102004', 'Indemnizaciones - Vacaciones', 226, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (231, '5020102005', 'Desahucios', 226, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (232, '5020102006', 'Subsidios', 226, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (233, '5020102007', 'Refrigerios al Personal', 226, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (234, '5020103000', 'GASTOS EN PERSONAL EXTERNO', 206, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (235, '5020103001', 'Honorarios Profesionales', 234, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (236, '5020103002', 'Refrigerios Personal Externo', 234, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (237, '5020104000', 'GASTOS ADMINISTRATIVOS', 206, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (238, '5020104001', 'Material de escritorio', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (239, '5020104002', 'Servicios de Courrier', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (240, '5020104003', 'Servicios y Comunicaciones', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (241, '5020104004', 'Servicios de Seguridad', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (242, '5020104005', 'Alquiler de Oficinas', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (243, '5020104006', 'Seguros', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (244, '5020104007', 'Servicios de Fotocopias, Anillados y Otros', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (245, '5020104008', 'Gastos de Imprenta, Enmarcados y Otros', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (246, '5020104009', 'Servicio y Material de Limpieza', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (247, '5020104010', 'Gastos de Movilidad', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (248, '5020104011', 'Gastos de representación', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (249, '5020104012', 'Suscripciones y Cuotas', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (250, '5020104013', 'Capacitación al Personal', 237, 1, 1, 3, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (251, '5020104014', 'Intereses y Multas', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (252, '5020104015', 'Gastos Bancarios', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (253, '5020104021', 'Mantenimiento y Reparación de Equipos', 237, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (254, '5020104022', 'Mantenimiento y Reparación de Instalaciones', 237, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (255, '5020104030', 'Gastos Varios', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (256, '5020105000', 'DEPRECIACIONES, AMORTIZACIONES', 206, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (257, '5020105001', 'Depreciación de Activos Fijos', 256, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (258, '5020105002', 'Amortización de Otros Activos', 256, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (259, '5020106001', 'Impuesto a las Transacciones Financieras', 207, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (260, '5020106002', 'Impuesto a las Utilidades', 207, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (261, '5020106003', 'Impuesto a las Transacciones', 207, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (262, '5020106004', 'Patentes y Licencias', 207, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (263, '5020111000', 'EGRESOS POR PROYECTOS', 206, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (264, '5020111004', 'Egresos NOREXPORT', 263, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (265, '5020111005', 'Egresos IRAM - IBNORCA', 263, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (266, '5020111006', 'Egresos Hecho a Mano', 263, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (267, '5020111007', 'Egresos CBH - IBNORCA', 263, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (268, '5020111008', 'Egresos FAT', 263, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (269, '4010100000', 'INGRESOS POR SERVICIOS', 208, 1, 1, 3, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (270, '4010101000', 'INGRESOS OI', 269, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (271, '4010101001', 'Ingresos por Certificación OIM', 270, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (272, '4010101002', 'Ingresos por Certificación OIQ', 270, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (273, '4010102000', 'INGRESOS SERVICIOS TECNICOS', 269, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (274, '4010102001', 'Ingresos por Certificación SELLO', 273, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (275, '4010102002', 'Ingresos por Certificación SISTEMAS', 273, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (276, '4010102003', 'Ingresos por Laboratorio', 273, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (277, '4010103000', 'INGRESOS VENTAS-NO', 269, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (278, '4010103002', 'Auspicios y Eventos', 277, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (279, '4010104001', 'Ingresos por Capacitación', 280, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (280, '4010104000', 'INGRESOS SERVICIOS EXTERNOS', 269, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (281, '4010103003', 'Ingresos cuotas Asociados', 277, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (282, '4010103001', 'Ingresos Ventas', 277, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (283, '4020000000', 'INGRESOS NO OPERATIVOS', 4, 1, 1, 3, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (284, '4020100000', 'INGRESOS MONETARIOS', 283, 1, 1, 3, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (285, '4020101000', 'INGRESOS FINANCIEROS Y OTROS', 284, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (286, '4020101001', 'Intereses Ganados', 285, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (287, '4020101002', 'Comisiones Ganadas', 285, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (288, '4020101003', 'Donaciones', 285, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (289, '4020101010', 'Otros Ingresos', 285, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (290, '4020200000', 'INGRESOS NO MONETARIOS', 283, 1, 1, 3, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (291, '4020210000', 'OTROS INGRESOS', 290, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (292, '4020210030', 'Otros', 291, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (293, '5100000000', 'OTROS INGRESOS Y/O EGRESOS NO OPERATIVOS', 5, 1, 1, 3, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (294, '5100100000', 'GANACIAS Y/O PERDIDAS EN VENTAS DE ACTIVOS FIJOS', 293, 1, 1, 3, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (295, '5100101000', 'VENTA ACTIVOS FIJOS', 294, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (296, '5100101001', 'Venta Activos Fijos', 295, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (297, '5100500000', 'AJUSTE POR REEXPRESION MONETARIA', 293, 1, 1, 3, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (298, '5100501000', 'AJUSTE POR INFLACION Y TENENCIA DE BIENES', 297, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (299, '5100501001', 'Ajuste por Inflacion y Tenencia de Bienes', 298, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (300, '5100501002', 'Resultados por Exposicion a la Inflacion', 298, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (301, '5100501003', 'Ajuste por Diferencia de Cambio', 298, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (302, '5100501004', 'Mantenimiento de Valor', 298, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (303, '5100501005', 'Corrección Monetaria', 298, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (304, '5100600000', 'PERDIDAS Y GANANCIAS', 293, 1, 1, 3, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (305, '5100601000', 'PERDIDAS Y GANANCIAS', 304, 1, 1, 3, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (306, '5100601001', 'Perdidas y Ganancias', 305, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (308, '7010000000', 'CUENTAS DE ORDEN', 307, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (309, '7010100000', 'CUENTAS DE ORDEN DEUDORAS', 308, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (310, '7010101000', 'CUENTAS DE ORDEN REGIONALES', 309, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (311, '7010101002', 'Regional Cochabamba', 310, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (312, '7010101003', 'Regional Santa Cruz', 310, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (313, '7010101004', 'Regional La Paz', 310, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (314, '7010101005', 'Regional Chuquisaca', 310, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (315, '7010101006', 'Regional Tarija', 310, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (316, '7010101008', 'Regional Oruro', 310, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (317, '7010101009', 'Regional El Alto', 310, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (319, '8010000000', 'CUENTAS DE ORDEN', 318, 1, 1, 1, 2, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (320, '8010100000', 'CUENTAS DE ORDEN ACREEDORAS', 319, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (321, '8010101000', 'CUENTAS DE ORDEN REGIONALES', 320, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (322, '8010101002', 'Regional Cochabamba', 321, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (323, '8010101003', 'Regional Santa Cruz', 321, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (324, '8010101004', 'Regional La Paz', 321, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (325, '8010101005', 'Regional Chuquisaca', 321, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (326, '8010101006', 'Regional Tarija', 321, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (327, '8010101007', 'Regional Oruro', 321, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (328, '8010101008', 'Regional El Alto', 321, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (329, '1020101000', 'MUEBLES Y ENSERES', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (330, '1020101001', 'Muebles y Enseres', 329, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (331, '1020101002', '(-) Dep. Acumulada Muebles y Enseres', 329, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (332, '1020102000', 'EQUIPOS DE COMPUTACION', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (333, '1020102001', 'Equipos de Computación', 332, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (334, '1020102002', '(-) Dep. Acumulada quipos de Computación', 332, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (335, '1020103000', 'EQUIPOS DE COMUNICACION', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (336, '1020103001', 'Equipos de Comunicación', 335, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (337, '1020103002', '(-) Dep. Acumulada Equipos de Comunicación', 335, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (338, '1020104000', 'EQUIPOS DE OFICINA', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (339, '1020104001', 'Equipos de Oficina', 338, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (340, '1020104002', '(-) Dep. Acumulada Equipos de oficina', 338, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (341, '1020105000', 'EQUIPO CENT.NAC. DE SOLDADURA', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (342, '1020105001', 'Equipo Cent.Nac. de Soldadura', 341, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (343, '1020105002', '(-) Dep. Acumulada Equipos Lab.Soldadura', 341, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (344, '1020106000', 'EQUIPO DE LABORATORIO QUIMICO', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (345, '1020106001', 'Equipo de Laboratorio Quimico', 344, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (346, '1020106002', '(-) Dep. Acumulada Equipo de Lab. Quimico', 344, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (347, '1020107000', 'MATERIAL DE CONSULTA', 89, 1, 2, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (348, '1020107001', 'Material de Consulta', 347, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (349, '1020107002', '(-) Dep. Acumulada. Material de Consulta', 347, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (350, '1020108000', 'MEJORAS EN PROPIEDAD ARRENDADA', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (351, '1020108001', 'Mejoras en Popiedad', 350, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (352, '1020108002', '(-) Amortiz. Acumulda Mejoras en Propiedad', 350, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (353, '1020109000', 'EDIFICACIONES', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (354, '1020109001', 'Edificaciones', 353, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (355, '1020109002', '(-)Depreciación Acumulada Edificaciones', 353, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (356, '1020110000', 'TERRENOS', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (357, '1020110001', 'Terrenos', 356, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (358, '1020130000', 'OBRAS EN CONSTRUCCIÓN', 89, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (359, '1020130001', 'Obras en Construcción', 358, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (360, '1023010018', 'Cuotas de Participación COTEOR', 97, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (361, '1010230030', 'Otras Cuentas por Cobrar', 47, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (362, '1010103021', 'Banco BISA S.A. Cta. Cte. 0131670036 M/N PROY', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (363, '4010101010', 'Servicios IRAM-IBNORCA OI', 270, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (364, '4010102010', 'Servicios IRAM-IBNORCA', 273, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (365, '4010103010', 'Ingresos IRAM-IBNORCA NO', 277, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (366, '1010103015', 'Banco Mercantil Santa Cruz Cta. Cte. 4010766046 M/E', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (367, '2021020000', 'PRESTAMOS A LARGO PLAZO', 171, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (368, '2021020001', 'Prestamos Hipotecarios', 367, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (369, '2015020001', 'Cuentas por Pagar UTILIDAD 40 % SERVICIOS IRAM', 155, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (370, '5020111009', 'Proyecto CAF', 263, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (371, '2021020002', 'Prestamos Bancarios', 367, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (372, '2013010010', 'Impuestos por Pagar', 135, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (373, '4010101020', 'Ingresos USAID - IBNORCA', 270, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (374, '5020111010', 'Egresos Proyecto USAID', 263, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (375, '1023010013', 'Cuotas de Participación COMTECO', 97, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (376, '2016020013', 'Ingresos SEA', 164, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (377, '2015020002', 'Cuentas por Pagar CAMARA DE INDUSTRIA ORURO', 155, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (378, '1010230040', 'Cuentas Por Cobrar IRAM', 47, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (379, '1023010014', 'Cuotas de Participacion COTES', 97, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (380, '1010260020', 'Regional Prorrateos', 55, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (381, '1010201950', 'Cuentas Transitorias', 37, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (382, '1022010014', 'Marcas', 91, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (383, '2017010012', 'Otras cuentas transitorias', 169, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (384, '5020104040', 'Gastos Foro Calidad', 237, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (385, '5020104041', 'Gastos Premio a la Calidad', 237, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (386, '1010103040', 'Banco Bisa Libreta de Inversión 0131674074 M/N', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (387, '5020106005', 'Impuesto a la Propiedad de Bienes Inmuebles y Vehículos', 207, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (388, '1010230050', 'Cuentas por Cobrar Proyectos', 47, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (389, '1022010015', 'Normateca', 91, 1, 2, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (390, '2021030000', 'OTROS', 171, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (391, '2021030001', 'Otras Obligaciones a Largo Plazo', 390, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (392, '4010102020', 'Ingresos AFNOR-IBNORCA', 273, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (393, '5020104050', 'Gastos AFNOR-IBNORCA', 237, 1, 2, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (394, '1010103016', 'Banco Fortaleza S.A. Cta. Cte. 2041001930 M/N', 17, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (395, '2021010013', 'Previsión para Responsabilidad Profesional', 172, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (396, '1022010101', 'Paquete Contable y Software', 91, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (397, '1022010102', '(-)Amortización Acumulada Paq.Contable y Software', 91, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (398, '1022010201', 'Acreditaciones', 91, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (399, '1022010202', '(-)Amortización Acumulada Acreditaciones', 91, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (400, '1022010301', 'Marcas', 91, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (401, '1022010302', '(-)Amortización Acumulada Marcas', 91, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (402, '1022010401', 'Normateca', 91, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (403, '2021010014', 'Previsión para Contingencias Laborales y Otros', 172, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (404, '2015020003', 'Cuentas por Pagar AFNOR', 155, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (405, '5020104023', 'Pérdidas en Cuentas Incobrables', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (406, '1022010402', '(-) Amortización Acumulada Normateca', 91, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (407, '1010102050', 'Caja Chica Proyectos', 10, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (408, '1010260017', 'Regional Cta. Cte. Potosi', 55, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (409, '1010102007', 'Caja Chica Potosí', 10, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (410, '2015030000', 'PRESTAMOS A CORTO PLAZO', 151, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (411, '2015030001', 'Préstamos Hipotecarios', 410, 1, 1, 1, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (412, '2015030002', 'Préstamos Bancarios', 410, 1, 1, 1, 5, '', 1);
INSERT INTO `plan_cuentas` VALUES (413, '2016010013', 'Depósitos por Identificar Banco Unión M/N ', 160, 1, 1, 1, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (414, '5020104016', 'Contingencias Laborales y Otros', 237, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (415, '3010300000', 'PATRIMONIO EN BIENES', 176, 1, 1, 1, 3, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (416, '3010301000', 'Patrimonio en Bienes', 415, 1, 1, 1, 4, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (417, '4020101004', 'Contribuciones Proyectos', 285, 1, 1, 3, 5, NULL, 0);
INSERT INTO `plan_cuentas` VALUES (447, '5020104018', 'GASTOS SA*', 2147483647, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (448, '5020104019', 'Mantenimiento y Reparación de Vehículos', 237, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (449, '3010301001', 'Patrimonio en Bienes', 416, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (450, '2016010014', 'Depósitos por Identificar Cta. BISA Nacional', 160, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (451, '5020101040', 'Otros Pagos', 215, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (452, '2016010015', 'Depósitos por Identificar Banco Mercantil M/N', 160, 1, 1, 1, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (453, '5020104040', 'Gastos por Contingencia Sanitaria', 237, 1, 2, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (454, '2015020050', 'Otros', 155, 1, 1, 1, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (455, '1020107000', 'VEHICULOS', 89, 1, 1, 1, 4, '', 0);
INSERT INTO `plan_cuentas` VALUES (456, '1020107001', 'Vehiculos', 455, 1, 1, 1, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (457, '1020107002', '(-) Dep. Acumulada Vehiculos', 455, 1, 1, 1, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (458, '5020104017', 'Combustibles y lubricantes', 237, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (459, '5100200000', 'RESULTADOS DE GESTIONES ANTERIORES', 293, 1, 1, 3, 3, '', NULL);
INSERT INTO `plan_cuentas` VALUES (460, '5100201000', 'INGRESOS Y/O GASTOS GESTIONES ANTERIORES', 459, 1, 1, 3, 4, '', NULL);
INSERT INTO `plan_cuentas` VALUES (461, '5100201001', 'Ingresos y/o gastos gestiones anteriores', 460, 1, 1, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (462, '4010103004', 'Ingresos de FOR a NO', 277, 1, 2, 3, 5, '', NULL);
INSERT INTO `plan_cuentas` VALUES (463, '2015020031', 'Fondos a Rendir BSI-IBNORCA', 155, 1, 1, 1, 5, '', NULL);

-- ----------------------------
-- Table structure for proyectos_financiacionexterna
-- ----------------------------
DROP TABLE IF EXISTS `proyectos_financiacionexterna`;
CREATE TABLE `proyectos_financiacionexterna`  (
  `codigo` int NOT NULL DEFAULT 0,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_estadoreferencial` int NULL DEFAULT NULL,
  `cod_unidadorganizacional` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of proyectos_financiacionexterna
-- ----------------------------
INSERT INTO `proyectos_financiacionexterna` VALUES (0, 'IBNO', 'IBNORCA', 1, 0);
INSERT INTO `proyectos_financiacionexterna` VALUES (1, 'SIS', 'PROYECTO SIS', 1, 3000);
INSERT INTO `proyectos_financiacionexterna` VALUES (2, 'BSI', 'PROYECTO BSI', 1, 5000);

-- ----------------------------
-- Table structure for tipos_campo
-- ----------------------------
DROP TABLE IF EXISTS `tipos_campo`;
CREATE TABLE `tipos_campo`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `abreviatura` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `string_formulario` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipos_campo
-- ----------------------------
INSERT INTO `tipos_campo` VALUES (1, 'NUMERO ENTERO', 'INT', 1, '<div class=\"form-group\">\r\n<input value=\"XX\" class=\"form-control\" type=\"number\" name=\"XXXXX\" id=\"XXXXX\" step=\"1\"/>\r\n</div>');
INSERT INTO `tipos_campo` VALUES (2, 'NUMERO DECIMAL', 'DEC', 1, '<div class=\"form-group\">\r\n<input value=\"XX\" class=\"form-control\" type=\"number\" name=\"XXXXX\" id=\"XXXXX\" step=\"0.1\"/>\r\n</div>');
INSERT INTO `tipos_campo` VALUES (3, 'TEXTO CORTO', 'SHORTTEXT', 1, '<div class=\"form-group\">\r\n<input value=\"XX\" class=\"form-control\" type=\"text\" name=\"XXXXX\" id=\"XXXXX\"  />\r\n</div>');
INSERT INTO `tipos_campo` VALUES (4, 'TEXTO LARGO', 'LARGETEXT', 1, '<div class=\"form-group\">\r\n<textarea class=\"form-control\" aria-label=\"With textarea\" name=\"XXXXX\" id=\"XXXXX\">XX</textarea>\r\n</div>');
INSERT INTO `tipos_campo` VALUES (5, 'FECHA', 'DATE', 1, '<div class=\"form-group\">\r\n<input value=\"XX\" class=\"form-control\" type=\"date\" name=\"XXXXX\" id=\"XXXXX\" />\r\n</div>');
INSERT INTO `tipos_campo` VALUES (6, 'HORA', 'HOUR', 1, '<div class=\"form-group\">\r\n<input value=\"XX\" class=\"form-control\" type=\"time\" name=\"XXXXX\" id=\"XXXXX\" />\r\n</div>');
INSERT INTO `tipos_campo` VALUES (7, 'BOOLEANO', 'BOOL', 1, '<div class=\"custom-control custom-switch\">\r\n<input XX type=\"checkbox\" class=\"custom-control-input\" id=\"XXXXX\" name=\"XXXXX\">\r\n<label class=\"custom-control-label\" for=\"XXXXX\"></label>\r\n</div>');

-- ----------------------------
-- Table structure for unidades_organizacionales
-- ----------------------------
DROP TABLE IF EXISTS `unidades_organizacionales`;
CREATE TABLE `unidades_organizacionales`  (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `abreviatura` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_estado` int NULL DEFAULT NULL,
  `centro_costos` int NULL DEFAULT NULL,
  `observaciones` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `modified_at` datetime NULL DEFAULT NULL,
  `modified_by` int NULL DEFAULT NULL,
  `cod_sucursal` int NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4001 CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unidades_organizacionales
-- ----------------------------
INSERT INTO `unidades_organizacionales` VALUES (1, 'IBNORCA', 'IBN', 2, 0, '', NULL, 1, NULL, 1, 1);
INSERT INTO `unidades_organizacionales` VALUES (5, 'OF LA PAZ', 'RLP', 1, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (8, 'OF ORURO', 'ROR', 1, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (9, 'OF COCHABAMBA', 'RCB', 1, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (10, 'OF SANTA CRUZ', 'RSC', 1, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (270, 'OF SUCRE', 'RCH', 1, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (271, 'OF TARIJA', 'RTJ', 1, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (272, 'OF POTOSI', 'RPT', 1, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (829, 'DIRECCION NACIONAL', 'DN', 1, 1, '', NULL, 1, NULL, 1, 1);
INSERT INTO `unidades_organizacionales` VALUES (1103, 'OF VIRTUAL', 'OV', 2, 0, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (2692, 'OF. EL ALTO', 'REA', 1, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (3000, 'PROYECTO SIS', 'SIS', 2, 1, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `unidades_organizacionales` VALUES (4000, 'PROYECTO BSI', 'BSI', 2, 1, NULL, NULL, NULL, NULL, NULL, 1);

SET FOREIGN_KEY_CHECKS = 1;
