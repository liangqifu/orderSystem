/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : ztgoldenarches

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2019-06-13 22:01:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `detail_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '订单详情表id',
  `order_id` int(32) DEFAULT NULL COMMENT '订单总表id',
  `round_id` int(32) DEFAULT NULL COMMENT '点餐轮数id',
  `product_id` int(32) DEFAULT NULL COMMENT '商品id',
  `product_name` varchar(255) DEFAULT NULL COMMENT '商品名',
  `product_price` double(10,2) DEFAULT NULL,
  `product_number` int(32) DEFAULT NULL COMMENT '商品数量',
  `category_id` int(32) DEFAULT NULL COMMENT '分类id',
  `category_name` varchar(255) DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COMMENT='订单详情表';

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('1', '1', null, '9', '商品名称1', '25.50', '1', null, null);
INSERT INTO `order_detail` VALUES ('2', '1', null, '10', '商品名称1', '24.00', '7', null, null);
INSERT INTO `order_detail` VALUES ('3', '1', null, '11', '商品名称1', '24.00', '4', null, null);
INSERT INTO `order_detail` VALUES ('4', '2', null, '12', '商品名称2', '24.00', '6', null, null);
INSERT INTO `order_detail` VALUES ('5', '2', null, '13', '商品名称3', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('6', '2', null, '1', '商品名称4', '24.00', '5', null, null);
INSERT INTO `order_detail` VALUES ('7', '2', null, '2', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('8', '2', null, '3', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('9', '2', null, '4', '商品名称1', '24.00', '3', null, null);
INSERT INTO `order_detail` VALUES ('10', '2', null, '18', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('11', '3', null, '17', '商品名称1', '24.00', '5', null, null);
INSERT INTO `order_detail` VALUES ('12', '3', null, '2', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('13', '3', null, '16', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('14', '3', null, '3', '商品名称1', '24.00', '6', null, null);
INSERT INTO `order_detail` VALUES ('15', '3', null, '1', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('16', '4', null, '7', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('17', '4', null, '18', '商品名称1', '24.00', '4', null, null);
INSERT INTO `order_detail` VALUES ('18', '4', null, '20', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('19', '4', null, '21', '商品名称1', '24.00', '8', null, null);
INSERT INTO `order_detail` VALUES ('20', '4', null, '16', '商品名称1', '24.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('21', '17', null, '82', '新增产品', '22.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('22', '18', null, '82', '新增产品', '22.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('23', '19', null, '79', '新增的闪频', '123.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('24', '19', null, '82', '新增产品', '22.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('25', '20', null, '33', '梨片', '6.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('26', '20', null, '29', '开心乐园餐（汉堡包）', '22.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('27', '20', null, '30', '开心乐园餐（吉士汉堡包）', '23.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('28', '20', null, '31', '开心乐园餐（麦乐鸡）', '22.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('29', '20', null, '32', '苹果片', '6.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('30', '21', null, '5', '草莓派', '8.00', '3', null, null);
INSERT INTO `order_detail` VALUES ('31', '21', null, '7', '金黄脆薯格下午茶香芋派组', '17.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('32', '22', null, '22', '草莓新地', '9.50', '2', null, null);
INSERT INTO `order_detail` VALUES ('33', '22', null, '1', '麦辣鸡翅三块', '10.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('34', '22', null, '2', '无辣不欢组合', '43.00', '0', null, null);
INSERT INTO `order_detail` VALUES ('35', '22', null, '4', '麦趣鸡盒', '79.00', '3', null, null);
INSERT INTO `order_detail` VALUES ('36', '22', null, '9', '经典麦辣鸡腿汉堡', '22.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('37', '22', null, '20', '麦旋风草莓口味', '12.50', '2', null, null);
INSERT INTO `order_detail` VALUES ('38', '23', null, '2', '无辣不欢组合', '43.00', '0', null, null);
INSERT INTO `order_detail` VALUES ('39', '24', null, '2', '无辣不欢组合', '43.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('40', '24', null, '5', '草莓派', '8.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('41', '25', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('42', '25', null, '2', '无辣不欢组合', '34.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('43', '25', null, '3', '国庆狂欢小食盒', '52.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('44', '25', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('45', '25', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('46', '25', null, '6', '金黄脆薯格下午茶鸡翅组', '15.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('47', '26', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('48', '26', null, '2', '无辣不欢组合', '34.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('49', '26', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('50', '26', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('51', '26', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('52', '26', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('53', '27', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('54', '27', null, '2', '无辣不欢组合', '34.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('55', '27', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('56', '27', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('57', '27', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('58', '27', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('59', '28', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('60', '28', null, '2', '无辣不欢组合', '34.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('61', '28', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('62', '28', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('63', '28', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('64', '28', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('65', '29', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('66', '29', null, '2', '无辣不欢组合', '34.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('67', '29', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('68', '29', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('69', '29', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('70', '29', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('71', '30', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('72', '30', null, '2', '无辣不欢组合', '34.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('73', '30', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('74', '30', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('75', '30', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('76', '30', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('77', '31', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('78', '32', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('79', '33', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('80', '34', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('81', '35', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('82', '36', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('83', '37', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('84', '38', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('85', '39', null, '3', '国庆狂欢小食盒', '52.80', '4', null, null);
INSERT INTO `order_detail` VALUES ('86', '40', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('87', '40', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('88', '41', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('89', '41', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('90', '42', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('91', '42', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('92', '43', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('93', '43', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('94', '44', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('95', '44', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('96', '45', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('97', '45', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('98', '46', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('99', '46', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('100', '46', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('101', '47', null, '4', '麦趣鸡盒', '79.00', '0', null, null);
INSERT INTO `order_detail` VALUES ('102', '47', null, '5', '草莓派', '8.00', '0', null, null);
INSERT INTO `order_detail` VALUES ('103', '47', null, '6', '金黄脆薯格下午茶鸡翅组', '19.00', '0', null, null);
INSERT INTO `order_detail` VALUES ('104', '48', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('105', '48', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('106', '48', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('107', '49', null, '4', '麦趣鸡盒', '63.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('108', '49', null, '5', '草莓派', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('109', '50', null, '29', '开心乐园餐（汉堡包）', '22.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('110', '50', null, '31', '开心乐园餐（麦乐鸡）', '22.00', '3', null, null);
INSERT INTO `order_detail` VALUES ('111', '50', null, '32', '苹果片', '6.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('112', '51', null, '29', '开心乐园餐（汉堡包）', '22.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('113', '51', null, '30', '开心乐园餐（吉士汉堡包）', '23.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('114', '51', null, '31', '开心乐园餐（麦乐鸡）', '22.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('115', '51', null, '32', '苹果片', '6.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('116', '52', null, '1', '万圣节日辣堡桶S', '67.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('117', '52', null, '3', '国庆狂欢小食盒', '66.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('118', '52', null, '5', '草莓派', '8.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('119', '53', null, '11', '麦香鸡', '13.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('120', '53', null, '13', '不素之霸双层牛肉堡', '21.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('121', '53', null, '10', '原味板烧鸡腿堡', '20.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('122', '54', null, '24', '那么大珍珠奶茶热', '21.60', '1', null, null);
INSERT INTO `order_detail` VALUES ('123', '54', null, '25', '那么大鲜柠特饮', '10.80', '1', null, null);
INSERT INTO `order_detail` VALUES ('124', '54', null, '27', '可口可乐', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('125', '55', null, '14', '麦乐鸡', '11.50', '1', null, null);
INSERT INTO `order_detail` VALUES ('126', '55', null, '15', '那么大鸡小块', '16.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('127', '55', null, '16', '那么大鸡排', '13.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('128', '55', null, '17', '香骨鸡腿', '13.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('129', '55', null, '18', '美味鲜蔬杯', '11.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('130', '56', null, '14', '鲜蔬沙拉', '11.50', '1', null, null);
INSERT INTO `order_detail` VALUES ('131', '56', null, '15', '薯条', '16.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('132', '57', null, '1', '万圣节日辣堡桶S', '53.60', '1', null, null);
INSERT INTO `order_detail` VALUES ('133', '57', null, '5', '蛋挞', '6.40', '1', null, null);
INSERT INTO `order_detail` VALUES ('134', '57', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('135', '58', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('136', '59', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('137', '60', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('138', '60', null, '4', '麦趣鸡盒', '79.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('139', '61', null, '3', '国庆狂欢小食盒', '52.80', '2', null, null);
INSERT INTO `order_detail` VALUES ('140', '61', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null);
INSERT INTO `order_detail` VALUES ('141', '61', null, '7', '金黄脆薯格下午茶香芋派组', '13.60', '2', null, null);
INSERT INTO `order_detail` VALUES ('142', '62', null, '1', '万圣节日辣堡桶S', '67.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('143', '62', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('144', '62', null, '4', '麦趣鸡盒', '79.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('145', '63', null, '3', '国庆狂欢小食盒', '52.80', '3', null, null);
INSERT INTO `order_detail` VALUES ('146', '63', null, '4', '麦趣鸡盒', '63.20', '2', null, null);
INSERT INTO `order_detail` VALUES ('147', '63', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '2', null, null);
INSERT INTO `order_detail` VALUES ('148', '63', null, '7', '金黄脆薯格下午茶香芋派组', '13.60', '3', null, null);
INSERT INTO `order_detail` VALUES ('149', '64', null, '1', '万圣节日辣堡桶S', '67.00', '3', null, null);
INSERT INTO `order_detail` VALUES ('150', '64', null, '3', '国庆狂欢小食盒', '66.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('151', '64', null, '6', '金黄脆薯格下午茶鸡翅组', '19.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('152', '64', null, '7', '金黄脆薯格下午茶香芋派组', '17.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('153', '65', null, '1', '万圣节日辣堡桶S', '53.60', '2', null, null);
INSERT INTO `order_detail` VALUES ('154', '65', null, '4', '麦趣鸡盒', '63.20', '3', null, null);
INSERT INTO `order_detail` VALUES ('155', '65', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '2', null, null);
INSERT INTO `order_detail` VALUES ('156', '65', null, '7', '金黄脆薯格下午茶香芋派组', '13.60', '3', null, null);
INSERT INTO `order_detail` VALUES ('157', '66', null, '11', '麦香鸡', '13.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('158', '66', null, '12', '俄式红肠双鸡堡', '21.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('159', '66', null, '10', '原味板烧鸡腿堡', '20.00', '3', null, null);
INSERT INTO `order_detail` VALUES ('160', '67', null, '1', '万圣节日辣堡桶S', '53.60', '3', null, null);
INSERT INTO `order_detail` VALUES ('161', '67', null, '3', '国庆狂欢小食盒', '52.80', '3', null, null);
INSERT INTO `order_detail` VALUES ('162', '68', null, '1', '万圣节日辣堡桶S', '67.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('163', '68', null, '4', '麦趣鸡盒', '79.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('164', '68', null, '5', '蛋挞', '8.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('165', '68', null, '6', '金黄脆薯格下午茶鸡翅组', '19.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('166', '69', null, '1', '万圣节日辣堡桶S', '53.60', '4', null, null);
INSERT INTO `order_detail` VALUES ('167', '69', null, '4', '麦趣鸡盒', '63.20', '6', null, null);
INSERT INTO `order_detail` VALUES ('168', '69', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '3', null, null);
INSERT INTO `order_detail` VALUES ('169', '69', null, '7', '金黄脆薯格下午茶香芋派组', '13.60', '0', null, null);
INSERT INTO `order_detail` VALUES ('170', '70', null, '1', '万圣节日辣堡桶S', '67.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('171', '70', null, '3', '国庆狂欢小食盒', '66.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('172', '71', null, '3', '???????', '66.00', '1', null, null);
INSERT INTO `order_detail` VALUES ('173', '72', null, '29', '??????????', '22.00', '3', null, null);
INSERT INTO `order_detail` VALUES ('174', '73', null, '3', '???????', '66.00', '3', null, null);
INSERT INTO `order_detail` VALUES ('175', '73', null, '4', '????', '79.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('176', '73', null, '7', '????????????', '17.00', '2', null, null);
INSERT INTO `order_detail` VALUES ('177', '73', null, '8', '????????????', '19.00', '1', null, null);

-- ----------------------------
-- Table structure for order_master
-- ----------------------------
DROP TABLE IF EXISTS `order_master`;
CREATE TABLE `order_master` (
  `order_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `buyer_id` int(32) DEFAULT NULL COMMENT '餐区ID',
  `order_type` varchar(255) DEFAULT NULL COMMENT '订单类型 1午餐 2晚餐',
  `total_amount` double(10,2) DEFAULT NULL COMMENT '订单总金额',
  `table_num` varchar(255) DEFAULT NULL COMMENT '台号',
  `adult` int(11) DEFAULT '0' COMMENT '成年人数',
  `child` int(11) DEFAULT '0' COMMENT '小孩人数',
  `lunch_num` int(11) DEFAULT '1' COMMENT '每轮午餐能点的数量',
  `dinner_num` int(11) DEFAULT '1' COMMENT '每轮晚餐能点的数量',
  `wait_time` int(11) DEFAULT '1' COMMENT '每轮需要等的时间',
  `status` varchar(255) DEFAULT NULL COMMENT '订单状态 0未结账 1已结账',
  `open_time` datetime DEFAULT NULL COMMENT '开台时间',
  `create_time` char(19) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COMMENT='订单总表';

