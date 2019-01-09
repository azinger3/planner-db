
USE `planner`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host:     Database: planner
-- ------------------------------------------------------
-- Server version	5.7.22-log

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
-- Table structure for table `BudgetIncome`
--

DROP TABLE IF EXISTS `BudgetIncome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BudgetIncome` (
  `BudgetIncomeID` int(10) NOT NULL AUTO_INCREMENT,
  `BudgetNumber` varchar(100) DEFAULT NULL,
  `IncomeName` varchar(100) DEFAULT NULL,
  `IncomeTypeID` int(10) DEFAULT NULL,
  `IncomeType` varchar(100) DEFAULT NULL,
  `PayCycleID` int(10) DEFAULT NULL,
  `PayCycle` varchar(100) DEFAULT NULL,
  `TakeHomePay` decimal(10,4) DEFAULT NULL,
  `HourlyRate` decimal(10,4) DEFAULT NULL,
  `PlannedHours` int(10) DEFAULT NULL,
  `Salary` decimal(10,4) DEFAULT NULL,
  `YearDeduct` decimal(10,4) DEFAULT NULL,
  `Sort` int(3) DEFAULT NULL,
  `CreateDT` datetime DEFAULT NULL,
  `CreateBy` varchar(100) DEFAULT NULL,
  `ModifyDT` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ActiveFlg` int(1) DEFAULT '1',
  PRIMARY KEY (`BudgetIncomeID`)
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-08 20:48:22
