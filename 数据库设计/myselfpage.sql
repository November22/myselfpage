-- MySQL dump 10.13  Distrib 5.6.29, for Win64 (x86_64)
--
-- Host: localhost    Database: myselfpage
-- ------------------------------------------------------
-- Server version	5.6.29-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `hs_album`
--

DROP TABLE IF EXISTS `hs_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hs_album` (
  `album_id` varchar(32) NOT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT '相册的描述',
  `visit_count` int(8) DEFAULT NULL COMMENT '统计相册的访问次数，以点击打开相册一次为一次',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(32) NOT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='相册表，用来管理图片（相片）表\r\n删除就真删除了，免得浪费资源';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hs_album`
--

LOCK TABLES `hs_album` WRITE;
/*!40000 ALTER TABLE `hs_album` DISABLE KEYS */;
INSERT INTO `hs_album` VALUES ('album12345','测试相册第一个，多谢几个字',NULL,'2017-04-13 03:20:28','');
/*!40000 ALTER TABLE `hs_album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hs_article`
--

DROP TABLE IF EXISTS `hs_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hs_article` (
  `article_id` varchar(32) NOT NULL,
  `title` varchar(32) NOT NULL,
  `digest` varchar(256) DEFAULT NULL,
  `content` text NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_id` varchar(32) NOT NULL,
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人文章表，用于存储个人在网站的发表的文章';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hs_article`
--

LOCK TABLES `hs_article` WRITE;
/*!40000 ALTER TABLE `hs_article` DISABLE KEYS */;
INSERT INTO `hs_article` VALUES ('a123456','测试文章1','这是一个测试的摘要','内容正在考虑是纯文本是说，可以插入图片之类的，目前还没有确定','2017-04-13 03:22:20','2017-04-13 03:22:24','');
/*!40000 ALTER TABLE `hs_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hs_dictionary`
--

DROP TABLE IF EXISTS `hs_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hs_dictionary` (
  `dictionary_id` int(2) NOT NULL COMMENT '类型',
  `type` varchar(20) NOT NULL COMMENT '1-阅读分享\r\n2-心得体会\r\n3-留言于主页\r\n4-留言于个人文章\r\n5-留言于分享\r\n6-留言于相册',
  `remark` varchar(256) DEFAULT NULL COMMENT '对类型的描述\r\n',
  PRIMARY KEY (`dictionary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hs_dictionary`
--

LOCK TABLES `hs_dictionary` WRITE;
/*!40000 ALTER TABLE `hs_dictionary` DISABLE KEYS */;
INSERT INTO `hs_dictionary` VALUES (1,'阅读分享','针对的是share表'),(2,'心得体会','针对的是share表，用户在发表分享的时候，可以选择这两种'),(3,'留言于主页','用户留言的位置'),(4,'留言于个人文章','留言在个人文章，留言表上应该有文章的ID'),(5,'留言于分享','留言于分享上应该有分享的id'),(6,'留言于相册','目前只针对相册，不针对图片');
/*!40000 ALTER TABLE `hs_dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hs_images`
--

DROP TABLE IF EXISTS `hs_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hs_images` (
  `image_id` varchar(32) NOT NULL,
  `image_name` varchar(16) DEFAULT NULL,
  `image_url` varchar(256) NOT NULL,
  `upload_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `album_id` varchar(32) NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `hs_images_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `hs_album` (`album_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用来存储图片';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hs_images`
--

LOCK TABLES `hs_images` WRITE;
/*!40000 ALTER TABLE `hs_images` DISABLE KEYS */;
INSERT INTO `hs_images` VALUES ('image1','测试图1','https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=356169338,1383516396&fm=58','2017-04-13 03:28:29','album12345'),('image2','测试图2','https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2278874371,3682636674&fm=58','2017-04-13 03:29:06','album12345');
/*!40000 ALTER TABLE `hs_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hs_leave_word`
--

DROP TABLE IF EXISTS `hs_leave_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hs_leave_word` (
  `lw_id` varchar(32) NOT NULL,
  `content` varchar(512) NOT NULL,
  `vc_id` varchar(32) NOT NULL COMMENT '对于留言表，指明留言对象\r\n',
  `dictionary_id` int(2) NOT NULL COMMENT '类型',
  `belong_id` varchar(32) DEFAULT NULL COMMENT '留言处的对象的ID，如果是主页就没有ID',
  PRIMARY KEY (`lw_id`),
  KEY `dictionary_id` (`dictionary_id`),
  KEY `vc_id` (`vc_id`),
  CONSTRAINT `hs_leave_word_ibfk_1` FOREIGN KEY (`dictionary_id`) REFERENCES `hs_dictionary` (`dictionary_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `hs_leave_word_ibfk_2` FOREIGN KEY (`vc_id`) REFERENCES `hs_visit_count` (`vc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户留言，分为首页留言，图片留言，文章留言之类的';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hs_leave_word`
--

LOCK TABLES `hs_leave_word` WRITE;
/*!40000 ALTER TABLE `hs_leave_word` DISABLE KEYS */;
INSERT INTO `hs_leave_word` VALUES ('l1','个人网页做的好棒','vc1',3,'');
/*!40000 ALTER TABLE `hs_leave_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hs_share`
--

DROP TABLE IF EXISTS `hs_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hs_share` (
  `share_id` varchar(32) NOT NULL,
  `dictionary_id` int(2) NOT NULL COMMENT '类型',
  `content` text NOT NULL,
  `conten_from` varchar(100) NOT NULL COMMENT '分享内容的出处，心得体会；阅读笔记\r\n心得体会 -- 用户的昵称\r\n阅读笔记 -- 《莎士比亚选集》',
  `user_id` varchar(32) NOT NULL,
  PRIMARY KEY (`share_id`),
  KEY `dictionary_id` (`dictionary_id`),
  CONSTRAINT `hs_share_ibfk_1` FOREIGN KEY (`dictionary_id`) REFERENCES `hs_dictionary` (`dictionary_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阅读分享，也可以是随记';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hs_share`
--

LOCK TABLES `hs_share` WRITE;
/*!40000 ALTER TABLE `hs_share` DISABLE KEYS */;
INSERT INTO `hs_share` VALUES ('s1',1,'阅读分享类型','追风筝的人','u1'),('s2',2,'心得体会','用户名称','u1');
/*!40000 ALTER TABLE `hs_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hs_userinfo`
--

DROP TABLE IF EXISTS `hs_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hs_userinfo` (
  `user_id` varchar(32) NOT NULL,
  `nick_name` varchar(16) DEFAULT NULL COMMENT '使用ifnull,或者在插入数据的时候，没有昵称就设置为邮箱\r\n',
  `email` varchar(128) DEFAULT NULL,
  `password` varchar(16) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active_code` varchar(64) DEFAULT NULL COMMENT '应当设置激活码失效时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nick_name` (`nick_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储个人信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hs_userinfo`
--

LOCK TABLES `hs_userinfo` WRITE;
/*!40000 ALTER TABLE `hs_userinfo` DISABLE KEYS */;
INSERT INTO `hs_userinfo` VALUES ('u1','haha','123@qq.com','123','2017-04-13 05:08:51','21342341234'),('u2','hshs','134@qq.com','123','2017-04-13 05:09:11','sdfasd1315sdf');
/*!40000 ALTER TABLE `hs_userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hs_visit_count`
--

DROP TABLE IF EXISTS `hs_visit_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hs_visit_count` (
  `vc_id` varchar(32) NOT NULL,
  `visitor_num` varchar(16) NOT NULL COMMENT '固定格式   visit_编号',
  `ip` varchar(16) NOT NULL COMMENT '访问者的ip，通过ip，判断他以前访问过没有',
  PRIMARY KEY (`vc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网站访问统计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hs_visit_count`
--

LOCK TABLES `hs_visit_count` WRITE;
/*!40000 ALTER TABLE `hs_visit_count` DISABLE KEYS */;
INSERT INTO `hs_visit_count` VALUES ('vc1','hs_001','192.168.242.31');
/*!40000 ALTER TABLE `hs_visit_count` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-13 13:14:12
