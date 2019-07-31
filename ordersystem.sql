/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : ordersystem

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2019-07-14 21:38:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `detail_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '订单详情表id',
  `detail_type` varchar(255) DEFAULT NULL COMMENT '明细类型 1 酒水明细 2菜品类明细 3服务类明细',
  `order_id` int(32) DEFAULT NULL COMMENT '订单总表id',
  `round_id` int(32) DEFAULT NULL COMMENT '点餐轮数id',
  `product_id` int(32) DEFAULT NULL COMMENT '商品id',
  `product_name` varchar(255) DEFAULT NULL COMMENT '商品名',
  `product_price` double(10,2) DEFAULT NULL,
  `product_number` int(32) DEFAULT NULL COMMENT '商品数量',
  `category_id` int(32) DEFAULT NULL COMMENT '分类id',
  `category_name` varchar(255) DEFAULT NULL COMMENT '分类名称',
  `state` varchar(1) DEFAULT '0' COMMENT '删除状态 0正常 1删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='订单详情表';

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('1', '2', '1', '1', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '0', '2019-07-14 16:59:43', '2019-07-14 16:59:43');
INSERT INTO `order_detail` VALUES ('2', '2', '2', '2', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '0', '2019-07-14 16:59:55', '2019-07-14 16:59:55');
INSERT INTO `order_detail` VALUES ('3', '2', '2', '3', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '0', '2019-07-14 17:00:04', '2019-07-14 17:00:04');
INSERT INTO `order_detail` VALUES ('4', '2', '2', '4', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '0', '2019-07-14 17:00:08', '2019-07-14 17:00:08');
INSERT INTO `order_detail` VALUES ('5', '2', '1', '5', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '0', '2019-07-14 17:00:17', '2019-07-14 17:00:17');
INSERT INTO `order_detail` VALUES ('6', '1', '1', null, '18', '开胃酒1', '90.00', '5', '9', '开胃酒', '0', '2019-07-14 17:00:25', '2019-07-14 17:00:25');
INSERT INTO `order_detail` VALUES ('7', '1', '1', null, '19', '开胃酒2', '90.00', '5', '9', '开胃酒', '0', '2019-07-14 17:00:25', '2019-07-14 17:00:25');
INSERT INTO `order_detail` VALUES ('8', '1', '1', null, '18', '开胃酒1', '90.00', '5', '9', '开胃酒', '0', '2019-07-14 17:00:28', '2019-07-14 17:00:28');
INSERT INTO `order_detail` VALUES ('9', '1', '1', null, '19', '开胃酒2', '90.00', '5', '9', '开胃酒', '0', '2019-07-14 17:00:28', '2019-07-14 17:00:28');
INSERT INTO `order_detail` VALUES ('10', '1', '2', null, '18', '开胃酒1', '90.00', '5', '9', '开胃酒', '0', '2019-07-14 17:00:44', '2019-07-14 17:00:44');
INSERT INTO `order_detail` VALUES ('11', '1', '2', null, '19', '开胃酒2', '90.00', '5', '9', '开胃酒', '0', '2019-07-14 17:00:44', '2019-07-14 17:00:44');
INSERT INTO `order_detail` VALUES ('12', '1', '2', null, '18', '开胃酒1', '90.00', '5', '9', '开胃酒', '0', '2019-07-14 17:00:46', '2019-07-14 17:00:46');
INSERT INTO `order_detail` VALUES ('13', '1', '2', null, '19', '开胃酒2', '90.00', '5', '9', '开胃酒', '0', '2019-07-14 17:00:46', '2019-07-14 17:00:46');
INSERT INTO `order_detail` VALUES ('14', '2', '3', '6', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '1', '2019-07-14 17:02:45', '2019-07-14 17:02:45');
INSERT INTO `order_detail` VALUES ('15', '2', '3', '7', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '1', '2019-07-14 17:04:34', '2019-07-14 17:04:34');
INSERT INTO `order_detail` VALUES ('16', '2', '3', '8', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '1', '2019-07-14 17:06:02', '2019-07-14 17:06:02');
INSERT INTO `order_detail` VALUES ('17', '2', '3', '9', '1', '铁板豆腐', '0.00', '5', '4', '铁板', '1', '2019-07-14 17:06:14', '2019-07-14 17:06:14');
INSERT INTO `order_detail` VALUES ('18', '1', '3', null, '18', '开胃酒1', '90.00', '5', '9', '开胃酒', '1', '2019-07-14 17:06:44', '2019-07-14 17:06:44');
INSERT INTO `order_detail` VALUES ('19', '1', '3', null, '19', '开胃酒2', '90.00', '5', '9', '开胃酒', '1', '2019-07-14 17:06:44', '2019-07-14 17:06:44');

-- ----------------------------
-- Table structure for order_master
-- ----------------------------
DROP TABLE IF EXISTS `order_master`;
CREATE TABLE `order_master` (
  `order_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `buyer_id` int(32) DEFAULT NULL COMMENT '餐区ID',
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单编号',
  `order_type` varchar(255) DEFAULT NULL COMMENT '订单类型 1午餐 2晚餐',
  `total_amount` double(10,2) DEFAULT NULL COMMENT '订单总金额',
  `drinks_total_amount` double(10,2) DEFAULT NULL COMMENT '酒水总价',
  `table_num` varchar(255) DEFAULT NULL COMMENT '台号',
  `adult` int(11) DEFAULT '0' COMMENT '成年人数',
  `child` int(11) DEFAULT '0' COMMENT '小孩人数',
  `lunch_num` int(11) DEFAULT '1' COMMENT '每轮午餐能点的数量',
  `dinner_num` int(11) DEFAULT '1' COMMENT '每轮晚餐能点的数量',
  `wait_time` int(11) DEFAULT '1' COMMENT '每轮需要等的时间',
  `status` varchar(2) DEFAULT NULL COMMENT '订单状态 0未结账 1结账中 2已结账 3已取消',
  `state` varchar(1) DEFAULT '0' COMMENT '删除状态 0正常 1删除',
  `mac` varchar(255) DEFAULT NULL COMMENT 'mac地址',
  `open_time` datetime DEFAULT NULL COMMENT '开台时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='订单总表';

