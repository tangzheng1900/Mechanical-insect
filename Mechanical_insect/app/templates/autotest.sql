/*
 Navicat Premium Data Transfer

 Source Server         : aliyuncs.com
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : rm-bp153srx1gt80tl1x2o.mysql.rds.aliyuncs.com:3306
 Source Schema         : autotest

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 08/04/2020 16:06:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `is_super` smallint(6) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  `state` smallint(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `name_2`(`name`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'pbkdf2:sha256:50000$F16zb4S2$a9dab90091a03c61a16b77ab55f62c15319633099072a952b1cc55595a28e240', 0, 1, '2019-12-27 11:46:16', 0);
INSERT INTO `admin` VALUES (18, 'root', 'pbkdf2:sha256:50000$Ax11MRZm$37569c9c2ae35538e3f8ea56acc053c10d8b2a46a06e8f3b4c024963d4fd895c', 1, 1, '2020-01-06 11:31:49', 0);

-- ----------------------------
-- Table structure for adminlog
-- ----------------------------
DROP TABLE IF EXISTS `adminlog`;
CREATE TABLE `adminlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE,
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 163 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES (1, 1, '172.16.16.47', '2019-12-11 16:01:50');
INSERT INTO `adminlog` VALUES (2, 1, '172.16.16.47', '2019-12-11 16:03:25');
INSERT INTO `adminlog` VALUES (3, 1, '172.16.16.47', '2019-12-11 16:07:32');
INSERT INTO `adminlog` VALUES (4, 1, '172.16.16.47', '2019-12-11 16:33:04');
INSERT INTO `adminlog` VALUES (5, 1, '172.16.16.47', '2019-12-11 16:34:31');
INSERT INTO `adminlog` VALUES (6, 1, '172.16.16.47', '2019-12-11 16:43:15');
INSERT INTO `adminlog` VALUES (7, 1, '172.16.16.47', '2019-12-11 16:46:24');
INSERT INTO `adminlog` VALUES (8, 1, '172.16.16.47', '2019-12-11 17:00:48');
INSERT INTO `adminlog` VALUES (9, 1, '172.16.16.47', '2019-12-11 17:03:39');
INSERT INTO `adminlog` VALUES (10, 1, '172.16.16.47', '2019-12-11 17:07:53');
INSERT INTO `adminlog` VALUES (11, 1, '127.0.0.1', '2019-12-12 09:51:28');
INSERT INTO `adminlog` VALUES (12, 1, '127.0.0.1', '2019-12-12 10:20:57');
INSERT INTO `adminlog` VALUES (13, 1, '127.0.0.1', '2019-12-12 11:10:12');
INSERT INTO `adminlog` VALUES (14, 1, '127.0.0.1', '2019-12-12 14:29:41');
INSERT INTO `adminlog` VALUES (15, 1, '127.0.0.1', '2019-12-12 14:42:14');
INSERT INTO `adminlog` VALUES (16, 1, '127.0.0.1', '2019-12-12 14:47:15');
INSERT INTO `adminlog` VALUES (17, 1, '127.0.0.1', '2019-12-12 14:50:12');
INSERT INTO `adminlog` VALUES (18, 1, '127.0.0.1', '2019-12-12 14:56:52');
INSERT INTO `adminlog` VALUES (19, 1, '127.0.0.1', '2019-12-12 15:19:33');
INSERT INTO `adminlog` VALUES (20, 1, '127.0.0.1', '2019-12-12 15:59:44');
INSERT INTO `adminlog` VALUES (21, 1, '127.0.0.1', '2019-12-12 16:17:03');
INSERT INTO `adminlog` VALUES (22, 1, '127.0.0.1', '2019-12-13 09:17:32');
INSERT INTO `adminlog` VALUES (23, 1, '127.0.0.1', '2019-12-13 09:19:22');
INSERT INTO `adminlog` VALUES (24, 1, '127.0.0.1', '2019-12-19 10:37:24');
INSERT INTO `adminlog` VALUES (25, 1, '127.0.0.1', '2019-12-19 10:38:59');
INSERT INTO `adminlog` VALUES (26, 1, '127.0.0.1', '2019-12-19 10:40:02');
INSERT INTO `adminlog` VALUES (27, 1, '127.0.0.1', '2019-12-20 09:03:08');
INSERT INTO `adminlog` VALUES (28, 1, '127.0.0.1', '2019-12-25 09:27:59');
INSERT INTO `adminlog` VALUES (29, 1, '172.16.16.50', '2019-12-25 09:33:03');
INSERT INTO `adminlog` VALUES (30, 1, '127.0.0.1', '2019-12-25 10:12:32');
INSERT INTO `adminlog` VALUES (31, 1, '127.0.0.1', '2019-12-25 10:12:56');
INSERT INTO `adminlog` VALUES (32, 1, '127.0.0.1', '2019-12-25 11:46:14');
INSERT INTO `adminlog` VALUES (33, 1, '172.16.16.47', '2019-12-25 11:48:20');
INSERT INTO `adminlog` VALUES (34, 1, '172.16.16.50', '2019-12-25 17:28:37');
INSERT INTO `adminlog` VALUES (35, 1, '172.16.16.47', '2019-12-26 13:30:56');
INSERT INTO `adminlog` VALUES (36, 1, '172.16.16.47', '2019-12-27 09:54:05');
INSERT INTO `adminlog` VALUES (37, 1, '172.16.16.47', '2019-12-27 10:15:19');
INSERT INTO `adminlog` VALUES (38, 1, '172.16.16.47', '2019-12-27 10:18:28');
INSERT INTO `adminlog` VALUES (39, 1, '172.16.16.47', '2019-12-27 11:54:39');
INSERT INTO `adminlog` VALUES (40, 1, '172.16.16.47', '2019-12-27 14:35:46');
INSERT INTO `adminlog` VALUES (41, 1, '172.16.16.47', '2019-12-27 14:36:24');
INSERT INTO `adminlog` VALUES (42, 1, '172.16.16.47', '2019-12-27 14:53:13');
INSERT INTO `adminlog` VALUES (43, 1, '172.16.16.47', '2019-12-27 14:57:15');
INSERT INTO `adminlog` VALUES (44, 1, '172.16.16.47', '2019-12-27 14:57:27');
INSERT INTO `adminlog` VALUES (45, 1, '172.16.16.47', '2019-12-27 15:06:38');
INSERT INTO `adminlog` VALUES (46, 1, '172.16.16.47', '2019-12-27 15:07:11');
INSERT INTO `adminlog` VALUES (47, 1, '172.16.16.47', '2019-12-27 16:10:31');
INSERT INTO `adminlog` VALUES (48, 1, '172.16.16.47', '2019-12-27 21:56:08');
INSERT INTO `adminlog` VALUES (49, 1, '127.0.0.1', '2019-12-27 22:03:23');
INSERT INTO `adminlog` VALUES (50, 1, '127.0.0.1', '2019-12-27 22:20:55');
INSERT INTO `adminlog` VALUES (51, 1, '127.0.0.1', '2019-12-27 22:23:18');
INSERT INTO `adminlog` VALUES (52, 1, '127.0.0.1', '2019-12-27 22:24:51');
INSERT INTO `adminlog` VALUES (53, 1, '127.0.0.1', '2019-12-27 22:32:37');
INSERT INTO `adminlog` VALUES (54, 1, '127.0.0.1', '2019-12-27 22:33:51');
INSERT INTO `adminlog` VALUES (55, 1, '172.16.16.47', '2019-12-30 13:39:04');
INSERT INTO `adminlog` VALUES (56, 1, '172.16.16.47', '2019-12-30 18:00:42');
INSERT INTO `adminlog` VALUES (57, 1, '172.16.16.47', '2019-12-30 18:02:11');
INSERT INTO `adminlog` VALUES (58, 1, '127.0.0.1', '2019-12-31 17:04:54');
INSERT INTO `adminlog` VALUES (59, 1, '127.0.0.1', '2020-01-02 14:21:31');
INSERT INTO `adminlog` VALUES (60, 1, '127.0.0.1', '2020-01-02 14:24:02');
INSERT INTO `adminlog` VALUES (61, 1, '127.0.0.1', '2020-01-02 15:17:02');
INSERT INTO `adminlog` VALUES (62, 1, '127.0.0.1', '2020-01-02 15:29:26');
INSERT INTO `adminlog` VALUES (63, 1, '127.0.0.1', '2020-01-02 15:49:47');
INSERT INTO `adminlog` VALUES (64, 1, '127.0.0.1', '2020-01-02 16:06:33');
INSERT INTO `adminlog` VALUES (65, 1, '127.0.0.1', '2020-01-02 17:08:26');
INSERT INTO `adminlog` VALUES (66, 1, '127.0.0.1', '2020-01-03 09:39:56');
INSERT INTO `adminlog` VALUES (67, 1, '127.0.0.1', '2020-01-03 10:00:05');
INSERT INTO `adminlog` VALUES (68, 1, '127.0.0.1', '2020-01-03 16:50:45');
INSERT INTO `adminlog` VALUES (69, 1, '127.0.0.1', '2020-01-06 09:36:01');
INSERT INTO `adminlog` VALUES (70, 1, '127.0.0.1', '2020-01-06 09:53:09');
INSERT INTO `adminlog` VALUES (71, 1, '127.0.0.1', '2020-01-06 13:50:46');
INSERT INTO `adminlog` VALUES (72, 1, '127.0.0.1', '2020-01-06 14:11:17');
INSERT INTO `adminlog` VALUES (73, 1, '127.0.0.1', '2020-01-06 14:12:59');
INSERT INTO `adminlog` VALUES (74, 1, '127.0.0.1', '2020-01-06 14:26:39');
INSERT INTO `adminlog` VALUES (75, 1, '127.0.0.1', '2020-01-06 14:28:17');
INSERT INTO `adminlog` VALUES (76, 18, '127.0.0.1', '2020-01-06 15:02:19');
INSERT INTO `adminlog` VALUES (77, 1, '127.0.0.1', '2020-01-06 15:02:28');
INSERT INTO `adminlog` VALUES (78, 1, '127.0.0.1', '2020-01-06 15:02:49');
INSERT INTO `adminlog` VALUES (79, 1, '127.0.0.1', '2020-01-06 16:07:40');
INSERT INTO `adminlog` VALUES (80, 1, '127.0.0.1', '2020-01-07 10:11:56');
INSERT INTO `adminlog` VALUES (81, 1, '127.0.0.1', '2020-01-07 15:21:14');
INSERT INTO `adminlog` VALUES (82, 1, '127.0.0.1', '2020-01-07 18:03:11');
INSERT INTO `adminlog` VALUES (83, 1, '127.0.0.1', '2020-01-08 10:12:09');
INSERT INTO `adminlog` VALUES (84, 18, '127.0.0.1', '2020-01-08 17:02:11');
INSERT INTO `adminlog` VALUES (85, 18, '127.0.0.1', '2020-01-08 17:03:11');
INSERT INTO `adminlog` VALUES (86, 1, '127.0.0.1', '2020-01-08 17:04:49');
INSERT INTO `adminlog` VALUES (87, 1, '127.0.0.1', '2020-01-09 14:05:47');
INSERT INTO `adminlog` VALUES (88, 1, '127.0.0.1', '2020-01-10 09:44:54');
INSERT INTO `adminlog` VALUES (89, 1, '127.0.0.1', '2020-01-10 10:34:48');
INSERT INTO `adminlog` VALUES (90, 1, '127.0.0.1', '2020-01-10 10:35:17');
INSERT INTO `adminlog` VALUES (91, 1, '127.0.0.1', '2020-01-10 10:37:04');
INSERT INTO `adminlog` VALUES (92, 1, '127.0.0.1', '2020-01-10 11:27:55');
INSERT INTO `adminlog` VALUES (93, 1, '127.0.0.1', '2020-01-10 13:49:29');
INSERT INTO `adminlog` VALUES (94, 1, '127.0.0.1', '2020-01-10 14:44:21');
INSERT INTO `adminlog` VALUES (95, 1, '127.0.0.1', '2020-01-10 15:03:53');
INSERT INTO `adminlog` VALUES (96, 1, '127.0.0.1', '2020-01-10 17:21:12');
INSERT INTO `adminlog` VALUES (97, 1, '127.0.0.1', '2020-01-10 17:28:56');
INSERT INTO `adminlog` VALUES (98, 1, '127.0.0.1', '2020-02-03 16:05:31');
INSERT INTO `adminlog` VALUES (99, 1, '127.0.0.1', '2020-02-11 14:00:02');
INSERT INTO `adminlog` VALUES (100, 1, '127.0.0.1', '2020-02-11 14:32:13');
INSERT INTO `adminlog` VALUES (101, 1, '127.0.0.1', '2020-02-12 12:15:03');
INSERT INTO `adminlog` VALUES (102, 1, '127.0.0.1', '2020-02-17 19:55:10');
INSERT INTO `adminlog` VALUES (103, 1, '127.0.0.1', '2020-02-17 20:06:12');
INSERT INTO `adminlog` VALUES (104, 1, '127.0.0.1', '2020-02-17 20:16:48');
INSERT INTO `adminlog` VALUES (105, 1, '127.0.0.1', '2020-02-18 09:29:00');
INSERT INTO `adminlog` VALUES (106, 1, '127.0.0.1', '2020-02-20 10:29:26');
INSERT INTO `adminlog` VALUES (107, 1, '127.0.0.1', '2020-02-20 10:29:55');
INSERT INTO `adminlog` VALUES (108, 1, '127.0.0.1', '2020-02-20 10:30:41');
INSERT INTO `adminlog` VALUES (109, 1, '127.0.0.1', '2020-02-20 10:32:59');
INSERT INTO `adminlog` VALUES (110, 1, '127.0.0.1', '2020-02-20 10:34:28');
INSERT INTO `adminlog` VALUES (111, 1, '127.0.0.1', '2020-02-20 10:40:45');
INSERT INTO `adminlog` VALUES (112, 1, '127.0.0.1', '2020-02-20 12:23:41');
INSERT INTO `adminlog` VALUES (113, 1, '127.0.0.1', '2020-02-20 13:13:02');
INSERT INTO `adminlog` VALUES (114, 1, '127.0.0.1', '2020-02-20 13:13:02');
INSERT INTO `adminlog` VALUES (115, 1, '127.0.0.1', '2020-02-20 13:13:02');
INSERT INTO `adminlog` VALUES (116, 1, '127.0.0.1', '2020-02-20 13:13:02');
INSERT INTO `adminlog` VALUES (117, 1, '127.0.0.1', '2020-02-20 13:13:02');
INSERT INTO `adminlog` VALUES (118, 1, '127.0.0.1', '2020-02-20 13:13:02');
INSERT INTO `adminlog` VALUES (119, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (120, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (121, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (122, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (123, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (124, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (125, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (126, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (127, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (128, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (129, 1, '127.0.0.1', '2020-02-20 13:13:03');
INSERT INTO `adminlog` VALUES (130, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (131, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (132, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (133, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (134, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (135, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (136, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (137, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (138, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (139, 1, '127.0.0.1', '2020-02-20 13:13:04');
INSERT INTO `adminlog` VALUES (140, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (141, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (142, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (143, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (144, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (145, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (146, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (147, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (148, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (149, 1, '127.0.0.1', '2020-02-20 13:13:05');
INSERT INTO `adminlog` VALUES (150, 1, '127.0.0.1', '2020-02-20 14:35:06');
INSERT INTO `adminlog` VALUES (151, 1, '127.0.0.1', '2020-02-24 09:35:59');
INSERT INTO `adminlog` VALUES (152, 1, '127.0.0.1', '2020-02-24 09:42:34');
INSERT INTO `adminlog` VALUES (153, 1, '127.0.0.1', '2020-02-24 16:42:41');
INSERT INTO `adminlog` VALUES (154, 1, '127.0.0.1', '2020-02-24 17:50:52');
INSERT INTO `adminlog` VALUES (155, 1, '127.0.0.1', '2020-02-25 09:24:44');
INSERT INTO `adminlog` VALUES (156, 1, '127.0.0.1', '2020-02-25 12:25:00');
INSERT INTO `adminlog` VALUES (157, 1, '127.0.0.1', '2020-02-27 10:09:41');
INSERT INTO `adminlog` VALUES (158, 1, '127.0.0.1', '2020-03-06 15:38:29');
INSERT INTO `adminlog` VALUES (159, 1, '127.0.0.1', '2020-03-09 17:51:03');
INSERT INTO `adminlog` VALUES (160, 1, '127.0.0.1', '2020-03-25 11:07:45');
INSERT INTO `adminlog` VALUES (161, 1, '172.16.16.47', '2020-03-25 13:54:13');
INSERT INTO `adminlog` VALUES (162, 1, '172.16.16.47', '2020-03-26 13:57:43');

-- ----------------------------
-- Table structure for aikfpt
-- ----------------------------
DROP TABLE IF EXISTS `aikfpt`;
CREATE TABLE `aikfpt`  (
  `restult` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ok` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `error` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `error_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aikfpt
-- ----------------------------
INSERT INTO `aikfpt` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 11:43:27\', \'sumtime\': \'0:00:00.196473\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2020-03-30 11:43:27');
INSERT INTO `aikfpt` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 11:46:49\', \'sumtime\': \'0:00:00.088763\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2020-03-30 11:46:46');
INSERT INTO `aikfpt` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 13:22:20\', \'sumtime\': \'0:00:00.028921\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2020-03-30 13:22:17');
INSERT INTO `aikfpt` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 13:41:44\', \'sumtime\': \'0:00:00.089762\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2020-03-30 13:41:41');
INSERT INTO `aikfpt` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 14:32:00\', \'sumtime\': \'0:00:00.052857\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2020-03-30 14:31:57');
INSERT INTO `aikfpt` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 15:18:32\', \'sumtime\': \'0:00:00.007909\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2020-03-30 15:18:32');
INSERT INTO `aikfpt` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-04-03 22:00:06\', \'sumtime\': \'0:00:00.008280\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2020-04-03 22:00:06');

-- ----------------------------
-- Table structure for aqhy
-- ----------------------------
DROP TABLE IF EXISTS `aqhy`;
CREATE TABLE `aqhy`  (
  `restult` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ok` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `error` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `error_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aqhy
-- ----------------------------
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 11:55:14\', \'sumtime\': \'0:00:00.125677\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2019-11-11 11:55:13');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-14 17:08:04\', \'sumtime\': \'0:00:33.651087\', \'testresult\': \'共 91 条接口用例，通过 64 条，失败 27 条\', \'tonggl\': \'70.33%\'}', '91', '64', '27', '0', '0', '2019-11-14 17:08:04');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-14 17:21:37\', \'sumtime\': \'0:00:00.417178\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', '1', '1', '0', '0', '0', '2019-11-14 17:21:37');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-14 17:26:04\', \'sumtime\': \'0:00:00.580447\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', '1', '1', '0', '0', '0', '2019-11-14 17:26:03');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-14 17:31:13\', \'sumtime\': \'0:00:00.419163\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', '1', '1', '0', '0', '0', '2019-11-14 17:31:13');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-14 17:39:56\', \'sumtime\': \'0:00:00.421641\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', '1', '1', '0', '0', '0', '2019-11-14 17:39:56');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-15 10:34:27\', \'sumtime\': \'0:00:01.655782\', \'testresult\': \'共 2 条接口用例，通过 2 条\', \'tonggl\': \'100.00%\'}', '2', '2', '0', '0', '0', '2019-11-15 10:34:27');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-15 17:59:12\', \'sumtime\': \'0:00:02.069839\', \'testresult\': \'共 14 条接口用例，通过 2 条，失败 2 条，错误 10 条\', \'tonggl\': \'14.29%\'}', '14', '2', '2', '10', '71.43', '2019-11-15 17:59:12');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-15 22:00:01\', \'sumtime\': \'0:00:00.404883\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', '1', '1', '0', '0', '0', '2019-11-15 22:00:01');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 11:00:19\', \'sumtime\': \'0:00:22.125367\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 11:00:19');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 11:01:42\', \'sumtime\': \'0:00:20.901789\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 11:01:42');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 11:04:19\', \'sumtime\': \'0:00:19.419218\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 11:04:19');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 11:38:17\', \'sumtime\': \'0:00:00.266597\', \'testresult\': \'共 1 条接口用例，失败 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '1', '0', '0', '2019-11-18 11:38:17');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 10:57:44\', \'sumtime\': \'0:00:20.739474\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 11:57:44');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 10:57:44\', \'sumtime\': \'0:00:20.739474\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 10:57:44');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 10:57:44\', \'sumtime\': \'0:00:20.739474\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 10:57:44');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 10:57:44\', \'sumtime\': \'0:00:20.739474\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 10:57:44');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 10:57:44\', \'sumtime\': \'0:00:20.739474\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 10:57:44');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 10:57:44\', \'sumtime\': \'0:00:20.739474\', \'testresult\': \'共 34 条接口用例，通过 28 条，失败 6 条\', \'tonggl\': \'82.35%\'}', '34', '28', '6', '0', '0', '2019-11-18 10:57:44');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-19 09:03:25\', \'sumtime\': \'0:00:18.072967\', \'testresult\': \'共 34 条接口用例，通过 27 条，失败 6 条，错误 1 条\', \'tonggl\': \'79.41%\'}', '34', '27', '6', '1', '2.94', '2019-11-19 09:03:24');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-22 22:00:02\', \'sumtime\': \'0:01:16.975602\', \'testresult\': \'共 34 条接口用例，通过 30 条，失败 3 条，错误 1 条\', \'tonggl\': \'88.24%\'}', '34', '30', '3', '1', '2.94', '2019-11-22 22:00:02');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-29 22:00:01\', \'sumtime\': \'0:00:16.866696\', \'testresult\': \'共 34 条接口用例，通过 30 条，失败 3 条，错误 1 条\', \'tonggl\': \'88.24%\'}', '34', '30', '3', '1', '2.94', '2019-11-29 22:00:01');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 22:00:02\', \'sumtime\': \'0:00:10.430527\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2019-12-13 22:00:02');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-20 22:00:02\', \'sumtime\': \'0:00:10.525728\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2019-12-20 22:00:02');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-27 22:00:02\', \'sumtime\': \'0:00:10.245526\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2019-12-27 22:00:02');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-03 22:00:02\', \'sumtime\': \'0:00:10.349715\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-01-03 22:00:02');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-10 22:00:05\', \'sumtime\': \'0:00:10.429352\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-01-10 22:00:04');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-17 22:00:02\', \'sumtime\': \'0:00:10.522393\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-01-17 22:00:02');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-24 22:00:01\', \'sumtime\': \'0:00:10.358369\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-01-24 22:00:01');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-31 22:00:01\', \'sumtime\': \'0:00:10.553291\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-01-31 22:00:01');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-07 22:00:01\', \'sumtime\': \'0:00:10.194711\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-02-07 22:00:01');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-14 22:00:01\', \'sumtime\': \'0:00:10.494050\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-02-14 22:00:01');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-21 22:00:02\', \'sumtime\': \'0:00:10.240378\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-02-21 22:00:02');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-28 22:00:05\', \'sumtime\': \'0:00:11.778276\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-02-28 22:00:04');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-06 22:00:03\', \'sumtime\': \'0:00:11.919578\', \'testresult\': \'共 34 条接口用例，通过 16 条，错误 18 条\', \'tonggl\': \'47.06%\'}', '34', '16', '0', '18', '52.94', '2020-03-06 22:00:03');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-09 16:31:01\', \'sumtime\': \'0:01:18.439238\', \'testresult\': \'共 34 条接口用例，通过 30 条，失败 3 条，错误 1 条\', \'tonggl\': \'88.24%\'}', '34', '30', '3', '1', '2.94', '2020-03-09 16:31:00');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 22:00:04\', \'sumtime\': \'0:00:17.387287\', \'testresult\': \'共 34 条接口用例，通过 30 条，失败 3 条，错误 1 条\', \'tonggl\': \'88.24%\'}', '34', '30', '3', '1', '2.94', '2020-03-27 22:00:04');
INSERT INTO `aqhy` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-04-03 22:00:04\', \'sumtime\': \'0:00:17.189958\', \'testresult\': \'共 34 条接口用例，通过 30 条，失败 3 条，错误 1 条\', \'tonggl\': \'88.24%\'}', '34', '30', '3', '1', '2.94', '2020-04-03 22:00:04');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `url`(`url`) USING BTREE,
  UNIQUE INDEX `name_2`(`name`) USING BTREE,
  UNIQUE INDEX `url_2`(`url`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES (2, '系统管理', '/admin/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (15, '会员列表', '/admin/user/list/<int:page>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (16, '查看会员', '/admin/user/view/<int:id>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (17, '会员删除', '/admin/user/del/<int:id>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (18, '评论列表', '/admin/comment/list/<int:page>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (19, '评论删除', '/admin/comment/del/<int:id>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (22, '操作日志列表', '/admin/oplog/list/<int:page>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (23, '管理员登录日志列表', '/admin/adminloginlog/list/<int:page>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (24, '会员登录日志列表', '/admin/userloginlog/list/<int:page>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (25, '添加权限', '/admin/auth/add/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (26, '编辑权限', '/admin/auth/edit/<int:id>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (27, '权限列表', '/admin/auth/list/<int:page>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (28, '权限删除', '/admin/auth/del/<int:id>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (29, '添加角色', '/admin/role/add/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (30, '角色列表', '/admin/role/list/<int:page>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (31, '角色删除', '/admin/role/del/<int:id>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (32, '编辑角色', '/admin/role/edit/<int:id>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (33, '添加管理员', '/admin/admin/add/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (34, '管理员列表', '/admin/admin/list/<int:page>/', '2019-12-27 14:59:43');
INSERT INTO `auth` VALUES (42, '删除管理员', '/admin/admin/del/<int:id>/', '2019-12-27 22:14:17');
INSERT INTO `auth` VALUES (43, '管理员状态', '/admin/admin/state/<int:id><int:state>/', '2020-01-06 14:07:12');
INSERT INTO `auth` VALUES (44, '项目列表', '/admin/project/list/<int:page>/', '2020-02-24 16:27:44');

-- ----------------------------
-- Table structure for dsjsc
-- ----------------------------
DROP TABLE IF EXISTS `dsjsc`;
CREATE TABLE `dsjsc`  (
  `restult` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sum` int(255) NULL DEFAULT NULL,
  `ok` int(255) NULL DEFAULT NULL,
  `fail` int(255) NULL DEFAULT NULL,
  `error` int(255) NULL DEFAULT NULL,
  `error_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dsjsc
-- ----------------------------
INSERT INTO `dsjsc` VALUES ('0', 105, 104, 0, 1, '99', '2019-11-08 17:11:04');
INSERT INTO `dsjsc` VALUES ('0', 105, 104, 0, 1, '99', '2019-11-08 17:11:16');
INSERT INTO `dsjsc` VALUES ('0', 105, 104, 0, 1, '99', '2019-11-08 17:11:19');
INSERT INTO `dsjsc` VALUES ('0', 105, 104, 0, 1, '99', '2019-11-08 17:11:22');
INSERT INTO `dsjsc` VALUES ('0', 105, 104, 0, 1, '99', '2019-11-08 17:11:25');
INSERT INTO `dsjsc` VALUES ('0', 105, 1, 0, 1, '99', '2019-11-08 17:11:28');
INSERT INTO `dsjsc` VALUES ('0', 105, 12, 0, 1, '99', '2019-11-08 17:11:39');
INSERT INTO `dsjsc` VALUES ('0', 105, 123, 0, 1, '99', '2019-11-08 17:11:41');
INSERT INTO `dsjsc` VALUES ('0', 105, 23, 0, 1, '99', '2019-11-08 17:11:48');
INSERT INTO `dsjsc` VALUES ('0', 105, 21, 0, 1, '99', '2019-11-08 17:12:12');
INSERT INTO `dsjsc` VALUES ('0', 105, 11, 0, 1, '99', '2019-11-08 17:12:15');
INSERT INTO `dsjsc` VALUES ('0', 105, 22, 0, 1, '99', '2019-11-08 17:12:17');
INSERT INTO `dsjsc` VALUES ('0', 105, 33, 0, 1, '99', '2019-11-08 17:12:19');
INSERT INTO `dsjsc` VALUES ('0', 105, 44, 0, 1, '99', '2019-11-08 17:12:22');
INSERT INTO `dsjsc` VALUES ('0', 105, 54, 0, 1, '99', '2019-11-08 17:12:24');
INSERT INTO `dsjsc` VALUES ('0', 105, 104, 0, 1, '99', '2019-11-08 17:13:03');
INSERT INTO `dsjsc` VALUES ('0', 1, 0, 0, 1, '100', '2019-11-11 11:52:16');
INSERT INTO `dsjsc` VALUES ('0', 1, 0, 0, 1, '100', '2019-11-11 11:55:13');
INSERT INTO `dsjsc` VALUES ('0', 1, 0, 0, 1, '100', '2019-11-11 11:55:13');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 11:55:14\', \'sumtime\': \'0:00:00.125677\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100%', '2019-11-11 11:55:13');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 12:02:54\', \'sumtime\': \'0:00:00.104720\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100', '2019-11-11 12:02:53');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 12:06:38\', \'sumtime\': \'0:00:00.098804\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100', '2019-11-11 12:06:37');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 12:26:33\', \'sumtime\': \'0:00:00.166554\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100', '2019-11-11 12:26:33');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 12:29:05\', \'sumtime\': \'0:00:00.112656\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100', '2019-11-11 12:29:04');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 12:37:48\', \'sumtime\': \'0:00:00.134900\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100', '2019-11-11 12:37:47');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 13:36:26\', \'sumtime\': \'0:00:00.152594\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 105, 0, 1, '100', '2019-11-11 13:36:25');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 13:37:14\', \'sumtime\': \'0:00:00.098645\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100%', '2019-11-11 13:37:14');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 13:46:50\', \'sumtime\': \'0:00:00.148596\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100%', '2019-11-11 13:46:50');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 11:55:14\', \'sumtime\': \'0:00:00.125677\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100', '2019-11-11 11:55:13');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 14:00:20\', \'sumtime\': \'0:00:00.116686\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100%', '2019-11-11 14:00:20');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 14:04:08\', \'sumtime\': \'0:00:00.098700\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100%', '2019-11-11 14:04:08');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 14:05:08\', \'sumtime\': \'0:00:00.104685\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100%', '2019-11-11 14:05:07');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 14:06:43\', \'sumtime\': \'0:00:00.100731\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100%', '2019-11-11 14:06:42');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 14:08:24\', \'sumtime\': \'0:00:01.027663\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0.95%', '2019-11-11 14:08:24');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 14:11:24\', \'sumtime\': \'0:00:01.050363\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '6%', '2019-11-11 14:11:24');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 14:20:00\', \'sumtime\': \'0:00:00.965624\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '4%', '2019-11-11 14:19:59');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 14:22:05\', \'sumtime\': \'0:00:01.012315\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '10%', '2019-11-11 14:22:04');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 15:41:33\', \'sumtime\': \'0:00:00.087765\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00%', '2019-11-11 15:41:33');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 15:57:57\', \'sumtime\': \'0:00:00.645967\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00%', '2019-11-11 15:57:56');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 15:59:06\', \'sumtime\': \'0:00:00.123710\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00%', '2019-11-11 15:59:05');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:01:21\', \'sumtime\': \'0:00:00.153584\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00%', '2019-11-11 16:01:19');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:03:10\', \'sumtime\': \'0:00:00.138526\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '.2f100.0', '2019-11-11 16:03:09');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:03:47\', \'sumtime\': \'0:00:00.123855\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00s', '2019-11-11 16:03:46');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:07:31\', \'sumtime\': \'0:00:00.120766\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00%', '2019-11-11 16:07:30');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:08:40\', \'sumtime\': \'0:00:00.161901\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.0', '2019-11-11 16:08:39');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:12:26\', \'sumtime\': \'0:00:00.078766\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00', '2019-11-11 16:12:25');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:15:54\', \'sumtime\': \'0:00:00.124668\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00', '2019-11-11 16:15:54');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:16:58\', \'sumtime\': \'0:00:00.134640\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00', '2019-11-11 16:16:57');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:17:33\', \'sumtime\': \'0:00:00.086394\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00', '2019-11-11 16:17:33');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:18:14\', \'sumtime\': \'0:00:00.090679\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', 1, 0, 0, 1, '100.00', '2019-11-11 16:18:13');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:18:47\', \'sumtime\': \'0:00:00.915405\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 16:18:47');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:19:25\', \'sumtime\': \'0:00:00.916454\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 16:19:25');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:19:50\', \'sumtime\': \'0:00:00.991552\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 16:19:49');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:21:06\', \'sumtime\': \'0:00:00.944521\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 16:21:06');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:21:46\', \'sumtime\': \'0:00:00.930129\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 16:21:45');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:22:35\', \'sumtime\': \'0:00:00.925298\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 16:22:34');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:47:07\', \'sumtime\': \'0:00:00.862329\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 16:47:07');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 16:49:15\', \'sumtime\': \'0:00:00.862663\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 16:49:15');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 17:13:10\', \'sumtime\': \'0:00:00.864124\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 17:13:10');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 17:15:00\', \'sumtime\': \'0:00:00.998434\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', 1, 1, 0, 0, '0', '2019-11-11 17:15:00');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 10:05:10\', \'sumtime\': \'0:00:00.781907\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', 2, 0, 0, 2, '100.00', '2019-11-12 10:05:09');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 14:10:18\', \'sumtime\': \'0:00:03.008107\', \'testresult\': \'共 3 条接口用例，通过 3 条\', \'tonggl\': \'100.00%\'}', 3, 3, 0, 0, '0', '2019-11-12 14:10:18');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 14:20:43\', \'sumtime\': \'0:00:03.015211\', \'testresult\': \'共 3 条接口用例，通过 3 条\', \'tonggl\': \'100.00%\'}', 3, 3, 0, 0, '0', '2019-11-12 14:20:43');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 15:39:18\', \'sumtime\': \'0:00:09.513153\', \'testresult\': \'共 11 条接口用例，通过 9 条，失败 2 条\', \'tonggl\': \'81.82%\'}', 11, 9, 2, 0, '0', '2019-11-12 15:39:18');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 15:45:14\', \'sumtime\': \'0:00:11.233508\', \'testresult\': \'共 11 条接口用例，通过 9 条，失败 2 条\', \'tonggl\': \'81.82%\'}', 11, 9, 2, 0, '0', '2019-11-12 15:45:13');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 15:48:55\', \'sumtime\': \'0:00:09.496530\', \'testresult\': \'共 11 条接口用例，通过 9 条，失败 2 条\', \'tonggl\': \'81.82%\'}', 11, 9, 2, 0, '0', '2019-11-12 15:48:54');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 16:28:07\', \'sumtime\': \'0:00:04.687258\', \'testresult\': \'共 11 条接口用例，通过 9 条，失败 2 条\', \'tonggl\': \'81.82%\'}', 11, 9, 2, 0, '0', '2019-11-12 16:28:06');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 16:30:40\', \'sumtime\': \'0:00:04.736888\', \'testresult\': \'共 11 条接口用例，通过 9 条，失败 2 条\', \'tonggl\': \'81.82%\'}', 11, 9, 2, 0, '0', '2019-11-12 16:30:40');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 16:42:23\', \'sumtime\': \'0:00:04.819258\', \'testresult\': \'共 11 条接口用例，通过 9 条，失败 2 条\', \'tonggl\': \'81.82%\'}', 11, 9, 2, 0, '0', '2019-11-12 16:42:22');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 16:57:53\', \'sumtime\': \'0:00:04.807523\', \'testresult\': \'共 11 条接口用例，通过 9 条，失败 2 条\', \'tonggl\': \'81.82%\'}', 11, 9, 2, 0, '0', '2019-11-12 16:57:52');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-12 17:27:31\', \'sumtime\': \'0:00:08.426528\', \'testresult\': \'共 17 条接口用例，通过 15 条，失败 2 条\', \'tonggl\': \'88.24%\'}', 17, 15, 2, 0, '0', '2019-11-12 17:27:30');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-14 15:07:15\', \'sumtime\': \'0:00:32.441958\', \'testresult\': \'共 91 条接口用例，通过 64 条，失败 27 条\', \'tonggl\': \'70.33%\'}', 91, 64, 27, 0, '0', '2019-11-14 15:07:15');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-14 15:20:20\', \'sumtime\': \'0:00:32.131592\', \'testresult\': \'共 91 条接口用例，通过 64 条，失败 27 条\', \'tonggl\': \'70.33%\'}', 91, 64, 27, 0, '0', '2019-11-14 15:20:19');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-15 22:00:02\', \'sumtime\': \'0:00:32.390895\', \'testresult\': \'共 91 条接口用例，通过 64 条，失败 27 条\', \'tonggl\': \'70.33%\'}', 91, 64, 27, 0, '0', '2019-11-15 22:00:01');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-20 09:56:12\', \'sumtime\': \'0:00:51.191706\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2019-11-20 09:56:11');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-22 22:00:02\', \'sumtime\': \'0:00:36.724429\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2019-11-22 22:00:02');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-29 09:29:50\', \'sumtime\': \'0:00:43.249124\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2019-11-29 09:29:49');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-29 22:00:02\', \'sumtime\': \'0:00:37.771357\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2019-11-29 22:00:01');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 22:00:03\', \'sumtime\': \'0:00:34.988329\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2019-12-13 22:00:02');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-20 22:00:02\', \'sumtime\': \'0:00:34.888909\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2019-12-20 22:00:02');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-27 22:00:02\', \'sumtime\': \'0:00:34.777735\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2019-12-27 22:00:02');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-03 22:00:03\', \'sumtime\': \'0:00:35.930981\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-01-03 22:00:03');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-10 22:00:05\', \'sumtime\': \'0:00:35.526115\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-01-10 22:00:04');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-17 22:00:03\', \'sumtime\': \'0:00:37.082184\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-01-17 22:00:02');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-24 22:00:01\', \'sumtime\': \'0:00:36.336076\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-01-24 22:00:01');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-31 22:00:01\', \'sumtime\': \'0:00:36.715219\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-01-31 22:00:01');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-07 22:00:01\', \'sumtime\': \'0:00:38.241480\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-02-07 22:00:01');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-14 22:00:01\', \'sumtime\': \'0:00:39.211346\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-02-14 22:00:01');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-21 22:00:02\', \'sumtime\': \'0:00:38.872324\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-02-21 22:00:02');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-28 22:00:05\', \'sumtime\': \'0:00:59.836257\', \'testresult\': \'共 91 条接口用例，通过 74 条，失败 17 条\', \'tonggl\': \'81.32%\'}', 91, 74, 17, 0, '0', '2020-02-28 22:00:04');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-06 22:11:41\', \'sumtime\': \'0:01:01.228647\', \'testresult\': \'共 97 条接口用例，通过 81 条，失败 16 条\', \'tonggl\': \'83.51%\'}', 97, 81, 16, 0, '0', '2020-03-06 22:11:41');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-09 14:02:54\', \'sumtime\': \'0:01:09.995828\', \'testresult\': \'共 109 条接口用例，通过 92 条，失败 17 条\', \'tonggl\': \'84.40%\'}', 109, 92, 17, 0, '0', '2020-03-09 14:02:53');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-09 14:05:50\', \'sumtime\': \'0:01:10.568924\', \'testresult\': \'共 109 条接口用例，通过 93 条，失败 16 条\', \'tonggl\': \'85.32%\'}', 109, 93, 16, 0, '0', '2020-03-09 14:05:50');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 22:00:04\', \'sumtime\': \'0:00:59.575363\', \'testresult\': \'共 109 条接口用例，通过 92 条，失败 17 条\', \'tonggl\': \'84.40%\'}', 109, 92, 17, 0, '0', '2020-03-27 22:00:03');
INSERT INTO `dsjsc` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-04-03 22:00:04\', \'sumtime\': \'0:00:49.920208\', \'testresult\': \'共 109 条接口用例，通过 92 条，失败 17 条\', \'tonggl\': \'84.40%\'}', 109, 92, 17, 0, '0', '2020-04-03 22:00:03');

-- ----------------------------
-- Table structure for environment
-- ----------------------------
DROP TABLE IF EXISTS `environment`;
CREATE TABLE `environment`  (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `smtp` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `project_url` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `dbconfig` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  `status` int(255) NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of environment
-- ----------------------------
INSERT INTO `environment` VALUES (0, '智能客服', 'V0.3.5', '{\'mail_host\':\'smtp.citydo.com.cn\',\'mail_user\':\'zentao@citydo.com.cn\',\'mail_pass\':\'Zz123456\',\'From\':\'zhanggh@citydo.com.cn\',\'To\':\'Everboby\',\'subject\':\'AI虚拟机器人接口自动化测试报告【V0.3.5】\',\'MIMEText\':\'这是python接口自动框架邮件模块发送的接口自动化测试报告，详情见附件或查看在线报告。\\n测试报告仅体现某接口请求以及参数值验证情况！\',}', 'https://testznkf.citydo.com.cn', '{\'host\':\'rm-bp153srx1gt80tl1x2o.mysql.rds.aliyuncs.com\',\'user\':\'sunbin\',\'password\':\'Sunbin@123\',\'port\':3306,\'database\':\'test_znkf\'}', 0, '2020-03-23 19:02:34', 0, '1');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `reason` varchar(600) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE,
  INDEX `ix_oplog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oplog
-- ----------------------------
INSERT INTO `oplog` VALUES (1, 1, '127.0.0.1', '退出系统', '2020-01-08 10:12:03');
INSERT INTO `oplog` VALUES (2, 1, '127.0.0.1', '编辑角色3', '2020-01-08 10:26:34');
INSERT INTO `oplog` VALUES (3, 1, '127.0.0.1', '退出系统', '2020-01-08 17:02:08');
INSERT INTO `oplog` VALUES (4, 18, '127.0.0.1', '退出系统', '2020-01-08 17:03:07');
INSERT INTO `oplog` VALUES (5, 18, '127.0.0.1', '退出系统', '2020-01-08 17:04:45');
INSERT INTO `oplog` VALUES (6, 1, '127.0.0.1', '退出系统', '2020-01-09 14:05:33');
INSERT INTO `oplog` VALUES (7, 1, '127.0.0.1', '退出系统', '2020-01-09 14:44:03');
INSERT INTO `oplog` VALUES (8, 1, '127.0.0.1', '退出系统', '2020-02-17 19:59:43');
INSERT INTO `oplog` VALUES (9, 1, '127.0.0.1', '退出系统', '2020-02-17 20:09:25');
INSERT INTO `oplog` VALUES (10, 1, '127.0.0.1', '退出系统', '2020-02-18 09:28:50');
INSERT INTO `oplog` VALUES (11, 1, '127.0.0.1', '停用角色18', '2020-02-18 11:21:17');
INSERT INTO `oplog` VALUES (12, 1, '127.0.0.1', '启用角色18', '2020-02-18 11:21:18');
INSERT INTO `oplog` VALUES (13, 1, '127.0.0.1', '停用角色18', '2020-02-18 11:25:12');
INSERT INTO `oplog` VALUES (14, 1, '127.0.0.1', '启用角色18', '2020-02-18 11:25:15');
INSERT INTO `oplog` VALUES (15, 1, '127.0.0.1', '停用角色18', '2020-02-18 11:26:20');
INSERT INTO `oplog` VALUES (16, 1, '127.0.0.1', '启用角色18', '2020-02-18 11:26:25');
INSERT INTO `oplog` VALUES (17, 1, '127.0.0.1', '停用角色18', '2020-02-18 11:26:35');
INSERT INTO `oplog` VALUES (18, 1, '127.0.0.1', '启用角色18', '2020-02-18 11:26:43');
INSERT INTO `oplog` VALUES (19, 1, '127.0.0.1', '停用角色18', '2020-02-18 11:27:36');
INSERT INTO `oplog` VALUES (20, 1, '127.0.0.1', '启用角色18', '2020-02-18 11:27:39');
INSERT INTO `oplog` VALUES (21, 1, '127.0.0.1', '停用角色18', '2020-02-20 10:27:37');
INSERT INTO `oplog` VALUES (22, 1, '127.0.0.1', '启用角色18', '2020-02-20 10:27:51');
INSERT INTO `oplog` VALUES (23, 1, '127.0.0.1', '停用角色18', '2020-02-20 10:27:55');
INSERT INTO `oplog` VALUES (24, 1, '127.0.0.1', '启用角色18', '2020-02-20 10:27:57');
INSERT INTO `oplog` VALUES (25, 1, '127.0.0.1', '退出系统', '2020-02-20 10:29:19');
INSERT INTO `oplog` VALUES (26, 1, '127.0.0.1', '退出系统', '2020-02-20 10:29:48');
INSERT INTO `oplog` VALUES (27, 1, '127.0.0.1', '退出系统', '2020-02-20 10:30:34');
INSERT INTO `oplog` VALUES (28, 1, '127.0.0.1', '退出系统', '2020-02-20 10:32:53');
INSERT INTO `oplog` VALUES (29, 1, '127.0.0.1', '退出系统', '2020-02-20 10:34:22');
INSERT INTO `oplog` VALUES (30, 1, '127.0.0.1', '退出系统', '2020-02-20 10:40:39');
INSERT INTO `oplog` VALUES (31, 1, '127.0.0.1', '停用角色18', '2020-02-20 10:41:50');
INSERT INTO `oplog` VALUES (32, 1, '127.0.0.1', '退出系统', '2020-02-20 12:23:36');
INSERT INTO `oplog` VALUES (33, 1, '127.0.0.1', '启用角色18', '2020-02-20 14:49:01');
INSERT INTO `oplog` VALUES (34, 1, '127.0.0.1', '添加管理员root1', '2020-02-20 14:58:44');
INSERT INTO `oplog` VALUES (35, 1, '127.0.0.1', '删除管理员19', '2020-02-20 15:02:18');
INSERT INTO `oplog` VALUES (36, 1, '127.0.0.1', '退出系统', '2020-02-24 09:36:04');
INSERT INTO `oplog` VALUES (37, 1, '127.0.0.1', '停用角色18', '2020-02-24 09:44:31');
INSERT INTO `oplog` VALUES (38, 1, '127.0.0.1', '启用角色18', '2020-02-24 09:44:42');
INSERT INTO `oplog` VALUES (39, 1, '127.0.0.1', '停用角色18', '2020-02-24 09:44:51');
INSERT INTO `oplog` VALUES (40, 1, '127.0.0.1', '启用角色18', '2020-02-24 09:44:54');
INSERT INTO `oplog` VALUES (41, 1, '127.0.0.1', '添加权限项目列表', '2020-02-24 16:27:44');
INSERT INTO `oplog` VALUES (42, 1, '127.0.0.1', '退出系统', '2020-02-24 16:42:37');
INSERT INTO `oplog` VALUES (43, 1, '127.0.0.1', '退出系统', '2020-02-25 09:24:39');
INSERT INTO `oplog` VALUES (44, 1, '127.0.0.1', '停用角色18', '2020-03-06 15:48:17');
INSERT INTO `oplog` VALUES (45, 1, '127.0.0.1', '启用角色18', '2020-03-06 15:48:19');
INSERT INTO `oplog` VALUES (46, 1, '127.0.0.1', '停用角色18', '2020-03-06 15:50:19');
INSERT INTO `oplog` VALUES (47, 1, '127.0.0.1', '启用角色18', '2020-03-06 15:50:21');
INSERT INTO `oplog` VALUES (48, 1, '127.0.0.1', '停用角色18', '2020-03-06 15:51:29');
INSERT INTO `oplog` VALUES (49, 1, '127.0.0.1', '启用角色18', '2020-03-06 15:51:32');
INSERT INTO `oplog` VALUES (50, 1, '127.0.0.1', '添加项目：系统管理', '2020-03-23 19:00:37');
INSERT INTO `oplog` VALUES (51, 1, '127.0.0.1', '添加项目：系统管理2', '2020-03-23 19:00:47');
INSERT INTO `oplog` VALUES (52, 1, '127.0.0.1', '添加环境：1', '2020-03-23 19:02:34');
INSERT INTO `oplog` VALUES (53, 1, '127.0.0.1', '停用环境0', '2020-03-24 10:28:36');
INSERT INTO `oplog` VALUES (54, 1, '127.0.0.1', '启用环境0', '2020-03-24 10:28:40');
INSERT INTO `oplog` VALUES (55, 1, '127.0.0.1', '停用环境0', '2020-03-24 10:29:11');
INSERT INTO `oplog` VALUES (56, 1, '127.0.0.1', '启用环境0', '2020-03-24 10:29:13');
INSERT INTO `oplog` VALUES (57, 1, '127.0.0.1', '停用环境0', '2020-03-24 10:32:15');
INSERT INTO `oplog` VALUES (58, 1, '127.0.0.1', '启用环境0', '2020-03-24 10:33:00');
INSERT INTO `oplog` VALUES (59, 1, '127.0.0.1', '停用环境0', '2020-03-24 10:35:53');
INSERT INTO `oplog` VALUES (60, 1, '127.0.0.1', '启用环境0', '2020-03-24 10:35:56');
INSERT INTO `oplog` VALUES (61, 1, '127.0.0.1', '停用环境0', '2020-03-24 10:36:52');
INSERT INTO `oplog` VALUES (62, 1, '127.0.0.1', '启用环境0', '2020-03-24 10:36:54');
INSERT INTO `oplog` VALUES (63, 1, '127.0.0.1', '停用环境0', '2020-03-24 10:36:56');
INSERT INTO `oplog` VALUES (64, 1, '127.0.0.1', '启用环境0', '2020-03-24 10:36:58');
INSERT INTO `oplog` VALUES (65, 1, '127.0.0.1', '停用环境0', '2020-03-24 10:38:19');
INSERT INTO `oplog` VALUES (66, 1, '127.0.0.1', '启用环境0', '2020-03-24 10:38:21');
INSERT INTO `oplog` VALUES (67, 1, '127.0.0.1', '添加用例：1', '2020-03-24 10:58:56');
INSERT INTO `oplog` VALUES (68, 1, '127.0.0.1', '停用项目1', '2020-03-24 10:59:40');
INSERT INTO `oplog` VALUES (69, 1, '127.0.0.1', '启用项目1', '2020-03-24 11:06:22');
INSERT INTO `oplog` VALUES (70, 1, '127.0.0.1', '添加用例：12', '2020-03-24 11:19:54');
INSERT INTO `oplog` VALUES (71, 1, '127.0.0.1', '添加用例：213', '2020-03-24 11:28:59');
INSERT INTO `oplog` VALUES (72, 1, '172.16.16.47', '停用项目2', '2020-03-26 13:54:48');
INSERT INTO `oplog` VALUES (73, 1, '172.16.16.47', '停用项目1', '2020-03-26 13:54:49');
INSERT INTO `oplog` VALUES (74, 1, '172.16.16.47', '添加项目：智能客服-测试版', '2020-03-26 13:56:18');
INSERT INTO `oplog` VALUES (75, 1, '172.16.16.47', '退出系统', '2020-03-26 13:57:34');
INSERT INTO `oplog` VALUES (76, 1, '172.16.16.47', '添加用例：接口登录-成功', '2020-03-26 14:00:11');
INSERT INTO `oplog` VALUES (77, 1, '172.16.16.47', '添加用例：登录接口-成功', '2020-03-26 14:42:44');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `version` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `models` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `leader` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  `case_num` int(11) NULL DEFAULT NULL,
  `execute_count` int(11) NULL DEFAULT NULL,
  `case_pass` int(11) NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `version`(`version`) USING BTREE,
  UNIQUE INDEX `name_2`(`name`) USING BTREE,
  UNIQUE INDEX `version_2`(`version`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `leader`(`leader`) USING BTREE,
  CONSTRAINT `project_ibfk_2` FOREIGN KEY (`leader`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES (3, '智能客服-测试版', 'V0.3.5', '智能客服', 0, 6, '2020-03-26 13:56:18', 0, 0, 0, 0, 'test');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `auths` varchar(600) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `name_2`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', '2,15,16,17,18,19,22,23,24,25,26,27,28,29,30,31,32,33,34,42,43,44', '2019-12-11 14:08:56');
INSERT INTO `role` VALUES (3, '系统管理', '2,15,16,17,18,19,22,23,24,25,26,27,28,29,30,31,32,33,34,42,43,44', '2020-01-07 17:28:34');

-- ----------------------------
-- Table structure for sjsb
-- ----------------------------
DROP TABLE IF EXISTS `sjsb`;
CREATE TABLE `sjsb`  (
  `restult` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sum` int(255) NULL DEFAULT NULL,
  `ok` int(255) NULL DEFAULT NULL,
  `fail` int(255) NULL DEFAULT NULL,
  `error` int(255) NULL DEFAULT NULL,
  `error_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sjsb
-- ----------------------------
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-23 16:57:16\', \'sumtime\': \'0:00:07.322569\', \'testresult\': \'共 24 条接口用例，通过 19 条，失败 3 条，错误 2 条\', \'tonggl\': \'79.17%\'}', 24, 19, 3, 2, '8.33', '2019-12-23 16:57:16');
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-23 17:02:00\', \'sumtime\': \'0:00:07.009096\', \'testresult\': \'共 24 条接口用例，通过 18 条，失败 4 条，错误 2 条\', \'tonggl\': \'75.00%\'}', 24, 18, 4, 2, '8.33', '2019-12-23 17:02:00');
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-25 09:35:09\', \'sumtime\': \'0:00:14.257882\', \'testresult\': \'共 49 条接口用例，通过 28 条，失败 18 条，错误 3 条\', \'tonggl\': \'57.14%\'}', 49, 28, 18, 3, '6.12', '2019-12-25 09:35:09');
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-27 22:00:24\', \'sumtime\': \'0:00:07.700529\', \'testresult\': \'共 24 条接口用例，通过 18 条，失败 4 条，错误 2 条\', \'tonggl\': \'75.00%\'}', 24, 18, 4, 2, '8.33', '2019-12-27 22:00:24');
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-11 18:48:40\', \'sumtime\': \'0:01:04.186026\', \'testresult\': \'共 108 条接口用例，通过 65 条，失败 38 条，错误 5 条\', \'tonggl\': \'60.19%\'}', 108, 65, 38, 5, '4.63', '2020-03-11 18:48:40');
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-11 18:53:15\', \'sumtime\': \'0:01:01.030163\', \'testresult\': \'共 108 条接口用例，通过 66 条，失败 37 条，错误 5 条\', \'tonggl\': \'61.11%\'}', 108, 66, 37, 5, '4.63', '2020-03-11 18:53:14');
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-11 18:57:08\', \'sumtime\': \'0:01:01.108511\', \'testresult\': \'共 108 条接口用例，通过 66 条，失败 37 条，错误 5 条\', \'tonggl\': \'61.11%\'}', 108, 66, 37, 5, '4.63', '2020-03-11 18:57:07');
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 22:00:04\', \'sumtime\': \'0:01:05.006150\', \'testresult\': \'共 108 条接口用例，通过 66 条，失败 37 条，错误 5 条\', \'tonggl\': \'61.11%\'}', 108, 66, 37, 5, '4.63', '2020-03-27 22:00:03');
INSERT INTO `sjsb` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-04-03 22:00:04\', \'sumtime\': \'0:01:08.551906\', \'testresult\': \'共 108 条接口用例，通过 66 条，失败 37 条，错误 5 条\', \'tonggl\': \'61.11%\'}', 108, 66, 37, 5, '4.63', '2020-04-03 22:00:04');

-- ----------------------------
-- Table structure for testcase
-- ----------------------------
DROP TABLE IF EXISTS `testcase`;
CREATE TABLE `testcase`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cases_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `url` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `data` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sql` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `actually` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sql_result` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `result` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `msg` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `version` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `models` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `case_leader` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `Environment` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `pass_num` int(11) NULL DEFAULT NULL,
  `fail_num` int(11) NULL DEFAULT NULL,
  `execute_count` int(11) NULL DEFAULT NULL,
  `case_pass` float NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `cases_name`(`cases_name`) USING BTREE,
  INDEX `case_leader`(`case_leader`) USING BTREE,
  CONSTRAINT `testcase_ibfk_1` FOREIGN KEY (`case_leader`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of testcase
-- ----------------------------
INSERT INTO `testcase` VALUES (10, '登录接口-成功', 'POST1', '/v1/staff/login', '{\"username\":\"emhhbmcwMDE=\",\"password\":\"MTIzNDU2\",\"forceFlag\":\"true\"}', '{}', 'ok', 'ok', '', 'pass', '', 'V0.3.5', '智能客服-测试版', 'admin', 1, '2020-03-26 14:42:44', '2020-03-26 14:42:44', '智能客服', 0, 0, 0, 0, 0, '1');
INSERT INTO `testcase` VALUES (11, '在线-事务小结-添加事务小结-成功', 'POST', '/v1/tenants/_1NTMWLA/addStaffSummaryAfterwards', '{ \"staffId\":\"s_819aee8ed8554b9f82e8d6302c8d2411\", \"keywords\":\"测试\",\"afterEvent\":\"这个是什么鬼\"}', '{}', 'ok', 'ok', '', 'pass', '{\'baseSuccess\': True, \'httpStatusCode\': 0, \'success\': True}', 'V0.3.5', '智能客服-测试版', 'admin', 1, '2020-03-26 14:42:44', '2020-03-26 14:42:44', '智能客服', 0, 0, 0, 0, 0, '1');

-- ----------------------------
-- Table structure for userlog
-- ----------------------------
DROP TABLE IF EXISTS `userlog`;
CREATE TABLE `userlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `face` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE,
  UNIQUE INDEX `face`(`face`) USING BTREE,
  UNIQUE INDEX `uuid`(`uuid`) USING BTREE,
  UNIQUE INDEX `name_2`(`name`) USING BTREE,
  UNIQUE INDEX `email_2`(`email`) USING BTREE,
  UNIQUE INDEX `phone_2`(`phone`) USING BTREE,
  UNIQUE INDEX `face_2`(`face`) USING BTREE,
  UNIQUE INDEX `uuid_2`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '逗起我', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user01.com', '12800128001', '个人简介', '01.jpg', '2018-01-23 13:01:35', 'd4d9772d0cb84f6b911a50670f55f395');
INSERT INTO `users` VALUES (2, '繁体', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user02.com', '12800128002', '个人简介', '02.jpg', '2019-04-01 13:01:45', '1fbd3079f1fb44afa7ddd9d212798d18');
INSERT INTO `users` VALUES (3, '立体', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user03.com', '12800128003', '个人简介', '03.jpg', '2019-01-06 13:01:56', '3f7f53f88d894f2cad96e8af4662322d');
INSERT INTO `users` VALUES (4, '突然变', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user04.com', '12800128004', '个人简介', '04.jpg', '2019-02-23 13:02:02', '256974f28e7a43809da96a716957921d');
INSERT INTO `users` VALUES (5, '刮胡刀', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user05.com', '12800128005', '个人简介', '05.jpg', '2018-03-05 13:02:07', '294a495e56474c1ea13962f602aed98d');
INSERT INTO `users` VALUES (6, '开机号', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user06.com', '12800128006', '个人简介', '06.jpg', '2019-05-07 13:11:29', 'd4b67132023b4f3c903c8e3e2b8e84e6');
INSERT INTO `users` VALUES (7, '萨达', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user07.com', '12800128007', '个人简介', '07.jpg', '2019-05-13 13:11:34', '7a3956518f034920a312877899afae0e');
INSERT INTO `users` VALUES (8, '认为他', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user08.com', '12800128008', '个人简介', '08.jpg', '2019-05-15 13:11:39', '1c5e5f7a4e564cffafd827c96e05bc2d');
INSERT INTO `users` VALUES (9, '话筒', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user09.com', '12800128009', '个人简介', '09.jpg', '2019-05-15 13:11:48', '1dd3276fdc8440ff92a537a00c13d07a');
INSERT INTO `users` VALUES (10, '机柜号', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user10.com', '12800128010', '个人简介', '10.jpg', '2019-05-15 13:11:42', 'b4fb51f547b8490188c5a889e26bbb06');
INSERT INTO `users` VALUES (11, '珀尔', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user11.com', '12800128011', '个人简介', '11.jpg', '2019-04-29 13:14:45', '94150271639b4e04855c365691cf3a47');
INSERT INTO `users` VALUES (12, '条纹', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user12.com', '12800128012', '个人简介', '12.jpg', '2019-03-30 13:14:49', '137b329d6e874e93b74082b2c133fad0');
INSERT INTO `users` VALUES (13, '与虎添翼', 'pbkdf2:sha256:50000$56hTmVhd$fa3c7d54ead0495e344f', 'user@user13.com', '12800128013', '个人简介', '13.jpg', '2019-02-23 13:14:55', 'c116ef9e419c447fa06991237f4ece87');
INSERT INTO `users` VALUES (62, 'zgh', 'pbkdf2:sha256:50000$H276zNWV$83b26c3eae6838d4c9bfe930d24861408cbfc8ea83efc24c300ffc091fa1c6cc', '111@qq.com', '13111111111', '十年窗下无人问，一举成名天下知，历史悠悠亘古变，独依红颜梦凡尘。', '14.jpg', '2019-05-28 11:23:50', '067dc25c4f584699a23d00df3230e141');
INSERT INTO `users` VALUES (63, 'niuniu', 'pbkdf2:sha256:50000$Ef74s8BY$e5664d68ff22cada62d72dbf942efde88789787484b168ce829a744aca4d8f19', '2@qq.com', '13222222222', '666666', '201905281740581fd2ab9a9e834790827e3ebce18210d512.jpg', '2019-05-28 17:40:31', 'fbf8427e3ab1464ab264b8922a259ae8');

-- ----------------------------
-- Table structure for xycp
-- ----------------------------
DROP TABLE IF EXISTS `xycp`;
CREATE TABLE `xycp`  (
  `restult` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ok` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `error` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `error_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xycp
-- ----------------------------
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 11:09:29\', \'sumtime\': \'0:00:37.150663\', \'testresult\': \'共 70 条接口用例，通过 37 条，失败 22 条，错误 11 条\', \'tonggl\': \'52.86%\'}', '70', '37', '22', '11', '15.71', '2019-12-13 11:09:29');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 11:17:09\', \'sumtime\': \'0:00:32.228835\', \'testresult\': \'共 70 条接口用例，通过 32 条，失败 27 条，错误 11 条\', \'tonggl\': \'45.71%\'}', '70', '32', '27', '11', '15.71', '2019-12-13 11:17:09');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 12:53:34\', \'sumtime\': \'0:00:43.166454\', \'testresult\': \'共 70 条接口用例，通过 44 条，失败 25 条，错误 1 条\', \'tonggl\': \'62.86%\'}', '70', '44', '25', '1', '1.43', '2019-12-13 12:53:33');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 13:10:07\', \'sumtime\': \'0:00:00.955444\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', '1', '1', '0', '0', '0', '2019-12-13 13:10:07');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 15:48:36\', \'sumtime\': \'0:00:27.433615\', \'testresult\': \'共 71 条接口用例，通过 57 条，失败 14 条\', \'tonggl\': \'80.28%\'}', '71', '57', '14', '0', '0', '2019-12-13 15:48:35');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 15:59:13\', \'sumtime\': \'0:00:27.691967\', \'testresult\': \'共 71 条接口用例，通过 59 条，失败 12 条\', \'tonggl\': \'83.10%\'}', '71', '59', '12', '0', '0', '2019-12-13 15:59:12');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 16:05:51\', \'sumtime\': \'0:00:29.223869\', \'testresult\': \'共 71 条接口用例，通过 64 条，失败 7 条\', \'tonggl\': \'90.14%\'}', '71', '64', '7', '0', '0', '2019-12-13 16:05:51');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 16:11:23\', \'sumtime\': \'0:00:26.830376\', \'testresult\': \'共 71 条接口用例，通过 64 条，失败 7 条\', \'tonggl\': \'90.14%\'}', '71', '64', '7', '0', '0', '2019-12-13 16:11:23');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 16:26:35\', \'sumtime\': \'0:00:28.759152\', \'testresult\': \'共 71 条接口用例，通过 63 条，失败 8 条\', \'tonggl\': \'88.73%\'}', '71', '63', '8', '0', '0', '2019-12-13 16:26:34');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 22:00:27\', \'sumtime\': \'0:00:29.984834\', \'testresult\': \'共 71 条接口用例，通过 63 条，失败 8 条\', \'tonggl\': \'88.73%\'}', '71', '63', '8', '0', '0', '2019-12-13 22:00:27');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-20 17:50:17\', \'sumtime\': \'0:02:11.360420\', \'testresult\': \'共 326 条接口用例，通过 210 条，失败 112 条，错误 4 条\', \'tonggl\': \'64.42%\'}', '326', '210', '112', '4', '1.23', '2019-12-20 17:50:16');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-20 22:00:25\', \'sumtime\': \'0:02:10.630230\', \'testresult\': \'共 326 条接口用例，通过 207 条，失败 118 条，错误 1 条\', \'tonggl\': \'63.50%\'}', '326', '207', '118', '1', '0.31', '2019-12-20 22:00:24');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-27 22:00:35\', \'sumtime\': \'0:02:14.293568\', \'testresult\': \'共 326 条接口用例，通过 213 条，失败 112 条，错误 1 条\', \'tonggl\': \'65.34%\'}', '326', '213', '112', '1', '0.31', '2019-12-27 22:00:35');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-03 22:00:26\', \'sumtime\': \'0:02:10.942897\', \'testresult\': \'共 326 条接口用例，通过 209 条，失败 116 条，错误 1 条\', \'tonggl\': \'64.11%\'}', '326', '209', '116', '1', '0.31', '2020-01-03 22:00:25');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-10 22:00:31\', \'sumtime\': \'0:00:01.249100\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-01-10 22:00:30');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-17 22:00:25\', \'sumtime\': \'0:00:01.255976\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-01-17 22:00:25');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-24 22:00:24\', \'sumtime\': \'0:00:01.267846\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-01-24 22:00:24');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-31 22:00:25\', \'sumtime\': \'0:00:02.260491\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-01-31 22:00:25');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-07 22:00:22\', \'sumtime\': \'0:00:01.253220\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-02-07 22:00:22');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-14 22:00:23\', \'sumtime\': \'0:00:01.243087\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-02-14 22:00:23');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-21 22:00:25\', \'sumtime\': \'0:00:01.244787\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-02-21 22:00:24');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-28 22:00:05\', \'sumtime\': \'0:00:01.310189\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-02-28 22:00:04');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-06 22:00:03\', \'sumtime\': \'0:00:01.402442\', \'testresult\': \'共 326 条接口用例，错误 326 条\', \'tonggl\': \'0.00%\'}', '326', '0', '0', '326', '100.00', '2020-03-06 22:00:03');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 22:00:04\', \'sumtime\': \'0:02:24.003520\', \'testresult\': \'共 326 条接口用例，通过 208 条，失败 117 条，错误 1 条\', \'tonggl\': \'63.80%\'}', '326', '208', '117', '1', '0.31', '2020-03-27 22:00:03');
INSERT INTO `xycp` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-04-03 22:00:04\', \'sumtime\': \'0:02:18.391738\', \'testresult\': \'共 326 条接口用例，通过 208 条，失败 117 条，错误 1 条\', \'tonggl\': \'63.80%\'}', '326', '208', '117', '1', '0.31', '2020-04-03 22:00:03');

-- ----------------------------
-- Table structure for znkf
-- ----------------------------
DROP TABLE IF EXISTS `znkf`;
CREATE TABLE `znkf`  (
  `restult` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ok` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `error` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `error_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of znkf
-- ----------------------------
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 11:55:14\', \'sumtime\': \'0:00:00.125677\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2019-11-11 11:55:13');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-11 11:55:14\', \'sumtime\': \'0:00:00.125677\', \'testresult\': \'共 1 条接口用例，错误 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '0', '1', '100.00', '2019-11-11 11:55:13');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 12:05:28\', \'sumtime\': \'0:00:01.093063\', \'testresult\': \'共 1 条接口用例，通过 1 条\', \'tonggl\': \'100.00%\'}', '1', '1', '0', '0', '0', '2019-11-18 12:05:28');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 12:08:21\', \'sumtime\': \'0:00:00.237691\', \'testresult\': \'共 1 条接口用例，失败 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '1', '0', '0', '2019-11-18 12:08:21');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-18 12:09:10\', \'sumtime\': \'0:00:00.280213\', \'testresult\': \'共 1 条接口用例，失败 1 条\', \'tonggl\': \'0.00%\'}', '1', '0', '1', '0', '0', '2019-11-18 12:09:10');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '90', '90', '0', '0', '0', '2019-11-18 12:20:27');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '90', '90', '0', '0', '0', '2019-11-18 12:23:01');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '90', '89', '1', '0', '0', '2019-11-18 12:23:04');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '90', '90', '0', '0', '0', '2019-11-18 12:23:06');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '90', '89', '1', '0', '0', '2019-11-18 12:23:08');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '105', '105', '0', '0', '0', '2019-11-18 12:23:10');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '105', '105', '0', '0', '0', '2019-11-18 12:23:15');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '105', '101', '4', '0', '0', '2019-11-18 12:23:17');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '105', '105', '0', '0', '0', '2019-11-18 12:23:19');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '105', '98', '6', '1', '0.95', '2019-11-18 12:23:21');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '105', '98', '7', '0', '0', '2019-11-18 12:23:33');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '105', '102', '3', '0', '0', '2019-11-18 12:23:36');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-10-10 13:41:02\', \'sumtime\': \'0:03:47.520591\', \'testresult\': \'共 105 条接口用例，通过 103 条，失败 2 条\', \'tonggl\': \'98.10%\'}', '105', '103', '2', '0', '0', '2019-11-18 12:23:38');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-21 13:37:22\', \'sumtime\': \'0:01:27.765346\', \'testresult\': \'共 153 条接口用例，通过 140 条，失败 13 条\', \'tonggl\': \'91.50%\'}', '153', '140', '13', '0', '0', '2019-11-21 13:37:20');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-22 16:54:39\', \'sumtime\': \'0:01:46.041458\', \'testresult\': \'共 194 条接口用例，通过 166 条，失败 23 条，错误 5 条\', \'tonggl\': \'85.57%\'}', '194', '166', '23', '5', '2.58', '2019-11-22 16:54:38');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-22 22:01:18\', \'sumtime\': \'0:01:39.121554\', \'testresult\': \'共 194 条接口用例，通过 167 条，失败 22 条，错误 5 条\', \'tonggl\': \'86.08%\'}', '194', '167', '22', '5', '2.58', '2019-11-22 22:01:17');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-22 22:22:00\', \'sumtime\': \'0:01:39.845502\', \'testresult\': \'共 194 条接口用例，通过 167 条，失败 22 条，错误 5 条\', \'tonggl\': \'86.08%\'}', '194', '167', '22', '5', '2.58', '2019-11-22 22:22:00');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-22 23:02:00\', \'sumtime\': \'0:01:39.165793\', \'testresult\': \'共 194 条接口用例，通过 167 条，失败 22 条，错误 5 条\', \'tonggl\': \'86.08%\'}', '194', '167', '22', '5', '2.58', '2019-11-22 23:02:00');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-25 16:55:01\', \'sumtime\': \'0:02:05.568073\', \'testresult\': \'共 245 条接口用例，通过 203 条，失败 37 条，错误 5 条\', \'tonggl\': \'82.86%\'}', '245', '203', '37', '5', '2.04', '2019-11-25 16:55:01');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-11-29 22:00:51\', \'sumtime\': \'0:02:03.358041\', \'testresult\': \'共 245 条接口用例，通过 194 条，失败 46 条，错误 5 条\', \'tonggl\': \'79.18%\'}', '245', '194', '46', '5', '2.04', '2019-11-29 22:00:51');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-10 09:35:50\', \'sumtime\': \'0:02:10.210085\', \'testresult\': \'共 245 条接口用例，通过 203 条，失败 37 条，错误 5 条\', \'tonggl\': \'82.86%\'}', '245', '203', '37', '5', '2.04', '2019-12-10 09:35:49');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-13 22:01:08\', \'sumtime\': \'0:02:15.670139\', \'testresult\': \'共 245 条接口用例，通过 215 条，失败 29 条，错误 1 条\', \'tonggl\': \'87.76%\'}', '245', '215', '29', '1', '0.41', '2019-12-13 22:01:08');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-20 22:01:02\', \'sumtime\': \'0:02:20.347431\', \'testresult\': \'共 245 条接口用例，通过 216 条，失败 28 条，错误 1 条\', \'tonggl\': \'88.16%\'}', '245', '216', '28', '1', '0.41', '2019-12-20 22:01:01');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2019-12-27 22:01:01\', \'sumtime\': \'0:02:23.311212\', \'testresult\': \'共 245 条接口用例，通过 216 条，失败 28 条，错误 1 条\', \'tonggl\': \'88.16%\'}', '245', '216', '28', '1', '0.41', '2019-12-27 22:01:00');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-03 15:09:17\', \'sumtime\': \'0:03:35.128327\', \'testresult\': \'共 293 条接口用例，通过 264 条，失败 28 条，错误 1 条\', \'tonggl\': \'90.10%\'}', '293', '264', '28', '1', '0.34', '2020-01-03 15:09:17');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-03 16:29:31\', \'sumtime\': \'0:03:07.282297\', \'testresult\': \'共 293 条接口用例，通过 273 条，失败 19 条，错误 1 条\', \'tonggl\': \'93.17%\'}', '293', '273', '19', '1', '0.34', '2020-01-03 16:29:31');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-06 09:12:01\', \'sumtime\': \'0:02:55.494795\', \'testresult\': \'共 293 条接口用例，通过 273 条，失败 19 条，错误 1 条\', \'tonggl\': \'93.17%\'}', '293', '273', '19', '1', '0.34', '2020-01-06 09:12:01');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-06 09:16:24\', \'sumtime\': \'0:02:54.847925\', \'testresult\': \'共 293 条接口用例，通过 273 条，失败 19 条，错误 1 条\', \'tonggl\': \'93.17%\'}', '293', '273', '19', '1', '0.34', '2020-01-06 09:16:24');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-10 22:01:24\', \'sumtime\': \'0:02:57.975954\', \'testresult\': \'共 293 条接口用例，通过 275 条，失败 17 条，错误 1 条\', \'tonggl\': \'93.86%\'}', '293', '275', '17', '1', '0.34', '2020-01-10 22:01:23');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-17 22:01:18\', \'sumtime\': \'0:03:11.346393\', \'testresult\': \'共 293 条接口用例，通过 275 条，失败 17 条，错误 1 条\', \'tonggl\': \'93.86%\'}', '293', '275', '17', '1', '0.34', '2020-01-17 22:01:17');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-24 22:01:17\', \'sumtime\': \'0:03:11.540881\', \'testresult\': \'共 293 条接口用例，通过 275 条，失败 17 条，错误 1 条\', \'tonggl\': \'93.86%\'}', '293', '275', '17', '1', '0.34', '2020-01-24 22:01:17');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-01-31 22:01:19\', \'sumtime\': \'0:03:09.508071\', \'testresult\': \'共 293 条接口用例，通过 275 条，失败 17 条，错误 1 条\', \'tonggl\': \'93.86%\'}', '293', '275', '17', '1', '0.34', '2020-01-31 22:01:18');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-07 22:01:19\', \'sumtime\': \'0:03:11.381094\', \'testresult\': \'共 293 条接口用例，通过 275 条，失败 17 条，错误 1 条\', \'tonggl\': \'93.86%\'}', '293', '275', '17', '1', '0.34', '2020-02-07 22:01:19');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-14 22:01:20\', \'sumtime\': \'0:03:08.745957\', \'testresult\': \'共 293 条接口用例，通过 275 条，失败 17 条，错误 1 条\', \'tonggl\': \'93.86%\'}', '293', '275', '17', '1', '0.34', '2020-02-14 22:01:20');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-21 22:01:23\', \'sumtime\': \'0:03:06.077492\', \'testresult\': \'共 293 条接口用例，通过 275 条，失败 17 条，错误 1 条\', \'tonggl\': \'93.86%\'}', '293', '275', '17', '1', '0.34', '2020-02-21 22:01:23');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-02-28 22:00:05\', \'sumtime\': \'0:03:16.610763\', \'testresult\': \'共 293 条接口用例，通过 272 条，失败 20 条，错误 1 条\', \'tonggl\': \'92.83%\'}', '293', '272', '20', '1', '0.34', '2020-02-28 22:00:05');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-05 18:53:46\', \'sumtime\': \'0:06:39.229823\', \'testresult\': \'共 410 条接口用例，通过 396 条，失败 10 条，错误 4 条\', \'tonggl\': \'96.59%\'}', '410', '396', '10', '4', '0.98', '2020-03-05 18:53:45');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-06 22:00:05\', \'sumtime\': \'0:04:52.976370\', \'testresult\': \'共 410 条接口用例，通过 402 条，失败 7 条，错误 1 条\', \'tonggl\': \'98.05%\'}', '410', '402', '7', '1', '0.24', '2020-03-06 22:00:05');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 15:56:36\', \'sumtime\': \'0:00:02.385656\', \'testresult\': \'共 2 条接口用例，通过 2 条\', \'tonggl\': \'100.00%\'}', '2', '2', '0', '0', '0', '2020-03-27 15:56:36');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 16:03:31\', \'sumtime\': \'0:00:01.369305\', \'testresult\': \'共 2 条接口用例，通过 2 条\', \'tonggl\': \'100.00%\'}', '2', '2', '0', '0', '0', '2020-03-27 16:03:31');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 16:37:46\', \'sumtime\': \'0:00:01.339381\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 16:37:46');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 16:40:37\', \'sumtime\': \'0:00:00.991348\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 16:40:37');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 16:43:43\', \'sumtime\': \'0:00:00.820756\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 16:43:43');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 17:02:21\', \'sumtime\': \'0:00:00.788887\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 17:02:21');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 17:04:10\', \'sumtime\': \'0:00:00.693106\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 17:04:10');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 17:09:57\', \'sumtime\': \'0:00:00.825792\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 17:09:57');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 17:11:23\', \'sumtime\': \'0:00:00.722034\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 17:11:23');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 17:13:46\', \'sumtime\': \'0:00:00.683172\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 17:13:46');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 17:13:58\', \'sumtime\': \'0:00:00.727060\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 17:13:58');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 17:19:04\', \'sumtime\': \'0:00:00.682175\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 17:19:04');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 18:08:33\', \'sumtime\': \'0:00:00.670208\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 18:08:33');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 18:08:42\', \'sumtime\': \'0:00:00.650241\', \'testresult\': \'共 2 条接口用例，错误 2 条\', \'tonggl\': \'0.00%\'}', '2', '0', '0', '2', '100.00', '2020-03-27 18:08:42');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 18:09:51\', \'sumtime\': \'0:00:01.436120\', \'testresult\': \'共 2 条接口用例，通过 1 条，错误 1 条\', \'tonggl\': \'50.00%\'}', '2', '1', '0', '1', '50.00', '2020-03-27 18:09:51');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 18:15:19\', \'sumtime\': \'0:00:01.217743\', \'testresult\': \'共 2 条接口用例，通过 1 条，错误 1 条\', \'tonggl\': \'50.00%\'}', '2', '1', '0', '1', '50.00', '2020-03-27 18:15:19');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-27 22:00:06\', \'sumtime\': \'0:05:06.052426\', \'testresult\': \'共 410 条接口用例，通过 389 条，失败 18 条，错误 3 条\', \'tonggl\': \'94.88%\'}', '410', '389', '18', '3', '0.73', '2020-03-27 22:00:05');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 09:10:27\', \'sumtime\': \'0:00:01.820984\', \'testresult\': \'共 2 条接口用例，通过 1 条，错误 1 条\', \'tonggl\': \'50.00%\'}', '2', '1', '0', '1', '50.00', '2020-03-27 18:15:19');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 09:14:16\', \'sumtime\': \'0:00:01.037264\', \'testresult\': \'共 2 条接口用例，通过 1 条，错误 1 条\', \'tonggl\': \'50.00%\'}', '2', '1', '0', '1', '50.00', '2020-03-30 09:14:16');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-03-30 09:22:00\', \'sumtime\': \'0:00:01.539840\', \'testresult\': \'共 2 条接口用例，通过 2 条\', \'tonggl\': \'100.00%\'}', '2', '2', '0', '0', '0', '2020-03-30 09:22:00');
INSERT INTO `znkf` VALUES ('{\'testname\': \'质量保障部—章广华\', \'time\': \'2020-04-03 22:00:09\', \'sumtime\': \'0:05:18.569147\', \'testresult\': \'共 410 条接口用例，通过 396 条，失败 12 条，错误 2 条\', \'tonggl\': \'96.59%\'}', '410', '396', '12', '2', '0.49', '2020-04-03 22:00:08');

SET FOREIGN_KEY_CHECKS = 1;
