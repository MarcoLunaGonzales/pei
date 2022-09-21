/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50712
 Source Host           : localhost:3306
 Source Schema         : financiero0901

 Target Server Type    : MySQL
 Target Server Version : 50712
 File Encoding         : 65001

 Date: 21/09/2022 10:00:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for proyectos_financiacionexterna
-- ----------------------------
DROP TABLE IF EXISTS `proyectos_financiacionexterna`;
CREATE TABLE `proyectos_financiacionexterna`  (
  `codigo` int(11) NOT NULL DEFAULT 0,
  `abreviatura` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci NULL DEFAULT NULL,
  `cod_estadoreferencial` int(11) NULL DEFAULT NULL,
  `cod_unidadorganizacional` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_spanish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of proyectos_financiacionexterna
-- ----------------------------
INSERT INTO `proyectos_financiacionexterna` VALUES (0, 'IBNO', 'IBNORCA', 1, 0);
INSERT INTO `proyectos_financiacionexterna` VALUES (1, 'SIS', 'PROYECTO SIS', 1, 3000);
INSERT INTO `proyectos_financiacionexterna` VALUES (2, 'BSI', 'PROYECTO BSI', 1, 5000);

SET FOREIGN_KEY_CHECKS = 1;