-- ----------------------------
-- Records of order_master
-- ----------------------------
INSERT INTO `order_master` VALUES ('1', '1', '201907140001', '1', '1920.00', '1800.00', '101', '2', '2', '5', '5', '20', '0', '0', null, '2019-07-14 16:59:30', '2019-07-14 16:59:30', '2019-07-14 17:00:28');
INSERT INTO `order_master` VALUES ('2', '1', '201907140002', '1', '1920.00', '1800.00', '101', '2', '2', '5', '5', '20', '0', '0', null, '2019-07-14 16:59:32', '2019-07-14 16:59:32', '2019-07-14 17:00:47');
INSERT INTO `order_master` VALUES ('3', '1', '201907140003', '2', '1050.00', '900.00', '101', '2', '2', '5', '5', '20', '0', '1', null, '2019-07-14 17:01:37', '2019-07-14 17:01:37', '2019-07-14 17:06:44');

-- ----------------------------
-- Table structure for order_printer_log
-- ----------------------------
DROP TABLE IF EXISTS `order_printer_log`;
CREATE TABLE `order_printer_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` int(11) DEFAULT NULL COMMENT '订单主表ID',
  `content` text COMMENT '服务内容',
  `printer_id` int(11) DEFAULT NULL COMMENT '关联打印机ID',
  `pinter_type` varchar(1) DEFAULT NULL COMMENT '1菜品打印 2酒水打印 3服务打印 4结账单打印',
  `status` varchar(1) DEFAULT '0' COMMENT '0未打印、1已打印 2打印失败',
  `state` varchar(1) DEFAULT '0' COMMENT '0正常 1删除',
  `msg` text COMMENT '打印失败原因',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_printer_log
-- ----------------------------
INSERT INTO `order_printer_log` VALUES ('1', '1', '{\"id\":1,\"num\":1,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":1,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":1}],\"orderId\":1,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 16:59:44', '2019-07-14 16:59:44');
INSERT INTO `order_printer_log` VALUES ('2', '2', '{\"id\":2,\"num\":1,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":2,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":2}],\"orderId\":2,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 16:59:55', '2019-07-14 16:59:55');
INSERT INTO `order_printer_log` VALUES ('3', '2', '{\"id\":3,\"num\":2,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":2,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":3}],\"orderId\":2,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 17:00:04', '2019-07-14 17:00:04');
INSERT INTO `order_printer_log` VALUES ('4', '2', '{\"id\":4,\"num\":3,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":2,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":4}],\"orderId\":2,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 17:00:08', '2019-07-14 17:00:08');
INSERT INTO `order_printer_log` VALUES ('5', '1', '{\"id\":5,\"num\":2,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":1,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":5}],\"orderId\":1,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 17:00:17', '2019-07-14 17:00:17');
INSERT INTO `order_printer_log` VALUES ('6', '1', '[{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":1,\"pageNum\":1,\"pageSize\":10,\"productId\":18,\"productName\":\"开胃酒1\",\"productNumber\":5,\"productPrice\":90.0},{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":1,\"pageNum\":1,\"pageSize\":10,\"productId\":19,\"productName\":\"开胃酒2\",\"productNumber\":5,\"productPrice\":90.0}]', null, '2', '0', '0', null, '2019-07-14 17:00:25', '2019-07-14 17:00:25');
INSERT INTO `order_printer_log` VALUES ('7', '1', '[{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":1,\"pageNum\":1,\"pageSize\":10,\"productId\":18,\"productName\":\"开胃酒1\",\"productNumber\":5,\"productPrice\":90.0},{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":1,\"pageNum\":1,\"pageSize\":10,\"productId\":19,\"productName\":\"开胃酒2\",\"productNumber\":5,\"productPrice\":90.0}]', null, '2', '0', '0', null, '2019-07-14 17:00:28', '2019-07-14 17:00:28');
INSERT INTO `order_printer_log` VALUES ('8', '2', '[{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":2,\"pageNum\":1,\"pageSize\":10,\"productId\":18,\"productName\":\"开胃酒1\",\"productNumber\":5,\"productPrice\":90.0},{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":2,\"pageNum\":1,\"pageSize\":10,\"productId\":19,\"productName\":\"开胃酒2\",\"productNumber\":5,\"productPrice\":90.0}]', null, '2', '0', '0', null, '2019-07-14 17:00:44', '2019-07-14 17:00:44');
INSERT INTO `order_printer_log` VALUES ('9', '2', '[{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":2,\"pageNum\":1,\"pageSize\":10,\"productId\":18,\"productName\":\"开胃酒1\",\"productNumber\":5,\"productPrice\":90.0},{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":2,\"pageNum\":1,\"pageSize\":10,\"productId\":19,\"productName\":\"开胃酒2\",\"productNumber\":5,\"productPrice\":90.0}]', null, '2', '0', '0', null, '2019-07-14 17:00:47', '2019-07-14 17:00:47');
INSERT INTO `order_printer_log` VALUES ('10', '3', '{\"id\":6,\"num\":1,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":3,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":6}],\"orderId\":3,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 17:02:45', '2019-07-14 17:02:45');
INSERT INTO `order_printer_log` VALUES ('11', '3', '{\"id\":7,\"num\":2,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":3,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":7}],\"orderId\":3,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 17:04:58', '2019-07-14 17:04:58');
INSERT INTO `order_printer_log` VALUES ('12', '3', '{\"id\":8,\"num\":3,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":3,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":8}],\"orderId\":3,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 17:06:05', '2019-07-14 17:06:05');
INSERT INTO `order_printer_log` VALUES ('13', '3', '{\"id\":9,\"num\":4,\"orderDetails\":[{\"categoryId\":4,\"categoryName\":\"铁板\",\"detailType\":\"2\",\"orderId\":3,\"pageNum\":1,\"pageSize\":10,\"productId\":1,\"productName\":\"铁板豆腐\",\"productNumber\":5,\"productPrice\":0.0,\"roundId\":9}],\"orderId\":3,\"pageNum\":1,\"pageSize\":10}', null, '1', '0', '0', null, '2019-07-14 17:06:15', '2019-07-14 17:06:15');
INSERT INTO `order_printer_log` VALUES ('14', '3', '[{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":3,\"pageNum\":1,\"pageSize\":10,\"productId\":18,\"productName\":\"开胃酒1\",\"productNumber\":5,\"productPrice\":90.0},{\"categoryId\":9,\"categoryName\":\"开胃酒\",\"detailType\":\"1\",\"orderId\":3,\"pageNum\":1,\"pageSize\":10,\"productId\":19,\"productName\":\"开胃酒2\",\"productNumber\":5,\"productPrice\":90.0}]', null, '2', '0', '0', null, '2019-07-14 17:06:44', '2019-07-14 17:06:44');

