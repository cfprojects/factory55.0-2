-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.51-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema factory55_demo
--

CREATE DATABASE IF NOT EXISTS factory55_demo;
USE factory55_demo;

--
-- Definition of table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `alias` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`,`name`,`alias`) VALUES 
 (1,'Factory 55','f55');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;


--
-- Definition of table `entries`
--

DROP TABLE IF EXISTS `entries`;
CREATE TABLE `entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `alias` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `morebody` varchar(1000) NOT NULL,
  `allowComments` bit(1) NOT NULL,
  `released` bit(1) NOT NULL,
  `views` int(10) unsigned NOT NULL,
  `datePosted` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entries`
--

/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` (`id`,`title`,`alias`,`body`,`morebody`,`allowComments`,`released`,`views`,`datePosted`) VALUES 
 (1,'Test Posting','test_posting','This is a test posting[more]that has the full body','This is a test posting',0x01,0x01,0,'2010-12-31 00:00:00');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;


--
-- Definition of table `entries_categories`
--

DROP TABLE IF EXISTS `entries_categories`;
CREATE TABLE `entries_categories` (
  `entry_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entries_categories`
--

/*!40000 ALTER TABLE `entries_categories` DISABLE KEYS */;
INSERT INTO `entries_categories` (`entry_id`,`category_id`) VALUES 
 (1,1);
/*!40000 ALTER TABLE `entries_categories` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
