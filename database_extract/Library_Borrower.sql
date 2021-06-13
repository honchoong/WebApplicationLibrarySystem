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
-- Table structure for table `Borrower`
--

DROP TABLE IF EXISTS `Borrower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Borrower` (
  `CardNo` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Phone` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`CardNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Borrower`
--

LOCK TABLES `Borrower` WRITE;
/*!40000 ALTER TABLE `Borrower` DISABLE KEYS */;
INSERT INTO `Borrower` VALUES (2,'Rudolph Valentino','893 SE Tonaka Rd.',NULL),(6,'Terry Dunn','08 SW River Pkwy',NULL),(11,'Steve McQueen','8349 NW Broadway Ave.',NULL),(34,'Timmy Kindle','43 N Smith Ave.',NULL),(67,'Imma Reader','2464 NE Division St',NULL),(222,'John Slate','492 SE Bonita Rd.',NULL),(332,'Betty Simmons','2523 NE Market St.',NULL),(454,'Dan Smith','2409 SW 45th Ave.',NULL),(469,'Gary Carter','408 NW Beaverton Rd.',NULL),(889,'John Dunn','9953 SW 24th Ave.',NULL),(1853,'Gary Gumbel','0459 SW Livery Rd.',NULL),(2749,'George Carlin','8984 NW Miller Rd.',NULL),(3356,'Marcus Lee','24 N Williams Ave.',NULL),(7250,'Marcus Aurelius','8842 NW Cornelius St.',NULL),(8355,'Felix Unger','23445 NE Betheny Ave.',NULL),(8835,'Minnie Mouse','3409 NW Tacoma St.',NULL),(9267,'Allison Reynolds','4089 SW Tanager Dr.',NULL),(19347,'Freddy Krueger','23049 NW Moonbeam Ln.',NULL),(22455,'Jane Austen','6543 NE Denton St.',NULL),(45545,'George Orton','2308 SE Greystone St.',NULL),(234346,'Candy Cane','493 SW Hood St.',NULL),(882543,'Betty Rubble','409 SE Stone Ln.',NULL),(3434342,'Stephenie Meyer','240 SE Swail Ave.',NULL),(5454543,'Martin Zell','953 SE Carlton Ave.',NULL),(67787887,'Sheila Wozniak','2021 SE Milwaukie Ave',NULL);
/*!40000 ALTER TABLE `Borrower` ENABLE KEYS */;
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

-- Dump completed on 2021-06-13 22:06:25