-- ----------------------------
-- Table structure for order_round
-- ----------------------------
DROP TABLE IF EXISTS `order_round`;
CREATE TABLE `order_round` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `num` int(32) DEFAULT '1' COMMENT '第几轮',
  `state` varchar(1) DEFAULT '0' COMMENT '删除状态 0正常 1删除',
  `order_id` int(32) DEFAULT NULL COMMENT '订单ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='点餐轮数表';

-- ----------------------------
-- Records of order_round
-- ----------------------------
INSERT INTO `order_round` VALUES ('1', '1', '0', '1', '2019-07-14 16:59:43');
INSERT INTO `order_round` VALUES ('2', '1', '0', '2', '2019-07-14 16:59:55');
INSERT INTO `order_round` VALUES ('3', '2', '0', '2', '2019-07-14 17:00:04');
INSERT INTO `order_round` VALUES ('4', '3', '0', '2', '2019-07-14 17:00:08');
INSERT INTO `order_round` VALUES ('5', '2', '0', '1', '2019-07-14 17:00:17');
INSERT INTO `order_round` VALUES ('6', '1', '1', '3', '2019-07-14 17:02:45');
INSERT INTO `order_round` VALUES ('7', '2', '1', '3', '2019-07-14 17:04:34');
INSERT INTO `order_round` VALUES ('8', '3', '1', '3', '2019-07-14 17:06:02');
INSERT INTO `order_round` VALUES ('9', '4', '1', '3', '2019-07-14 17:06:14');

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `category_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '商品类型id',
  `parent_id` int(32) NOT NULL DEFAULT '0' COMMENT '父id',
  `category_name` varchar(255) NOT NULL COMMENT '商品类型名',
  `printid` int(21) DEFAULT NULL COMMENT '打印机id',
  `state` varchar(1) DEFAULT '0' COMMENT '状态 0正常 1删除',
  `pic` varchar(255) DEFAULT NULL COMMENT '图片',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='商品类型表';

-- ----------------------------
-- Records of product_category
-- ----------------------------
INSERT INTO `product_category` VALUES ('1', '0', '酒⽔分类', '1', '0', '3fd3908d2c624a169d535b90bbdcbc28.jpg', null, '2019-07-14 14:35:31');
INSERT INTO `product_category` VALUES ('2', '0', '菜品分类', '2', '0', 'b10f9813266c47d795953b6a63e41aee.png', null, '2019-07-09 15:14:50');
INSERT INTO `product_category` VALUES ('3', '0', '服务分类', '3', '0', '1a07df5df39b4e298331ca393c54ffc1.png', null, '2019-07-09 15:13:36');
INSERT INTO `product_category` VALUES ('4', '2', '铁板', '2', '0', 'c9cf6d698fe548fb828d69bf3e0267c9.png', null, '2019-07-09 15:25:57');
INSERT INTO `product_category` VALUES ('5', '2', '饮品', '2', '0', '9813ed2d9352436fafb23f4965140421.png', null, '2019-07-09 15:29:44');
INSERT INTO `product_category` VALUES ('6', '2', '沙拉', '2', '0', '93b218f282c64e708b21844688079342.png', null, '2019-07-09 15:52:58');
INSERT INTO `product_category` VALUES ('7', '2', '油锅', '1', '0', '74da8d10d7c24fa2a497bbea3f70424a.png', null, '2019-07-09 15:46:05');
INSERT INTO `product_category` VALUES ('8', '2', '寿司', '2', '0', 'd797b6cd73a64747ba5734c0c288d7d9.png', null, '2019-07-09 15:21:58');
INSERT INTO `product_category` VALUES ('9', '1', '开胃酒', '1', '0', '8e6790a41b5c4300b2aa6b7e6e3bc187.jpg', null, '2019-07-09 16:28:05');
INSERT INTO `product_category` VALUES ('10', '1', '⾼度酒', '1', '0', '3af9d58893be416582abb62d64fda1c7.png', null, '2019-07-09 16:30:01');
INSERT INTO `product_category` VALUES ('11', '1', '威⼠忌', '1', '0', 'c0550faba5854b7683a2d0cb4f5aad5b.png', null, '2019-07-09 16:06:55');
INSERT INTO `product_category` VALUES ('12', '1', '鸡尾酒', '1', '0', '43ad435be56a42b88d931fc20f00d877.png', null, '2019-07-09 16:11:20');
INSERT INTO `product_category` VALUES ('13', '1', '软饮料', '1', '0', '75c401819fee4496bf451aa434abf3bf.png', null, '2019-07-09 16:13:31');
INSERT INTO `product_category` VALUES ('14', '1', '红酒', '1', '0', 'b8f0a045c3f94cfa85b7dff94baaeffa.png', null, '2019-07-09 16:19:18');
INSERT INTO `product_category` VALUES ('15', '1', '⽩酒', '1', '0', 'c5b59dfd30a94a749e32d63b99e9b577.png', null, '2019-07-09 16:26:37');
INSERT INTO `product_category` VALUES ('16', '1', '热饮', '1', '0', 'dbc89369fd164ac2823eb60a4e35fcc5.png', null, '2019-07-09 16:21:35');
INSERT INTO `product_category` VALUES ('17', '3', '刀叉', '3', '0', '6910081ac8ef441190b62bef56094406.png', '2019-07-08 21:36:25', '2019-07-09 16:42:54');
INSERT INTO `product_category` VALUES ('18', '3', '勺子', '3', '0', '943b30e410aa40888866b0c302d25e63.png', '2019-07-08 21:37:09', '2019-07-09 16:14:54');
INSERT INTO `product_category` VALUES ('37', '2', '炒饭', '2', '0', 'a39360730b0d4147bceb64aab6d0f5a8.jpg', '2019-07-09 16:56:23', '2019-07-09 16:56:23');

-- ----------------------------
-- Table structure for product_info
-- ----------------------------
DROP TABLE IF EXISTS `product_info`;
CREATE TABLE `product_info` (
  `product_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '商品id号',
  `product_name` varchar(255) DEFAULT NULL COMMENT '商品名',
  `product_price` double(5,2) DEFAULT NULL COMMENT '商品单价',
  `product_inventory` int(8) DEFAULT NULL COMMENT '商品库存',
  `product_status` varchar(1) DEFAULT NULL COMMENT '商品状态1上架 0下架',
  `category_id` int(32) DEFAULT NULL COMMENT '商品类型id',
  `product_pic` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `state` varchar(1) DEFAULT '0' COMMENT '删除状态0正常 1删除',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='商品信息表';

