-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: lib.cio67kp6uxwj.us-east-1.rds.amazonaws.com    Database: Library
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book` (
  `BookId` int NOT NULL,
  `Title` varchar(50) NOT NULL,
  `PublisherName` varchar(50) NOT NULL,
  `Author` int NOT NULL,
  PRIMARY KEY (`BookId`),
  KEY `PublisherName` (`PublisherName`),
  KEY `Author` (`Author`),
  CONSTRAINT `Book_ibfk_1` FOREIGN KEY (`PublisherName`) REFERENCES `Publisher` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Book_ibfk_2` FOREIGN KEY (`Author`) REFERENCES `Author` (`AuthorId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
INSERT INTO `Book` VALUES (1,'The Lost Tribe','Penguin',1),(2,'Gone With the Wind','Hachette',2),(3,'Hunger Games','Hachette',3),(4,'To Kill a Mockingbird','Penguin',4),(5,'The Book Thief','Penguin',8),(6,'The Giving Tree','Penguin',9),(7,'Hitchhiker\'s Guide','Harper',10),(8,'Fault in Our Stars','Harper',11),(9,'Hobbit','Harper',12),(10,'Lord of the Rings','Penguin',12),(11,'Wuthering Heights','Penguin',14),(12,'The da Vinci Code','Penguin',15),(13,'Alice in Wonderland','Penguin',16),(14,'Divergent','Harper',17),(15,'The Picture of Dorian Gray','Harper',18),(16,'Lord of the Flies','Harper',19),(17,'Ender\'s Game','Harper',20),(18,'The Alchemist','Penguin',21),(19,'Time Traveler\'s Wife','Penguin',22),(20,'Crime & Punishment','Harper',23),(21,'Jane Eyre','Hachette',24),(22,'Charlotte\'s Web','Penguin',25),(23,'The Stand','Hachette',26),(24,'City of Bones','Harper',27);
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-13 22:06:32
