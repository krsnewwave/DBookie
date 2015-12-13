-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: ebook_db
-- ------------------------------------------------------
-- Server version	5.5.46

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
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2015-12-10 06:25:57','historical','Category object',1,'Added.',12,1),(2,'2015-12-10 06:26:10','drama','Category object',1,'Added.',12,1),(3,'2015-12-10 06:26:24','non-fiction','Category object',1,'Added.',12,1),(4,'2015-12-10 06:35:41','1','Publisher object',1,'Added.',14,1),(5,'2015-12-10 06:36:31','1','Author object',1,'Added.',7,1),(6,'2015-12-10 09:33:24','978-0199678112','Book object',1,'Added.',8,1),(7,'2015-12-12 16:34:42','2','Publisher object',1,'Added.',14,1),(8,'2015-12-12 16:35:24','science','Category object',1,'Added.',12,1),(9,'2015-12-12 16:36:19','2','Author object',1,'Added.',7,1),(10,'2015-12-12 16:37:59','978-0062230171','Book object',1,'Added.',8,1),(11,'2015-12-12 16:38:38','978-0062230171','Book object',2,'Changed publisher.',8,1),(12,'2015-12-12 16:39:55','978-0062109392','Book object',1,'Added.',8,1),(13,'2015-12-12 16:40:44','978-0062296238','Book object',1,'Added.',8,1),(14,'2015-12-12 16:45:28','40','ShoppingCart object',2,'Changed discount for cart item \"CartItem object\".',15,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-13 22:12:52