-- ----------------------------
-- Records of product_info
-- ----------------------------
INSERT INTO `product_info` VALUES ('1', '铁板豆腐', '0.00', null, '1', '4', 'bbff7e986f6043b1a4840ea57e0a08cb.jpg', '2019-07-14 13:22:38', '2019-07-14 13:38:51', '0');
INSERT INTO `product_info` VALUES ('2', '铁板牛肉', '0.00', null, '1', '4', '97270ceae9944322a4f3e4972da8c6f6.jpg', '2019-07-14 13:23:24', '2019-07-14 13:38:45', '0');
INSERT INTO `product_info` VALUES ('3', '红烧肉', '0.00', null, '1', '7', '65aa61c38074473d9cadbf2009038962.jpg', '2019-07-14 13:25:45', '2019-07-14 13:38:35', '0');
INSERT INTO `product_info` VALUES ('4', '红烧肉2', '0.00', null, '1', '7', 'bdb8fb8f2804402194642a862d45261d.jpg', '2019-07-14 13:26:05', '2019-07-14 13:38:29', '0');
INSERT INTO `product_info` VALUES ('5', '红烧肉3', '0.00', null, '1', '37', '02ab2685686947b2833c7c5508ca7601.jpg', '2019-07-14 13:26:47', '2019-07-14 13:38:21', '0');
INSERT INTO `product_info` VALUES ('6', '寿司1', '0.00', null, '1', '8', '01a4cd08be834798aff0a3ed23850ed9.jpg', '2019-07-14 13:29:19', '2019-07-14 13:29:19', '0');
INSERT INTO `product_info` VALUES ('7', '寿司2', '0.00', null, '1', '8', '14a1e9cc1f5b4a4eb3859ee656a15db2.jpg', '2019-07-14 13:36:17', '2019-07-14 13:36:17', '0');
INSERT INTO `product_info` VALUES ('8', '寿司3', '0.00', null, '1', '8', 'e56b7510790644fbbc7985807299078f.jpg', '2019-07-14 13:38:10', '2019-07-14 13:38:10', '0');
INSERT INTO `product_info` VALUES ('9', '寿司4', '0.00', null, '1', '8', 'e24b3887b67b487ebf92ac2aa064c6cf.jpg', '2019-07-14 13:39:14', '2019-07-14 13:39:14', '0');
INSERT INTO `product_info` VALUES ('10', '沙拉1', '0.00', null, '1', '6', '48a050b2f7bd45bdaa3435f7627f75b2.jpg', '2019-07-14 13:40:36', '2019-07-14 13:40:36', '0');
INSERT INTO `product_info` VALUES ('11', '沙拉2', '0.00', null, '1', '6', '4f3f021f9aed402c8c518720e099b9d3.jpg', '2019-07-14 13:40:55', '2019-07-14 13:40:55', '0');
INSERT INTO `product_info` VALUES ('12', '沙拉3', '0.00', null, '1', '6', 'b5220ee8a9e74fb5b3e60d7ef11f65c1.jpg', '2019-07-14 13:41:14', '2019-07-14 13:41:14', '0');
INSERT INTO `product_info` VALUES ('13', '沙拉4', '0.00', null, '1', '6', '051d2baf884e45f19efb30cd3a6632a8.jpg', '2019-07-14 13:41:35', '2019-07-14 13:41:35', '0');
INSERT INTO `product_info` VALUES ('14', '炒饭1', '0.00', null, '1', '37', 'a76543510a0d4dbebdfb3db083fbb025.jpg', '2019-07-14 13:43:18', '2019-07-14 13:43:18', '0');
INSERT INTO `product_info` VALUES ('15', '炒饭2', '0.00', null, '1', '37', '5d26e4ae601e4064904e6ad37a502858.jpg', '2019-07-14 13:43:32', '2019-07-14 13:43:32', '0');
INSERT INTO `product_info` VALUES ('16', '炒饭3', '0.00', null, '1', '37', 'd3860b9992694766bc787a0315b525ae.jpg', '2019-07-14 13:43:51', '2019-07-14 13:43:51', '0');
INSERT INTO `product_info` VALUES ('17', '炒饭4', '0.00', null, '1', '37', '211b3a8591bd471db8f1f0a566153af8.jpg', '2019-07-14 13:44:07', '2019-07-14 13:44:19', '0');
INSERT INTO `product_info` VALUES ('18', '开胃酒1', '90.00', null, '1', '9', '626a963039ae46fcae9351da6d78667f.jpg', '2019-07-14 13:46:36', '2019-07-14 13:46:36', '0');
INSERT INTO `product_info` VALUES ('19', '开胃酒2', '89.00', null, '1', '9', '1c84a00c456148f882558920936ca378.jpg', '2019-07-14 13:46:55', '2019-07-14 13:46:55', '0');
INSERT INTO `product_info` VALUES ('20', '开胃酒3', '600.00', null, '1', '9', '662dd82e9cb641f4ac2934951264b119.jpg', '2019-07-14 13:47:19', '2019-07-14 13:47:19', '0');
INSERT INTO `product_info` VALUES ('21', '开胃酒4', '125.00', null, '1', '9', 'da3c9a7d27b04a858975e695f68244e0.jpg', '2019-07-14 13:47:39', '2019-07-14 13:47:39', '0');
INSERT INTO `product_info` VALUES ('22', '⾼度酒1', '900.00', null, '1', '10', 'f5ac01d7f8fa4343a7ff655b2db9d996.jpg', '2019-07-14 13:49:05', '2019-07-14 13:49:05', '0');
INSERT INTO `product_info` VALUES ('23', '⾼度酒2', '780.00', null, '1', '10', '46a5a6752bf04a2f9ae0857adbfae7a9.jpg', '2019-07-14 13:49:26', '2019-07-14 13:49:26', '0');
INSERT INTO `product_info` VALUES ('24', '⾼度酒3', '890.00', null, '1', '10', '03da570f230c4c60805f65021d1a24b0.jpg', '2019-07-14 13:49:52', '2019-07-14 13:49:52', '0');
INSERT INTO `product_info` VALUES ('25', '鸡尾酒1', '690.00', null, '1', '12', 'f6c40b5626994d3d866bf0f77df09f98.jpg', '2019-07-14 13:51:04', '2019-07-14 13:51:04', '0');
INSERT INTO `product_info` VALUES ('26', '鸡尾酒2', '780.00', null, '1', '12', '3bf993590e134cec9b6e55a54bd9089d.jpg', '2019-07-14 13:51:22', '2019-07-14 13:51:22', '0');
INSERT INTO `product_info` VALUES ('27', '鸡尾酒3', '790.00', null, '1', '12', 'e7216d0ae6404f74a685003214fbdb2b.jpg', '2019-07-14 13:51:44', '2019-07-14 13:51:44', '0');
INSERT INTO `product_info` VALUES ('28', '饮料1', '35.00', null, '1', '13', '4f2fef9f1ab84176a91c35d7b53c8909.jpg', '2019-07-14 13:53:49', '2019-07-14 13:53:49', '0');
INSERT INTO `product_info` VALUES ('29', '饮料2', '46.00', null, '1', '13', 'ba751b3242f7425283eb54af45a74091.jpg', '2019-07-14 13:54:05', '2019-07-14 13:54:05', '0');
INSERT INTO `product_info` VALUES ('30', '饮料3', '59.00', null, '1', '13', '967ce61c71d945a5baf23278e8b821da.jpg', '2019-07-14 13:54:23', '2019-07-14 13:54:23', '0');
INSERT INTO `product_info` VALUES ('31', '红酒1', '198.00', null, '1', '14', '134a3ae2d03246428fc9fb3349be8f5d.jpg', '2019-07-14 14:26:13', '2019-07-14 14:26:13', '0');
INSERT INTO `product_info` VALUES ('32', '红酒2', '298.00', null, '1', '14', '6ffa5d1f079f4ce2acce9fc1c500b7d1.jpg', '2019-07-14 14:26:34', '2019-07-14 14:26:34', '0');
INSERT INTO `product_info` VALUES ('33', '红酒3', '399.00', null, '1', '14', '66b22f31838449ccb4fc67ef59d7162a.jpg', '2019-07-14 14:26:52', '2019-07-14 14:26:52', '0');
INSERT INTO `product_info` VALUES ('34', '⽩酒1', '289.00', null, '1', '15', '113a3ecd338549b29a8b6977df18222e.jpg', '2019-07-14 14:28:49', '2019-07-14 14:28:49', '0');
INSERT INTO `product_info` VALUES ('35', '⽩酒2', '389.00', null, '1', '15', '13f3227229754424b6e91b7f34f6de9e.jpg', '2019-07-14 14:29:07', '2019-07-14 14:29:07', '0');
INSERT INTO `product_info` VALUES ('36', '⽩酒3', '399.00', null, '1', '15', '2be53e6906434bfea124c7b62f890cf4.jpg', '2019-07-14 14:29:25', '2019-07-14 14:29:25', '0');
INSERT INTO `product_info` VALUES ('37', '刀叉1', '0.00', null, '1', '17', '57a105b0510e4fbb8d775cad3610202a.jpg', '2019-07-14 14:30:00', '2019-07-14 14:31:56', '0');
INSERT INTO `product_info` VALUES ('38', '刀叉2', '0.00', null, '1', '17', '47646ceb595c41d19765ae0a1c661ac5.jpg', '2019-07-14 14:30:15', '2019-07-14 14:31:50', '0');
INSERT INTO `product_info` VALUES ('39', '刀叉3', '0.00', null, '1', '17', '6013f8d50027447a9d61d426ef683f12.jpg', '2019-07-14 14:30:31', '2019-07-14 14:32:06', '0');
INSERT INTO `product_info` VALUES ('40', '勺子1', '0.00', null, '1', '18', '41f526f00ba946ef912a63b230995830.jpg', '2019-07-14 14:31:42', '2019-07-14 14:31:42', '0');
INSERT INTO `product_info` VALUES ('41', '勺子2', '0.00', null, '1', '18', '372266ef267e480bb278b65dddf07c2e.jpg', '2019-07-14 14:32:24', '2019-07-14 14:32:24', '0');
INSERT INTO `product_info` VALUES ('42', '热饮1', '30.00', null, '1', '16', '530c0e7fbc4b4523a63dda721b77e105.jpg', '2019-07-14 14:34:00', '2019-07-14 14:34:00', '0');
INSERT INTO `product_info` VALUES ('43', '热饮2', '50.00', null, '1', '16', 'e5a54ffb36454d8ca7057b9fc2bf7fc6.jpg', '2019-07-14 14:34:15', '2019-07-14 14:34:15', '0');
INSERT INTO `product_info` VALUES ('44', '热饮3', '26.00', null, '1', '16', '66fa52408710444a9d014db1787b9ce0.jpg', '2019-07-14 14:34:47', '2019-07-14 14:34:47', '0');

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `create_time` char(19) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES ('1', 'admin', 'admin', '1234', '2018-10-29 17:05:23');
INSERT INTO `t_admin` VALUES ('73', '任年祥', 'SR', '1234', '2018-10-29 17:05:23');
INSERT INTO `t_admin` VALUES ('74', '程乘', 'CC', '1234', '2018-10-29 17:05:58');
INSERT INTO `t_admin` VALUES ('75', '徐强', 'XuQiang', '1234', '2018-10-29 17:06:29');
INSERT INTO `t_admin` VALUES ('76', '单发显', 'ShanFaxian', '1234', '2018-10-29 17:07:06');
INSERT INTO `t_admin` VALUES ('77', '张爱军', 'ZhangAijun', '1234', '2018-10-29 17:07:46');
INSERT INTO `t_admin` VALUES ('78', '朱贺', 'ZhuHe', '1234', '2018-10-29 17:08:23');
INSERT INTO `t_admin` VALUES ('79', '宋培江', 'SongJiang', '1234', '2018-10-29 17:09:16');

