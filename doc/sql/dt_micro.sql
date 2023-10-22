/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : 127.0.0.1:3306
 Source Schema         : dt_micro

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 29/03/2023 17:04:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Trigger作为Blob类型存储（用于Quartz用户用JDBC创建他们自己定制的Trigger类型，JobStore 并不知道如何存储实例的时候）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '以Blob类型存储Quartz的Calendar日历信息， quartz可配置一个日历来指定一个时间范围' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'triggers表trigger_name的外键',
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron表达式',
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储Cron Trigger，包括Cron表达式和时区信息。' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('scheduler', '675674866094208', 'DEFAULT', '0 0/10 * * * ? ', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint NOT NULL,
  `SCHED_TIME` bigint NOT NULL,
  `PRIORITY` int NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储与已触发的Trigger相关的状态信息，以及相联Job的执行信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'JOB名称',
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'JOB所属组',
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'job实现类的完全包名，quartz就是根据这个路径到classpath找到该job类',
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否持久化：0.否 1.是',
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL COMMENT 'blob字段，存放持久化job对象',
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储每一个已配置的Job的详细信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('scheduler', '675674866094208', 'DEFAULT', '定时删除系统日志', 'com.cms.job.task.bean.CronLoginLogJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C770800000010000000027400067461736B496474000F3637353637343836363039343230387400127363686564756C655461736B4F626A4B657973720020636F6D2E636D732E6A6F622E656E746974792E51756172747A4A6F62496E666FB186A23DE4A9471F0200064C000E63726F6E45787072657373696F6E7400124C6A6176612F6C616E672F537472696E673B4C0007646174614D61707400174C6F72672F71756172747A2F4A6F62446174614D61703B4C00086A6F62436C6173737400114C6A6176612F6C616E672F436C6173733B4C000D7461736B47726F75704E616D6571007E000B4C00067461736B496471007E000B4C00087461736B4E616D6571007E000B787074000F3020302F3130202A202A202A203F207076720025636F6D2E636D732E6A6F622E7461736B2E6265616E2E43726F6E4C6F67696E4C6F674A6F620000000000000000000000787074000764656661756C7471007E0008740018E5AE9AE697B6E588A0E999A4E7B3BBE7BB9FE697A5E5BF977800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储程序的非观锁的信息(假如使用了悲观锁)' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('scheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储已暂停的Trigger组的信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint NOT NULL,
  `CHECKIN_INTERVAL` bigint NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储少量的有关 Scheduler的状态信息，和别的 Scheduler 实例(假如是用于一个集群中)' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint NOT NULL,
  `REPEAT_INTERVAL` bigint NOT NULL,
  `TIMES_TRIGGERED` bigint NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储简单的 Trigger，包括重复次数，间隔，以及已触的次数' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int NULL DEFAULT NULL,
  `INT_PROP_2` int NULL DEFAULT NULL,
  `LONG_PROP_1` bigint NULL DEFAULT NULL,
  `LONG_PROP_2` bigint NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'trigger名称',
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'trigger所属组',
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint NULL DEFAULT NULL,
  `PRIORITY` int NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '当前trigger状态，设置为ACQUIRED,如果设置为WAITING,则job不会触发',
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'trigger类型，CRON表达式',
  `START_TIME` bigint NOT NULL,
  `END_TIME` bigint NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储已配置的 Trigger的信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('scheduler', '675674866094208', 'DEFAULT', '675674866094208', 'DEFAULT', NULL, 1653706800000, 1653706200000, 5, 'WAITING', 'CRON', 1649596841000, 0, NULL, 0, '');

-- ----------------------------
-- Table structure for sys_department
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department`  (
  `id` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '部门id',
  `parent_id` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '上级部门id',
  `label` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '部门名称',
  `sort` int NULL DEFAULT NULL COMMENT '序号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES ('1000000174227147', '1000001620535597', '市场部门', 1, '2021-06-17 21:33:41', '2021-06-17 21:34:03');
INSERT INTO `sys_department` VALUES ('1000000204663981', '1000001200689941', '前端部门', 3, '2021-06-17 21:27:59', '2021-06-17 21:28:22');
INSERT INTO `sys_department` VALUES ('1000000622591924', '1000001620535597', '设计部', 1, '2021-06-20 21:53:49', '2021-06-20 21:57:45');
INSERT INTO `sys_department` VALUES ('1000000952846438', '1000001251633881', '财务部门', 1, '2021-06-17 21:29:00', '2021-10-03 16:50:39');
INSERT INTO `sys_department` VALUES ('1000001186458564', '1000001637526739', '服务二部', 2, '2021-06-20 21:56:29', '2021-06-20 21:56:29');
INSERT INTO `sys_department` VALUES ('1000001200689941', '1000001776185099', '技术部', 1, '2021-06-13 19:15:04', '2022-05-28 09:47:11');
INSERT INTO `sys_department` VALUES ('1000001251633881', '1000001776185099', '财务部', 2, '2021-06-13 14:35:36', '2021-06-17 21:29:25');
INSERT INTO `sys_department` VALUES ('1000001258096779', '1000001200689941', 'UI设计部门', 4, '2021-06-17 21:28:10', '2021-06-17 21:31:41');
INSERT INTO `sys_department` VALUES ('1000001341234088', '1000001776185099', '行政部', 3, '2021-06-13 14:35:38', '2021-06-17 21:26:17');
INSERT INTO `sys_department` VALUES ('1000001620535597', '1000001776185099', '客服部', 4, '2021-06-13 14:35:40', '2021-06-17 21:29:39');
INSERT INTO `sys_department` VALUES ('1000001625392933', '1000001341234088', '法律部门', 1, '2021-06-17 21:33:05', '2021-06-17 21:33:05');
INSERT INTO `sys_department` VALUES ('1000001637526739', '1000001620535597', '服务部门', 2, '2021-06-17 21:33:55', '2021-06-17 21:33:55');
INSERT INTO `sys_department` VALUES ('1000001728835022', '1000001637526739', '服务一部', 1, '2021-06-20 21:56:19', '2021-06-20 21:56:19');
INSERT INTO `sys_department` VALUES ('1000001776185099', '0', 'DT编程科技有限公司', 1, '2021-06-13 14:35:42', '2021-11-14 11:22:51');
INSERT INTO `sys_department` VALUES ('1000001779686042', '1000001200689941', '后端部门', 1, '2021-06-17 21:27:48', '2021-06-17 21:27:48');
INSERT INTO `sys_department` VALUES ('1000001854756787', '1000000622591924', '设计组一', 1, '2021-06-20 21:54:18', '2021-06-20 21:54:18');
INSERT INTO `sys_department` VALUES ('1000001934748021', '1000000622591924', '设计组二', 2, '2021-06-20 21:54:27', '2021-06-20 21:54:27');
INSERT INTO `sys_department` VALUES ('1000001975876013', '1000000622591924', '设计组三', 3, '2021-06-20 21:54:48', '2021-06-20 21:54:48');

-- ----------------------------
-- Table structure for sys_log_login
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_login`;
CREATE TABLE `sys_log_login`  (
  `id` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志标题',
  `login_user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `login_ip` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '登录IP',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录浏览器',
  `operating_system` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `status` int NULL DEFAULT NULL COMMENT '登录状态：1成功 2失败',
  `type` int NULL DEFAULT NULL COMMENT '类型：1登录系统 2退出系统',
  `message_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'MQ消息ID',
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作消息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log_login
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log_operator
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operator`;
CREATE TABLE `sys_log_operator`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `business_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `request_method_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `request_method_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法类型',
  `request_user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员',
  `request_url` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求URL',
  `request_ip` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求IP',
  `request_param` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `response_param` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '响应参数',
  `status` int NULL DEFAULT NULL COMMENT '操作状态：1正常 2异常',
  `error_info` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '错误信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log_operator
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `parent_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父节点',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由地址',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型（menu：菜单，iframe：嵌入，link：外链）',
  `order_num` int NULL DEFAULT 1 COMMENT '排序序号',
  `sort` int NULL DEFAULT NULL COMMENT '菜单排序',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权标识符',
  `hidden` tinyint(1) NULL DEFAULT 0 COMMENT '隐藏菜单',
  `hidden_breadcrumb` tinyint(1) NULL DEFAULT 0 COMMENT '隐藏面包屑',
  `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('111', '0', '/setting', 'setting', NULL, '系统', 'el-icon-setting', 'menu', 1, 4, NULL, 0, 0, '2022-02-22 11:27:20', '2022-03-09 14:25:12');
INSERT INTO `sys_menu` VALUES ('112', '111', '/setting/user', 'user', 'setting/user', '用户管理', 'sc-icon-user', 'menu', 2, 5, 'user.list', 0, 0, '2022-02-22 11:27:19', '2022-03-09 14:25:03');
INSERT INTO `sys_menu` VALUES ('113', '112', NULL, NULL, NULL, '添加', NULL, 'button', 3, 6, 'user.add', 0, 0, '2022-02-22 11:27:18', '2022-02-22 11:27:18');
INSERT INTO `sys_menu` VALUES ('114', '0', '/home', 'home', NULL, '首页', 'el-icon-data-line', 'menu', 1, 1, NULL, 0, 0, '2022-02-22 11:27:17', '2022-02-22 11:27:17');
INSERT INTO `sys_menu` VALUES ('115', '114', '/dashboard', 'dashboard', 'home', '控制台', 'el-icon-monitor', 'menu', 2, 2, NULL, 0, 0, '2022-02-22 11:27:16', '2022-03-26 21:15:31');
INSERT INTO `sys_menu` VALUES ('116', '114', '/usercenter', 'usercenter', 'userCenter', '个人中心', 'el-icon-edit', 'menu', 3, 3, NULL, 0, 0, '2022-02-22 11:27:15', '2022-05-22 22:24:05');
INSERT INTO `sys_menu` VALUES ('117', '111', '/setting/menu', 'settingMenu', 'setting/menu', '菜单管理', 'sc-icon-menu', 'menu', 1, 7, NULL, 0, 0, '2022-02-22 13:58:56', '2022-03-09 14:24:56');
INSERT INTO `sys_menu` VALUES ('118', '111', '/setting/dept', 'settingDept', 'setting/dept', '部门管理', 'sc-icon-dept', 'menu', 1, 8, NULL, 0, 0, '2022-02-28 16:45:31', '2022-03-08 15:44:32');
INSERT INTO `sys_menu` VALUES ('119', '111', '/setting/role', 'role', 'setting/role', '角色管理', 'sc-icon-role', 'menu', 1, 9, NULL, 0, 0, '2022-03-09 14:26:01', '2022-03-09 14:26:01');
INSERT INTO `sys_menu` VALUES ('675073235689600', '0', '/log', 'log', '', '日志', 'sc-icon-log', 'menu', 1, 10, NULL, 0, 1, '2022-03-24 21:21:02', '2022-05-25 21:30:43');
INSERT INTO `sys_menu` VALUES ('675073256198272', '675073235689600', '/log/login', 'login', 'log/login', '登录日志', 'sc-icon-login-log', 'menu', 1, 11, NULL, 0, 0, '2022-03-24 21:21:19', '2022-03-24 21:26:32');
INSERT INTO `sys_menu` VALUES ('675073263906944', '675073235689600', '/log/operation', 'operation', 'log/operation', '操作日志', 'sc-icon-operation-log', 'menu', 1, 12, NULL, 0, 0, '2022-03-24 21:21:35', '2022-03-24 21:26:56');
INSERT INTO `sys_menu` VALUES ('675144297996416', '0', '/task', 'task', '', '任务', 'sc-icon-task', 'menu', 1, 13, NULL, 0, 0, '2022-03-26 21:32:17', '2022-04-10 20:53:08');
INSERT INTO `sys_menu` VALUES ('675144452886656', '675144297996416', '/task/dispatch', 'dispatch', 'task/dispatch', '任务管理', 'el-icon-clock', 'menu', 1, 14, NULL, 0, 0, '2022-04-10 20:41:52', '2022-04-10 20:53:23');
INSERT INTO `sys_menu` VALUES ('675181511221376', '112', '', '', '', '编辑', '', 'button', 1, 17, 'user.edit', 0, 0, '2022-03-27 22:46:46', '2022-03-27 22:46:47');
INSERT INTO `sys_menu` VALUES ('675181535461504', '112', '', '', '', '删除', NULL, 'button', 1, 18, 'user.delete', 0, 0, '2022-03-27 22:47:26', '2022-03-27 22:47:26');
INSERT INTO `sys_menu` VALUES ('675181546832000', '112', '', '', '', '批量删除', NULL, 'button', 1, 19, 'user.batch.delete', 0, 0, '2022-03-27 22:47:47', '2022-03-27 22:51:08');
INSERT INTO `sys_menu` VALUES ('675181714677888', '117', '', '', '', '添加', '', 'button', 1, 20, 'menu.add', 0, 0, '2022-03-27 22:54:38', '2022-03-27 22:54:38');
INSERT INTO `sys_menu` VALUES ('675181723545728', '117', '', '', '', '批量删除', NULL, 'button', 1, 21, 'menu.batch.delete', 0, 0, '2022-03-27 22:54:56', '2022-03-27 22:54:56');
INSERT INTO `sys_menu` VALUES ('675181755994240', '118', '', '', '', '添加', '', 'button', 1, 22, 'dept.add', 0, 0, '2022-03-27 22:56:14', '2022-03-27 22:56:14');
INSERT INTO `sys_menu` VALUES ('675181762871424', '118', '', '', '', '批量删除', NULL, 'button', 1, 23, 'dept.batch.delete', 0, 0, '2022-03-27 22:56:34', '2022-03-27 22:56:34');
INSERT INTO `sys_menu` VALUES ('675181771518080', '119', '', '', '', '添加', '', 'button', 1, 24, 'role.add', 0, 0, '2022-03-27 22:56:57', '2022-03-27 22:56:57');
INSERT INTO `sys_menu` VALUES ('675181780402304', '119', '', '', '', '编辑', NULL, 'button', 1, 25, 'role.edit', 0, 0, '2022-03-27 22:57:12', '2022-03-27 22:57:12');
INSERT INTO `sys_menu` VALUES ('675181786669184', '119', '', '', '', '删除', NULL, 'button', 1, 26, 'role.delete', 0, 0, '2022-03-27 22:57:32', '2022-03-27 22:57:32');
INSERT INTO `sys_menu` VALUES ('675181798477952', '119', '', '', '', '权限设置', NULL, 'button', 1, 27, 'role.auth', 0, 0, '2022-03-27 22:58:02', '2022-03-27 22:58:02');
INSERT INTO `sys_menu` VALUES ('675181806932096', '119', '', '', '', '数据权限', NULL, 'button', 1, 28, 'role.data.scope', 0, 0, '2022-03-27 22:58:21', '2022-03-27 22:58:21');
INSERT INTO `sys_menu` VALUES ('675181820149888', '119', '', '', '', '批量删除', NULL, 'button', 1, 29, 'role.batch.delete', 0, 0, '2022-03-27 22:58:58', '2022-03-27 22:58:58');
INSERT INTO `sys_menu` VALUES ('675181831987328', '675073256198272', '', '', '', '批量删除', '', 'button', 1, 30, 'log.login.batch.delete', 0, 0, '2022-03-27 22:59:30', '2022-03-27 22:59:30');
INSERT INTO `sys_menu` VALUES ('675181843529856', '675073263906944', '', '', '', '批量删除', NULL, 'button', 1, 31, 'log.oper.batch.delete', 0, 0, '2022-03-27 22:59:53', '2022-03-27 22:59:53');
INSERT INTO `sys_menu` VALUES ('675181998772352', '675073256198272', '', '', '', '删除', NULL, 'button', 1, 32, 'log.login.delete', 0, 0, '2022-03-27 23:06:08', '2022-03-27 23:06:08');
INSERT INTO `sys_menu` VALUES ('675182006534272', '675073263906944', '', '', '', '删除', NULL, 'button', 1, 33, 'log.oper.delete', 0, 0, '2022-03-27 23:06:26', '2022-03-27 23:09:22');
INSERT INTO `sys_menu` VALUES ('675562021273728', '0', '/doc', 'doc', '', '文件', 'el-icon-folder-opened', 'menu', 1, 39, NULL, 0, 0, '2022-04-07 16:49:20', '2022-04-10 20:53:38');
INSERT INTO `sys_menu` VALUES ('675562032300160', '675562021273728', '/doc/file', 'file', 'doc/file', '文件管理', 'el-icon-apple', 'menu', 1, 40, NULL, 0, 0, '2022-04-07 16:50:04', '2022-04-10 20:53:47');
INSERT INTO `sys_menu` VALUES ('677268006871168', '0', '/othertwo', 'othertwo', '', '其它', 'el-icon-connection', 'menu', 1, 44, NULL, 0, 0, '2022-05-25 21:46:33', '2022-05-25 21:53:44');
INSERT INTO `sys_menu` VALUES ('677268028162176', '677268006871168', 'https://www.baidu.com', 'link', '', '百度外链', 'el-icon-connection', 'link', 1, 45, NULL, 0, 0, '2022-05-25 21:47:59', '2022-05-25 22:08:19');
INSERT INTO `sys_menu` VALUES ('677268523430016', '677268006871168', 'https://v3.cn.vuejs.org', 'iframe', '', 'Vue官网', 'sc-icon-vue', 'iframe', 1, 46, NULL, 0, 1, '2022-05-25 22:08:34', '2022-05-25 22:09:50');

-- ----------------------------
-- Table structure for sys_operator
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator`;
CREATE TABLE `sys_operator`  (
  `id` bigint NOT NULL COMMENT '用户 ID',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '系统登录名',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `idno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `openid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信ID',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码，加密存储, admin/1234',
  `scope` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '使用范围（web PC端， app 手机端）',
  `dept_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门ID',
  `is_admin` int NOT NULL DEFAULT 0 COMMENT '是否超级管理员(1 是，0 否)',
  `is_account_non_expired` int NOT NULL DEFAULT 1 COMMENT '帐户是否过期(1 未过期，0 已过期)',
  `is_account_non_locked` int NOT NULL DEFAULT 1 COMMENT '帐户是否被锁定(1 未过期，0 已过期)',
  `is_credentials_non_expired` int NOT NULL DEFAULT 1 COMMENT '密码是否过期(1 未过期，0 已过期)',
  `is_enabled` int NOT NULL DEFAULT 1 COMMENT '帐户是否可用(1 可用，0 删除用户)',
  `avatar` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '用户图片地址',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_operator
-- ----------------------------
INSERT INTO `sys_operator` VALUES (674996197965952, 'dt', 'admin', '15186257311', '52020199', 'oprIA5YF-0cn_Nb_zEK8bvJsExcv', '$2a$10$U6s5CKezRAhOcNMsfHhg8OsLxtA4bcZr3DLVVFPjq98C0a2xTLK0q', 'web', '0', 0, 1, 1, 1, 1, 'http://42.192.121.230:9000/default-bucket/20220406/af39ceaf3fe9464c8ead6d72da270ac1.jpg?Content-Disposition=attachment%3B%20filename%3D%2220220406%2Faf39ceaf3fe9464c8ead6d72da270ac1.jpg%22&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220406%2F%2Fs3%2Faws4_request&X-Amz-Date=20220406T120530Z&X-Amz-Expires=432000&X-Amz-SignedHeaders=host&X-Amz-Signature=2aec1bc7308ff4394e5dfed2870a02af42da84dff2748cd703e4597287e0901e', '2022-03-22 17:05:36', '2023-03-29 17:02:12');

-- ----------------------------
-- Table structure for sys_operator_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator_role`;
CREATE TABLE `sys_operator_role`  (
  `id` bigint NOT NULL COMMENT '主键 ID',
  `user_id` bigint NOT NULL COMMENT '用户 ID',
  `role_id` bigint NOT NULL COMMENT '角色 ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_operator_role
-- ----------------------------
INSERT INTO `sys_operator_role` VALUES (261749792542789, 261749792505925, 248204504629317);
INSERT INTO `sys_operator_role` VALUES (261749792546885, 261749792505925, 256693602365509);
INSERT INTO `sys_operator_role` VALUES (263086138716229, 263086138699845, 248204504629317);
INSERT INTO `sys_operator_role` VALUES (263086138724421, 263086138699845, 256693602365509);
INSERT INTO `sys_operator_role` VALUES (267011175546949, 1503614791426621441, 248204504629317);
INSERT INTO `sys_operator_role` VALUES (401179155435589, 674996197965952, 674996182413440);

-- ----------------------------
-- Table structure for sys_operator_setting
-- ----------------------------
DROP TABLE IF EXISTS `sys_operator_setting`;
CREATE TABLE `sys_operator_setting`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_operator_setting
-- ----------------------------
INSERT INTO `sys_operator_setting` VALUES (675142950023296, 248204704247877, 'dashboard', '2022-03-26 20:36:58', '2022-03-26 20:45:03');
INSERT INTO `sys_operator_setting` VALUES (675143177953408, 674996197965952, 'user,settingDept,dispatch,setting,wechart', '2022-03-26 20:46:14', '2022-05-26 21:36:05');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '权限 ID',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父权限 ID (0为顶级菜单)',
  `label` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '授权标识符',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '授权路径',
  `order_num` int NULL DEFAULT 0 COMMENT '序号',
  `type` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '类型(0 目录 1菜单，2按钮)',
  `icon` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图标',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `parent_name` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '父级菜单名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (17, 0, '系统管理', 'sys:user:manage', '/system', NULL, NULL, 1, '0', 'el-icon-monitor', NULL, '2023-08-08 11:11:11', '2021-11-13 13:05:24', '顶级菜单');
INSERT INTO `sys_permission` VALUES (18, 17, '用户管理', 'sys:user', '/userList', 'userList', '/system/user/UserList', 3, '1', 'el-icon-user', NULL, '2023-08-08 11:11:11', '2021-10-31 12:36:43', '系统管理');
INSERT INTO `sys_permission` VALUES (20, 18, '新增', 'sys:user:add', NULL, NULL, '', 2, '2', '', '新增用户', '2023-08-08 11:11:11', '2021-06-20 20:07:50', '用户管理');
INSERT INTO `sys_permission` VALUES (21, 18, '修改', 'sys:user:update', NULL, NULL, '', 3, '2', '', '修改用户', '2023-08-08 11:11:11', '2021-06-20 20:08:17', '用户管理');
INSERT INTO `sys_permission` VALUES (22, 18, '删除', 'sys:user:del', NULL, NULL, '', 4, '2', '', '删除用户', '2023-08-08 11:11:11', '2021-06-20 20:08:08', '用户管理');
INSERT INTO `sys_permission` VALUES (23, 17, '角色管理', 'sys:role', '/roleList', 'roleList', '/system/role/RoleList', 4, '1', 'el-icon-lock', NULL, '2023-08-08 11:11:11', '2021-06-26 22:46:45', '系统管理');
INSERT INTO `sys_permission` VALUES (25, 23, '新增', 'sys:role:add', NULL, NULL, '', 2, '2', '', '新增角色', '2023-08-08 11:11:11', '2021-06-20 20:13:32', '角色管理');
INSERT INTO `sys_permission` VALUES (26, 23, '修改', 'sys:role:update', NULL, NULL, '', 3, '2', '', '修改角色', '2023-08-08 11:11:11', '2021-06-20 20:13:51', '角色管理');
INSERT INTO `sys_permission` VALUES (27, 23, '删除', 'sys:role:del', NULL, NULL, '', 4, '2', '', '删除角色', '2023-08-08 11:11:11', '2021-06-20 20:14:04', '角色管理');
INSERT INTO `sys_permission` VALUES (28, 17, '菜单管理', 'sys:menu', '/menuList', 'menuList', '/system/menu/MenuList', 5, '1', 'el-icon-s-operation', NULL, '2023-08-08 11:11:11', '2023-08-09 15:26:28', '系统管理');
INSERT INTO `sys_permission` VALUES (30, 28, '新增', 'sys:menu:add', NULL, NULL, '', 1, '2', NULL, '新增权限', '2023-08-08 11:11:11', '2021-06-20 21:04:12', '菜单管理');
INSERT INTO `sys_permission` VALUES (31, 28, '编辑', 'sys:menu:update', NULL, NULL, '', 2, '2', NULL, '修改权限', '2023-08-08 11:11:11', '2021-06-20 21:03:59', '菜单管理');
INSERT INTO `sys_permission` VALUES (32, 28, '删除', 'sys:menu:del', NULL, NULL, '', 3, '2', '', '删除权限', '2023-08-08 11:11:11', '2021-06-20 21:04:24', '菜单管理');
INSERT INTO `sys_permission` VALUES (33, 17, '机构管理', 'sys:dept', '/departmentList', 'departmentList', '/system/department/DepartmentList', 2, '1', 'el-icon-connection', '机构管理', '2020-04-12 22:58:29', '2021-06-27 00:23:02', '系统管理');
INSERT INTO `sys_permission` VALUES (42, 0, '参数配置', 'sys:config:manage', '/config', '', NULL, 5, '0', 'el-icon-setting', NULL, '2020-04-12 22:50:03', '2021-10-31 12:52:29', '顶级菜单');
INSERT INTO `sys_permission` VALUES (46, 33, '新增', 'sys:dept:add', '', '', NULL, 1, '2', '', NULL, '2020-04-12 19:58:48', '2021-06-20 21:02:05', '部门管理');
INSERT INTO `sys_permission` VALUES (76, 33, '编辑', 'sys:dept:update', '', '', NULL, 2, '2', '', NULL, '2020-04-12 20:42:20', '2021-10-06 15:08:21', '部门管理');
INSERT INTO `sys_permission` VALUES (77, 42, '参数配置', 'sys:config', '/configList', 'configList', '/config/ConfigList', 1, '1', 'el-icon-setting', NULL, '2020-04-13 11:31:45', '2021-10-27 21:16:23', '系统工具');
INSERT INTO `sys_permission` VALUES (78, 33, '删除', 'sys:dept:del', '', '', '', 3, '2', '', NULL, '2020-04-18 10:25:55', '2021-06-20 21:02:34', '机构管理');
INSERT INTO `sys_permission` VALUES (79, 23, '分配权限', 'sys:role:assign', '', '', '', 1, '2', '', NULL, '2020-04-18 10:31:05', '2021-06-20 20:13:38', '角色管理');
INSERT INTO `sys_permission` VALUES (80, 18, '分配角色', 'sys:user:assign', '', '', '', 1, '2', '', NULL, '2020-04-18 10:50:14', '2021-06-20 20:07:35', '用户管理');
INSERT INTO `sys_permission` VALUES (92, 0, '字典管理', 'sys:dic:manage', '/dic', '', '', 6, '0', 'el-icon-collection', NULL, '2021-06-27 00:36:23', '2021-07-07 21:19:59', '根节点');
INSERT INTO `sys_permission` VALUES (100, 0, '日志管理', 'sys:log:manage', '/log', '', '', 7, '0', 'el-icon-document-copy', NULL, '2021-07-07 21:26:02', '2021-11-20 19:43:23', '根节点');
INSERT INTO `sys_permission` VALUES (101, 100, '操作日志', 'sys:log:manage', '/operatorLogList', 'operatorLogList', '/log/OperatorLogList', 1, '1', 'el-icon-caret-right', NULL, '2021-07-07 21:26:59', '2021-11-20 19:50:07', '日志管理');
INSERT INTO `sys_permission` VALUES (103, 92, '一级菜单', 'a', 'a', 'a', 'a', 0, '1', 'el-icon-download', NULL, '2021-10-03 20:47:36', '2021-11-06 10:57:23', '字典管理');
INSERT INTO `sys_permission` VALUES (104, 103, '二级菜单', 'b', 'b', 'b', 'b', 0, '1', 'el-icon-video-camera', NULL, '2021-10-03 20:47:52', '2021-11-06 10:57:59', '一级菜单');
INSERT INTO `sys_permission` VALUES (105, 104, '区域列表', 'c', 'c', 'c', 'c', 0, '1', 'el-icon-s-home', NULL, '2021-10-03 20:48:06', '2021-11-06 11:01:14', '二级菜单');
INSERT INTO `sys_permission` VALUES (106, 105, '添加', 'd', '', '', '', 0, '2', '', NULL, '2021-10-03 20:48:22', '2021-11-06 11:01:22', '三级菜单');
INSERT INTO `sys_permission` VALUES (108, 28, '展开/折叠', 'sys:menu:expand', '', '', '', 4, '2', '', NULL, '2021-10-22 20:37:47', '2021-10-22 20:37:47', '菜单管理');
INSERT INTO `sys_permission` VALUES (109, 33, '展开/折叠', 'sys:dept:expand', '', '', '', 4, '2', '', NULL, '2021-10-23 15:45:18', '2021-10-23 15:45:18', '机构管理');
INSERT INTO `sys_permission` VALUES (110, 18, '导入', 'sys:user:import', '', '', '', 5, '2', '', NULL, '2021-10-23 19:45:38', '2021-10-23 19:45:46', '用户管理');
INSERT INTO `sys_permission` VALUES (111, 18, '导出', 'sys:user:export', '', '', '', 6, '2', '', NULL, '2021-10-23 19:46:18', '2021-10-23 19:46:18', '用户管理');
INSERT INTO `sys_permission` VALUES (114, 77, '添加', 'sys:config:add', '', '', '', 1, '2', '', NULL, '2021-11-06 11:48:24', '2021-11-06 11:48:24', '参数配置');
INSERT INTO `sys_permission` VALUES (115, 77, '编辑', 'sys:config:update', '', '', '', 2, '2', '', NULL, '2021-11-06 11:48:39', '2021-11-06 11:48:39', '参数配置');
INSERT INTO `sys_permission` VALUES (116, 77, '删除', 'sys:config:del', '', '', '', 0, '2', '', NULL, '2021-11-06 11:48:53', '2021-11-06 11:48:53', '参数配置');
INSERT INTO `sys_permission` VALUES (117, 100, '登录日志', 'sys:login:list', '/loginLogList', 'loginLogList', '/log/LoginLogList', 2, '1', 'el-icon-caret-right', NULL, '2021-11-20 19:50:58', '2021-11-20 19:51:10', '日志管理');
INSERT INTO `sys_permission` VALUES (118, 101, '删除', 'sys:operatorLog:del', '', '', '', 1, '2', '', NULL, '2021-11-20 20:17:20', '2021-11-20 20:17:20', '操作日志');
INSERT INTO `sys_permission` VALUES (119, 117, '删除', 'sys:loginLog:del', '', '', '', 1, '2', '', NULL, '2021-11-20 22:57:33', '2021-11-20 22:57:33', '登录日志');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色 ID',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `data_scope` bigint NULL DEFAULT NULL COMMENT '数据权限',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色别名',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色说明',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 677268959117441 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (248204504629317, 'ADMIN', 3, '管理员A', '超级管理员', '2022-01-21 10:46:45', '2022-03-26 21:13:09');
INSERT INTO `sys_role` VALUES (256693602365509, 'ROOT', 4, '管理员B', '超级管理员', '2022-02-14 10:28:59', '2022-03-26 21:13:06');
INSERT INTO `sys_role` VALUES (674996182413440, 'WEB', 1, '超级管理员', '超级管理员', '2022-03-22 17:04:58', '2022-05-21 23:42:21');
INSERT INTO `sys_role` VALUES (677268959117440, 'TEST', NULL, '测试角色', '测试', '2022-05-25 22:24:30', '2022-05-28 09:47:17');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `id` bigint NOT NULL,
  `role_id` bigint NULL DEFAULT NULL,
  `dept_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('\r\n\r\n257838251663429', '248204504629317', '112');
INSERT INTO `sys_role_menu` VALUES ('257837477670981', '248204504629317', '111');
INSERT INTO `sys_role_menu` VALUES ('257838321094725', '248204504629317', '113');
INSERT INTO `sys_role_menu` VALUES ('258142502264901', '248204504629317', '114');
INSERT INTO `sys_role_menu` VALUES ('258142598918213', '248204504629317', '115');
INSERT INTO `sys_role_menu` VALUES ('258143150133317', '248204504629317', '116');
INSERT INTO `sys_role_menu` VALUES ('258143150133318', '248204504629317', '117');
INSERT INTO `sys_role_menu` VALUES ('675071403167872', '256693602365509', '114');
INSERT INTO `sys_role_menu` VALUES ('675071403171968', '256693602365509', '115');
INSERT INTO `sys_role_menu` VALUES ('675071403171969', '256693602365509', '116');
INSERT INTO `sys_role_menu` VALUES ('675071403171970', '256693602365509', '112');
INSERT INTO `sys_role_menu` VALUES ('675071403171971', '256693602365509', '113');
INSERT INTO `sys_role_menu` VALUES ('675071403171972', '256693602365509', '111');
INSERT INTO `sys_role_menu` VALUES ('688159624978560', '674996182413440', '114');
INSERT INTO `sys_role_menu` VALUES ('688159624978561', '674996182413440', '115');
INSERT INTO `sys_role_menu` VALUES ('688159624978562', '674996182413440', '116');
INSERT INTO `sys_role_menu` VALUES ('688159624978563', '674996182413440', '111');
INSERT INTO `sys_role_menu` VALUES ('688159624978564', '674996182413440', '112');
INSERT INTO `sys_role_menu` VALUES ('688159624978565', '674996182413440', '113');
INSERT INTO `sys_role_menu` VALUES ('688159624978566', '674996182413440', '675181511221376');
INSERT INTO `sys_role_menu` VALUES ('688159624982656', '674996182413440', '675181535461504');
INSERT INTO `sys_role_menu` VALUES ('688159624982657', '674996182413440', '675181546832000');
INSERT INTO `sys_role_menu` VALUES ('688159624982658', '674996182413440', '117');
INSERT INTO `sys_role_menu` VALUES ('688159624982659', '674996182413440', '675181714677888');
INSERT INTO `sys_role_menu` VALUES ('688159624982660', '674996182413440', '675181723545728');
INSERT INTO `sys_role_menu` VALUES ('688159624982661', '674996182413440', '118');
INSERT INTO `sys_role_menu` VALUES ('688159624982662', '674996182413440', '675181755994240');
INSERT INTO `sys_role_menu` VALUES ('688159624982663', '674996182413440', '675181762871424');
INSERT INTO `sys_role_menu` VALUES ('688159624982664', '674996182413440', '119');
INSERT INTO `sys_role_menu` VALUES ('688159624982665', '674996182413440', '675181771518080');
INSERT INTO `sys_role_menu` VALUES ('688159624982666', '674996182413440', '675181780402304');
INSERT INTO `sys_role_menu` VALUES ('688159624982667', '674996182413440', '675181786669184');
INSERT INTO `sys_role_menu` VALUES ('688159624986752', '674996182413440', '675181798477952');
INSERT INTO `sys_role_menu` VALUES ('688159624986753', '674996182413440', '675181806932096');
INSERT INTO `sys_role_menu` VALUES ('688159624986754', '674996182413440', '675181820149888');
INSERT INTO `sys_role_menu` VALUES ('688159624986755', '674996182413440', '675073235689600');
INSERT INTO `sys_role_menu` VALUES ('688159624986756', '674996182413440', '675073256198272');
INSERT INTO `sys_role_menu` VALUES ('688159624986757', '674996182413440', '675181831987328');
INSERT INTO `sys_role_menu` VALUES ('688159624986758', '674996182413440', '675181998772352');
INSERT INTO `sys_role_menu` VALUES ('688159624986759', '674996182413440', '675073263906944');
INSERT INTO `sys_role_menu` VALUES ('688159624986760', '674996182413440', '675181843529856');
INSERT INTO `sys_role_menu` VALUES ('688159624986761', '674996182413440', '675182006534272');
INSERT INTO `sys_role_menu` VALUES ('688159624986762', '674996182413440', '675144297996416');
INSERT INTO `sys_role_menu` VALUES ('688159624986763', '674996182413440', '675144452886656');
INSERT INTO `sys_role_menu` VALUES ('688159624986764', '674996182413440', '675562021273728');
INSERT INTO `sys_role_menu` VALUES ('688159624986765', '674996182413440', '675562032300160');
INSERT INTO `sys_role_menu` VALUES ('688159624986766', '674996182413440', '677268006871168');
INSERT INTO `sys_role_menu` VALUES ('688159624990848', '674996182413440', '677268028162176');
INSERT INTO `sys_role_menu` VALUES ('688159624990849', '674996182413440', '677268523430016');
INSERT INTO `sys_role_menu` VALUES ('688159631224960', '677268959117440', '114');
INSERT INTO `sys_role_menu` VALUES ('688159631224961', '677268959117440', '115');
INSERT INTO `sys_role_menu` VALUES ('688159631229056', '677268959117440', '116');
INSERT INTO `sys_role_menu` VALUES ('688159631229057', '677268959117440', '675073235689600');
INSERT INTO `sys_role_menu` VALUES ('688159631229058', '677268959117440', '675073256198272');
INSERT INTO `sys_role_menu` VALUES ('688159631229059', '677268959117440', '675181831987328');
INSERT INTO `sys_role_menu` VALUES ('688159631229060', '677268959117440', '675181998772352');
INSERT INTO `sys_role_menu` VALUES ('688159631229061', '677268959117440', '675073263906944');
INSERT INTO `sys_role_menu` VALUES ('688159631229062', '677268959117440', '675181843529856');
INSERT INTO `sys_role_menu` VALUES ('688159631229063', '677268959117440', '675182006534272');
INSERT INTO `sys_role_menu` VALUES ('688159631229064', '677268959117440', '677268006871168');
INSERT INTO `sys_role_menu` VALUES ('688159631229065', '677268959117440', '677268028162176');
INSERT INTO `sys_role_menu` VALUES ('688159631233152', '677268959117440', '677268523430016');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 ID',
  `role_id` bigint NOT NULL COMMENT '角色 ID',
  `permission_id` bigint NOT NULL COMMENT '权限 ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1561 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1443, 33, 92);
INSERT INTO `sys_role_permission` VALUES (1444, 33, 103);
INSERT INTO `sys_role_permission` VALUES (1445, 33, 104);
INSERT INTO `sys_role_permission` VALUES (1446, 33, 105);
INSERT INTO `sys_role_permission` VALUES (1447, 33, 106);
INSERT INTO `sys_role_permission` VALUES (1448, 33, 100);
INSERT INTO `sys_role_permission` VALUES (1449, 33, 101);
INSERT INTO `sys_role_permission` VALUES (1523, 9, 17);
INSERT INTO `sys_role_permission` VALUES (1524, 9, 33);
INSERT INTO `sys_role_permission` VALUES (1525, 9, 46);
INSERT INTO `sys_role_permission` VALUES (1526, 9, 76);
INSERT INTO `sys_role_permission` VALUES (1527, 9, 78);
INSERT INTO `sys_role_permission` VALUES (1528, 9, 109);
INSERT INTO `sys_role_permission` VALUES (1529, 9, 18);
INSERT INTO `sys_role_permission` VALUES (1530, 9, 80);
INSERT INTO `sys_role_permission` VALUES (1531, 9, 20);
INSERT INTO `sys_role_permission` VALUES (1532, 9, 21);
INSERT INTO `sys_role_permission` VALUES (1533, 9, 22);
INSERT INTO `sys_role_permission` VALUES (1534, 9, 110);
INSERT INTO `sys_role_permission` VALUES (1535, 9, 111);
INSERT INTO `sys_role_permission` VALUES (1536, 9, 23);
INSERT INTO `sys_role_permission` VALUES (1537, 9, 79);
INSERT INTO `sys_role_permission` VALUES (1538, 9, 25);
INSERT INTO `sys_role_permission` VALUES (1539, 9, 26);
INSERT INTO `sys_role_permission` VALUES (1540, 9, 27);
INSERT INTO `sys_role_permission` VALUES (1541, 9, 28);
INSERT INTO `sys_role_permission` VALUES (1542, 9, 30);
INSERT INTO `sys_role_permission` VALUES (1543, 9, 31);
INSERT INTO `sys_role_permission` VALUES (1544, 9, 32);
INSERT INTO `sys_role_permission` VALUES (1545, 9, 108);
INSERT INTO `sys_role_permission` VALUES (1546, 9, 42);
INSERT INTO `sys_role_permission` VALUES (1547, 9, 77);
INSERT INTO `sys_role_permission` VALUES (1548, 9, 116);
INSERT INTO `sys_role_permission` VALUES (1549, 9, 114);
INSERT INTO `sys_role_permission` VALUES (1550, 9, 115);
INSERT INTO `sys_role_permission` VALUES (1551, 9, 92);
INSERT INTO `sys_role_permission` VALUES (1552, 9, 103);
INSERT INTO `sys_role_permission` VALUES (1553, 9, 104);
INSERT INTO `sys_role_permission` VALUES (1554, 9, 105);
INSERT INTO `sys_role_permission` VALUES (1555, 9, 106);
INSERT INTO `sys_role_permission` VALUES (1556, 9, 100);
INSERT INTO `sys_role_permission` VALUES (1557, 9, 101);
INSERT INTO `sys_role_permission` VALUES (1558, 9, 118);
INSERT INTO `sys_role_permission` VALUES (1559, 9, 117);
INSERT INTO `sys_role_permission` VALUES (1560, 9, 119);

-- ----------------------------
-- Table structure for t_file_info
-- ----------------------------
DROP TABLE IF EXISTS `t_file_info`;
CREATE TABLE `t_file_info`  (
  `id` bigint NOT NULL,
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `file_url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `suffix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `size` bigint NULL DEFAULT NULL,
  `bucket` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `object_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_file_info
-- ----------------------------
INSERT INTO `t_file_info` VALUES (1511969115361787906, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220407/a68378a4765945b5865a879f331306b2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220407%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220407T072822Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=45c9e48fa897a09df3868fa1358e7f01b849689f273448205bf72e940995e0ad', 'jpg', 35739, 'default', '20220407/a68378a4765945b5865a879f331306b2.jpg', '2022-04-07 15:28:23', '2022-04-07 15:28:23');
INSERT INTO `t_file_info` VALUES (1512037468051468289, 'src=http___img.zcool.cn_community_01ccb65c540cdaa801203d224def33.jpg@2o.jpg&refer=http___img.zcool.jpg', 'http://42.192.121.230:9000/default/20220407/986434ae18004998a181d7eb74ac9806.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220407%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220407T115959Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=7144be59ac6281ef5f0f8e942ca45a7732d036ae05cfaf019ad58f037a656b67', 'jpg', 192806, 'default', '20220407/986434ae18004998a181d7eb74ac9806.jpg', '2022-04-07 19:59:59', '2022-04-07 19:59:59');
INSERT INTO `t_file_info` VALUES (1512042294919426050, 'dtcms.sql', 'http://42.192.121.230:9000/default/20220407/61d63e8a91724f85a82d5c25e48893c9.sql?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220407%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220407T121910Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=46b48c6ddaab010cce0efa7a808c9eafc5e78ca35ae5f4a3fc40ddae3bea86bc', 'sql', 37567, 'default', '20220407/61d63e8a91724f85a82d5c25e48893c9.sql', '2022-04-07 20:19:10', '2022-04-07 20:19:10');
INSERT INTO `t_file_info` VALUES (1512042623937409026, 't_cb_class_photo.sql', 'http://42.192.121.230:9000/default/20220407/4ec22a8fd8044548aa6cbe7483fef49b.sql?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220407%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220407T122028Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=adb8d22b5fbc3ed51517daf40e0bd2b287c4083d2b94d713a6d6e39872898d38', 'sql', 3303, 'default', '20220407/4ec22a8fd8044548aa6cbe7483fef49b.sql', '2022-04-07 20:20:29', '2022-04-07 20:20:29');
INSERT INTO `t_file_info` VALUES (1512042993099075585, '202203262157.mp4', 'http://42.192.121.230:9000/default/20220407/3c0de9810ab84900ae371fd2d82767ee.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220407%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220407T122156Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=fc26f86edb43884d9c1d95a42674506ecf08bc9efe5e5ce55104d514f799f88b', 'mp4', 223976953, 'default', '20220407/3c0de9810ab84900ae371fd2d82767ee.mp4', '2022-04-07 20:21:57', '2022-04-07 20:21:57');
INSERT INTO `t_file_info` VALUES (1512266110915846146, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220408/16400d8b5fd4462185da29f7d1b00ce7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T030831Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=7e5e2628a5dc25c40f355f959cf26dc7f4fab5c3b6ee9ea4f5e8fd18532769a4', 'jpg', 35739, 'default', '20220408/16400d8b5fd4462185da29f7d1b00ce7.jpg', '2022-04-08 11:08:32', '2022-04-08 11:08:32');
INSERT INTO `t_file_info` VALUES (1512266152187797506, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220408/320813eac11c4328a6beb614caa3acac.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T030841Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=b888487a034321b7a2758cd12de68ee04d8938f1663dc6e132e9d520fcf58591', 'jpg', 35739, 'default', '20220408/320813eac11c4328a6beb614caa3acac.jpg', '2022-04-08 11:08:42', '2022-04-08 11:08:42');
INSERT INTO `t_file_info` VALUES (1512266181023637506, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220408/4c562f2294f743ea97e0695dfbaa1b70.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T030848Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=6ff2baba53fea5cd8061a8af8151df3699e0195df71cd77063b3bf6d908fc2f8', 'jpg', 35739, 'default', '20220408/4c562f2294f743ea97e0695dfbaa1b70.jpg', '2022-04-08 11:08:49', '2022-04-08 11:08:49');
INSERT INTO `t_file_info` VALUES (1512266207917514754, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220408/d900b89e8e0e43fc95eb6404b856bbc2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T030855Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=7b8c84657b82f47435da01c2239fd0ffcf0136eab0cbd4723abce67dc2a22e2a', 'jpg', 35739, 'default', '20220408/d900b89e8e0e43fc95eb6404b856bbc2.jpg', '2022-04-08 11:08:55', '2022-04-08 11:08:55');
INSERT INTO `t_file_info` VALUES (1512266250535837698, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220408/f818c727452f466d853afd39ebd116e0.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T030905Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=292667565b72b986aaddc6f4fa316d11211cfd31947ce575af8dd7686adce3e5', 'jpg', 35739, 'default', '20220408/f818c727452f466d853afd39ebd116e0.jpg', '2022-04-08 11:09:05', '2022-04-08 11:09:05');
INSERT INTO `t_file_info` VALUES (1512303890073251841, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220408/391853064ac64d7fbcfc8932479b4901.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T053839Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=f66276fc96dfdab41430fbda27dcfea4be0ef34b9d9536ee23e29f0d99d883d5', 'jpg', 35739, 'default', '20220408/391853064ac64d7fbcfc8932479b4901.jpg', '2022-04-08 13:38:39', '2022-04-08 13:38:39');
INSERT INTO `t_file_info` VALUES (1512326692142592002, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220408/607f8b653aff43cea4fbfbde9e7e4ab6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T070915Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=316ba7fdcbfb5838073c223605cbf831960a12f7b3eb56abc2a6e29180efc4b3', 'jpg', 35739, 'default', '20220408/607f8b653aff43cea4fbfbde9e7e4ab6.jpg', '2022-04-08 15:09:16', '2022-04-08 15:09:16');
INSERT INTO `t_file_info` VALUES (1512332404977573890, 'src=http___b-ssl.duitang.com_uploads_item_201512_13_20151213112543_sitRU.jpeg&refer=http___b-ssl.duitang.webp', 'http://42.192.121.230:9000/default/20220408/c933922fea964647a0a5d460ff5cecbe.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T073157Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=1fd1f2c73ee94873a914c48c5775cab96bc5473346a2004403991675b5372290', 'webp', 25928, 'default', '20220408/c933922fea964647a0a5d460ff5cecbe.webp', '2022-04-08 15:31:58', '2022-04-08 15:31:58');
INSERT INTO `t_file_info` VALUES (1512333081493643265, '测试.jpg', 'http://42.192.121.230:9000/default/20220408/0d8b13dadf4e42b8bcf7fbdf19f3cdbc.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T073438Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=167b1990565cc4b7e76a73ad8092379cd891aee64f97dbb4e39886785135c137', 'jpg', 65903, 'default', '20220408/0d8b13dadf4e42b8bcf7fbdf19f3cdbc.jpg', '2022-04-08 15:34:39', '2022-04-08 15:34:39');
INSERT INTO `t_file_info` VALUES (1512392415695622146, '是七叔呢 - 客子光阴.flac', 'http://42.192.121.230:9000/default/20220408/f6d0424485e6466cae833949747fbcbd.flac?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T113024Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=b410d02653d9f28e59db9e04b78f8e5f40032daf12f06c09cea50bee750d2278', 'flac', 18844084, 'default', '20220408/f6d0424485e6466cae833949747fbcbd.flac', '2022-04-08 19:30:25', '2022-04-08 19:30:25');
INSERT INTO `t_file_info` VALUES (1512451202569834497, 'src=http___img.zcool.cn_community_01ccb65c540cdaa801203d224def33.jpg@2o.jpg&refer=http___img.zcool.jpg', 'http://42.192.121.230:9000/default/20220408/abf305b16cc64f89bace5bbbdd3cf9a4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220408%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220408T152400Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=93a81c048b3c92d9cd26ebedae3340743e40a954293a2fe1c8b49d45bd70dbaf', 'jpg', 192806, 'default', '20220408/abf305b16cc64f89bace5bbbdd3cf9a4.jpg', '2022-04-08 23:24:01', '2022-04-08 23:24:01');
INSERT INTO `t_file_info` VALUES (1512695020254765058, 'src=http___img.zcool.cn_community_01ccb65c540cdaa801203d224def33.jpg@2o.jpg&refer=http___img.zcool.jpg', 'http://42.192.121.230:9000/default/20220409/6681dceacbac4671ba7089df3eb8d3f1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220409%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220409T073251Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=d6a61c266433613b36618c237665102e61aada285611905c7ae6a8b3cb98a54b', 'jpg', 192806, 'default', '20220409/6681dceacbac4671ba7089df3eb8d3f1.jpg', '2022-04-09 15:32:52', '2022-04-09 15:32:52');
INSERT INTO `t_file_info` VALUES (1513111347398189057, 'community-epidemic.sql', 'http://42.192.121.230:9000/default/20220410/505a25ad88b444f5869c07558607ee53.sql?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220410%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220410T110712Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=db932f511f260feaa53d3bf8abf28a3f0477d17f7976b6b77be3a784e942ccbc', 'sql', 23905, 'default', '20220410/505a25ad88b444f5869c07558607ee53.sql', '2022-04-10 19:07:12', '2022-04-10 19:07:12');
INSERT INTO `t_file_info` VALUES (1513111583147433986, '白小白 - 我爱你不问归期.flac', 'http://42.192.121.230:9000/default/20220410/018a9007ca4c46a08eaec4a6fbd85402.flac?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220410%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220410T110808Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=c43ba92ff4f6d86738a29b51dece31392bb4bd54a83ffb3b9add653b7f7e0873', 'flac', 32547590, 'default', '20220410/018a9007ca4c46a08eaec4a6fbd85402.flac', '2022-04-10 19:08:08', '2022-04-10 19:08:08');
INSERT INTO `t_file_info` VALUES (1518434257725333505, '728da9773912b31b686ade638d18367adab4e172.jpg', 'http://42.192.121.230:9000/default/20220425/8a9cf0ac7ac84eebbe74ee143edb258a.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220425%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220425T033832Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=156bcf378c62a3379bc4f711e8ee51399ca51b96dbe2da114670412910e06e5b', 'jpg', 35739, NULL, '20220425/8a9cf0ac7ac84eebbe74ee143edb258a.jpg', '2022-04-25 11:38:33', '2022-04-25 11:38:33');
INSERT INTO `t_file_info` VALUES (1518434452030660609, '测试.jpg', 'http://42.192.121.230:9000/default/20220425/7d6ec5668b6f4a7ebc919bf2d8d051e8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220425%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220425T033919Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=1bb6332235f0da8cccfe484de416814fbbce8e0df4547bb4bb19f07432830c2a', 'jpg', 65903, NULL, '20220425/7d6ec5668b6f4a7ebc919bf2d8d051e8.jpg', '2022-04-25 11:39:19', '2022-04-25 11:39:19');
INSERT INTO `t_file_info` VALUES (1529811480206733313, '是七叔呢 - 客子光阴.flac', 'http://42.192.121.230:9000/default/20220526/40d6131707db4e97b7fd1c90ad0c3f0a.flac?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220526%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220526T130734Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=08cf2ef53ff47da107e0fb2f79c22a4c9c4d79aa722e8dab7ef1ebe586e54494', 'flac', 18844084, 'default', '20220526/40d6131707db4e97b7fd1c90ad0c3f0a.flac', '2022-05-26 21:07:34', '2022-05-26 21:07:34');
INSERT INTO `t_file_info` VALUES (1530365650437468162, 'BZ - 35.jpg', 'http://42.192.121.230:9000/default/20220528/db8afbbb64f749619af31f6b85b1406d.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=admin%2F20220528%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220528T014938Z&X-Amz-Expires=7200&X-Amz-SignedHeaders=host&X-Amz-Signature=96d40751817f61f53343540761c25477270e3b829c195f0111da6e703359197f', 'jpg', 1114159, 'default', '20220528/db8afbbb64f749619af31f6b85b1406d.jpg', '2022-05-28 09:49:39', '2022-05-28 09:49:39');

-- ----------------------------
-- Table structure for t_job_information
-- ----------------------------
DROP TABLE IF EXISTS `t_job_information`;
CREATE TABLE `t_job_information`  (
  `id` bigint NOT NULL,
  `task_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `task_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_class` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT 1,
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_job_information
-- ----------------------------
INSERT INTO `t_job_information` VALUES (675674866266240, '675674866094208', '定时删除系统日志', 'default', 'com.cms.job.task.bean.CronLoginLogJob', '0 0/10 * * * ? ', 1, '', '2022-04-10 21:20:41', '2022-04-10 21:20:41');

SET FOREIGN_KEY_CHECKS = 1;
