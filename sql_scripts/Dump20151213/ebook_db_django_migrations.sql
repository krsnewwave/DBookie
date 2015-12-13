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
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2015-12-04 09:14:48'),(2,'auth','0001_initial','2015-12-04 09:14:49'),(3,'admin','0001_initial','2015-12-04 09:14:49'),(4,'sessions','0001_initial','2015-12-04 09:14:49'),(5,'admin','0002_logentry_remove_auto_add','2015-12-10 03:42:45'),(6,'contenttypes','0002_remove_content_type_name','2015-12-10 03:42:45'),(7,'auth','0002_alter_permission_name_max_length','2015-12-10 03:42:46'),(8,'auth','0003_alter_user_email_max_length','2015-12-10 03:42:46'),(9,'auth','0004_alter_user_username_opts','2015-12-10 03:42:46'),(10,'auth','0005_alter_user_last_login_null','2015-12-10 03:42:46'),(11,'auth','0006_require_contenttypes_0002','2015-12-10 03:42:46'),(12,'auth','0007_alter_validators_add_error_messages','2015-12-10 03:42:46'),(13,'ebooks','0001_initial','2015-12-10 03:42:46'),(14,'ebooks','0002_book_bookhasauthor_bookhascategory_payment','2015-12-10 03:42:46'),(15,'ebooks','0003_customer','2015-12-12 02:30:20'),(16,'ebooks','0004_auto_20151212_1030','2015-12-12 02:30:20'),(17,'ebooks','0005_auto_20151212_1032','2015-12-12 02:33:00'),(18,'ebooks','0006_auto_20151212_1055','2015-12-12 02:55:39'),(19,'ebooks','0007_auto_20151212_1111','2015-12-12 03:15:12'),(20,'ebooks','0008_auto_20151212_1122','2015-12-12 03:22:37'),(21,'ebooks','0009_auto_20151212_1125','2015-12-12 03:25:54');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-13 22:13:05