-- ----------------------------
-- Table structure for t_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_role`;
CREATE TABLE `t_admin_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) DEFAULT NULL,
  `role_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin_role
-- ----------------------------
INSERT INTO `t_admin_role` VALUES ('6', '5', '1');
INSERT INTO `t_admin_role` VALUES ('7', '5', '7');
INSERT INTO `t_admin_role` VALUES ('9', '71', '2');
INSERT INTO `t_admin_role` VALUES ('11', '71', '10');
INSERT INTO `t_admin_role` VALUES ('12', '69', '2');
INSERT INTO `t_admin_role` VALUES ('23', '2', '2');
INSERT INTO `t_admin_role` VALUES ('24', '1', '1');
INSERT INTO `t_admin_role` VALUES ('26', '72', '1');
INSERT INTO `t_admin_role` VALUES ('29', '73', '26');
INSERT INTO `t_admin_role` VALUES ('30', '75', '26');
INSERT INTO `t_admin_role` VALUES ('32', '78', '26');
INSERT INTO `t_admin_role` VALUES ('33', '77', '26');
INSERT INTO `t_admin_role` VALUES ('34', '76', '26');
INSERT INTO `t_admin_role` VALUES ('35', '74', '2');
INSERT INTO `t_admin_role` VALUES ('38', '79', '1');
INSERT INTO `t_admin_role` VALUES ('40', '79', '2');
INSERT INTO `t_admin_role` VALUES ('43', '79', '26');

-- ----------------------------
-- Table structure for t_area
-- ----------------------------
DROP TABLE IF EXISTS `t_area`;
CREATE TABLE `t_area` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '餐区名称',
  `pwd` varchar(255) DEFAULT NULL COMMENT '餐区密码',
  `state` varchar(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='餐区配置表';

-- ----------------------------
-- Records of t_area
-- ----------------------------
INSERT INTO `t_area` VALUES ('1', 'K1', '123456', '0');
INSERT INTO `t_area` VALUES ('2', 'k2', '123456', '1');
INSERT INTO `t_area` VALUES ('3', 'k2', '123456', '0');
INSERT INTO `t_area` VALUES ('4', 'k3', '123456', '0');
INSERT INTO `t_area` VALUES ('5', 'k4', '123456', '0');
INSERT INTO `t_area` VALUES ('6', 'K5', '123456', '0');
INSERT INTO `t_area` VALUES ('7', 'K6', '123456', '0');
INSERT INTO `t_area` VALUES ('8', 'K7', '123456', '0');
INSERT INTO `t_area` VALUES ('9', 'K8', '123456', '0');
INSERT INTO `t_area` VALUES ('10', 'K9', '123456', '0');
INSERT INTO `t_area` VALUES ('11', 'K10', '123456', '0');
INSERT INTO `t_area` VALUES ('12', 'K11', '123456', '0');
INSERT INTO `t_area` VALUES ('13', 'k12', '123456', '0');

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pid` int(10) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `ord` int(11) DEFAULT NULL COMMENT '排序',
  `no` varchar(255) DEFAULT NULL COMMENT '编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('1', '系统菜单', '0', null, 'glyphicon glyphicon-th-list', '0', 'mean_0');
