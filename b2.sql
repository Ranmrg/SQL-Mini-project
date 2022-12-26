CREATE DATABASE  IF NOT EXISTS `bank` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bank`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bank
-- ------------------------------------------------------
-- Server version	8.0.29

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

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `acnumber` int NOT NULL,
  `custid` int DEFAULT NULL,
  `bid` int DEFAULT NULL,
  `curbal` int DEFAULT NULL,
  `opnDT` date NOT NULL,
  `atype` varchar(15) NOT NULL,
  `astatus` varchar(15) NOT NULL,
  PRIMARY KEY (`acnumber`),
  KEY `custid` (`custid`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`custid`) REFERENCES `customer` (`custid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,1,1,5000,'2012-12-15','Saving','Active'),(2,2,2,2000,'2012-06-12','Saving','Active');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `Branch_no` int NOT NULL,
  `Name` varchar(15) NOT NULL,
  `city` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Branch_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1,'Delhi',NULL),(2,'Mumbai',NULL);
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `custid` int NOT NULL,
  `fname` varchar(15) NOT NULL,
  `mname` varchar(15) DEFAULT NULL,
  `lname` varchar(15) DEFAULT NULL,
  `occupation` varchar(15) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`custid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Ramesh','Chandra','Sharma','Service','1976-12-06','Delhi'),(2,'Avinash','Sunder','Minha','Business','1974-10-16','Mumbai');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!50001 DROP VIEW IF EXISTS `customers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customers` AS SELECT 
 1 AS `custid`,
 1 AS `fname`,
 1 AS `mname`,
 1 AS `lname`,
 1 AS `occupation`,
 1 AS `dob`,
 1 AS `city`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `emp_no` int NOT NULL,
  `Branch_no` int DEFAULT NULL,
  `fname` varchar(15) NOT NULL,
  `Mname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `Dept` varchar(15) NOT NULL,
  `Desig` varchar(15) NOT NULL,
  `managr_no` int NOT NULL,
  PRIMARY KEY (`emp_no`),
  KEY `Branch_no` (`Branch_no`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Branch_no`) REFERENCES `branch` (`Branch_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,1,'Mark','steve','Lara','Account','Accountant',2),(2,2,'Bella','Karan','Singh','Loan','Manager',1);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `tid` int NOT NULL,
  `custid` int NOT NULL,
  `account_no` int DEFAULT NULL,
  `bid` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `DOT` date DEFAULT NULL,
  PRIMARY KEY (`tid`),
  KEY `custid` (`custid`),
  KEY `account_no` (`account_no`),
  KEY `bid` (`bid`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`custid`) REFERENCES `customer` (`custid`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`account_no`) REFERENCES `account` (`acnumber`),
  CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`bid`) REFERENCES `branch` (`Branch_no`),
  CONSTRAINT `transaction_chk_1` CHECK ((`type` in (_utf8mb4'Withdraw',_utf8mb4'deposit')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (123456,1,1,1,1000,'withdraw','2022-08-07'),(123457,1,1,1,1000,'withdraw','2022-08-07'),(123458,1,1,1,1000,'withdraw','2022-08-07'),(123459,1,1,1,1000,'withdraw','2022-08-07'),(123460,1,1,1,1000,'deposit','2022-08-07'),(123461,1,1,1,1000,'deposit','2022-08-07'),(123462,1,1,1,1000,'deposit','2022-08-07'),(123463,1,1,1,1000,'deposit','2022-08-07'),(123464,2,1,1,1000,'deposit','2022-08-07'),(123465,2,1,1,1000,'withdraw','2022-08-07'),(123466,2,1,1,3000,'withdraw','2022-08-07'),(123467,1,1,1,3000,'withdraw','2022-08-07');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `customers`
--

/*!50001 DROP VIEW IF EXISTS `customers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customers` AS select `account`.`custid` AS `custid`,`customer`.`fname` AS `fname`,`customer`.`mname` AS `mname`,`customer`.`lname` AS `lname`,`customer`.`occupation` AS `occupation`,`customer`.`dob` AS `dob`,`customer`.`city` AS `city` from ((`account` join `customer` on((`account`.`custid` = `customer`.`custid`))) join `branch` on((`account`.`bid` = `branch`.`Branch_no`))) where (`customer`.`city` = `branch`.`Name`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-07 13:43:30
