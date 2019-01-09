
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
-- Table structure for table `ApplicationLog`
--

DROP TABLE IF EXISTS `ApplicationLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ApplicationLog` (
  `ApplicationLogID` int(10) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(10) DEFAULT NULL,
  `RemoteAddress` varchar(100) DEFAULT NULL,
  `RemoteHost` varchar(100) DEFAULT NULL,
  `RemotePort` varchar(100) DEFAULT NULL,
  `RemoteUser` varchar(100) DEFAULT NULL,
  `RemoteUserRedirect` varchar(100) DEFAULT NULL,
  `RequestMethod` varchar(100) DEFAULT NULL,
  `RequestTime` varchar(100) DEFAULT NULL,
  `HTTPAcceptCharacterSet` varchar(100) DEFAULT NULL,
  `HTTPAcceptEncoding` varchar(100) DEFAULT NULL,
  `HTTPAcceptHeader` varchar(1000) DEFAULT NULL,
  `HTTPAcceptLanguage` varchar(100) DEFAULT NULL,
  `HTTPConnection` varchar(100) DEFAULT NULL,
  `HTTPHost` varchar(100) DEFAULT NULL,
  `HTTPReferer` varchar(100) DEFAULT NULL,
  `HTTPSecure` varchar(100) DEFAULT NULL,
  `HTTPUserAgent` varchar(8000) DEFAULT NULL,
  `AuthenticationPassword` varchar(100) DEFAULT NULL,
  `AuthenticationType` varchar(100) DEFAULT NULL,
  `AuthenticationUser` varchar(100) DEFAULT NULL,
  `ServerAddress` varchar(100) DEFAULT NULL,
  `ServerAdministrator` varchar(100) DEFAULT NULL,
  `ServerName` varchar(100) DEFAULT NULL,
  `ServerPort` varchar(100) DEFAULT NULL,
  `ServerProtocol` varchar(100) DEFAULT NULL,
  `ServerSignature` varchar(100) DEFAULT NULL,
  `ServerSoftware` varchar(100) DEFAULT NULL,
  `ScriptFileName` varchar(100) DEFAULT NULL,
  `ScriptName` varchar(100) DEFAULT NULL,
  `ScriptPathTranslated` varchar(100) DEFAULT NULL,
  `ScriptURI` varchar(100) DEFAULT NULL,
  `PathInformation` varchar(100) DEFAULT NULL,
  `PathInformationOriginal` varchar(100) DEFAULT NULL,
  `DocumentRoot` varchar(100) DEFAULT NULL,
  `GatewayInterface` varchar(100) DEFAULT NULL,
  `PHPSelf` varchar(100) DEFAULT NULL,
  `QueryString` varchar(100) DEFAULT NULL,
  `CreateDT` datetime DEFAULT NULL,
  `CreateBy` varchar(100) DEFAULT NULL,
  `ModifyDT` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ActiveFlg` int(1) DEFAULT '1',
  PRIMARY KEY (`ApplicationLogID`)
) ENGINE=MyISAM AUTO_INCREMENT=3397 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-08 20:48:12