INSERT INTO `t_permission` VALUES ('2', '数据管理', '1', null, 'glyphicon glyphicon-equalizer', '1', 'mean_1');
INSERT INTO `t_permission` VALUES ('3', '菜品管理', '1', '', 'glyphicon glyphicon-ok', '2', 'mean_2');
INSERT INTO `t_permission` VALUES ('4', '系统设置管理', '1', null, 'glyphicon glyphicon-cog', '3', 'mean_3');
INSERT INTO `t_permission` VALUES ('5', '权限管理', '1', null, 'glyphicon glyphicon glyphicon-tasks', '4', 'mean_4');
INSERT INTO `t_permission` VALUES ('6', '订单数据', '2', '/order/index', 'glyphicon glyphicon-list-alt', '101', 'mean_101');
INSERT INTO `t_permission` VALUES ('7', '数据分析', '2', '/admin/dataAnalysis', 'glyphicon glyphicon-stats', '102', 'mean_102');
INSERT INTO `t_permission` VALUES ('8', '菜品列表', '3', '/product/index', 'glyphicon glyphicon-check', '201', 'mean_201');
INSERT INTO `t_permission` VALUES ('9', '菜品品类管理', '3', '/category/index', 'glyphicon glyphicon-tag', '202', 'mean_202');
INSERT INTO `t_permission` VALUES ('10', '系统设置', '4', '/setting/index', 'glyphicon glyphicon-cog', '301', 'mean_301');
INSERT INTO `t_permission` VALUES ('11', '打印机设置', '4', '/printer/index', 'glyphicon glyphicon-print', '302', 'mean_302');
INSERT INTO `t_permission` VALUES ('12', '管理员维护', '5', '/admin/index', 'glyphicon glyphicon-user', '401', 'mean_401');
INSERT INTO `t_permission` VALUES ('13', '角色维护', '5', '/role/index', 'glyphicon glyphicon-knight', '402', 'mean_402');

