/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : ordersystem

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2019-07-09 23:59:16
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
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COMMENT='订单详情表';

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('1', null, '1', null, '9', '商品名称1', '25.50', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('2', null, '1', null, '10', '商品名称1', '24.00', '7', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('3', null, '1', null, '11', '商品名称1', '24.00', '4', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('4', null, '2', null, '12', '商品名称2', '24.00', '6', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('5', null, '2', null, '13', '商品名称3', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('6', null, '2', null, '1', '商品名称4', '24.00', '5', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('7', null, '2', null, '2', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('8', null, '2', null, '3', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('9', null, '2', null, '4', '商品名称1', '24.00', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('10', null, '2', null, '18', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('11', null, '3', null, '17', '商品名称1', '24.00', '5', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('12', null, '3', null, '2', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('13', null, '3', null, '16', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('14', null, '3', null, '3', '商品名称1', '24.00', '6', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('15', null, '3', null, '1', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('16', null, '4', null, '7', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('17', null, '4', null, '18', '商品名称1', '24.00', '4', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('18', null, '4', null, '20', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('19', null, '4', null, '21', '商品名称1', '24.00', '8', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('20', null, '4', null, '16', '商品名称1', '24.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('21', null, '17', null, '82', '新增产品', '22.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('22', null, '18', null, '82', '新增产品', '22.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('23', null, '19', null, '79', '新增的闪频', '123.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('24', null, '19', null, '82', '新增产品', '22.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('25', null, '20', null, '33', '梨片', '6.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('26', null, '20', null, '29', '开心乐园餐（汉堡包）', '22.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('27', null, '20', null, '30', '开心乐园餐（吉士汉堡包）', '23.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('28', null, '20', null, '31', '开心乐园餐（麦乐鸡）', '22.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('29', null, '20', null, '32', '苹果片', '6.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('30', null, '21', null, '5', '草莓派', '8.00', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('31', null, '21', null, '7', '金黄脆薯格下午茶香芋派组', '17.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('32', null, '22', null, '22', '草莓新地', '9.50', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('33', null, '22', null, '1', '麦辣鸡翅三块', '10.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('34', null, '22', null, '2', '无辣不欢组合', '43.00', '0', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('35', null, '22', null, '4', '麦趣鸡盒', '79.00', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('36', null, '22', null, '9', '经典麦辣鸡腿汉堡', '22.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('37', null, '22', null, '20', '麦旋风草莓口味', '12.50', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('38', null, '23', null, '2', '无辣不欢组合', '43.00', '0', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('39', null, '24', null, '2', '无辣不欢组合', '43.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('40', null, '24', null, '5', '草莓派', '8.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('41', null, '25', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('42', null, '25', null, '2', '无辣不欢组合', '34.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('43', null, '25', null, '3', '国庆狂欢小食盒', '52.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('44', null, '25', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('45', null, '25', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('46', null, '25', null, '6', '金黄脆薯格下午茶鸡翅组', '15.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('47', null, '26', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('48', null, '26', null, '2', '无辣不欢组合', '34.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('49', null, '26', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('50', null, '26', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('51', null, '26', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('52', null, '26', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('53', null, '27', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('54', null, '27', null, '2', '无辣不欢组合', '34.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('55', null, '27', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('56', null, '27', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('57', null, '27', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('58', null, '27', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('59', null, '28', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('60', null, '28', null, '2', '无辣不欢组合', '34.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('61', null, '28', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('62', null, '28', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('63', null, '28', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('64', null, '28', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('65', null, '29', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('66', null, '29', null, '2', '无辣不欢组合', '34.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('67', null, '29', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('68', null, '29', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('69', null, '29', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('70', null, '29', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('71', null, '30', null, '1', '麦辣鸡翅三块', '8.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('72', null, '30', null, '2', '无辣不欢组合', '34.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('73', null, '30', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('74', null, '30', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('75', null, '30', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('76', null, '30', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('77', null, '31', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('78', null, '32', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('79', null, '33', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('80', null, '34', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('81', null, '35', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('82', null, '36', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('83', null, '37', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('84', null, '38', null, '3', '国庆狂欢小食盒', '52.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('85', null, '39', null, '3', '国庆狂欢小食盒', '52.80', '4', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('86', null, '40', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('87', null, '40', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('88', null, '41', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('89', null, '41', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('90', null, '42', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('91', null, '42', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('92', null, '43', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('93', null, '43', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('94', null, '44', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('95', null, '44', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('96', null, '45', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('97', null, '45', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('98', null, '46', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('99', null, '46', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('100', null, '46', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('101', null, '47', null, '4', '麦趣鸡盒', '79.00', '0', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('102', null, '47', null, '5', '草莓派', '8.00', '0', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('103', null, '47', null, '6', '金黄脆薯格下午茶鸡翅组', '19.00', '0', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('104', null, '48', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('105', null, '48', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('106', null, '48', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('107', null, '49', null, '4', '麦趣鸡盒', '63.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('108', null, '49', null, '5', '草莓派', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('109', null, '50', null, '29', '开心乐园餐（汉堡包）', '22.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('110', null, '50', null, '31', '开心乐园餐（麦乐鸡）', '22.00', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('111', null, '50', null, '32', '苹果片', '6.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('112', null, '51', null, '29', '开心乐园餐（汉堡包）', '22.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('113', null, '51', null, '30', '开心乐园餐（吉士汉堡包）', '23.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('114', null, '51', null, '31', '开心乐园餐（麦乐鸡）', '22.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('115', null, '51', null, '32', '苹果片', '6.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('116', null, '52', null, '1', '万圣节日辣堡桶S', '67.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('117', null, '52', null, '3', '国庆狂欢小食盒', '66.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('118', null, '52', null, '5', '草莓派', '8.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('119', null, '53', null, '11', '麦香鸡', '13.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('120', null, '53', null, '13', '不素之霸双层牛肉堡', '21.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('121', null, '53', null, '10', '原味板烧鸡腿堡', '20.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('122', null, '54', null, '24', '那么大珍珠奶茶热', '21.60', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('123', null, '54', null, '25', '那么大鲜柠特饮', '10.80', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('124', null, '54', null, '27', '可口可乐', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('125', null, '55', null, '14', '麦乐鸡', '11.50', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('126', null, '55', null, '15', '那么大鸡小块', '16.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('127', null, '55', null, '16', '那么大鸡排', '13.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('128', null, '55', null, '17', '香骨鸡腿', '13.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('129', null, '55', null, '18', '美味鲜蔬杯', '11.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('130', null, '56', null, '14', '鲜蔬沙拉', '11.50', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('131', null, '56', null, '15', '薯条', '16.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('132', null, '57', null, '1', '万圣节日辣堡桶S', '53.60', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('133', null, '57', null, '5', '蛋挞', '6.40', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('134', null, '57', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('135', null, '58', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('136', null, '59', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('137', null, '60', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('138', null, '60', null, '4', '麦趣鸡盒', '79.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('139', null, '61', null, '3', '国庆狂欢小食盒', '52.80', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('140', null, '61', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('141', null, '61', null, '7', '金黄脆薯格下午茶香芋派组', '13.60', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('142', null, '62', null, '1', '万圣节日辣堡桶S', '67.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('143', null, '62', null, '3', '国庆狂欢小食盒', '66.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('144', null, '62', null, '4', '麦趣鸡盒', '79.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('145', null, '63', null, '3', '国庆狂欢小食盒', '52.80', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('146', null, '63', null, '4', '麦趣鸡盒', '63.20', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('147', null, '63', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('148', null, '63', null, '7', '金黄脆薯格下午茶香芋派组', '13.60', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('149', null, '64', null, '1', '万圣节日辣堡桶S', '67.00', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('150', null, '64', null, '3', '国庆狂欢小食盒', '66.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('151', null, '64', null, '6', '金黄脆薯格下午茶鸡翅组', '19.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('152', null, '64', null, '7', '金黄脆薯格下午茶香芋派组', '17.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('153', null, '65', null, '1', '万圣节日辣堡桶S', '53.60', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('154', null, '65', null, '4', '麦趣鸡盒', '63.20', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('155', null, '65', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('156', null, '65', null, '7', '金黄脆薯格下午茶香芋派组', '13.60', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('157', null, '66', null, '11', '麦香鸡', '13.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('158', null, '66', null, '12', '俄式红肠双鸡堡', '21.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('159', null, '66', null, '10', '原味板烧鸡腿堡', '20.00', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('160', null, '67', null, '1', '万圣节日辣堡桶S', '53.60', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('161', null, '67', null, '3', '国庆狂欢小食盒', '52.80', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('162', null, '68', null, '1', '万圣节日辣堡桶S', '67.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('163', null, '68', null, '4', '麦趣鸡盒', '79.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('164', null, '68', null, '5', '蛋挞', '8.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('165', null, '68', null, '6', '金黄脆薯格下午茶鸡翅组', '19.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('166', null, '69', null, '1', '万圣节日辣堡桶S', '53.60', '4', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('167', null, '69', null, '4', '麦趣鸡盒', '63.20', '6', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('168', null, '69', null, '6', '金黄脆薯格下午茶鸡翅组', '15.20', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('169', null, '69', null, '7', '金黄脆薯格下午茶香芋派组', '13.60', '0', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('170', null, '70', null, '1', '万圣节日辣堡桶S', '67.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('171', null, '70', null, '3', '国庆狂欢小食盒', '66.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('172', null, '71', null, '3', '???????', '66.00', '1', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('173', null, '72', null, '29', '??????????', '22.00', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('174', null, '73', null, '3', '???????', '66.00', '3', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('175', null, '73', null, '4', '????', '79.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('176', null, '73', null, '7', '????????????', '17.00', '2', null, null, null, null, null);
INSERT INTO `order_detail` VALUES ('177', null, '73', null, '8', '????????????', '19.00', '1', null, null, null, null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COMMENT='订单总表';

-- ----------------------------
-- Records of order_master
-- ----------------------------
INSERT INTO `order_master` VALUES ('1', '1', null, null, '500.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-09-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('2', '2', null, null, '230.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-07-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('3', '3', null, null, '120.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-06-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('4', '5', null, null, '560.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-05-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('5', '6', null, null, '30.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-08-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('6', '9', null, null, '70.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-04-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('7', '1', null, null, '50.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-03-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('8', '4', null, null, '160.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-02-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('9', '7', null, null, '700.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-01-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('10', '12', null, null, '700.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('11', '10', null, null, '900.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-11-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('12', '2', null, null, '800.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-12-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('13', '1', null, null, '600.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-01-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('14', '4', null, null, '900.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-03-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('15', '9', null, null, '140.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-04-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('16', '4', null, null, '320.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-05-27 12:22:55', null);
INSERT INTO `order_master` VALUES ('17', '3123', null, null, '44.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-10 19:40:19', null);
INSERT INTO `order_master` VALUES ('18', '1231', null, null, '22.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-10 19:42:01', null);
INSERT INTO `order_master` VALUES ('19', '1', null, null, '116.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-10 20:00:02', null);
INSERT INTO `order_master` VALUES ('20', '1', null, null, '63.20', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-10 20:50:54', null);
INSERT INTO `order_master` VALUES ('21', '7575', null, null, '58.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 14:38:42', null);
INSERT INTO `order_master` VALUES ('22', '3453', null, null, '335.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 15:08:48', null);
INSERT INTO `order_master` VALUES ('23', '3253', null, null, '0.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 15:09:21', null);
INSERT INTO `order_master` VALUES ('24', '2312', null, null, '51.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 18:16:57', null);
INSERT INTO `order_master` VALUES ('25', '1', null, null, '180.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:17:37', null);
INSERT INTO `order_master` VALUES ('26', '1', null, null, '180.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:19:30', null);
INSERT INTO `order_master` VALUES ('27', '1', null, null, '180.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:19:47', null);
INSERT INTO `order_master` VALUES ('28', '1', null, null, '180.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:19:51', null);
INSERT INTO `order_master` VALUES ('29', '1', null, null, '180.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:22:01', null);
INSERT INTO `order_master` VALUES ('30', '1', null, null, '180.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:23:03', null);
INSERT INTO `order_master` VALUES ('31', '5675', null, null, '66.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:25:01', null);
INSERT INTO `order_master` VALUES ('32', '66', null, null, '66.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:25:52', null);
INSERT INTO `order_master` VALUES ('33', '4234', null, null, '132.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:30:22', null);
INSERT INTO `order_master` VALUES ('34', '1', null, null, '52.84', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:31:01', null);
INSERT INTO `order_master` VALUES ('35', '1', null, null, '52.60', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:35:42', null);
INSERT INTO `order_master` VALUES ('36', '1', null, null, '52.40', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:35:51', null);
INSERT INTO `order_master` VALUES ('37', '1', null, null, '52.84', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:35:53', null);
INSERT INTO `order_master` VALUES ('38', '1', null, null, '52.40', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:35:54', null);
INSERT INTO `order_master` VALUES ('39', '1', null, null, '211.22', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-12 19:37:05', null);
INSERT INTO `order_master` VALUES ('40', '1', null, null, '69.60', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-17 14:18:19', null);
INSERT INTO `order_master` VALUES ('41', '1', null, null, '69.60', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-17 14:19:05', null);
INSERT INTO `order_master` VALUES ('42', '1', null, null, '69.60', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-17 14:23:55', null);
INSERT INTO `order_master` VALUES ('43', '1', null, null, '69.60', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-17 14:28:54', null);
INSERT INTO `order_master` VALUES ('44', '1', null, null, '69.60', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-17 14:29:52', null);
INSERT INTO `order_master` VALUES ('45', '2', null, null, '69.60', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-17 14:33:18', null);
INSERT INTO `order_master` VALUES ('46', '1', null, null, '84.80', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-18 12:03:16', null);
INSERT INTO `order_master` VALUES ('47', '3123', null, null, '0.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-18 12:28:42', null);
INSERT INTO `order_master` VALUES ('48', '1', null, null, '84.80', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-18 13:01:00', null);
INSERT INTO `order_master` VALUES ('49', '1', null, null, '69.60', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-18 20:24:43', null);
INSERT INTO `order_master` VALUES ('50', '8888', null, null, '100.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-23 15:25:24', null);
INSERT INTO `order_master` VALUES ('51', '1212', null, null, '73.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-23 18:11:36', null);
INSERT INTO `order_master` VALUES ('52', '3132', null, null, '141.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-24 09:14:39', null);
INSERT INTO `order_master` VALUES ('53', '-1', null, null, '54.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-24 09:31:56', null);
INSERT INTO `order_master` VALUES ('54', '4', null, null, '38.80', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-24 09:34:41', null);
INSERT INTO `order_master` VALUES ('55', '-1', null, null, '64.50', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-24 13:37:35', null);
INSERT INTO `order_master` VALUES ('56', '-1', null, null, '27.50', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 16:46:24', null);
INSERT INTO `order_master` VALUES ('57', '1', null, null, '75.20', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 16:48:42', null);
INSERT INTO `order_master` VALUES ('58', '-1', null, null, '132.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 19:13:14', null);
INSERT INTO `order_master` VALUES ('59', '-1', null, null, '132.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 19:13:29', null);
INSERT INTO `order_master` VALUES ('60', '-1', null, null, '211.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 19:28:16', null);
INSERT INTO `order_master` VALUES ('61', '27', null, null, '148.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 19:29:03', null);
INSERT INTO `order_master` VALUES ('62', '-1', null, null, '424.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 19:51:27', null);
INSERT INTO `order_master` VALUES ('63', '28', null, null, '356.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 19:52:46', null);
INSERT INTO `order_master` VALUES ('64', '-1', null, null, '303.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 20:06:02', null);
INSERT INTO `order_master` VALUES ('65', '29', null, null, '368.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 20:07:24', null);
INSERT INTO `order_master` VALUES ('66', '-1', null, null, '128.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 20:19:42', null);
INSERT INTO `order_master` VALUES ('67', '30', null, null, '319.20', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 20:20:50', null);
INSERT INTO `order_master` VALUES ('68', '-1', null, null, '346.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 20:35:39', null);
INSERT INTO `order_master` VALUES ('69', '31', null, null, '639.20', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-10-29 20:37:32', null);
INSERT INTO `order_master` VALUES ('70', '-1', null, null, '133.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2018-11-02 15:12:42', null);
INSERT INTO `order_master` VALUES ('71', '-1', null, null, '66.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2019-05-26 18:23:30', null);
INSERT INTO `order_master` VALUES ('72', '-1', null, null, '66.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2019-05-26 18:39:58', null);
INSERT INTO `order_master` VALUES ('73', '-1', null, null, '409.00', null, '0', '0', '1', '1', '1', null, null, null, null, '2019-05-26 18:40:27', null);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_printer_log
-- ----------------------------

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
  `state` varchar(1) DEFAULT '0' COMMENT '状态 0正常 1删除',
  `pic` varchar(255) DEFAULT NULL COMMENT '图片',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='商品类型表';

-- ----------------------------
-- Records of product_category
-- ----------------------------
INSERT INTO `product_category` VALUES ('1', '0', '酒⽔分类', '2', '0', 'dcb47b58c40d49919b5fd223f6904045.png', null, '2019-07-09 15:08:38');
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
INSERT INTO `product_category` VALUES ('36', '0', '11', '1', '1', '982a99a99fe6483980eef697a2d10573.jpg', '2019-07-09 13:21:14', '2019-07-09 16:35:39');
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
  `product_status` tinyint(4) DEFAULT NULL COMMENT '商品状态',
  `category_id` int(32) DEFAULT NULL COMMENT '商品类型id',
  `product_pic` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='商品信息表';

-- ----------------------------
-- Records of product_info
-- ----------------------------
INSERT INTO `product_info` VALUES ('1', '万圣节日辣堡桶S', '67.00', '74', '1', '1', '636adc4794484ca88a8bae6ff0ebd909.JPG', null, null);
INSERT INTO `product_info` VALUES ('2', '无辣不欢组合', '43.00', '93', '0', '1', '8111d7da0e39484ea669e19e5b5e52ea.JPG', null, null);
INSERT INTO `product_info` VALUES ('3', '国庆狂欢小食盒', '66.00', '58', '1', '1', 'cde5c5c7c6f446cc9787579d18a871b7.JPG', null, null);
INSERT INTO `product_info` VALUES ('4', '麦趣鸡盒', '79.00', '64', '1', '1', '5fd8e7239ad448b7b95e873e94bae20b.JPG', null, null);
INSERT INTO `product_info` VALUES ('5', '蛋挞', '8.00', '77', '1', '1', '72708d2c20864af9bb2bb0f4429496ce.JPG', null, null);
INSERT INTO `product_info` VALUES ('6', '金黄脆薯格下午茶鸡翅组', '19.00', '80', '1', '1', '4f98bb3ca9e24d0f8b5f532573c067e2.JPG', null, null);
INSERT INTO `product_info` VALUES ('7', '金黄脆薯格下午茶香芋派组', '17.00', '87', '1', '1', 'ebe680e693d64dc3a67e1663d3172e53.JPG', null, null);
INSERT INTO `product_info` VALUES ('8', '金黄脆薯格下午茶麦乐鸡组', '19.00', '99', '1', '1', '96812ba0bd274a2bb9151d92a2227ad3.JPG', null, null);
INSERT INTO `product_info` VALUES ('9', '经典麦辣鸡腿汉堡', '22.00', '98', '0', '2', '1770641e2c084d55958d01f329fef7e2.JPG', null, null);
INSERT INTO `product_info` VALUES ('10', '原味板烧鸡腿堡', '20.00', '96', '1', '2', '3fec9e1c54f747b6a85f35e2f3244b4a.JPG', null, null);
INSERT INTO `product_info` VALUES ('11', '麦香鸡', '13.00', '97', '1', '2', 'b2ec8e72f91042dfb7a21c5b0b54bc6f.JPG', null, null);
INSERT INTO `product_info` VALUES ('12', '俄式红肠双鸡堡', '21.00', '98', '1', '2', '957d4d46fa124724ad0fc64467655ffd.JPG', null, null);
INSERT INTO `product_info` VALUES ('13', '不素之霸双层牛肉堡', '21.00', '99', '1', '2', '8f39ca7518474774b0a57d0e9f1d257e.JPG', null, null);
INSERT INTO `product_info` VALUES ('14', '鲜蔬沙拉', '11.50', '98', '1', '3', '194d6fab070f46649378243b23d80659.JPG', null, null);
INSERT INTO `product_info` VALUES ('15', '薯条', '16.00', '98', '1', '3', 'a7248c18337a4c9fbb68a1231eb19bd1.JPG', null, null);
INSERT INTO `product_info` VALUES ('16', '那么大鸡排', '13.00', '99', '1', '3', 'a7778b63acd04f8a958ee15616ac7db1.JPG', null, null);
INSERT INTO `product_info` VALUES ('17', '上校鸡块', '13.00', '99', '1', '3', 'b09e10e97d7743f1b865f4ec9b4f2272.JPG', null, null);
INSERT INTO `product_info` VALUES ('18', '美味鲜蔬杯', '11.00', '99', '1', '3', '68b463b8494746ba9d4adec1c7277743.JPG', null, null);
INSERT INTO `product_info` VALUES ('19', '香甜玉米', '12.50', '100', '1', '4', 'c38b61a7b3e44f9eb8259caf26ae7c8f.JPG', null, null);
INSERT INTO `product_info` VALUES ('20', '醇香土豆泥', '12.50', '98', '1', '4', '547a7287b7574fe3a3210524e3178b8b.JPG', null, null);
INSERT INTO `product_info` VALUES ('21', '香脆薯饼', '9.50', '100', '1', '4', '9b8f2effcea34cd08b54421dc1a8264f.JPG', null, null);
INSERT INTO `product_info` VALUES ('22', '太阳蛋', '9.50', '98', '1', '4', '15e1ac18fd4d4020aa2e1a099a8286ae.JPG', null, null);
INSERT INTO `product_info` VALUES ('23', '香芋派', '7.50', '100', '1', '4', '9c7bdd7051034422b44f2cb26f0ccb22.JPG', null, null);
INSERT INTO `product_info` VALUES ('24', '怪力血怪饮', '27.00', '99', '1', '5', '5508be914db640338e2d237baa33ad3f.jpg', null, null);
INSERT INTO `product_info` VALUES ('25', '纯纯玉米饮', '13.50', '99', '1', '5', '0e22c8eb29de44b99194e6859069eee6.jpg', null, null);
INSERT INTO `product_info` VALUES ('26', '黑pro豆浆', '13.50', '100', '1', '5', 'bd5b5a3111944257bc126be9f9b55c83.jpg', null, null);
INSERT INTO `product_info` VALUES ('27', '可口可乐', '8.00', '99', '1', '5', '18bb456381b649b9b6497a337291cdec.jpg', null, null);
INSERT INTO `product_info` VALUES ('28', '九珍果汁饮料', '8.00', '100', '1', '5', '198cde05b7064113a18c5a2fa8fcf7dc.jpg', null, null);
INSERT INTO `product_info` VALUES ('29', '开心乐园餐（汉堡包）', '22.00', '94', '1', '6', '510ee4dd569b4446b07381a294f8eec9.jpg', null, null);
INSERT INTO `product_info` VALUES ('30', '开心乐园餐（吉士汉堡包）', '23.00', '98', '1', '6', '4a9b9067a7764ab98fec46af54246f3e.jpg', null, null);
INSERT INTO `product_info` VALUES ('31', '开心乐园餐（麦乐鸡）', '22.00', '95', '1', '6', 'ae460ab1529a46c48bc591e4c4b3e4a8.jpg', null, null);
INSERT INTO `product_info` VALUES ('32', '苹果片', '6.00', '96', '1', '5', 'a44e4a74fe794e1d8a957dac5b6c0bf1.jpg', null, null);
INSERT INTO `product_info` VALUES ('33', '梨片', '6.00', '99', '0', '4', '2a1bc8a3d98b435da24bd0f65fe3d39e.jpg', null, null);
INSERT INTO `product_info` VALUES ('34', '1212', '12.00', '112', '1', '3', 'f7a52d827419455d8d74f9485ee26ce8.jpg', null, null);
INSERT INTO `product_info` VALUES ('35', 'yyyy', '22.00', '22', '1', '1', 'bd1df5e6cd324b42b8f438dd6522b36a.jpg', null, null);
INSERT INTO `product_info` VALUES ('36', 'uuuu', '666.00', '2', '1', '1', '91fef1f868ad4eecb60fffe5169553b8.jpg', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('1', '系统菜单', '0', null, 'glyphicon glyphicon-th-list');
INSERT INTO `t_permission` VALUES ('3', '权限管理', '1', null, 'glyphicon glyphicon glyphicon-tasks');
INSERT INTO `t_permission` VALUES ('4', '管理员维护', '3', '/admin/index', 'glyphicon glyphicon-user');
INSERT INTO `t_permission` VALUES ('5', '角色维护', '3', '/role/index', 'glyphicon glyphicon-knight');
INSERT INTO `t_permission` VALUES ('6', '菜品管理', '1', '', 'glyphicon glyphicon-ok');
INSERT INTO `t_permission` VALUES ('7', '菜品列表', '6', '/product/index', 'glyphicon glyphicon-check');
INSERT INTO `t_permission` VALUES ('9', '菜品品类管理', '6', '/category/index', 'glyphicon glyphicon-tag');
INSERT INTO `t_permission` VALUES ('12', '数据管理', '1', null, 'glyphicon glyphicon-equalizer');
INSERT INTO `t_permission` VALUES ('13', '会员数据', '12', '/member/index', 'glyphicon glyphicon-king');
INSERT INTO `t_permission` VALUES ('14', '订单数据', '12', '/order/index', 'glyphicon glyphicon-list-alt');
INSERT INTO `t_permission` VALUES ('15', '数据分析', '12', '/admin/dataAnalysis', 'glyphicon glyphicon-stats');
INSERT INTO `t_permission` VALUES ('16', '会员显示', '13', '/member/index', 'glyphicon glyphicon-king');
INSERT INTO `t_permission` VALUES ('17', '金额修改', '13', '/member/doEdit', 'glyphicon glyphicon-jpy');
INSERT INTO `t_permission` VALUES ('18', '删除会员', '13', '/member/delete', 'glyphicon glyphicon-check');
INSERT INTO `t_permission` VALUES ('19', '系统设置管理', '1', null, 'glyphicon glyphicon-cog');
INSERT INTO `t_permission` VALUES ('20', '系统设置', '19', '/setting/index', 'glyphicon glyphicon-cog');
INSERT INTO `t_permission` VALUES ('21', '打印机设置', '19', '/printer/index', 'glyphicon glyphicon-print');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='打印机配置表';

-- ----------------------------
-- Records of t_printer
-- ----------------------------
INSERT INTO `t_printer` VALUES ('1', '吧台打印机', '192.168.1.2', '22', '0', '0');
INSERT INTO `t_printer` VALUES ('2', '后厨打印机', '192.168.1.3', '223', '0', '0');
INSERT INTO `t_printer` VALUES ('3', '服务台打印机', '192.168.1.4', '22', '0', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=604 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
INSERT INTO `t_role_permission` VALUES ('577', '1', '1');
INSERT INTO `t_role_permission` VALUES ('578', '1', '3');
INSERT INTO `t_role_permission` VALUES ('579', '1', '4');
INSERT INTO `t_role_permission` VALUES ('580', '1', '5');
INSERT INTO `t_role_permission` VALUES ('581', '1', '6');
INSERT INTO `t_role_permission` VALUES ('582', '1', '7');
INSERT INTO `t_role_permission` VALUES ('583', '1', '9');
INSERT INTO `t_role_permission` VALUES ('584', '1', '12');
INSERT INTO `t_role_permission` VALUES ('585', '1', '14');
INSERT INTO `t_role_permission` VALUES ('586', '1', '15');
INSERT INTO `t_role_permission` VALUES ('587', '1', '19');
INSERT INTO `t_role_permission` VALUES ('588', '1', '20');
INSERT INTO `t_role_permission` VALUES ('589', '1', '21');
INSERT INTO `t_role_permission` VALUES ('590', '2', '1');
INSERT INTO `t_role_permission` VALUES ('591', '2', '6');
INSERT INTO `t_role_permission` VALUES ('592', '2', '7');
INSERT INTO `t_role_permission` VALUES ('593', '2', '9');
INSERT INTO `t_role_permission` VALUES ('594', '2', '12');
INSERT INTO `t_role_permission` VALUES ('595', '2', '14');
INSERT INTO `t_role_permission` VALUES ('596', '2', '15');
INSERT INTO `t_role_permission` VALUES ('597', '2', '19');
INSERT INTO `t_role_permission` VALUES ('598', '2', '20');
INSERT INTO `t_role_permission` VALUES ('599', '2', '21');
INSERT INTO `t_role_permission` VALUES ('600', '26', '1');
INSERT INTO `t_role_permission` VALUES ('601', '26', '12');
INSERT INTO `t_role_permission` VALUES ('602', '26', '14');
INSERT INTO `t_role_permission` VALUES ('603', '26', '15');

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