-- ----------------------------
-- Records of order_master
-- ----------------------------
INSERT INTO `order_master` VALUES ('1', '1', null, '500.00', null, '0', '0', '1', '1', '1', null, null, '2018-09-27 12:22:55');
INSERT INTO `order_master` VALUES ('2', '2', null, '230.00', null, '0', '0', '1', '1', '1', null, null, '2018-07-27 12:22:55');
INSERT INTO `order_master` VALUES ('3', '3', null, '120.00', null, '0', '0', '1', '1', '1', null, null, '2018-06-27 12:22:55');
INSERT INTO `order_master` VALUES ('4', '5', null, '560.00', null, '0', '0', '1', '1', '1', null, null, '2018-05-27 12:22:55');
INSERT INTO `order_master` VALUES ('5', '6', null, '30.00', null, '0', '0', '1', '1', '1', null, null, '2018-08-27 12:22:55');
INSERT INTO `order_master` VALUES ('6', '9', null, '70.00', null, '0', '0', '1', '1', '1', null, null, '2018-04-27 12:22:55');
INSERT INTO `order_master` VALUES ('7', '1', null, '50.00', null, '0', '0', '1', '1', '1', null, null, '2018-03-27 12:22:55');
INSERT INTO `order_master` VALUES ('8', '4', null, '160.00', null, '0', '0', '1', '1', '1', null, null, '2018-02-27 12:22:55');
INSERT INTO `order_master` VALUES ('9', '7', null, '700.00', null, '0', '0', '1', '1', '1', null, null, '2018-01-27 12:22:55');
INSERT INTO `order_master` VALUES ('10', '12', null, '700.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-27 12:22:55');
INSERT INTO `order_master` VALUES ('11', '10', null, '900.00', null, '0', '0', '1', '1', '1', null, null, '2018-11-27 12:22:55');
INSERT INTO `order_master` VALUES ('12', '2', null, '800.00', null, '0', '0', '1', '1', '1', null, null, '2018-12-27 12:22:55');
INSERT INTO `order_master` VALUES ('13', '1', null, '600.00', null, '0', '0', '1', '1', '1', null, null, '2018-01-27 12:22:55');
INSERT INTO `order_master` VALUES ('14', '4', null, '900.00', null, '0', '0', '1', '1', '1', null, null, '2018-03-27 12:22:55');
INSERT INTO `order_master` VALUES ('15', '9', null, '140.00', null, '0', '0', '1', '1', '1', null, null, '2018-04-27 12:22:55');
INSERT INTO `order_master` VALUES ('16', '4', null, '320.00', null, '0', '0', '1', '1', '1', null, null, '2018-05-27 12:22:55');
INSERT INTO `order_master` VALUES ('17', '3123', null, '44.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-10 19:40:19');
INSERT INTO `order_master` VALUES ('18', '1231', null, '22.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-10 19:42:01');
INSERT INTO `order_master` VALUES ('19', '1', null, '116.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-10 20:00:02');
INSERT INTO `order_master` VALUES ('20', '1', null, '63.20', null, '0', '0', '1', '1', '1', null, null, '2018-10-10 20:50:54');
INSERT INTO `order_master` VALUES ('21', '7575', null, '58.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 14:38:42');
INSERT INTO `order_master` VALUES ('22', '3453', null, '335.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 15:08:48');
INSERT INTO `order_master` VALUES ('23', '3253', null, '0.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 15:09:21');
INSERT INTO `order_master` VALUES ('24', '2312', null, '51.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 18:16:57');
INSERT INTO `order_master` VALUES ('25', '1', null, '180.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:17:37');
INSERT INTO `order_master` VALUES ('26', '1', null, '180.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:19:30');
INSERT INTO `order_master` VALUES ('27', '1', null, '180.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:19:47');
INSERT INTO `order_master` VALUES ('28', '1', null, '180.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:19:51');
INSERT INTO `order_master` VALUES ('29', '1', null, '180.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:22:01');
INSERT INTO `order_master` VALUES ('30', '1', null, '180.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:23:03');
INSERT INTO `order_master` VALUES ('31', '5675', null, '66.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:25:01');
INSERT INTO `order_master` VALUES ('32', '66', null, '66.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:25:52');
INSERT INTO `order_master` VALUES ('33', '4234', null, '132.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:30:22');
INSERT INTO `order_master` VALUES ('34', '1', null, '52.84', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:31:01');
INSERT INTO `order_master` VALUES ('35', '1', null, '52.60', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:35:42');
INSERT INTO `order_master` VALUES ('36', '1', null, '52.40', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:35:51');
INSERT INTO `order_master` VALUES ('37', '1', null, '52.84', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:35:53');
INSERT INTO `order_master` VALUES ('38', '1', null, '52.40', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:35:54');
INSERT INTO `order_master` VALUES ('39', '1', null, '211.22', null, '0', '0', '1', '1', '1', null, null, '2018-10-12 19:37:05');
INSERT INTO `order_master` VALUES ('40', '1', null, '69.60', null, '0', '0', '1', '1', '1', null, null, '2018-10-17 14:18:19');
INSERT INTO `order_master` VALUES ('41', '1', null, '69.60', null, '0', '0', '1', '1', '1', null, null, '2018-10-17 14:19:05');
INSERT INTO `order_master` VALUES ('42', '1', null, '69.60', null, '0', '0', '1', '1', '1', null, null, '2018-10-17 14:23:55');
INSERT INTO `order_master` VALUES ('43', '1', null, '69.60', null, '0', '0', '1', '1', '1', null, null, '2018-10-17 14:28:54');
INSERT INTO `order_master` VALUES ('44', '1', null, '69.60', null, '0', '0', '1', '1', '1', null, null, '2018-10-17 14:29:52');
INSERT INTO `order_master` VALUES ('45', '2', null, '69.60', null, '0', '0', '1', '1', '1', null, null, '2018-10-17 14:33:18');
INSERT INTO `order_master` VALUES ('46', '1', null, '84.80', null, '0', '0', '1', '1', '1', null, null, '2018-10-18 12:03:16');
INSERT INTO `order_master` VALUES ('47', '3123', null, '0.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-18 12:28:42');
INSERT INTO `order_master` VALUES ('48', '1', null, '84.80', null, '0', '0', '1', '1', '1', null, null, '2018-10-18 13:01:00');
INSERT INTO `order_master` VALUES ('49', '1', null, '69.60', null, '0', '0', '1', '1', '1', null, null, '2018-10-18 20:24:43');
INSERT INTO `order_master` VALUES ('50', '8888', null, '100.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-23 15:25:24');
INSERT INTO `order_master` VALUES ('51', '1212', null, '73.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-23 18:11:36');
INSERT INTO `order_master` VALUES ('52', '3132', null, '141.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-24 09:14:39');
INSERT INTO `order_master` VALUES ('53', '-1', null, '54.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-24 09:31:56');
INSERT INTO `order_master` VALUES ('54', '4', null, '38.80', null, '0', '0', '1', '1', '1', null, null, '2018-10-24 09:34:41');
INSERT INTO `order_master` VALUES ('55', '-1', null, '64.50', null, '0', '0', '1', '1', '1', null, null, '2018-10-24 13:37:35');
INSERT INTO `order_master` VALUES ('56', '-1', null, '27.50', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 16:46:24');
INSERT INTO `order_master` VALUES ('57', '1', null, '75.20', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 16:48:42');
INSERT INTO `order_master` VALUES ('58', '-1', null, '132.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 19:13:14');
INSERT INTO `order_master` VALUES ('59', '-1', null, '132.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 19:13:29');
INSERT INTO `order_master` VALUES ('60', '-1', null, '211.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 19:28:16');
INSERT INTO `order_master` VALUES ('61', '27', null, '148.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 19:29:03');
INSERT INTO `order_master` VALUES ('62', '-1', null, '424.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 19:51:27');
INSERT INTO `order_master` VALUES ('63', '28', null, '356.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 19:52:46');
INSERT INTO `order_master` VALUES ('64', '-1', null, '303.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 20:06:02');
INSERT INTO `order_master` VALUES ('65', '29', null, '368.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 20:07:24');
INSERT INTO `order_master` VALUES ('66', '-1', null, '128.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 20:19:42');
INSERT INTO `order_master` VALUES ('67', '30', null, '319.20', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 20:20:50');
INSERT INTO `order_master` VALUES ('68', '-1', null, '346.00', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 20:35:39');
INSERT INTO `order_master` VALUES ('69', '31', null, '639.20', null, '0', '0', '1', '1', '1', null, null, '2018-10-29 20:37:32');
INSERT INTO `order_master` VALUES ('70', '-1', null, '133.00', null, '0', '0', '1', '1', '1', null, null, '2018-11-02 15:12:42');
INSERT INTO `order_master` VALUES ('71', '-1', null, '66.00', null, '0', '0', '1', '1', '1', null, null, '2019-05-26 18:23:30');
INSERT INTO `order_master` VALUES ('72', '-1', null, '66.00', null, '0', '0', '1', '1', '1', null, null, '2019-05-26 18:39:58');
INSERT INTO `order_master` VALUES ('73', '-1', null, '409.00', null, '0', '0', '1', '1', '1', null, null, '2019-05-26 18:40:27');

-- ----------------------------
-- Table structure for order_round
-- ----------------------------
DROP TABLE IF EXISTS `order_round`;
CREATE TABLE `order_round` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `num` int(32) DEFAULT '1' COMMENT '第几轮',
  `order_id` int(32) DEFAULT NULL COMMENT '订单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='点餐轮数表';

-- ----------------------------
-- Records of order_round
-- ----------------------------

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `category_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '商品类型id',
  `parent_id` int(32) NOT NULL DEFAULT '0' COMMENT '父id',
  `category_name` varchar(255) NOT NULL COMMENT '商品类型名',
  `printid` int(21) DEFAULT NULL COMMENT '打印机id',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='商品类型表';

-- ----------------------------
-- Records of product_category
-- ----------------------------
INSERT INTO `product_category` VALUES ('1', '0', '主食', null);
INSERT INTO `product_category` VALUES ('2', '0', '酒水', null);
INSERT INTO `product_category` VALUES ('3', '1', '小食', null);
INSERT INTO `product_category` VALUES ('4', '1', '甜品', null);
INSERT INTO `product_category` VALUES ('5', '2', '饮品', null);
INSERT INTO `product_category` VALUES ('6', '1', '开心乐园餐', null);

-- ----------------------------
-- Table structure for product_info
-- ----------------------------
DROP TABLE IF EXISTS `product_info`;
CREATE TABLE `product_info` (
  `product_id` int(32) NOT NULL AUTO_INCREMENT COMMENT '商品id号',
  `product_name` varchar(255) DEFAULT NULL COMMENT '商品名',
  `product_price` double(5,2) DEFAULT NULL COMMENT '商品单价',
  `product_inventory` int(8) DEFAULT NULL COMMENT '商品库存',
  `product_status` tinyint(4) DEFAULT NULL COMMENT '商品状态',
  `category_id` int(32) DEFAULT NULL COMMENT '商品类型id',
  `product_pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='商品信息表';

-- ----------------------------
-- Records of product_info
-- ----------------------------
INSERT INTO `product_info` VALUES ('1', '万圣节日辣堡桶S', '67.00', '74', '1', '1', '636adc4794484ca88a8bae6ff0ebd909.JPG');
INSERT INTO `product_info` VALUES ('2', '无辣不欢组合', '43.00', '93', '0', '1', '8111d7da0e39484ea669e19e5b5e52ea.JPG');
INSERT INTO `product_info` VALUES ('3', '国庆狂欢小食盒', '66.00', '58', '1', '1', 'cde5c5c7c6f446cc9787579d18a871b7.JPG');
INSERT INTO `product_info` VALUES ('4', '麦趣鸡盒', '79.00', '64', '1', '1', '5fd8e7239ad448b7b95e873e94bae20b.JPG');
INSERT INTO `product_info` VALUES ('5', '蛋挞', '8.00', '77', '1', '1', '72708d2c20864af9bb2bb0f4429496ce.JPG');
INSERT INTO `product_info` VALUES ('6', '金黄脆薯格下午茶鸡翅组', '19.00', '80', '1', '1', '4f98bb3ca9e24d0f8b5f532573c067e2.JPG');
INSERT INTO `product_info` VALUES ('7', '金黄脆薯格下午茶香芋派组', '17.00', '87', '1', '1', 'ebe680e693d64dc3a67e1663d3172e53.JPG');
INSERT INTO `product_info` VALUES ('8', '金黄脆薯格下午茶麦乐鸡组', '19.00', '99', '1', '1', '96812ba0bd274a2bb9151d92a2227ad3.JPG');
INSERT INTO `product_info` VALUES ('9', '经典麦辣鸡腿汉堡', '22.00', '98', '0', '2', '1770641e2c084d55958d01f329fef7e2.JPG');
INSERT INTO `product_info` VALUES ('10', '原味板烧鸡腿堡', '20.00', '96', '1', '2', '3fec9e1c54f747b6a85f35e2f3244b4a.JPG');
INSERT INTO `product_info` VALUES ('11', '麦香鸡', '13.00', '97', '1', '2', 'b2ec8e72f91042dfb7a21c5b0b54bc6f.JPG');
INSERT INTO `product_info` VALUES ('12', '俄式红肠双鸡堡', '21.00', '98', '1', '2', '957d4d46fa124724ad0fc64467655ffd.JPG');
INSERT INTO `product_info` VALUES ('13', '不素之霸双层牛肉堡', '21.00', '99', '1', '2', '8f39ca7518474774b0a57d0e9f1d257e.JPG');
INSERT INTO `product_info` VALUES ('14', '鲜蔬沙拉', '11.50', '98', '1', '3', '194d6fab070f46649378243b23d80659.JPG');
INSERT INTO `product_info` VALUES ('15', '薯条', '16.00', '98', '1', '3', 'a7248c18337a4c9fbb68a1231eb19bd1.JPG');
INSERT INTO `product_info` VALUES ('16', '那么大鸡排', '13.00', '99', '1', '3', 'a7778b63acd04f8a958ee15616ac7db1.JPG');
INSERT INTO `product_info` VALUES ('17', '上校鸡块', '13.00', '99', '1', '3', 'b09e10e97d7743f1b865f4ec9b4f2272.JPG');
INSERT INTO `product_info` VALUES ('18', '美味鲜蔬杯', '11.00', '99', '1', '3', '68b463b8494746ba9d4adec1c7277743.JPG');
INSERT INTO `product_info` VALUES ('19', '香甜玉米', '12.50', '100', '1', '4', 'c38b61a7b3e44f9eb8259caf26ae7c8f.JPG');
INSERT INTO `product_info` VALUES ('20', '醇香土豆泥', '12.50', '98', '1', '4', '547a7287b7574fe3a3210524e3178b8b.JPG');
INSERT INTO `product_info` VALUES ('21', '香脆薯饼', '9.50', '100', '1', '4', '9b8f2effcea34cd08b54421dc1a8264f.JPG');
INSERT INTO `product_info` VALUES ('22', '太阳蛋', '9.50', '98', '1', '4', '15e1ac18fd4d4020aa2e1a099a8286ae.JPG');
INSERT INTO `product_info` VALUES ('23', '香芋派', '7.50', '100', '1', '4', '9c7bdd7051034422b44f2cb26f0ccb22.JPG');
INSERT INTO `product_info` VALUES ('24', '怪力血怪饮', '27.00', '99', '1', '5', 'e8a039a050b4481c903615fd4d60ddc0.JPG');
INSERT INTO `product_info` VALUES ('25', '纯纯玉米饮', '13.50', '99', '1', '5', '20371e35857740a8b402f122f7cd06c2.JPG');
INSERT INTO `product_info` VALUES ('26', '黑pro豆浆', '13.50', '100', '1', '5', '8aa9b2509b69481cb14ddec4334c7704.JPG');
INSERT INTO `product_info` VALUES ('27', '可口可乐', '8.00', '99', '1', '5', '7e763c74c2984e9ba68e2218bfc34002.JPG');
INSERT INTO `product_info` VALUES ('28', '九珍果汁饮料', '8.00', '100', '1', '5', '379d7f1483494b848d1df901b6740f8f.JPG');
INSERT INTO `product_info` VALUES ('29', '开心乐园餐（汉堡包）', '22.00', '94', '1', '6', '1a9186fcb40240e39d9a86a16e4be912.png');
INSERT INTO `product_info` VALUES ('30', '开心乐园餐（吉士汉堡包）', '23.00', '98', '1', '6', '28159d626d4e45b68f59098a989ab914.png');
INSERT INTO `product_info` VALUES ('31', '开心乐园餐（麦乐鸡）', '22.00', '95', '1', '6', '88fa45f8597e45ae83ba1e5c22ef6804.png');
INSERT INTO `product_info` VALUES ('32', '苹果片', '6.00', '96', '1', '6', 'a44e4a74fe794e1d8a957dac5b6c0bf1.jpg');
INSERT INTO `product_info` VALUES ('33', '梨片', '6.00', '99', '0', '6', '2a1bc8a3d98b435da24bd0f65fe3d39e.jpg');

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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

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
INSERT INTO `t_admin_role` VALUES ('42', '79', '26');

-- ----------------------------
-- Table structure for t_area
-- ----------------------------
DROP TABLE IF EXISTS `t_area`;
CREATE TABLE `t_area` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '餐区名称',
  `pwd` varchar(255) DEFAULT NULL COMMENT '餐区密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='餐区配置表';

-- ----------------------------
-- Records of t_area
-- ----------------------------

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('1', '系统菜单', '0', null, 'glyphicon glyphicon-th-list');
INSERT INTO `t_permission` VALUES ('3', '权限管理', '1', null, 'glyphicon glyphicon glyphicon-tasks');
INSERT INTO `t_permission` VALUES ('4', '管理员维护', '3', '/admin/index', 'glyphicon glyphicon-user');
INSERT INTO `t_permission` VALUES ('5', '角色维护', '3', '/role/index', 'glyphicon glyphicon-knight');
INSERT INTO `t_permission` VALUES ('6', '商品管理', '1', '', 'glyphicon glyphicon-ok');
INSERT INTO `t_permission` VALUES ('7', '全部商品', '6', '/product/index', 'glyphicon glyphicon-check');
INSERT INTO `t_permission` VALUES ('8', '添加商品', '6', '/product/add', 'glyphicon glyphicon-check');
INSERT INTO `t_permission` VALUES ('9', '商品类别', '6', '/category/index', 'glyphicon glyphicon-tag');
INSERT INTO `t_permission` VALUES ('12', '数据管理', '1', null, 'glyphicon glyphicon-equalizer');
INSERT INTO `t_permission` VALUES ('13', '会员数据', '12', '/member/index', 'glyphicon glyphicon-king');
INSERT INTO `t_permission` VALUES ('14', '订单数据', '12', '/order/index', 'glyphicon glyphicon-list-alt');
INSERT INTO `t_permission` VALUES ('15', '数据分析', '12', '/admin/main', 'glyphicon glyphicon-stats');
INSERT INTO `t_permission` VALUES ('16', '会员显示', '13', '/member/index', 'glyphicon glyphicon-king');
INSERT INTO `t_permission` VALUES ('17', '金额修改', '13', '/member/doEdit', 'glyphicon glyphicon-jpy');
INSERT INTO `t_permission` VALUES ('18', '删除会员', '13', '/member/delete', 'glyphicon glyphicon-check');
INSERT INTO `t_permission` VALUES ('19', '系统设置管理', '1', null, 'glyphicon glyphicon-cog');
INSERT INTO `t_permission` VALUES ('20', '打印机设置', '19', '/printer/index', 'glyphicon glyphicon-print');

-- ----------------------------
-- Table structure for t_printer
-- ----------------------------
DROP TABLE IF EXISTS `t_printer`;
CREATE TABLE `t_printer` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '打印机名称',
  `ip` varchar(20) NOT NULL COMMENT '打印机ip',
  `status` char(1) NOT NULL COMMENT '状态0正常1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='打印机配置表';

-- ----------------------------
-- Records of t_printer
-- ----------------------------
INSERT INTO `t_printer` VALUES ('1', '1212', '121212222', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=468 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
INSERT INTO `t_role_permission` VALUES ('358', '26', '1');
INSERT INTO `t_role_permission` VALUES ('359', '26', '12');
INSERT INTO `t_role_permission` VALUES ('360', '26', '13');
INSERT INTO `t_role_permission` VALUES ('361', '26', '16');
INSERT INTO `t_role_permission` VALUES ('362', '26', '14');
INSERT INTO `t_role_permission` VALUES ('363', '26', '15');
INSERT INTO `t_role_permission` VALUES ('440', '1', '1');
INSERT INTO `t_role_permission` VALUES ('441', '1', '3');
INSERT INTO `t_role_permission` VALUES ('442', '1', '4');
INSERT INTO `t_role_permission` VALUES ('443', '1', '5');
INSERT INTO `t_role_permission` VALUES ('444', '1', '6');
INSERT INTO `t_role_permission` VALUES ('445', '1', '7');
INSERT INTO `t_role_permission` VALUES ('446', '1', '8');
INSERT INTO `t_role_permission` VALUES ('447', '1', '9');
INSERT INTO `t_role_permission` VALUES ('448', '1', '12');
INSERT INTO `t_role_permission` VALUES ('449', '1', '13');
INSERT INTO `t_role_permission` VALUES ('450', '1', '16');
INSERT INTO `t_role_permission` VALUES ('451', '1', '17');
INSERT INTO `t_role_permission` VALUES ('452', '1', '14');
INSERT INTO `t_role_permission` VALUES ('453', '1', '15');
INSERT INTO `t_role_permission` VALUES ('454', '1', '19');
INSERT INTO `t_role_permission` VALUES ('455', '1', '20');
INSERT INTO `t_role_permission` VALUES ('456', '2', '1');
INSERT INTO `t_role_permission` VALUES ('457', '2', '6');
INSERT INTO `t_role_permission` VALUES ('458', '2', '7');
INSERT INTO `t_role_permission` VALUES ('459', '2', '8');
INSERT INTO `t_role_permission` VALUES ('460', '2', '9');
INSERT INTO `t_role_permission` VALUES ('461', '2', '12');
INSERT INTO `t_role_permission` VALUES ('462', '2', '13');
INSERT INTO `t_role_permission` VALUES ('463', '2', '16');
INSERT INTO `t_role_permission` VALUES ('464', '2', '14');
INSERT INTO `t_role_permission` VALUES ('465', '2', '15');
INSERT INTO `t_role_permission` VALUES ('466', '2', '19');
INSERT INTO `t_role_permission` VALUES ('467', '2', '20');

-- ----------------------------
-- Table structure for t_setting
-- ----------------------------
DROP TABLE IF EXISTS `t_setting`;
CREATE TABLE `t_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_pwd` varchar(255) DEFAULT NULL COMMENT 'app开机密码',
  `lunch_num` int(11) DEFAULT '1' COMMENT '每轮午餐能点的数量',
  `dinner_num` int(11) DEFAULT '1' COMMENT '每轮晚餐能点的数量',
  `wait_time` int(11) DEFAULT '1' COMMENT '每轮需要等的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统设置表';

-- ----------------------------
-- Records of t_setting
-- ----------------------------

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