-- ----------------------------
-- Table structure for t_printer
-- ----------------------------
DROP TABLE IF EXISTS `t_printer`;
CREATE TABLE `t_printer` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '打印机名称',
  `ip` varchar(20) NOT NULL COMMENT '打印机ip',
  `port` int(11) DEFAULT NULL COMMENT '打印机端口',
  `status` char(1) NOT NULL COMMENT '状态0正常1删除',
  `state` varchar(1) DEFAULT '0' COMMENT '删除状态 0 正常 1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='打印机配置表';

-- ----------------------------
-- Records of t_printer
-- ----------------------------
INSERT INTO `t_printer` VALUES ('1', '吧台打印机', '192.168.1.2', '22', '0', '0');
INSERT INTO `t_printer` VALUES ('2', '后厨打印机', '192.168.1.3', '22', '0', '0');
INSERT INTO `t_printer` VALUES ('3', '服务台打印机', '192.168.1.4', '22', '0', '0');
INSERT INTO `t_printer` VALUES ('4', '333', '192.168.1.89', '22', '0', '0');
INSERT INTO `t_printer` VALUES ('5', '444', '192.168.1.79', '22', '0', '0');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '超级管理员');
INSERT INTO `t_role` VALUES ('2', '管理员');
INSERT INTO `t_role` VALUES ('26', '管理员（仅数据）');

-- ----------------------------
-- Table structure for t_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` int(10) DEFAULT NULL,
  `permission_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
INSERT INTO `t_role_permission` VALUES ('26', '26', '1');
INSERT INTO `t_role_permission` VALUES ('27', '26', '2');
INSERT INTO `t_role_permission` VALUES ('28', '26', '6');
INSERT INTO `t_role_permission` VALUES ('29', '26', '3');
INSERT INTO `t_role_permission` VALUES ('30', '26', '8');
INSERT INTO `t_role_permission` VALUES ('31', '26', '9');
INSERT INTO `t_role_permission` VALUES ('32', '1', '1');
INSERT INTO `t_role_permission` VALUES ('33', '1', '2');
INSERT INTO `t_role_permission` VALUES ('34', '1', '6');
INSERT INTO `t_role_permission` VALUES ('35', '1', '3');
INSERT INTO `t_role_permission` VALUES ('36', '1', '8');
INSERT INTO `t_role_permission` VALUES ('37', '1', '9');
INSERT INTO `t_role_permission` VALUES ('38', '1', '4');
INSERT INTO `t_role_permission` VALUES ('39', '1', '10');
INSERT INTO `t_role_permission` VALUES ('40', '1', '11');
INSERT INTO `t_role_permission` VALUES ('41', '1', '5');
INSERT INTO `t_role_permission` VALUES ('42', '1', '12');
INSERT INTO `t_role_permission` VALUES ('43', '1', '13');
INSERT INTO `t_role_permission` VALUES ('44', '2', '1');
INSERT INTO `t_role_permission` VALUES ('45', '2', '2');
INSERT INTO `t_role_permission` VALUES ('46', '2', '6');
INSERT INTO `t_role_permission` VALUES ('47', '2', '3');
INSERT INTO `t_role_permission` VALUES ('48', '2', '8');
INSERT INTO `t_role_permission` VALUES ('49', '2', '9');
INSERT INTO `t_role_permission` VALUES ('50', '2', '4');
INSERT INTO `t_role_permission` VALUES ('51', '2', '10');
INSERT INTO `t_role_permission` VALUES ('52', '2', '11');

-- ----------------------------
-- Table structure for t_setting
-- ----------------------------
DROP TABLE IF EXISTS `t_setting`;
CREATE TABLE `t_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_pwd` varchar(255) DEFAULT NULL COMMENT 'app开机密码',
  `ctl_app_pwd` varchar(255) DEFAULT NULL COMMENT '控制面板App登录密码',
  `lunch_num` int(11) DEFAULT '1' COMMENT '每轮午餐能点的数量',
  `dinner_num` int(11) DEFAULT '1' COMMENT '每轮晚餐能点的数量',
  `wait_time` int(11) DEFAULT '1' COMMENT '每轮需要等的时间',
  `adult_lunch_price` double(10,0) DEFAULT '0' COMMENT '成年人午餐价格',
  `adult_dinner_price` double(10,0) DEFAULT NULL COMMENT '成年人晚餐价格',
  `child_lunch_price` double(10,0) DEFAULT '0' COMMENT '小孩午餐价格',
  `child_dinner_price` double(10,0) DEFAULT NULL COMMENT '小孩晚餐价格',
  `service_printer_id` int(11) DEFAULT NULL COMMENT '服务台打印机id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统设置表';

-- ----------------------------
-- Records of t_setting
-- ----------------------------
INSERT INTO `t_setting` VALUES ('1', '123456', '123456', '31', '42', '26', '50', '60', '10', '15', '3');

-- ----------------------------
-- Table structure for vip_info
-- ----------------------------
DROP TABLE IF EXISTS `vip_info`;
CREATE TABLE `vip_info` (
  `vip_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '会员id号',
  `vip_name` varchar(255) DEFAULT NULL COMMENT '会员姓名',
  `vip_phone` char(11) DEFAULT NULL COMMENT '会员手机号',
  `vip_balance` double(10,2) DEFAULT NULL COMMENT '会员账号余额',
  `create_time` char(19) DEFAULT NULL,
  PRIMARY KEY (`vip_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of vip_info
-- ----------------------------
INSERT INTO `vip_info` VALUES ('1', 'Morty', '17864392521', '9685.60', '2018-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('2', '张三', '14766556812', '9930.40', '2018-09-27 11:22:50');
INSERT INTO `vip_info` VALUES ('3', '李四', '16556238635', '10000.00', '2017-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('4', '王五', '14766556813', '961.20', '2014-09-27 02:22:50');
INSERT INTO `vip_info` VALUES ('5', '赵六', '14766556814', '7300.00', '2016-09-27 11:22:50');
INSERT INTO `vip_info` VALUES ('6', '张伟', '14766556815', '2700.00', '2017-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('7', '王伟', '14766556816', '10000.00', '2017-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('8', '王芳', '14766556817', '5000.00', '2017-09-27 08:22:50');
INSERT INTO `vip_info` VALUES ('9', '王秀英', '14766556818', '7260.00', '2014-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('10', '李娜', '14766556818', '1200.00', '2017-09-27 07:22:50');
INSERT INTO `vip_info` VALUES ('11', '张丽', '14766556821', '1000.00', '2010-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('12', '任丽', '14766556822', '7000.00', '2016-09-27 09:22:50');
INSERT INTO `vip_info` VALUES ('14', '托马斯', '14766556824', '7500.00', '2013-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('15', '海绵宝宝', '14766556825', '1500.00', '2017-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('16', '派大星', '14766556826', '8000.00', '2015-09-27 03:22:50');
INSERT INTO `vip_info` VALUES ('17', '悟空', '14766556827', '9300.00', '2011-09-27 12:22:50');
INSERT INTO `vip_info` VALUES ('18', '蒙奇·D·路飞', '14766556828', '14000.00', '2017-09-27 08:22:50');
INSERT INTO `vip_info` VALUES ('20', '椎名真由理', '14766556830', '4900.00', '2017-09-27 10:22:50');
INSERT INTO `vip_info` VALUES ('21', '李三宝', '10647304931', '11980.00', '2018-10-10 20:12:59');
INSERT INTO `vip_info` VALUES ('22', '李四宝', '10647304932', '5990.00', '2018-10-12 14:39:09');
INSERT INTO `vip_info` VALUES ('23', '蕾姆', '10647304933', '31300.00', '2018-10-16 14:49:59');
INSERT INTO `vip_info` VALUES ('25', '李阿三', '10647304915', '599.00', '2018-10-29 14:12:42');
INSERT INTO `vip_info` VALUES ('26', '程乘', '18766208032', '4000.00', '2018-10-29 16:51:34');
INSERT INTO `vip_info` VALUES ('27', '马世达', '17888888888', '9740.00', '2018-10-29 19:28:36');
INSERT INTO `vip_info` VALUES ('28', '李四', '15888888888', '99643.00', '2018-10-29 19:52:19');
INSERT INTO `vip_info` VALUES ('29', '张三', '13288888888', '3632.00', '2018-10-29 20:06:50');
INSERT INTO `vip_info` VALUES ('30', '强强', '17866666666', '5680.80', '2018-10-29 20:20:27');
INSERT INTO `vip_info` VALUES ('31', '小强', '12345678900', '7360.80', '2018-10-29 20:36:59');

-- ----------------------------
-- Function structure for queryCategoryChildren
-- ----------------------------
DROP FUNCTION IF EXISTS `queryCategoryChildren`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `queryCategoryChildren`(`id` int) RETURNS varchar(400) CHARSET utf8
BEGIN
DECLARE sTemp VARCHAR(4000);
DECLARE sTempChd VARCHAR(4000);
 
SET sTemp = '$';
SET sTempChd = cast(id as char);
 
WHILE sTempChd is not NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT group_concat(category_id) INTO sTempChd FROM product_category where FIND_IN_SET(parent_id,sTempChd)>0;
END WHILE;
return sTemp;
END
;;
DELIMITER ;