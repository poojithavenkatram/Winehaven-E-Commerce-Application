-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: IES-ADS-ClassDB.sjsu.edu    Database: bossbunch_db
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Current Database: `bossbunch_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bossbunch_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `bossbunch_db`;

--
-- Table structure for table `AffordableWines`
--

DROP TABLE IF EXISTS `AffordableWines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AffordableWines` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `color` varchar(25) DEFAULT NULL,
  `vintage` varchar(25) DEFAULT NULL,
  `price_group` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AffordableWines`
--

LOCK TABLES `AffordableWines` WRITE;
/*!40000 ALTER TABLE `AffordableWines` DISABLE KEYS */;
INSERT INTO `AffordableWines` VALUES (1,'Cabernet Sauvignon','Red','2016','Expensive'),(2,'Chardonnay','White','2019','Affordable'),(3,'Merlot','Red','2018','Expensive'),(4,'Sauvignon Blanc','White','2020','Affordable');
/*!40000 ALTER TABLE `AffordableWines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cart`
--

DROP TABLE IF EXISTS `Cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cart` (
  `CartID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `WineID` varchar(25) NOT NULL,
  `Quantity` int NOT NULL,
  `total_wine_price` float DEFAULT NULL,
  `pers_id` varchar(25) DEFAULT NULL,
  `custom_message` varchar(1000) DEFAULT NULL,
  `gift_wrap` tinyint(1) DEFAULT NULL,
  `customization_price` float DEFAULT NULL,
  PRIMARY KEY (`CartID`),
  KEY `fk_cart_customer` (`CustomerID`),
  KEY `fk_cart_wine` (`WineID`),
  CONSTRAINT `fk_cart_customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`),
  CONSTRAINT `fk_cart_wine` FOREIGN KEY (`WineID`) REFERENCES `Wine` (`WineID`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cart`
--

LOCK TABLES `Cart` WRITE;
/*!40000 ALTER TABLE `Cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Countries`
--

DROP TABLE IF EXISTS `Countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Countries` (
  `CountryCode` varchar(25) NOT NULL,
  `CountryName` varchar(25) NOT NULL,
  PRIMARY KEY (`CountryCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Countries`
--

LOCK TABLES `Countries` WRITE;
/*!40000 ALTER TABLE `Countries` DISABLE KEYS */;
INSERT INTO `Countries` VALUES ('CA','Canada'),('FR','France'),('GE','Germany'),('IN','India'),('IT','Italy'),('PR','Prague'),('RU','Russia'),('SW','Switzerland'),('UK','United Kingdom'),('US','United States');
/*!40000 ALTER TABLE `Countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Custom_orders`
--

DROP TABLE IF EXISTS `Custom_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Custom_orders` (
  `Custom_OrderID` varchar(25) NOT NULL,
  `Date` date NOT NULL,
  `pers_id` varchar(30) DEFAULT NULL,
  `custom_message` varchar(1000) DEFAULT NULL,
  `gift_wrap` tinyint(1) DEFAULT NULL,
  `gift_wrap_cost` float DEFAULT NULL,
  `custom_bottle_price` float DEFAULT NULL,
  `total_custom_price` float DEFAULT NULL,
  `OrderID` varchar(25) NOT NULL,
  PRIMARY KEY (`Custom_OrderID`),
  KEY `OrdersFK` (`OrderID`),
  CONSTRAINT `OrdersFK` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Custom_orders`
--

LOCK TABLES `Custom_orders` WRITE;
/*!40000 ALTER TABLE `Custom_orders` DISABLE KEYS */;
INSERT INTO `Custom_orders` VALUES ('CUSTODR007','2023-05-06','PERS003','hello',0,0,29.99,29.99,'ORD007'),('CUSTODR008','2023-05-06','PERS003','hi gobi',1,3.99,29.99,33.98,'ORD008'),('CUSTODR1731','2023-05-11','PERS005','congrats for graduation',1,3.99,23,26.99,'ORD173'),('CUSTODR1732','2023-05-11','PERS004','Congrats for your new home !',0,0,19.99,19.99,'ORD173'),('CUSTODR1741','2023-05-12','PERS001','HBD Becky !',1,3.99,24.99,28.98,'ORD174'),('CUSTODR1742','2023-05-12','PERS001','HBD Becky !',1,3.99,24.99,28.98,'ORD174'),('CUSTODR1743','2023-05-12','PERS002','happy anniversary',1,3.99,20.45,24.44,'ORD174'),('CUSTODR1761','2023-05-12','PERS001','happy bday ram',1,3.99,24.99,28.98,'ORD176'),('CUSTODR1771','2023-05-12','PERS004','celebrate together honey !',1,3.99,19.99,23.98,'ORD177'),('CUSTODR1772','2023-05-12','PERS004','celebrate together honey !',1,3.99,19.99,23.98,'ORD177'),('CUSTODR3401','2023-05-19','PERS002','hello',1,3.99,20.45,24.44,'ORD439'),('CUSTODR3402','2023-05-19','PERS001','Wishing you a very Happy Birthday! Hope you like this wine.',1,3.99,24.99,28.98,'ORD439');
/*!40000 ALTER TABLE `Custom_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `CustomerID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `CountryCode` varchar(25) DEFAULT NULL,
  `State` varchar(20) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Street` varchar(100) DEFAULT NULL,
  `ZipCode` varchar(10) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  KEY `CustomerFK1` (`CountryCode`),
  CONSTRAINT `CustomerFK1` FOREIGN KEY (`CountryCode`) REFERENCES `Countries` (`CountryCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1001,'Emma','Lee','1988-06-15',34,'US','California','Los Angeles','123 Main St.','90001','emma.lee@example.com'),(1002,'James','Kim','1996-11-23',26,'US','California','Los Angeles','456 Elm St.','60601','james.kim@example.com'),(1003,'Olivia','Chen','1975-03-07',48,'RU','Moscow','Moscow','789 Oak St.','75001','olivia.chen@example.com'),(1004,'Ethan','Liu','1982-09-12',39,'IN','Delhi','New Delhi','321 Maple St.','10001','ethan.liu@example.com'),(1005,'Sophia','Wong','1992-12-01',30,'UK','London','London','654 Pine St.','90001','sophia.wong@example.com'),(1006,'William','Kim','1978-07-29',43,'GE','Berlin','Berlin','987 Cedar St.','30301','william.kim@example.com'),(1007,'Emily','Park','1999-04-05',23,'PR','San Juan','San Juan','654 Birch St.','75201','emily.park@example.com'),(1008,'Daniel','Kim','1990-08-18',32,'IT','Rome','Rome','321 Spruce St.','02101','daniel.kim@example.com'),(1009,'Elizabeth','Lee','1985-02-20',38,'SW','Stockholm','Stockholm','789 Hickory St.','60601','elizabeth.lee@example.com'),(1010,'Michael','Nguyen','1972-12-09',50,'FR','Paris','Paris','246 Juniper St.','90001','michael.nguyen@example.com'),(1020,'Olivia','Brown','1985-04-03',37,'PR','Capri','San Francisco','baobUW65br','93436','fETeKGAE@example.com'),(1021,'Emily','Wilson','1976-08-21',34,'PR','Texas','San Jose','MWTvNQW9XY','77439','S9tdqdLk@example.com'),(1022,'David','Smith','1988-12-17',51,'US','Capri','San Jose','aOuvWtC4tK','97776','wMJIEpBh@example.com'),(1023,'Olivia','Johnson','2000-05-19',22,'IN','New York','San Francisco','wc6gPGWI5e','58915','VVlHYNDV@example.com'),(1024,'Emily','Smith','1998-03-31',30,'IN','Berlin','Miami','k2Zjp7RbVd','64330','1Pt06ZQc@example.com'),(1025,'Olivia','Wilson','1975-12-30',35,'FR','Wales','San Francisco','3CmylwpJNG','65385','27YSieRu@example.com'),(1026,'Olivia','Wilson','1970-05-13',45,'UK','California','San Jose','53SYlHucaP','01350','sdOYN0IM@example.com'),(1027,'John','Anderson','1980-02-24',46,'IN','Florida','New York','ZmNhLy8BMa','14957','qd56fbjK@example.com'),(1028,'David','Anderson','1983-06-25',59,'GE','Florida','Chicago','qDsSRE7KKd','36946','EVLsF1Em@example.com'),(1029,'John','Smith','1983-11-29',54,'CA','Texas','Chicago','T73C3vtrZH','29895','0DpBKCRa@example.com'),(1030,'David','Anderson','1985-05-08',50,'IN','New York','Chicago','9yB9qeUe5u','95374','G3yi77F7@example.com'),(1031,'Emily','Wilson','1971-01-09',32,'US','Wales','New York','IebRSU7j15','41316','GawXgSBf@example.com'),(1032,'David','Johnson','1989-10-03',43,'IN','Berlin','San Jose','NmUMeXavxM','10473','vwB9ntnQ@example.com'),(1033,'David','Wilson','1981-08-25',29,'UK','Texas','Miami','RO8olaleKP','77404','L30twGj0@example.com'),(1034,'Emily','Anderson','1975-01-29',44,'RU','Florida','Chicago','shea1bJvvi','39338','D6oYP3WQ@example.com'),(1035,'John','Brown','1978-11-26',23,'IT','Texas','Chicago','nQt0E3zGC9','33639','di7VsyuW@example.com'),(1036,'Olivia','Brown','1985-05-24',31,'UK','Berlin','Miami','tuA9VfhEzQ','29801','PIZs2PDB@example.com'),(1037,'Olivia','Brown','1978-10-13',62,'IT','Berlin','Miami','1FnqiENXvn','34641','WArzTlGt@example.com'),(1038,'Olivia','Wilson','1991-04-28',58,'FR','New York','Miami','14iCpQ5vtH','59626','eBjDaoUU@example.com'),(1039,'John','Anderson','1985-11-30',30,'IN','Texas','San Francisco','iYJp90PaSh','32910','gH3VLIMS@example.com'),(1040,'Jane','Smith','1976-03-08',35,'CA','Texas','San Francisco','YhUYLEyESe','58793','pWUiDDPF@example.com'),(1041,'Olivia','Brown','1994-07-15',26,'UK','New York','San Francisco','eWdYSfOQYu','05601','sV8GcKLR@example.com'),(1042,'Michael','Brown','1999-08-19',43,'PR','Florida','Chicago','iORmVUhid5','45071','Ceao7STC@example.com'),(1043,'Michael','Brown','1975-03-30',65,'RU','California','Los Angeles','Q0QVmzokPo','02353','4CUCcwMC@example.com'),(1044,'Michael','Smith','1989-07-19',32,'RU','Texas','Chicago','FtyfYjzwnU','95368','h90yH2uC@example.com'),(1045,'Jane','Johnson','1982-08-25',40,'GE','Florida','San Jose','T1q2EOeB5I','07192','fpPAUXx3@example.com'),(1046,'Jane','Brown','1984-11-28',59,'GE','Berlin','San Francisco','h80BVd065z','82642','J0iczihS@example.com'),(1047,'Michael','Wilson','1975-10-09',60,'US','Wales','New York','1uoTCiZV4R','44627','pZbEy8Gp@example.com'),(1048,'Michael','Brown','1978-12-16',43,'RU','California','New York','H65WUlCuKz','53688','3MrdYNFu@example.com'),(1049,'Jane','Anderson','1995-06-11',63,'US','New York','Dallas','QIB7bq0CaU','69303','q17b9nrt@example.com'),(1050,'David','Smith','1975-01-04',39,'IT','Texas','Los Angeles','HtNeAq1mVb','35509','AGPNJtzJ@example.com'),(1051,'David','Smith','1970-01-15',36,'SW','Berlin','Los Angeles','Xiw47zMRJa','63945','iNwKr4D4@example.com'),(1052,'John','Wilson','1978-03-31',40,'SW','Florida','Dallas','wl6ehhqn3O','15075','Z7P4534h@example.com'),(1053,'John','Smith','1981-01-22',29,'IN','Florida','Miami','tkOmkTlAPm','39055','PdQTIfOq@example.com'),(1054,'Jane','Taylor','1993-11-29',43,'FR','New York','Los Angeles','Ru6aggt2o9','32950','pF02gg4i@example.com'),(1055,'David','Smith','1994-09-20',30,'FR','New York','Miami','97dFsQjlU0','96799','edThknLS@example.com'),(1056,'David','Taylor','1980-02-04',57,'SW','Capri','Chicago','9UQGn5NvX5','04640','FJq3W557@example.com'),(1057,'John','Brown','1998-05-22',36,'RU','Wales','Chicago','y5cqm2wRyd','65433','VTl597jo@example.com'),(1058,'Jane','Anderson','1989-08-18',63,'RU','New York','New York','vCmfKx3Njo','36895','7jKRKcaA@example.com'),(1059,'David','Johnson','1978-05-15',52,'IT','Florida','Los Angeles','o0DxIrgNyy','90625','By27Z1c5@example.com'),(1060,'Jane','Brown','1997-04-14',44,'IN','Florida','New York','Q5HKrjBZiJ','88665','Y82oOQLo@example.com'),(1061,'David','Taylor','1987-12-21',31,'PR','Florida','Miami','Z0teqV6CYY','97941','Mcf87RgL@example.com'),(1062,'John','Smith','1974-11-26',40,'IN','Florida','Chicago','MMc9jeksOM','63881','rm8lGeQu@example.com'),(1063,'Jane','Johnson','1995-02-15',28,'PR','Florida','Chicago','Bprls8lHEY','55727','LqqmPBOc@example.com'),(1064,'Olivia','Wilson','1999-04-30',24,'GE','New York','San Jose','soabpT62za','77572','6prx0fGl@example.com'),(1065,'John','Taylor','1994-04-28',36,'US','California','Los Angeles','2A1oF2QVKt','58366','NGY6TkTU@example.com'),(1066,'Emily','Johnson','1977-10-22',33,'CA','Florida','Dallas','RrllJTaXnM','87407','93QrKdaW@example.com'),(1067,'Olivia','Brown','1995-05-17',30,'GE','California','Dallas','xpZjZXkRBq','58024','5s4GArIz@example.com'),(1068,'Emily','Brown','1975-09-29',37,'FR','New York','San Jose','kHGaE3ACf2','80352','a79Vzx3j@example.com'),(1069,'Emily','Smith','1992-01-03',27,'PR','Florida','New York','MVtjF7Aa0S','57059','2mGI30nR@example.com'),(1070,'Michael','Smith','1989-07-26',54,'IN','Texas','Dallas','pRkgAmWHUv','19366','fOSKGzeX@example.com'),(1071,'Olivia','Brown','1977-04-08',21,'UK','Capri','New York','bWUMb4r2oq','81557','eyVtqBzs@example.com'),(1072,'Olivia','Wilson','1975-10-08',58,'CA','Berlin','Miami','3bXOG3QSuC','05350','QhfjIhE3@example.com'),(1073,'Jane','Taylor','1991-09-20',54,'IT','Texas','Miami','G9ScT3Nh9h','44829','dQQjQA63@example.com'),(1074,'Olivia','Wilson','1982-11-26',37,'PR','Berlin','San Francisco','WmxtTjTReQ','79146','QKGUChj1@example.com'),(1075,'Michael','Taylor','1989-11-11',49,'SW','Wales','Chicago','rna4tGCkTn','38152','1PVO6IVI@example.com'),(1076,'Jane','Anderson','1999-03-26',31,'IN','Wales','New York','GHNTygTh3G','40517','yCMQc6i3@example.com'),(1077,'Jane','Taylor','1968-08-12',25,'PR','Florida','Dallas','4l6MXoW2E3','72746','xCyMVNm6@example.com'),(1078,'John','Smith','1981-04-30',47,'IN','Wales','San Francisco','w9tCObp07m','62811','S3rkP0Rs@example.com'),(1079,'Michael','Brown','1976-07-18',63,'GE','California','Miami','nyOIcYtzsv','34724','BR9SARl7@example.com'),(1080,'Jane','Smith','1971-03-18',51,'PR','New York','Miami','0TjHid2fS8','74349','RuK8m11Y@example.com'),(1081,'Olivia','Wilson','1969-08-04',34,'FR','New York','Los Angeles','PadJCl4qSU','67079','6J686pRQ@example.com'),(1082,'Jane','Taylor','1969-09-13',32,'GE','Berlin','San Francisco','Ul37W60MFc','32968','pf0VmTw8@example.com'),(1083,'Emily','Johnson','1993-12-06',40,'PR','New York','San Jose','0OvlmLyWv4','90477','abGyPCLi@example.com'),(1084,'John','Anderson','1977-05-15',45,'FR','Wales','Dallas','RmbBxj79Fj','59635','gGGndmac@example.com'),(1085,'Jane','Smith','1972-05-08',38,'FR','Texas','Los Angeles','3o6JRM5ORg','54902','MzGeihqi@example.com'),(1086,'David','Johnson','1987-04-19',52,'RU','Berlin','New York','1weHyACxA7','53050','7pwTFpLX@example.com'),(1087,'John','Brown','1988-05-02',51,'SW','Florida','Chicago','JHbHmrY2sR','98351','j3u8mnM7@example.com'),(1088,'Emily','Johnson','1997-11-29',60,'UK','Berlin','San Jose','eOQHykUIbz','61513','SZDHzlyX@example.com'),(1089,'Michael','Brown','1980-02-06',65,'RU','California','New York','mbRLNcSKA7','18555','b688MB1S@example.com'),(1090,'David','Wilson','1985-07-06',63,'CA','Capri','Miami','cEMz95530b','50738','eOukX1MK@example.com'),(1091,'John','Smith','1985-01-20',40,'FR','Texas','Chicago','R6jEg8zn4j','98167','Ev4LZsUm@example.com'),(1092,'John','Wilson','1988-07-16',36,'GE','Wales','San Jose','t64IceKmYk','89512','c2pr128H@example.com'),(1093,'Michael','Anderson','1987-11-20',45,'SW','Berlin','Los Angeles','uF6Hp8bUoj','08726','53eqRv3n@example.com'),(1094,'Jane','Wilson','1985-11-26',28,'UK','Wales','San Jose','VjnJeB2Ba0','89827','6RI7ypz9@example.com'),(1095,'Jane','Anderson','1988-07-03',46,'IT','Berlin','San Francisco','UIjKjN1PS7','82187','h3WnjjHc@example.com'),(1096,'David','Taylor','1976-08-17',36,'CA','Texas','San Francisco','wgW4QPMGce','44994','b74hsFoa@example.com'),(1097,'Michael','Johnson','1999-10-31',60,'RU','California','New York','XtMfZ0ky1L','65446','hRD6GzwU@example.com'),(1098,'Emily','Johnson','1983-03-23',59,'IT','New York','San Jose','AusAbHFTBm','71392','Yb88EpOQ@example.com'),(1099,'David','Johnson','1994-11-05',47,'FR','Capri','Chicago','B8wBb1vWMB','35795','fpa79K1Y@example.com'),(1100,'Jane','Johnson','2000-07-12',52,'UK','Berlin','San Francisco','RRSmI3LVi8','91854','lJE06APl@example.com'),(1101,'John','Wilson','1993-11-13',56,'US','California','San Francisco','4hRj8W1jI8','09982','wcHWa47b@example.com'),(1102,'Olivia','Anderson','1993-04-05',40,'IN','Berlin','San Jose','nKIINMSsZK','25542','4ixxY9Nt@example.com'),(1103,'John','Johnson','1996-05-27',59,'FR','Capri','Los Angeles','MI6RESbWFc','53595','fa47Mnkr@example.com'),(1104,'John','Johnson','1969-06-10',57,'FR','California','Los Angeles','QtOreiN1d4','41645','Dh5dooQe@example.com'),(1105,'Jane','Brown','1974-01-07',36,'IN','Florida','Los Angeles','WuvIfKOp8I','76622','4VTAdO7j@example.com'),(1106,'Jane','Wilson','1987-06-10',53,'IT','Texas','Los Angeles','1vnZNdspyf','81427','gweQzA5u@example.com'),(1107,'John','Taylor','1988-04-28',44,'US','California','New York','3cK4K0MtHF','33545','84RBzZ9e@example.com'),(1108,'John','Anderson','1988-11-19',25,'RU','Texas','San Francisco','OXeGyw6bm9','32010','MI8PBYJ6@example.com'),(1109,'Olivia','Taylor','1973-01-07',35,'PR','Wales','Chicago','vbX5PZiMeI','08297','OQ1zoAUS@example.com'),(1110,'Olivia','Anderson','1996-02-08',51,'SW','Wales','New York','WhTYLcMGkF','99060','zdNakCBZ@example.com'),(1111,'David','Wilson','1993-09-28',46,'PR','Texas','Los Angeles','JiwsfYHBis','06479','12yYjmxI@example.com'),(1112,'John','Wilson','1980-09-06',32,'RU','Berlin','San Francisco','PwjL6ONkTX','67051','MNDCeNS4@example.com'),(1113,'Michael','Smith','1997-02-27',42,'CA','Berlin','Dallas','zA1ZRCzHo8','00380','8ukd6N18@example.com'),(1114,'Olivia','Smith','1989-11-10',31,'CA','Capri','New York','9OU67dPvEL','96053','E76FLFi7@example.com'),(1115,'Olivia','Johnson','1994-08-02',50,'IN','Capri','Chicago','hpCieeqy6W','26538','VS7gsl07@example.com'),(1116,'Jane','Anderson','1997-10-14',34,'CA','California','Dallas','0oEWzdHwqB','50314','L9FweI32@example.com'),(1117,'David','Wilson','1988-01-18',38,'US','Capri','New York','EFYUUBTxqT','43881','OfqYO4CB@example.com'),(1118,'David','Johnson','1988-10-26',28,'GE','Capri','San Francisco','At61MeYEU2','36034','hJMdolis@example.com'),(1119,'John','Anderson','1973-05-27',59,'CA','Berlin','Los Angeles','Zw72VHnRAB','48472','pgdMhwwP@example.com'),(1120,'David','Johnson','1995-08-16',62,'CA','California','San Jose','Ht7xTjb3JR','34018','8qGZvNEa@example.com'),(1121,'John','Smith','1993-10-03',24,'RU','Florida','Dallas','iaOtneh9HP','53048','AZeJBaxC@example.com'),(1122,'Emily','Smith','1979-02-16',22,'UK','Florida','Dallas','Gz19CbelsA','89243','4pUt65Nz@example.com'),(1123,'Jane','Brown','1970-04-24',63,'US','Wales','Miami','XyMEocLlZw','21042','cctTRITb@example.com'),(1124,'Michael','Taylor','1998-11-25',27,'IT','Texas','Miami','lU22dziNII','86488','u3cNPMVi@example.com'),(1125,'Emily','Wilson','1986-06-23',37,'IN','Texas','Dallas','2uBnzlZLDL','51606','nonaaxRu@example.com'),(1126,'John','Taylor','1986-08-07',41,'GE','Wales','San Francisco','zRAbztFu52','36271','pUaoZvA2@example.com'),(1127,'Jane','Brown','1992-11-20',24,'RU','Berlin','Los Angeles','mt3hG2U2DT','15813','0SNnukzg@example.com'),(1128,'Jane','Taylor','1983-03-27',25,'PR','Capri','Miami','nMOp88gwgh','40859','jW90WspS@example.com'),(1129,'Olivia','Anderson','1985-01-11',21,'FR','Florida','San Francisco','TT26dKaiYa','13467','27GyA0dj@example.com'),(1130,'Michael','Smith','1991-07-22',38,'IT','California','Dallas','L9UffcYhcq','02756','3miAS0dP@example.com'),(1131,'John','Brown','1977-06-01',48,'CA','Capri','Los Angeles','OJcXY0hwvC','71474','Mc0YZxaZ@example.com'),(1132,'John','Brown','1990-06-16',65,'SW','Berlin','Dallas','fi6e3F9OrF','10918','kaKiCxNP@example.com'),(1133,'David','Smith','1972-12-16',25,'IT','Wales','San Francisco','H1MFvnqJd2','78080','W9Vpi7zI@example.com'),(1134,'John','Anderson','1993-09-02',40,'IT','Texas','Miami','8unzLwcoDb','95140','MJW5lenw@example.com'),(1135,'David','Wilson','1991-11-03',44,'US','New York','Dallas','T5FBzFOx65','88058','rxnvFmFW@example.com'),(1136,'David','Wilson','1996-07-24',28,'UK','Texas','Miami','3OibhfcZp6','99072','wjFEuccu@example.com'),(1137,'John','Brown','1975-07-30',28,'UK','California','Dallas','8iLncXSThd','43151','aZc39abN@example.com'),(1138,'Jane','Brown','1976-12-06',24,'RU','New York','Los Angeles','LrlVzEeFhn','47086','O7ctuUNU@example.com'),(1139,'David','Taylor','1985-11-05',25,'US','Berlin','San Francisco','WFY0w7dwy4','78244','jKMHOTBI@example.com'),(1140,'Olivia','Anderson','1987-08-15',45,'FR','Florida','San Francisco','1Kunj0dHjh','89613','xjBVxPBz@example.com'),(1141,'Olivia','Brown','1974-09-27',37,'US','California','Chicago','U5sUY6Y8H8','21388','rtlGTuMK@example.com'),(1142,'Jane','Anderson','1977-09-27',52,'PR','California','Dallas','eTXJaa3EX1','58077','TAOZ196J@example.com'),(1143,'Jane','Taylor','1975-04-14',24,'RU','New York','Chicago','uWhHgXdYXA','85757','oQgrsyJY@example.com'),(1144,'Jane','Johnson','1983-06-13',35,'PR','Capri','Los Angeles','Qz23oECdIs','08126','VMccknRt@example.com'),(1145,'Olivia','Wilson','1982-04-13',32,'IN','New York','San Jose','n8s5OKYICN','16940','ZXqyS6q7@example.com'),(1146,'Jane','Smith','1999-11-14',28,'PR','Berlin','San Francisco','8Lc7LgGow8','02782','mppOXlmw@example.com'),(1147,'Emily','Taylor','1986-08-05',60,'RU','Wales','Dallas','gMHUeax6H4','82191','jxMzMlv9@example.com'),(1148,'Michael','Taylor','1972-07-04',47,'CA','Wales','Los Angeles','vRQehJjCF6','73128','GGv4FAVN@example.com'),(1149,'John','Brown','1983-01-10',28,'CA','New York','New York','lsbcLdTvL5','06347','itJIJeQA@example.com'),(1150,'John','Brown','1976-05-23',55,'SW','California','Miami','5alWCpU1I7','63077','FyDRH0BL@example.com'),(1151,'Emily','Taylor','1976-06-06',43,'UK','Florida','Miami','ovXViwLfoA','23079','7FU32Dti@example.com'),(1152,'David','Johnson','1990-01-15',42,'UK','Florida','Miami','zseGokSnbl','34915','k0JXv8l0@example.com'),(1153,'Jane','Wilson','1996-06-29',51,'SW','California','Miami','KMRK5FMPgT','59325','ChjSMJj4@example.com'),(1154,'John','Smith','1998-07-17',55,'GE','Wales','Miami','LzmWcJPB6i','47759','MDUG4iQw@example.com'),(1155,'Emily','Taylor','1996-12-21',26,'FR','New York','San Jose','FEfiySz2Qr','68251','n86jWiWS@example.com'),(1156,'Emily','Brown','1994-01-28',65,'RU','Berlin','Miami','9JS3KcbafG','86294','kiixx8UC@example.com'),(1157,'Jane','Brown','1989-03-27',44,'PR','Berlin','San Jose','9hQXmQys0U','42079','HHK9783t@example.com'),(1158,'David','Johnson','1999-05-06',53,'IT','Florida','New York','b816aiRv8B','74920','WajZ3Uhg@example.com'),(1159,'Jane','Anderson','1996-02-05',49,'RU','Florida','Dallas','G2KemiWNC2','76282','0arRR2ba@example.com'),(1160,'John','Anderson','1984-11-13',31,'IT','Capri','Miami','dglyAeSxMq','36398','ndWk1Oh7@example.com'),(1161,'Olivia','Brown','1996-06-03',59,'UK','Berlin','Chicago','DeyElS44kn','93446','icPsHgjy@example.com'),(1162,'David','Taylor','1994-11-24',31,'US','Wales','New York','9mOy5xw3Vj','76568','nGvN9Vtn@example.com'),(1163,'John','Smith','1978-09-20',64,'GE','Wales','Los Angeles','k8fc584JN6','95482','HW8zIyGw@example.com'),(1164,'Emily','Smith','1979-08-27',23,'GE','California','Dallas','Vx5WKHhcaV','14287','279L6KFx@example.com'),(1165,'Michael','Smith','1991-12-29',55,'UK','Florida','Los Angeles','hxX8YuDH0b','04462','3XcRW0js@example.com'),(1166,'Michael','Wilson','1994-02-23',33,'GE','California','San Jose','pCJ1VYg0i2','34229','bMkno1FD@example.com'),(1167,'David','Brown','1974-09-12',45,'PR','California','San Francisco','wADys4vghr','39390','lCXvMFtr@example.com'),(1168,'Michael','Brown','1975-11-08',52,'PR','Capri','Miami','qB8EbN8Ywv','54418','og42Hamr@example.com'),(1169,'Emily','Smith','1991-05-30',34,'RU','Wales','New York','rgxV8Oy4ZA','04179','oOlcgokL@example.com'),(1170,'Michael','Wilson','1975-02-13',27,'SW','Capri','Miami','o1jrOpTuAY','69238','B5V1ivcY@example.com'),(1171,'John','Wilson','1977-09-27',36,'UK','New York','San Jose','zTdZwRKS6A','59727','qZWcFJ1A@example.com'),(1172,'Jane','Anderson','1991-09-02',35,'SW','Wales','Chicago','KIW2Ii1WHb','89374','28cLSd8j@example.com'),(1173,'David','Johnson','1981-02-20',26,'SW','Texas','Los Angeles','PtMFAxbtt2','39597','DjNp1Sis@example.com'),(1174,'Michael','Wilson','1993-03-16',39,'IT','California','Los Angeles','pIkrE8nfNO','98528','FOXFGWvU@example.com'),(1175,'Michael','Anderson','1997-03-10',28,'SW','Texas','Dallas','04IadQ44nE','97385','EJU1tssY@example.com'),(1176,'Olivia','Taylor','1973-01-11',26,'US','Berlin','Chicago','C1fVNgUSJn','69841','m8zLynXA@example.com'),(1177,'David','Johnson','1971-03-12',50,'PR','Texas','Los Angeles','EIPrEdFoAi','81666','4JKMafZ0@example.com'),(1178,'Olivia','Smith','1999-07-12',31,'US','Capri','Los Angeles','OqPpkFVsjZ','66675','ApcBDBpg@example.com'),(1179,'Jane','Johnson','1984-08-02',64,'SW','California','Chicago','vMZDQbhkmp','15061','l8pcR8lC@example.com'),(2171,'Shruti','Badri','1999-06-16',23,'US','California','Los Angeles','123 Main Street','12345','shruti@gmail.com'),(2172,'Divya','N','1999-06-16',23,'US','California','Los Angeles','123 Main Street','12345','shruti@gmail.com'),(2173,'Divya','Neelamegam','1999-06-16',23,'US','California','Los Angeles','123 Main Street','12345','shruti@gmail.com'),(2174,'Poojitha','Venkat','1999-04-07',24,'US','California','Los Angeles','123 Main Street','96145','poojitha.v@gmail.com');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer_Phone`
--

DROP TABLE IF EXISTS `Customer_Phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer_Phone` (
  `Phone` varchar(25) NOT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`Phone`,`CustomerID`),
  KEY `Customer_PhoneFK1` (`CustomerID`),
  CONSTRAINT `Customer_PhoneFK1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer_Phone`
--

LOCK TABLES `Customer_Phone` WRITE;
/*!40000 ALTER TABLE `Customer_Phone` DISABLE KEYS */;
INSERT INTO `Customer_Phone` VALUES ('(555) 123-4567',1001),('(456) 345 4421',1002),('(555) 555-1212',1003),('(555) 888-7777',1004),('(555) 444-3333',1005),('(555) 999-0000',1006),('(555) 777-8888',1007),('(555) 222-1111',1008),('(555) 333-2222',1009),('(555) 666-7777',1010),('1234567899',2171),('1234567899',2172),('1234567899',2173),('+1 200 234 3456',2174);
/*!40000 ALTER TABLE `Customer_Phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DiscountedWines`
--

DROP TABLE IF EXISTS `DiscountedWines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DiscountedWines` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `color` varchar(25) DEFAULT NULL,
  `vintage` varchar(25) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DiscountedWines`
--

LOCK TABLES `DiscountedWines` WRITE;
/*!40000 ALTER TABLE `DiscountedWines` DISABLE KEYS */;
INSERT INTO `DiscountedWines` VALUES (1,'Cabernet Sauvignon','Red','2016',50),(2,'Chardonnay','White','2019',25),(3,'Merlot','Red','2018',35),(4,'Sauvignon Blanc','White','2020',20);
/*!40000 ALTER TABLE `DiscountedWines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Discounts`
--

DROP TABLE IF EXISTS `Discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Discounts` (
  `DiscountCode` varchar(20) NOT NULL,
  `DiscountName` varchar(50) DEFAULT NULL,
  `DiscountPercentage` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`DiscountCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Discounts`
--

LOCK TABLES `Discounts` WRITE;
/*!40000 ALTER TABLE `Discounts` DISABLE KEYS */;
INSERT INTO `Discounts` VALUES ('BIRTHDAY10','Birthday 10% off',10.00),('DISCOUNT5','5% off',5.00),('FREESHIP','Free Shipping',15.00),('NEWCUSTOMER','New Customer 20%',20.00),('SPRING10','Spring Sale 10%',10.00),('SUMMER25','Summer Sale 25%',25.00);
/*!40000 ALTER TABLE `Discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feedback`
--

DROP TABLE IF EXISTS `Feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feedback` (
  `Winename` varchar(255) NOT NULL,
  `Rating` int NOT NULL,
  `Feedback` varchar(400) NOT NULL,
  `Username` varchar(25) DEFAULT NULL,
  `PurchaseExperience` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feedback`
--

LOCK TABLES `Feedback` WRITE;
/*!40000 ALTER TABLE `Feedback` DISABLE KEYS */;
INSERT INTO `Feedback` VALUES ('Apothic Inferno Red Blend',4,'Good','BlueSky22',4),('Barefoot Pinot Grigio',5,'Impressive selection of unique wines.','BlueSky22',5),('Caymus Cabernet Sauvignon',4,'Quick shipping and secure packaging.','BlueSky22',5),('Chateau d Esclans Whispering Angel Rose',4,'User-friendly website with easy order tracking.','BlueSky22',5),('Barefoot Moscato',5,'Excellent customer service.','BlueSky22',3),('Bogle Chardonnay',5,'Highly recommend for wine lovers.','BlueSky22',4),('Bogle Vineyards Petite Sirah',3,'The wine tasted okay, but it wasn\'t anything special.','BlueSky22',4),('Barefoot Moscato',5,'Great tasting wines and a user-friendly website.','4W6tUlX5',4),('Bogle Chardonnay',5,'Enjoyed the wines I purchased and the online shopping experience was seamless.','0CE5lsrL',4),('Apothic Red Blend',4,'Wines were delicious and the ordering process was easy.','0HI6PqSB',4),('Barefoot White Zinfandel',5,'Excellent selection of wines and a hassle-free shopping experience.','BmtkVKPu',4),('Apothic Inferno Red Blend',4,'Highly recommend the wines and the website for any wine enthusiast.','bmwOxViK',4),('Bogle Sauvignon Blanc',4,'Delicious wine and easy checkout process.','0CE5lsrL',5),('WineName',5,'Great wine selection and seamless website experience.','0HI6PqSB',5),('Barefoot Pinot Grigio',4,'Tasty wine and fast shipping.','0hn6ROIJ',5),('Caymus Cabernet Sauvignon',5,'Smooth website experience and enjoyable wine selection.','13X8c7DW',5),('Chateau d Esclans Whispering Angel Rose',4,'Satisfying wine taste and efficient customer service.','1ClOtvOo',5),('Barefoot Moscato',5,'Well-organized website and great-tasting wine selection.','1Hd15aY1',5),('Bogle Chardonnay',5,'The wine tasted delicious, and the checkout process on the website was easy and seamless.','1xY9g75u',5),('Barefoot Moscato',4,'The wine selection was great, and the experience of shopping on the website was smooth and hassle-free.','2kOiCBDD',5),('Bogle Chardonnay',5,'The wine tasted fantastic, and the shipping was fast and efficient.','3aoFxHX8',4),('Apothic Red Blend',4,'The website was well-organized, and the wine selection was enjoyable.','3OMuVkny',4),('Barefoot White Zinfandel',4,'The website was easy to navigate, and the wine selection was great-tasting and diverse.','4W6tUlX5',4),('Emmolo Sauvignon Blanc',4,'The wine was of high quality, and the ordering process on the website was user-friendly.','1Hd15aY1',4),('Apothic Inferno Red Blend',5,'The wine selection was diverse and impressive, and the checkout process was smooth.','1xY9g75u',4),('Barefoot White Zinfandel',4,'The wine tasted great, and the packaging for shipping was secure and reliable.','2kOiCBDD',3),('Emmolo Sauvignon Blanc',4,'The website was easy to navigate, and the selection of wines available was impressive.','3aoFxHX8',3),('Apothic Inferno Red Blend',4,'The wine was delicious, and the order tracking on the website was helpful and informative.','1ClOtvOo',5),('Barefoot Merlot',4,'The customer service was responsive and helpful, and the wine tasted great.','1Hd15aY1',5),('Bogle Sauvignon Blanc',4,'The website was well-organized and the wine selection was diverse, making it easy to find what I was looking for.','1xY9g75u',5),('Bogle Vineyards Petite Sirah',5,'The wine tasted wonderful, and the delivery was fast and on-time.','2kOiCBDD',4),('WineName',4,'The checkout process was easy to follow, and the wine selection was varied and interesting.','3aoFxHX8',4),('Barefoot Pinot Grigio',5,'The wine was of high quality, and the website made it easy to place my order and track its progress.','3OMuVkny',4),('Caymus Cabernet Sauvignon',5,'I appreciated the user-friendly checkout process and the high-quality wine selection available on this website.','B0tYR6jE',4),('Chateau d Esclans Whispering Angel Rose',5,'I found the website easy to navigate, and the selection of wines available was enjoyable.','BaO7QpOi',5),('Barefoot Moscato',5,'The wine tasted fantastic, and the shipping process was fast and reliable.','Befj3pPU',5),('Bogle Chardonnay',5,'The wine I ordered tasted great, and the checkout process was smooth and hassle-free.','bkIm01nI',5),('Apothic Red Blend',5,'I had a great experience with this website! The wine tasted delicious and the checkout process was easy to follow.','bKKhuxQU',5),('Barefoot White Zinfandel',5,'The wine I ordered tasted great, and I appreciate the fast and reliable shipping.','BlueSky22',5),('Emmolo Sauvignon Blanc',5,'The wine tasted wonderful, and the website made it easy to place my order and track its progress','BmtkVKPu',5),('Apothic Inferno Red Blend',4,'Smooth checkout process and easy navigation.','bmwOxViK',5),('Bogle Sauvignon Blanc',4,'Quick shipping and secure packaging.','CRajGFyR',5),('Bogle Vineyards Petite Sirah',4,'User-friendly website with easy order tracking.','CSYb3hhe',5),('Barefoot Pinot Grigio',3,'The wine was decent, but not exceptional. The website was easy to use, but the shipping was a bit slower than expected.','CuRAFQxX',4),('Caymus Cabernet Sauvignon',3,'The wine was satisfactory, but not outstanding. The website was functional, but the checkout process could have been more intuitive.','D54SlsSw',4),('Chateau d Esclans Whispering Angel Rose',3,'The wine was good, but not great. The selection on the website was limited, and I was unable to find exactly what I was looking for.','d9oBmivu',3),('Barefoot Moscato',3,'The website was easy to navigate, but the wine I ordered was not as flavorful as I had hoped.','E2aqHJWZ',5),('Bogle Chardonnay',3,'The website was user-friendly, but the wine I ordered was a bit disappointing.','Eqtkv9wn',3),('Apothic Red Blend',3,'The wine tasted okay, but it was not exceptional. The website had a decent selection, but the prices were a bit higher than I expected.','eUeybL9v',4),('Barefoot White Zinfandel',5,'The website was functional, but the checkout process was a bit slow.','EvxMsRe8',4),('Emmolo Sauvignon Blanc',5,'The shipping was prompt, but the packaging was not very secure. The wine tasted okay, but it was not outstanding.','EyPfsaHW',4),('Apothic Inferno Red Blend',5,'The wine I ordered was decent, but not exceptional. The checkout process was straightforward, but the shipping was a bit slower than expected.','F9mDe0Ko',4),('Barefoot Merlot',5,'The website was easy to use, but the wine I ordered did not meet my expectations.','FkA15rdS',3),('Bogle Sauvignon Blanc',5,'The wine I ordered was decent, but it did not blow me away','FlyingEagle99',4),('Bogle Vineyards Petite Sirah',5,'The prices were reasonable, but I have had better experiences with other wine retailers.','G0b5iPwE',3),('Caymus Cabernet Sauvignon',5,'The website had a decent selection, but it was not as diverse as I had hoped.','hDR90cq9',4),('Chateau d Esclans Whispering Angel Rose',5,'The checkout process was straightforward, but the shipping was a bit slower than I expected.','Eqtkv9wn',4),('Barefoot Moscato',5,'The wine was okay, but it did not meet my expectations','eUeybL9v',4),('Bogle Chardonnay',5,'wine I ordered was not as flavorful as I had hoped','EvxMsRe8',4),('Apothic Red Blend',5,'The wine tasted okay, but it wasn\'t anything special.','EyPfsaHW',4),('Barefoot Pinot Grigio',5,'The shipping was prompt, but the packaging was not very secure.','HappyCamper16',4),('Caymus Cabernet Sauvignon',5,'The wine tasted satisfactory, but it was not as good as I had anticipated.','HaSCGw8o',4),('Chateau d Esclans Whispering Angel Rose',5,'The checkout process was straightforward, but the website had limited selection.','hDftYtTX',4),('Emmolo Sauvignon Blanc',3,'The website was easy to navigate, but the wine I ordered was not my favorite','hDR90cq9',4),('Apothic Inferno Red Blend',3,'he wine was okay, but it was not particularly memorable.','hHFczQop',3),('Barefoot Merlot',3,'The website had an acceptable selection, but the prices were a bit higher than I expected.','HjjgGiGP',3),('Bogle Sauvignon Blanc',3,'The wine tasted fine, but it was not amazing.','hn2E5NDd',3),('Bogle Vineyards Petite Sirah',3,'had some issues with the delivery','I8lPcJ92',5),('Barefoot Pinot Grigio',2,'Terrible wine with poor packaging and slow shipping, combined with an unresponsive and unhelpful customer service experience.','IKJRS4A7',3),('Caymus Cabernet Sauvignon',1,'The website was confusing and difficult to navigate','IybK6nbM',2),('Chateau d Esclans Whispering Angel Rose',2,'wine was undrinkable, and the delivery was delayed and damaged.','j05smHgy',3),('Barefoot Moscato',1,'The wine tasted awful','Jf9KJqYm',3),('Bogle Chardonnay',2,'checkout process was frustrating and buggy, leading to a negative overall experience.','kMFxi0uF',1),('Apothic Red Blend',1,'The shipping was delayed and unprofessional','KnEwQBFx',1),('Barefoot White Zinfandel',2,'the wine tasted terrible, and the website was poorly designed with limited selection.','kOsuSLkR',2),('Emmolo Sauvignon Blanc',1,'The wine was undrinkable','KoWRWieH',3),('Apothic Inferno Red Blend',2,'website was confusing with unhelpful customer service, making for an overall terrible experience.','kpsofcFU',1),('Barefoot Merlot',1,'The wine tasted like vinegar','KwhOP8uZ',3),('Bogle Sauvignon Blanc',2,'website had limited selection','kMFxi0uF',3),('Bogle Vineyards Petite Sirah',2,'High Prices','KnEwQBFx',3),('Apothic Red Blend',5,'Satisfying wine taste and efficient customer service.','0BFAolNc',5),('Barefoot White Zinfandel',4,'Well-organized website and great-tasting wine selection.','0CE5lsrL',5),('Emmolo Sauvignon Blanc',4,'The wine tasted delicious, and the checkout process on the website was easy and seamless.','0HI6PqSB',5),('Apothic Inferno Red Blend',4,'The wine selection was great, and the experience of shopping on the website was smooth and hassle-free.','0hn6ROIJ',5),('Barefoot Merlot',5,'The wine tasted fantastic, and the shipping was fast and efficient.','13X8c7DW',5),('Bogle Sauvignon Blanc',5,'The website was easy to navigate, and the selection of wines available was impressive.','KoWRWieH',4),('Bogle Vineyards Petite Sirah',5,'The wine was delicious, and the order tracking on the website was helpful and informative.','kpsofcFU',4),('Caymus Cabernet Sauvignon',4,'The customer service was responsive and helpful, and the wine tasted great.','KwhOP8uZ',4),('Chateau d Esclans Whispering Angel Rose',5,'The website was well-organized and the wine selection was diverse, making it easy to find what I was looking for.','kYRKareg',4),('Barefoot Moscato',4,'Good','kzvhJTN2',4),('Bogle Chardonnay',4,'Impressive selection of unique wines.','L24dAWgL',3),('Apothic Red Blend',4,'Quick shipping and secure packaging.','lqtcGY3i',3),('Barefoot Pinot Grigio',5,'User-friendly website with easy order tracking.','lW3EuPCk',5),('Caymus Cabernet Sauvignon',4,'Excellent customer service.','lW6dQPEG',5),('Chateau d Esclans Whispering Angel Rose',5,'Highly recommend for wine lovers.','LXxTcGde',5),('Emmolo Sauvignon Blanc',4,'The wine tasted okay, but it wasn\'t anything special.','M39DwJZh',3),('Apothic Inferno Red Blend',5,'Great tasting wines and a user-friendly website.','Jf9KJqYm',4),('Barefoot Merlot',5,'Enjoyed the wines I purchased and the online shopping experience was seamless.','JgWx4uQR',4),('Bogle Sauvignon Blanc',4,'Wines were delicious and the ordering process was easy.','jkdxfwYN',4),('Bogle Vineyards Petite Sirah',5,'Tasty wine and fast shipping.','jPU57kmO',4),('Barefoot Pinot Grigio',4,'Smooth website experience and enjoyable wine selection.','KFctIKqd',4),('Caymus Cabernet Sauvignon',4,'Satisfying wine taste and efficient customer service.','kMFxi0uF',4),('Chateau d Esclans Whispering Angel Rose',4,'Well-organized website and great-tasting wine selection.','KnEwQBFx',4),('Barefoot Moscato',5,'The wine tasted delicious, and the checkout process on the website was easy and seamless.','kOsuSLkR',4),('Bogle Chardonnay',4,'The wine selection was great, and the experience of shopping on the website was smooth and hassle-free.','KoWRWieH',3),('Apothic Red Blend',4,'The wine tasted fantastic, and the shipping was fast and efficient.','kpsofcFU',3),('Barefoot White Zinfandel',4,'The website was well-organized, and the wine selection was enjoyable.','KwhOP8uZ',5),('Emmolo Sauvignon Blanc',4,'The website was easy to navigate, and the wine selection was great-tasting and diverse.','kYRKareg',5),('Apothic Inferno Red Blend',4,'The wine was of high quality, and the ordering process on the website was user-friendly.','kzvhJTN2',5),('Barefoot Merlot',5,'The wine selection was diverse and impressive, and the checkout process was smooth.','L24dAWgL',3),('Bogle Sauvignon Blanc',4,'The wine tasted great, and the packaging for shipping was secure and reliable.','n9q0Ubh5',4),('Barefoot Moscato',5,'I appreciated the user-friendly checkout process and the high-quality wine selection available on this website.','Nchb37bM',4),('Bogle Chardonnay',5,'I found the website easy to navigate, and the selection of wines available was enjoyable.','nFCnDgwF',5),('Apothic Red Blend',5,'The wine tasted fantastic, and the shipping process was fast and reliable.','NiL1L7cS',3),('Barefoot White Zinfandel',5,'The wine I ordered tasted great, and the checkout process was smooth and hassle-free.','nMIplxJW',4),('Emmolo Sauvignon Blanc',5,'Highly recommend the wines and the website for any wine enthusiast.','nQUdMaoY',4),('Apothic Inferno Red Blend',5,'Impressed with the quality of the wines and the convenience of shopping online.','Nu1E8T5y',4),('Barefoot White Zinfandel',5,'Delicious wine and easy checkout process.','nXQFefg2',4),('Emmolo Sauvignon Blanc',4,'Great wine selection and seamless website experience.','OceanBreeze64',4),('Apothic Inferno Red Blend',5,'Tasty wine and fast shipping.','OgfvhZvB',4),('Barefoot Merlot',5,'Smooth website experience and enjoyable wine selection.','OGuquooZ',4),('Bogle Sauvignon Blanc',4,'Satisfying wine taste and efficient customer service.','OjVXxzQR',5),('Bogle Vineyards Petite Sirah',5,'Well-organized website and great-tasting wine selection.','omsqwW2I',5),('WineName',4,'The wine tasted delicious, and the checkout process on the website was easy and seamless.','oQTI0tNQ',5),('Barefoot Pinot Grigio',4,'The wine selection was great, and the experience of shopping on the website was smooth and hassle-free.','OSGqSLYN',5),('Caymus Cabernet Sauvignon',4,'The wine tasted fantastic, and the shipping was fast and efficient.','Ow3tRNAJ',5),('Chateau d Esclans Whispering Angel Rose',5,'The wine tasted wonderful, and the website made it easy to place my order and track its progress','oZUAJ3mS',5),('Barefoot Moscato',4,'Smooth checkout process and easy navigation.','pa8YCp1x',5),('Bogle Chardonnay',4,'Impressive selection of unique wines.','pLFPjiY0',5),('Apothic Red Blend',4,'Quick shipping and secure packaging.','pRpFqEMM',3),('Barefoot White Zinfandel',4,'User-friendly website with easy order tracking.','pV5hAytH',1),('Emmolo Sauvignon Blanc',4,'The wine was decent, but not exceptional. The website was easy to use, but the shipping was a bit slower than expected.','pxcaQBtz',1),('Apothic Inferno Red Blend',5,'The wine was satisfactory, but not outstanding. The website was functional, but the checkout process could have been more intuitive.','PzqAmPXg',2),('Barefoot Merlot',3,'The wine was good, but not great. The selection on the website was limited, and I was unable to find exactly what I was looking for.','sd4YLHoM',3),('Bogle Sauvignon Blanc',3,'The website was easy to navigate, but the wine I ordered was not as flavorful as I had hoped.','sRqTCL9W',1),('Bogle Vineyards Petite Sirah',3,'The website was user-friendly, but the wine I ordered was a bit disappointing.','Starlight33',3),('Barefoot Pinot Grigio',3,'The wine tasted okay, but it was not exceptional. The website had a decent selection, but the prices were a bit higher than I expected.','SunnyDays42',3),('Caymus Cabernet Sauvignon',3,'The website was functional, but the checkout process was a bit slow.','suuABTov',3),('Barefoot White Zinfandel',5,'The shipping was prompt, but the packaging was not very secure. The wine tasted okay, but it was not outstanding.','t79oe9Zy',5),('Emmolo Sauvignon Blanc',5,'The wine I ordered was decent, but not exceptional. The checkout process was straightforward, but the shipping was a bit slower than expected.','TechGuru89',5),('Apothic Inferno Red Blend',5,'The shipping was prompt, but the packaging was not very secure. The wine tasted okay, but it was not outstanding.','tgRCFaaL',3),('Barefoot Merlot',5,'The wine I ordered was decent, but not exceptional. The checkout process was straightforward, but the shipping was a bit slower than expected.','tI8dCwbJ',2),('Bogle Sauvignon Blanc',5,'The website was easy to use, but the wine I ordered did not meet my expectations.','tjQYcjDM',3),('Bogle Vineyards Petite Sirah',5,'The wine I ordered was decent, but it did not blow me away','tkask6Cn',5),('WineName',5,'the wine tasted terrible, and the website was poorly designed with limited selection.','tPumiO28',3),('Barefoot Pinot Grigio',5,'The website had a decent selection, but it was not as diverse as I had hoped.','tq8I0VqQ',2),('Caymus Cabernet Sauvignon',4,'Great wine selection and seamless website experience.','tq8I0VqQ',4),('Barefoot Merlot',5,'Excellent!!','0BFAolNc',5),('Apothic Red Blend',3,'The stock seemed slightly new.  Wanted an older wine.','CoolCat21',4);
/*!40000 ALTER TABLE `Feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GrapeVariety`
--

DROP TABLE IF EXISTS `GrapeVariety`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GrapeVariety` (
  `VarietyID` varchar(25) NOT NULL,
  `Variety` varchar(25) NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`VarietyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GrapeVariety`
--

LOCK TABLES `GrapeVariety` WRITE;
/*!40000 ALTER TABLE `GrapeVariety` DISABLE KEYS */;
INSERT INTO `GrapeVariety` VALUES ('V01','Chardonnay',NULL),('V02','Pinot Noir',NULL),('V03','Sauvignon Blanc',NULL),('V04','Cabernet Sauvignon',NULL),('V05','Merlot',NULL),('V06','Zinfandel',NULL),('V07','Riesling',NULL),('V08','Syrah',NULL),('V09','Pinot Grigio',NULL),('V10','Malbec',NULL),('V11','Mixed Grape Blend',NULL);
/*!40000 ALTER TABLE `GrapeVariety` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inventory`
--

DROP TABLE IF EXISTS `Inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inventory` (
  `InventoryID` int NOT NULL AUTO_INCREMENT,
  `WineID` varchar(25) NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`InventoryID`),
  KEY `fk_wine_inventory` (`WineID`),
  CONSTRAINT `fk_wine_inventory` FOREIGN KEY (`WineID`) REFERENCES `Wine` (`WineID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inventory`
--

LOCK TABLES `Inventory` WRITE;
/*!40000 ALTER TABLE `Inventory` DISABLE KEYS */;
INSERT INTO `Inventory` VALUES (1,'WINE001',50),(2,'WINE002',66),(3,'WINE003',83),(4,'WINE004',22),(5,'WINE005',37),(6,'WINE006',15),(7,'WINE007',47),(8,'WINE008',90),(9,'WINE009',28),(10,'WINE010',41),(11,'WINE011',10),(12,'WINE012',5);
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Items`
--

DROP TABLE IF EXISTS `Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Items` (
  `ItemID` varchar(25) DEFAULT NULL,
  `quantity` int NOT NULL,
  `OrderID` varchar(25) NOT NULL,
  KEY `OrdersFKI` (`OrderID`),
  CONSTRAINT `OrdersFKI` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Items`
--

LOCK TABLES `Items` WRITE;
/*!40000 ALTER TABLE `Items` DISABLE KEYS */;
INSERT INTO `Items` VALUES ('WINE012',2,'ORD001'),('WINE004',1,'ORD001'),('WINE005',5,'ORD001'),('WINE009',3,'ORD001'),('WINE003',5,'ORD002'),('WINE008',1,'ORD002'),('WINE009',4,'ORD002'),('WINE001',4,'ORD002'),('WINE004',4,'ORD002'),('WINE002',5,'ORD002'),('WINE007',5,'ORD003'),('WINE003',2,'ORD004'),('WINE008',1,'ORD004'),('WINE006',1,'ORD004'),('WINE008',3,'ORD005'),('WINE004',3,'ORD006'),('WINE012',2,'ORD007'),('WINE004',2,'ORD008'),('WINE006',4,'ORD008'),('WINE010',3,'ORD10'),('WINE002',1,'ORD100'),('WINE011',2,'ORD100'),('WINE004',5,'ORD101'),('WINE008',1,'ORD102'),('WINE003',4,'ORD103'),('WINE001',4,'ORD104'),('WINE005',5,'ORD105'),('WINE005',3,'ORD106'),('WINE012',5,'ORD106'),('WINE011',4,'ORD107'),('WINE002',4,'ORD107'),('WINE005',4,'ORD108'),('WINE012',3,'ORD108'),('WINE005',1,'ORD109'),('WINE011',5,'ORD109'),('WINE009',1,'ORD11'),('WINE011',5,'ORD110'),('WINE010',2,'ORD111'),('WINE004',4,'ORD111'),('WINE006',4,'ORD112'),('WINE004',5,'ORD112'),('WINE006',4,'ORD113'),('WINE002',1,'ORD113'),('WINE002',2,'ORD114'),('WINE006',5,'ORD114'),('WINE002',1,'ORD115'),('WINE010',3,'ORD115'),('WINE004',4,'ORD116'),('WINE001',3,'ORD116'),('WINE011',1,'ORD116'),('WINE003',2,'ORD117'),('WINE009',1,'ORD117'),('WINE007',4,'ORD117'),('WINE005',5,'ORD118'),('WINE001',1,'ORD118'),('WINE002',1,'ORD118'),('WINE007',1,'ORD119'),('WINE011',1,'ORD119'),('WINE008',4,'ORD119'),('WINE002',5,'ORD12'),('WINE006',2,'ORD12'),('WINE001',4,'ORD12'),('WINE001',1,'ORD12'),('WINE006',3,'ORD120'),('WINE012',4,'ORD120'),('WINE001',5,'ORD120'),('WINE012',5,'ORD120'),('WINE004',3,'ORD121'),('WINE005',2,'ORD121'),('WINE003',4,'ORD121'),('WINE011',3,'ORD121'),('WINE003',5,'ORD122'),('WINE008',3,'ORD122'),('WINE007',3,'ORD122'),('WINE002',4,'ORD122'),('WINE008',2,'ORD123'),('WINE010',3,'ORD123'),('WINE011',3,'ORD123'),('WINE007',3,'ORD123'),('WINE004',3,'ORD124'),('WINE007',5,'ORD124'),('WINE008',4,'ORD124'),('WINE002',1,'ORD124'),('WINE002',3,'ORD125'),('WINE012',5,'ORD125'),('WINE005',5,'ORD125'),('WINE002',3,'ORD125'),('WINE009',3,'ORD125'),('WINE006',2,'ORD126'),('WINE004',3,'ORD126'),('WINE008',5,'ORD126'),('WINE012',2,'ORD126'),('WINE011',2,'ORD126'),('WINE005',3,'ORD126'),('WINE002',1,'ORD126'),('WINE008',5,'ORD127'),('WINE006',3,'ORD127'),('WINE006',3,'ORD127'),('WINE009',5,'ORD127'),('WINE008',2,'ORD128'),('WINE008',4,'ORD128'),('WINE006',4,'ORD128'),('WINE007',4,'ORD128'),('WINE011',5,'ORD129'),('WINE011',1,'ORD129'),('WINE006',4,'ORD129'),('WINE005',2,'ORD129'),('WINE005',4,'ORD13'),('WINE001',2,'ORD13'),('WINE001',1,'ORD13'),('WINE011',3,'ORD13'),('WINE004',2,'ORD130'),('WINE006',1,'ORD130'),('WINE006',5,'ORD130'),('WINE006',1,'ORD130'),('WINE003',1,'ORD131'),('WINE008',5,'ORD131'),('WINE009',2,'ORD131'),('WINE011',3,'ORD131'),('WINE012',5,'ORD132'),('WINE003',5,'ORD132'),('WINE004',4,'ORD133'),('WINE009',2,'ORD133'),('WINE012',5,'ORD134'),('WINE006',2,'ORD134'),('WINE006',1,'ORD135'),('WINE007',1,'ORD135'),('WINE011',3,'ORD136'),('WINE001',5,'ORD136'),('WINE004',2,'ORD137'),('WINE007',3,'ORD137'),('WINE006',3,'ORD138'),('WINE012',4,'ORD138'),('WINE002',5,'ORD139'),('WINE006',5,'ORD139'),('WINE002',1,'ORD14'),('WINE006',1,'ORD14'),('WINE003',5,'ORD140'),('WINE001',1,'ORD140'),('WINE006',5,'ORD140'),('WINE008',3,'ORD140'),('WINE005',4,'ORD141'),('WINE007',2,'ORD141'),('WINE004',2,'ORD141'),('WINE003',1,'ORD142'),('WINE006',5,'ORD143'),('WINE007',1,'ORD144'),('WINE008',3,'ORD144'),('WINE004',1,'ORD144'),('WINE002',5,'ORD145'),('WINE007',1,'ORD145'),('WINE007',5,'ORD145'),('WINE009',1,'ORD145'),('WINE002',3,'ORD146'),('WINE001',2,'ORD147'),('WINE012',4,'ORD147'),('WINE006',3,'ORD148'),('WINE006',5,'ORD149'),('WINE007',1,'ORD149'),('WINE002',3,'ORD15'),('WINE011',2,'ORD150'),('WINE006',4,'ORD150'),('WINE005',1,'ORD151'),('WINE009',3,'ORD151'),('WINE002',5,'ORD152'),('WINE006',2,'ORD152'),('WINE009',2,'ORD153'),('WINE003',3,'ORD153'),('WINE009',3,'ORD154'),('WINE010',3,'ORD154'),('WINE011',3,'ORD155'),('WINE005',4,'ORD156'),('WINE002',2,'ORD156'),('WINE006',3,'ORD156'),('WINE011',4,'ORD157'),('WINE012',2,'ORD158'),('WINE008',1,'ORD159'),('WINE010',2,'ORD16'),('WINE006',4,'ORD160'),('WINE002',1,'ORD161'),('WINE004',2,'ORD162'),('WINE012',1,'ORD163'),('WINE011',5,'ORD164'),('WINE001',2,'ORD165'),('WINE005',1,'ORD166'),('WINE007',2,'ORD167'),('WINE004',3,'ORD168'),('WINE008',2,'ORD169'),('WINE007',3,'ORD17'),('WINE007',1,'ORD170'),('WINE007',1,'ORD171'),('WINE012',5,'ORD172'),('WINE006',4,'ORD173'),('WINE008',3,'ORD174'),('WINE003',3,'ORD175'),('WINE010',4,'ORD176'),('WINE006',4,'ORD177'),('WINE009',3,'ORD178'),('WINE009',3,'ORD179'),('WINE001',2,'ORD18'),('WINE001',1,'ORD19'),('WINE004',4,'ORD20'),('WINE011',3,'ORD200'),('WINE011',5,'ORD201'),('WINE009',1,'ORD202'),('WINE003',1,'ORD203'),('WINE010',3,'ORD204'),('WINE005',5,'ORD205'),('WINE002',1,'ORD206'),('WINE007',4,'ORD207'),('WINE005',5,'ORD208'),('WINE010',4,'ORD209'),('WINE004',2,'ORD21'),('WINE009',2,'ORD210'),('WINE009',2,'ORD211'),('WINE004',2,'ORD212'),('WINE006',3,'ORD213'),('WINE006',3,'ORD214'),('WINE008',1,'ORD215'),('WINE008',4,'ORD216'),('WINE006',4,'ORD217'),('WINE004',1,'ORD218'),('WINE002',2,'ORD219'),('WINE012',4,'ORD22'),('WINE009',3,'ORD220'),('WINE008',5,'ORD221'),('WINE009',3,'ORD222'),('WINE009',2,'ORD223'),('WINE003',3,'ORD224'),('WINE012',1,'ORD225'),('WINE005',2,'ORD226'),('WINE003',1,'ORD227'),('WINE012',2,'ORD228'),('WINE001',2,'ORD229'),('WINE010',5,'ORD23'),('WINE005',4,'ORD230'),('WINE007',1,'ORD231'),('WINE004',1,'ORD232'),('WINE007',5,'ORD233'),('WINE005',5,'ORD234'),('WINE010',4,'ORD235'),('WINE007',4,'ORD236'),('WINE010',3,'ORD237'),('WINE012',4,'ORD238'),('WINE012',4,'ORD239'),('WINE008',3,'ORD24'),('WINE008',3,'ORD240'),('WINE010',3,'ORD241'),('WINE006',1,'ORD242'),('WINE006',5,'ORD243'),('WINE005',5,'ORD244'),('WINE008',1,'ORD245'),('WINE003',5,'ORD246'),('WINE005',3,'ORD247'),('WINE002',2,'ORD248'),('WINE001',3,'ORD249'),('WINE002',2,'ORD25'),('WINE006',5,'ORD250'),('WINE002',4,'ORD251'),('WINE009',2,'ORD252'),('WINE007',1,'ORD253'),('WINE003',3,'ORD254'),('WINE003',4,'ORD255'),('WINE010',2,'ORD256'),('WINE011',2,'ORD257'),('WINE012',2,'ORD258'),('WINE009',3,'ORD259'),('WINE010',4,'ORD26'),('WINE009',1,'ORD260'),('WINE001',4,'ORD261'),('WINE007',2,'ORD262'),('WINE006',4,'ORD263'),('WINE004',5,'ORD264'),('WINE006',3,'ORD265'),('WINE012',5,'ORD266'),('WINE002',5,'ORD267'),('WINE005',3,'ORD268'),('WINE005',3,'ORD269'),('WINE004',4,'ORD27'),('WINE012',3,'ORD270'),('WINE012',3,'ORD271'),('WINE009',3,'ORD272'),('WINE008',5,'ORD273'),('WINE009',5,'ORD274'),('WINE008',5,'ORD275'),('WINE009',3,'ORD276'),('WINE008',4,'ORD277'),('WINE005',3,'ORD278'),('WINE012',5,'ORD279'),('WINE010',2,'ORD28'),('WINE007',5,'ORD280'),('WINE010',2,'ORD281'),('WINE007',1,'ORD282'),('WINE001',1,'ORD283'),('WINE002',2,'ORD284'),('WINE002',2,'ORD285'),('WINE002',1,'ORD286'),('WINE008',5,'ORD287'),('WINE007',2,'ORD288'),('WINE010',3,'ORD289'),('WINE002',3,'ORD29'),('WINE002',1,'ORD290'),('WINE002',1,'ORD291'),('WINE010',4,'ORD292'),('WINE007',5,'ORD293'),('WINE007',3,'ORD294'),('WINE001',2,'ORD295'),('WINE002',3,'ORD296'),('WINE011',5,'ORD297'),('WINE007',5,'ORD298'),('WINE004',3,'ORD299'),('WINE010',4,'ORD30'),('WINE009',2,'ORD300'),('WINE008',1,'ORD301'),('WINE008',5,'ORD302'),('WINE003',1,'ORD303'),('WINE010',5,'ORD304'),('WINE001',5,'ORD305'),('WINE010',2,'ORD306'),('WINE007',1,'ORD307'),('WINE002',1,'ORD308'),('WINE010',1,'ORD309'),('WINE001',5,'ORD31'),('WINE006',3,'ORD310'),('WINE011',1,'ORD311'),('WINE003',5,'ORD312'),('WINE004',3,'ORD313'),('WINE006',1,'ORD314'),('WINE004',2,'ORD315'),('WINE007',2,'ORD316'),('WINE002',4,'ORD317'),('WINE002',3,'ORD318'),('WINE011',2,'ORD319'),('WINE006',2,'ORD32'),('WINE002',2,'ORD320'),('WINE003',5,'ORD321'),('WINE011',5,'ORD322'),('WINE006',3,'ORD323'),('WINE012',1,'ORD324'),('WINE007',2,'ORD325'),('WINE010',4,'ORD326'),('WINE001',5,'ORD327'),('WINE003',2,'ORD328'),('WINE012',3,'ORD329'),('WINE003',1,'ORD33'),('WINE001',2,'ORD330'),('WINE002',3,'ORD331'),('WINE012',2,'ORD332'),('WINE007',1,'ORD333'),('WINE001',1,'ORD334'),('WINE008',4,'ORD335'),('WINE011',5,'ORD336'),('WINE002',4,'ORD337'),('WINE003',5,'ORD338'),('WINE003',2,'ORD339'),('WINE011',5,'ORD34'),('WINE010',5,'ORD340'),('WINE011',5,'ORD341'),('WINE006',5,'ORD342'),('WINE004',1,'ORD343'),('WINE002',5,'ORD344'),('WINE004',5,'ORD345'),('WINE002',2,'ORD346'),('WINE007',4,'ORD347'),('WINE007',4,'ORD348'),('WINE008',1,'ORD349'),('WINE010',2,'ORD35'),('WINE003',3,'ORD350'),('WINE011',1,'ORD351'),('WINE007',5,'ORD352'),('WINE008',2,'ORD353'),('WINE002',2,'ORD353'),('WINE012',5,'ORD353'),('WINE012',1,'ORD354'),('WINE007',2,'ORD354'),('WINE004',4,'ORD354'),('WINE004',5,'ORD355'),('WINE004',4,'ORD355'),('WINE007',4,'ORD355'),('WINE005',3,'ORD356'),('WINE009',5,'ORD356'),('WINE012',1,'ORD356'),('WINE004',5,'ORD357'),('WINE008',3,'ORD357'),('WINE009',4,'ORD357'),('WINE010',5,'ORD358'),('WINE005',3,'ORD358'),('WINE006',5,'ORD358'),('WINE002',1,'ORD359'),('WINE007',3,'ORD359'),('WINE006',3,'ORD359'),('WINE006',4,'ORD36'),('WINE006',3,'ORD36'),('WINE002',2,'ORD37'),('WINE004',1,'ORD37'),('WINE012',4,'ORD38'),('WINE003',3,'ORD38'),('WINE010',5,'ORD39'),('WINE003',4,'ORD39'),('WINE012',4,'ORD40'),('WINE005',4,'ORD40'),('WINE012',2,'ORD41'),('WINE005',3,'ORD41'),('WINE012',3,'ORD42'),('WINE006',5,'ORD42'),('WINE003',1,'ORD43'),('WINE005',3,'ORD44'),('WINE001',4,'ORD45'),('WINE009',4,'ORD46'),('WINE001',5,'ORD47'),('WINE007',5,'ORD48'),('WINE005',5,'ORD49'),('WINE003',4,'ORD50'),('WINE001',2,'ORD51'),('WINE005',5,'ORD52'),('WINE010',2,'ORD53'),('WINE010',3,'ORD54'),('WINE002',2,'ORD55'),('WINE004',3,'ORD56'),('WINE001',2,'ORD57'),('WINE005',1,'ORD58'),('WINE004',3,'ORD59'),('WINE008',5,'ORD60'),('WINE002',5,'ORD61'),('WINE006',3,'ORD62'),('WINE012',4,'ORD63'),('WINE005',1,'ORD64'),('WINE008',4,'ORD65'),('WINE002',4,'ORD66'),('WINE006',5,'ORD66'),('WINE002',1,'ORD67'),('WINE012',4,'ORD67'),('WINE009',3,'ORD68'),('WINE007',3,'ORD68'),('WINE004',3,'ORD69'),('WINE003',5,'ORD69'),('WINE008',2,'ORD70'),('WINE002',1,'ORD70'),('WINE012',5,'ORD700'),('WINE012',5,'ORD700'),('WINE001',5,'ORD71'),('WINE007',4,'ORD71'),('WINE005',1,'ORD71'),('WINE004',2,'ORD72'),('WINE006',1,'ORD72'),('WINE001',5,'ORD72'),('WINE008',1,'ORD73'),('WINE003',3,'ORD73'),('WINE008',3,'ORD73'),('WINE006',5,'ORD74'),('WINE004',3,'ORD74'),('WINE006',4,'ORD74'),('WINE003',1,'ORD75'),('WINE005',2,'ORD75'),('WINE002',3,'ORD75'),('WINE005',5,'ORD75'),('WINE001',5,'ORD76'),('WINE006',1,'ORD76'),('WINE010',5,'ORD76'),('WINE005',3,'ORD77'),('WINE002',5,'ORD77'),('WINE007',3,'ORD78'),('WINE003',3,'ORD78'),('WINE005',5,'ORD78'),('WINE009',1,'ORD79'),('WINE012',1,'ORD80'),('WINE012',4,'ORD81'),('WINE008',5,'ORD82'),('WINE008',4,'ORD83'),('WINE007',4,'ORD84'),('WINE004',3,'ORD85'),('WINE009',2,'ORD85'),('WINE009',1,'ORD86'),('WINE011',3,'ORD86'),('WINE003',2,'ORD87'),('WINE001',1,'ORD87'),('WINE011',5,'ORD88'),('WINE002',5,'ORD88'),('WINE001',5,'ORD89'),('WINE007',4,'ORD89'),('WINE006',1,'ORD90'),('WINE004',4,'ORD90'),('WINE011',4,'ORD91'),('WINE007',5,'ORD91'),('WINE003',3,'ORD92'),('WINE005',4,'ORD92'),('WINE006',3,'ORD93'),('WINE010',2,'ORD93'),('WINE011',1,'ORD94'),('WINE007',4,'ORD94'),('WINE001',3,'ORD95'),('WINE008',2,'ORD95'),('WINE012',2,'ORD96'),('WINE005',3,'ORD96'),('WINE003',3,'ORD97'),('WINE008',4,'ORD97'),('WINE012',5,'ORD98'),('WINE012',4,'ORD98'),('WINE004',2,'ORD99'),('WINE008',4,'ORD99'),('WINE003',1,'ORD439'),('WINE012',1,'ORD439'),('WINE010',1,'ORD439'),('WINE002',1,'ORD439');
/*!40000 ALTER TABLE `Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `OrderID` varchar(25) NOT NULL,
  `Date` date NOT NULL,
  `Instructions` varchar(30) DEFAULT NULL,
  `TotalAmount` float NOT NULL,
  `Coupon` varchar(30) DEFAULT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `OrdersFK1` (`CustomerID`),
  CONSTRAINT `OrdersFK1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES ('ORD001','2023-05-05','',748.3,'SPRING10',1003),('ORD002','2023-05-05','',623.99,'SUMMER25',1003),('ORD003','2023-05-05','',623.99,'SUMMER25',1003),('ORD004','2023-05-05','',623.99,'SUMMER25',1003),('ORD005','2023-05-05','',748.3,'SPRING10',1003),('ORD006','2023-05-06','',711.75,'SUMMER25',1003),('ORD007','2023-05-06','',836.99,'',1003),('ORD008','2023-05-06','',884.68,'SPRING10',1003),('ORD10','2022-05-14',NULL,997.94,'NEWCUSTOMER',1108),('ORD100','2022-11-20',NULL,465.76,'SUMMER25',1120),('ORD101','2022-11-09',NULL,773.93,'DISCOUNT5',1068),('ORD102','2022-08-06',NULL,985.46,'BIRTHDAY10',1130),('ORD103','2022-07-18',NULL,335.45,'SUMMER25',1059),('ORD104','2022-11-03',NULL,929.7,'NEWCUSTOMER',1003),('ORD105','2022-08-30',NULL,719.56,'SPRING10',1112),('ORD106','2022-10-10',NULL,231.9,'SUMMER25',1077),('ORD107','2022-07-25',NULL,698.28,'BIRTHDAY10',1165),('ORD108','2022-07-26',NULL,670.91,'SUMMER25',1096),('ORD109','2023-03-25',NULL,208.38,'SUMMER25',1089),('ORD11','2023-01-15',NULL,165.93,'FREESHIP',1074),('ORD110','2022-07-24',NULL,624.22,'FREESHIP',1121),('ORD111','2022-10-24',NULL,544.62,'NEWCUSTOMER',1030),('ORD112','2022-10-21',NULL,504.06,'SUMMER25',1114),('ORD113','2022-12-12',NULL,165.04,'NEWCUSTOMER',1109),('ORD114','2022-10-13',NULL,885.55,'SPRING10',1087),('ORD115','2022-05-14',NULL,115.39,'NEWCUSTOMER',1052),('ORD116','2022-05-29',NULL,150.76,'SUMMER25',1092),('ORD117','2022-08-17',NULL,412.86,'BIRTHDAY10',1116),('ORD118','2022-09-23',NULL,650.39,'FREESHIP',1104),('ORD119','2023-02-24',NULL,859.4,'BIRTHDAY10',1031),('ORD12','2022-09-21',NULL,515.23,'SPRING10',1111),('ORD120','2023-03-09',NULL,969.92,'NEWCUSTOMER',1173),('ORD121','2023-03-18',NULL,325.27,'SUMMER25',1091),('ORD122','2022-10-14',NULL,106.61,'DISCOUNT5',1061),('ORD123','2022-05-30',NULL,877.51,'FREESHIP',1029),('ORD124','2023-01-31',NULL,541.88,'NEWCUSTOMER',1062),('ORD125','2022-08-05',NULL,220.54,'BIRTHDAY10',1037),('ORD126','2022-09-06',NULL,109.42,'FREESHIP',1035),('ORD127','2022-12-08',NULL,349.7,'NEWCUSTOMER',1127),('ORD128','2022-09-12',NULL,940.93,'FREESHIP',1020),('ORD129','2023-03-19',NULL,859.8,'SPRING10',1073),('ORD13','2022-12-25',NULL,250.31,'FREESHIP',1174),('ORD130','2022-10-06',NULL,367.9,'BIRTHDAY10',1088),('ORD131','2022-12-15',NULL,904.59,'FREESHIP',1172),('ORD132','2022-09-09',NULL,110,'SPRING10',1155),('ORD133','2023-03-30',NULL,899.16,'BIRTHDAY10',1066),('ORD134','2022-06-27',NULL,788.6,'FREESHIP',1050),('ORD135','2022-07-29',NULL,159.74,'BIRTHDAY10',1078),('ORD136','2022-09-23',NULL,305.69,'FREESHIP',1113),('ORD137','2022-09-25',NULL,434.65,'NEWCUSTOMER',1110),('ORD138','2023-02-25',NULL,728.49,'BIRTHDAY10',1145),('ORD139','2023-02-07',NULL,164.28,'FREESHIP',1140),('ORD14','2022-07-24',NULL,149.86,'SPRING10',1051),('ORD140','2022-07-11',NULL,798.44,'NEWCUSTOMER',1026),('ORD141','2022-06-02',NULL,982.24,'BIRTHDAY10',1033),('ORD142','2022-10-14',NULL,353.54,'DISCOUNT5',1082),('ORD143','2022-06-20',NULL,640.95,'DISCOUNT5',1070),('ORD144','2023-01-13',NULL,941.76,'NEWCUSTOMER',1137),('ORD145','2023-04-05',NULL,790.57,'NEWCUSTOMER',1053),('ORD146','2023-03-03',NULL,808.27,'NEWCUSTOMER',1034),('ORD147','2023-04-25',NULL,150.24,'SUMMER25',1042),('ORD148','2023-01-16',NULL,166.1,'SPRING10',1056),('ORD149','2022-07-04',NULL,693.93,'BIRTHDAY10',1106),('ORD15','2022-06-24',NULL,865.83,'FREESHIP',1134),('ORD150','2023-03-13',NULL,201.46,'BIRTHDAY10',1057),('ORD151','2022-06-19',NULL,340.1,'SUMMER25',1080),('ORD152','2022-11-09',NULL,701.98,'SUMMER25',1124),('ORD153','2023-04-03',NULL,701.39,'SPRING10',1004),('ORD154','2022-10-20',NULL,953.6,'BIRTHDAY10',1038),('ORD155','2022-08-02',NULL,353.14,'BIRTHDAY10',1045),('ORD156','2022-08-12',NULL,745.46,'NEWCUSTOMER',1170),('ORD157','2022-08-26',NULL,956.82,'FREESHIP',1002),('ORD158','2022-10-30',NULL,592.7,'BIRTHDAY10',1166),('ORD159','2022-11-26',NULL,273.68,'DISCOUNT5',1133),('ORD16','2022-10-06',NULL,836.71,'DISCOUNT5',1179),('ORD160','2022-08-02',NULL,602.38,'NEWCUSTOMER',1099),('ORD161','2023-02-14',NULL,467.49,'DISCOUNT5',1090),('ORD162','2022-09-15',NULL,458.98,'BIRTHDAY10',1021),('ORD163','2023-01-24',NULL,145.29,'FREESHIP',1125),('ORD164','2022-05-05',NULL,209.87,'BIRTHDAY10',1060),('ORD165','2022-11-01',NULL,761.87,'NEWCUSTOMER',1081),('ORD166','2022-05-12',NULL,383.59,'BIRTHDAY10',1149),('ORD167','2022-07-16',NULL,659.74,'DISCOUNT5',1171),('ORD168','2023-05-11','',4419.98,'',1003),('ORD169','2023-05-11','',4419.98,'',1003),('ORD17','2022-09-19',NULL,501.84,'SPRING10',1129),('ORD170','2023-05-11','',4419.98,'',1003),('ORD171','2023-05-11','',4419.98,'',1003),('ORD172','2023-05-11','',4419.98,'',1003),('ORD173','2023-05-11','',4419.98,'',1003),('ORD174','2023-05-12','',4775.4,'',1003),('ORD175','2023-05-12','',807,'',1003),('ORD176','2023-05-12','',3000.58,'',1003),('ORD177','2023-05-12','',1945.96,'',1003),('ORD178','2023-05-13','',2840,'',1003),('ORD179','2023-05-13','',1130,'',1003),('ORD18','2023-03-11',NULL,392.38,'BIRTHDAY10',1152),('ORD19','2022-10-17',NULL,643.78,'SPRING10',1148),('ORD20','2023-04-24',NULL,570.26,'FREESHIP',1043),('ORD200','2020-08-21',NULL,1280.25,'FREESHIP',1079),('ORD201','2021-04-18',NULL,1606.42,'BIRTHDAY10',1077),('ORD202','2020-07-03',NULL,1837.79,'SUMMER25',1126),('ORD203','2019-04-01',NULL,1858,'SUMMER25',1147),('ORD204','2021-09-02',NULL,1367.58,'SUMMER25',1161),('ORD205','2018-09-13',NULL,1558.55,'BIRTHDAY10',1060),('ORD206','2020-02-10',NULL,1902.34,'BIRTHDAY10',1065),('ORD207','2018-05-19',NULL,1442.63,'DISCOUNT5',1061),('ORD208','2019-12-04',NULL,634.37,'SUMMER25',1055),('ORD209','2019-05-31',NULL,1798.41,'NEWCUSTOMER',1053),('ORD21','2023-04-29',NULL,844.32,'SPRING10',1039),('ORD210','2020-04-05',NULL,1865.68,'SPRING10',1047),('ORD211','2018-11-01',NULL,871.5,'BIRTHDAY10',1075),('ORD212','2018-09-17',NULL,1905.7,'BIRTHDAY10',1004),('ORD213','2021-10-18',NULL,1149.41,'DISCOUNT5',1026),('ORD214','2021-11-06',NULL,714.68,'NEWCUSTOMER',1169),('ORD215','2018-06-22',NULL,1242.99,'SPRING10',1174),('ORD216','2020-06-13',NULL,671.48,'SPRING10',1144),('ORD217','2021-08-27',NULL,908.49,'FREESHIP',1095),('ORD218','2021-04-08',NULL,1496.11,'FREESHIP',1102),('ORD219','2018-10-07',NULL,858.34,'SPRING10',1090),('ORD22','2022-10-15',NULL,221.5,'SPRING10',1076),('ORD220','2018-10-18',NULL,1788.12,'FREESHIP',1028),('ORD221','2020-12-12',NULL,752.7,'BIRTHDAY10',1109),('ORD222','2019-05-25',NULL,1359.62,'SPRING10',1125),('ORD223','2020-09-19',NULL,1979.86,'DISCOUNT5',1005),('ORD224','2019-07-22',NULL,1239.53,'DISCOUNT5',1029),('ORD225','2018-10-04',NULL,1768.3,'NEWCUSTOMER',1008),('ORD226','2019-11-08',NULL,1860.32,'SPRING10',1148),('ORD227','2021-12-15',NULL,1889.71,'SPRING10',1171),('ORD228','2020-12-11',NULL,565.93,'SPRING10',1049),('ORD229','2019-07-07',NULL,895.48,'SUMMER25',1163),('ORD23','2023-03-09',NULL,837.69,'FREESHIP',1041),('ORD230','2021-10-18',NULL,549.23,'BIRTHDAY10',1051),('ORD231','2021-08-31',NULL,517.25,'NEWCUSTOMER',1045),('ORD232','2018-05-03',NULL,1582.55,'FREESHIP',1033),('ORD233','2018-09-16',NULL,1131.86,'NEWCUSTOMER',1035),('ORD234','2021-10-04',NULL,1794.77,'SPRING10',1099),('ORD235','2021-11-19',NULL,912.02,'SUMMER25',1159),('ORD236','2019-12-12',NULL,1306.26,'NEWCUSTOMER',1009),('ORD237','2021-12-03',NULL,1584.06,'NEWCUSTOMER',1066),('ORD238','2019-11-27',NULL,1110.95,'SPRING10',1132),('ORD239','2020-06-20',NULL,1092.58,'SUMMER25',1069),('ORD24','2022-10-27',NULL,164.4,'BIRTHDAY10',1001),('ORD240','2021-09-20',NULL,776.66,'BIRTHDAY10',1111),('ORD241','2019-06-10',NULL,540.37,'FREESHIP',1145),('ORD242','2021-10-12',NULL,1952.14,'SPRING10',1110),('ORD243','2020-08-26',NULL,564.73,'NEWCUSTOMER',1052),('ORD244','2021-03-18',NULL,795.45,'SUMMER25',1112),('ORD245','2020-08-30',NULL,1691.4,'DISCOUNT5',1022),('ORD246','2021-03-25',NULL,921.43,'NEWCUSTOMER',1166),('ORD247','2020-10-16',NULL,1126.03,'SPRING10',1103),('ORD248','2018-08-27',NULL,1287.26,'SPRING10',1041),('ORD249','2018-09-21',NULL,967.02,'SPRING10',1115),('ORD25','2022-12-18',NULL,114.11,'FREESHIP',1008),('ORD250','2021-04-03',NULL,1214,'BIRTHDAY10',1133),('ORD251','2019-10-24',NULL,634.34,'SPRING10',1032),('ORD252','2020-10-28',NULL,542.57,'SUMMER25',1170),('ORD253','2021-11-28',NULL,963.71,'NEWCUSTOMER',1082),('ORD254','2021-04-28',NULL,876.66,'SUMMER25',1050),('ORD255','2020-08-16',NULL,1225.76,'NEWCUSTOMER',1059),('ORD256','2019-12-03',NULL,527.39,'SUMMER25',1093),('ORD257','2021-01-07',NULL,1879.58,'DISCOUNT5',1149),('ORD258','2020-12-24',NULL,1317.3,'SPRING10',1048),('ORD259','2019-10-02',NULL,1100.57,'SPRING10',1038),('ORD26','2022-08-05',NULL,570.43,'FREESHIP',1153),('ORD260','2021-11-14',NULL,1841.86,'SPRING10',1120),('ORD261','2018-06-26',NULL,1348.8,'FREESHIP',1058),('ORD262','2020-01-07',NULL,1856.06,'NEWCUSTOMER',1096),('ORD263','2021-11-13',NULL,1294.92,'FREESHIP',1001),('ORD264','2020-03-30',NULL,701.87,'SUMMER25',1113),('ORD265','2019-02-25',NULL,1461.02,'NEWCUSTOMER',1128),('ORD266','2020-06-29',NULL,626.31,'SPRING10',1106),('ORD267','2019-03-27',NULL,1093.68,'DISCOUNT5',1172),('ORD268','2020-02-05',NULL,678.97,'BIRTHDAY10',1154),('ORD269','2018-05-03',NULL,1307.71,'DISCOUNT5',1021),('ORD27','2022-07-29',NULL,943.21,'SUMMER25',1028),('ORD270','2021-04-16',NULL,506.42,'SUMMER25',1138),('ORD271','2018-09-11',NULL,1135.16,'NEWCUSTOMER',1003),('ORD272','2019-06-03',NULL,1587.65,'FREESHIP',1124),('ORD273','2019-04-25',NULL,792.45,'DISCOUNT5',1136),('ORD274','2019-04-17',NULL,1784.56,'DISCOUNT5',1119),('ORD275','2020-03-15',NULL,1959.02,'DISCOUNT5',1156),('ORD276','2018-08-06',NULL,745.24,'SUMMER25',1031),('ORD277','2021-11-08',NULL,720.45,'SPRING10',1168),('ORD278','2019-09-11',NULL,1227.64,'FREESHIP',1152),('ORD279','2018-08-04',NULL,1709.96,'SUMMER25',1063),('ORD28','2022-09-26',NULL,175.68,'BIRTHDAY10',1049),('ORD280','2018-08-29',NULL,573.89,'FREESHIP',1027),('ORD281','2021-11-24',NULL,1007.49,'NEWCUSTOMER',1121),('ORD282','2020-12-27',NULL,897.64,'DISCOUNT5',1078),('ORD283','2018-08-15',NULL,1158.93,'SPRING10',1129),('ORD284','2021-09-28',NULL,1656.45,'SUMMER25',1108),('ORD285','2019-02-07',NULL,1343.77,'BIRTHDAY10',1105),('ORD286','2020-07-20',NULL,861.49,'FREESHIP',1071),('ORD287','2019-03-05',NULL,1839.93,'BIRTHDAY10',1118),('ORD288','2020-03-23',NULL,1315.09,'FREESHIP',1153),('ORD289','2019-10-16',NULL,1456.11,'SUMMER25',1024),('ORD29','2023-03-27',NULL,470.49,'BIRTHDAY10',1040),('ORD290','2021-12-26',NULL,854.23,'NEWCUSTOMER',1057),('ORD291','2020-10-27',NULL,1764.64,'BIRTHDAY10',1067),('ORD292','2019-12-12',NULL,1273.78,'SPRING10',1062),('ORD293','2021-03-17',NULL,1676.55,'FREESHIP',1023),('ORD294','2021-07-03',NULL,1397.29,'DISCOUNT5',1143),('ORD295','2021-03-24',NULL,1793.72,'BIRTHDAY10',1137),('ORD296','2021-06-24',NULL,1633.17,'NEWCUSTOMER',1146),('ORD297','2018-10-19',NULL,1417.07,'BIRTHDAY10',1100),('ORD298','2018-12-08',NULL,1251.13,'DISCOUNT5',1056),('ORD299','2019-06-05',NULL,1345.82,'SUMMER25',1114),('ORD30','2022-07-27',NULL,773.86,'BIRTHDAY10',1069),('ORD300','2021-03-15',NULL,807.2,'SPRING10',1097),('ORD301','2018-10-16',NULL,901.01,'FREESHIP',1025),('ORD302','2020-12-19',NULL,1524.11,'SUMMER25',1151),('ORD303','2019-03-07',NULL,936.62,'DISCOUNT5',1046),('ORD304','2018-11-28',NULL,1409.32,'FREESHIP',1036),('ORD305','2020-02-06',NULL,1717.85,'BIRTHDAY10',1006),('ORD306','2019-05-02',NULL,1540.69,'FREESHIP',1020),('ORD307','2018-10-30',NULL,1404.36,'FREESHIP',1080),('ORD308','2019-05-25',NULL,582.94,'SUMMER25',1157),('ORD309','2018-08-14',NULL,1546.62,'SUMMER25',1177),('ORD31','2022-07-21',NULL,970.33,'SUMMER25',1093),('ORD310','2020-02-14',NULL,848.24,'SUMMER25',1088),('ORD311','2021-03-24',NULL,1864.01,'SUMMER25',1072),('ORD312','2018-05-13',NULL,1533.24,'FREESHIP',1127),('ORD313','2019-08-05',NULL,1497.01,'SUMMER25',1002),('ORD314','2021-07-12',NULL,1559.22,'DISCOUNT5',1037),('ORD315','2020-01-10',NULL,527.76,'NEWCUSTOMER',1160),('ORD316','2020-06-28',NULL,1697.92,'FREESHIP',1068),('ORD317','2020-10-03',NULL,675.07,'FREESHIP',1074),('ORD318','2021-08-02',NULL,1043.21,'BIRTHDAY10',1064),('ORD319','2019-02-21',NULL,1989.95,'NEWCUSTOMER',1087),('ORD32','2022-09-21',NULL,589.34,'FREESHIP',1044),('ORD320','2018-06-22',NULL,706.18,'DISCOUNT5',1054),('ORD321','2019-12-29',NULL,1169.72,'SUMMER25',1092),('ORD322','2018-11-19',NULL,1028.02,'BIRTHDAY10',1155),('ORD323','2018-12-11',NULL,539.17,'NEWCUSTOMER',1081),('ORD324','2021-02-15',NULL,511.21,'FREESHIP',1134),('ORD325','2018-05-02',NULL,917.47,'SUMMER25',1150),('ORD326','2020-07-16',NULL,1709.85,'DISCOUNT5',1158),('ORD327','2019-09-02',NULL,1216.31,'DISCOUNT5',1085),('ORD328','2021-06-12',NULL,1230.67,'SPRING10',1044),('ORD329','2019-07-23',NULL,553.08,'BIRTHDAY10',1042),('ORD33','2022-08-01',NULL,252.83,'NEWCUSTOMER',1010),('ORD330','2021-04-10',NULL,1659.21,'SPRING10',1007),('ORD331','2020-05-27',NULL,1598.59,'SPRING10',1164),('ORD332','2021-02-25',NULL,1129.58,'DISCOUNT5',1131),('ORD333','2021-06-21',NULL,1596.1,'DISCOUNT5',1073),('ORD334','2021-09-01',NULL,879.79,'DISCOUNT5',1039),('ORD335','2019-03-09',NULL,1309.56,'SUMMER25',1086),('ORD336','2021-08-18',NULL,500.49,'SUMMER25',1142),('ORD337','2019-09-19',NULL,546.94,'BIRTHDAY10',1130),('ORD338','2021-03-25',NULL,1796.16,'FREESHIP',1094),('ORD339','2020-08-27',NULL,893.75,'FREESHIP',1040),('ORD34','2022-11-23',NULL,658.42,'SUMMER25',1007),('ORD340','2018-09-01',NULL,1648.08,'SPRING10',1175),('ORD341','2020-05-01',NULL,1211.56,'NEWCUSTOMER',1030),('ORD342','2021-07-22',NULL,1530.94,'BIRTHDAY10',1076),('ORD343','2020-06-26',NULL,1721.8,'BIRTHDAY10',1010),('ORD344','2020-05-14',NULL,1556.08,'BIRTHDAY10',1034),('ORD345','2021-10-06',NULL,989.5,'FREESHIP',1173),('ORD346','2019-10-01',NULL,1765.82,'BIRTHDAY10',1089),('ORD347','2018-10-19',NULL,1761.11,'BIRTHDAY10',1083),('ORD348','2018-07-31',NULL,873.55,'SPRING10',1122),('ORD349','2021-03-29',NULL,1697.12,'FREESHIP',1084),('ORD35','2022-12-20',NULL,102.91,'NEWCUSTOMER',1143),('ORD350','2018-07-31',NULL,1516.11,'NEWCUSTOMER',1104),('ORD351','2021-05-12',NULL,1395.27,'NEWCUSTOMER',1179),('ORD352','2019-10-22',NULL,552.35,'NEWCUSTOMER',1043),('ORD353','2019-09-28',NULL,1004.4,'FREESHIP',1165),('ORD354','2020-07-13',NULL,864.86,'BIRTHDAY10',1116),('ORD355','2021-05-01',NULL,647.74,'SPRING10',1167),('ORD356','2021-04-02',NULL,1853.91,'SPRING10',1091),('ORD357','2021-11-22',NULL,1562.84,'SUMMER25',1140),('ORD358','2019-08-08',NULL,1425.73,'SPRING10',1070),('ORD359','2021-02-27',NULL,1887.29,'BIRTHDAY10',1098),('ORD36','2022-07-14',NULL,918.41,'NEWCUSTOMER',1058),('ORD37','2022-11-26',NULL,404.36,'BIRTHDAY10',1167),('ORD38','2023-04-09',NULL,150.28,'NEWCUSTOMER',1122),('ORD39','2022-12-18',NULL,578.44,'SUMMER25',1131),('ORD40','2022-12-30',NULL,171.84,'BIRTHDAY10',1095),('ORD41','2022-11-22',NULL,462.81,'DISCOUNT5',1083),('ORD42','2023-03-20',NULL,916.28,'SUMMER25',1177),('ORD43','2022-08-19',NULL,828.23,'DISCOUNT5',1136),('ORD439','2023-05-19','',1844.48,'',1003),('ORD44','2022-05-04',NULL,697.9,'BIRTHDAY10',1118),('ORD45','2023-02-08',NULL,853.05,'BIRTHDAY10',1142),('ORD46','2022-08-29',NULL,463.56,'SPRING10',1027),('ORD47','2022-06-13',NULL,462.29,'FREESHIP',1054),('ORD48','2023-01-20',NULL,363.91,'SUMMER25',1144),('ORD49','2022-07-20',NULL,359.8,'NEWCUSTOMER',1064),('ORD50','2023-02-27',NULL,235.39,'DISCOUNT5',1150),('ORD51','2022-07-08',NULL,617.38,'DISCOUNT5',1065),('ORD52','2022-05-25',NULL,643.66,'NEWCUSTOMER',1115),('ORD53','2022-11-06',NULL,236.73,'SUMMER25',1063),('ORD54','2022-11-22',NULL,865.84,'FREESHIP',1072),('ORD55','2023-01-01',NULL,256.5,'DISCOUNT5',1102),('ORD56','2022-05-06',NULL,257.58,'SUMMER25',1048),('ORD57','2022-08-15',NULL,956.47,'SPRING10',1079),('ORD58','2022-11-05',NULL,647.76,'FREESHIP',1158),('ORD59','2022-11-11',NULL,193.11,'FREESHIP',1151),('ORD60','2022-12-18',NULL,776.68,'FREESHIP',1022),('ORD61','2022-10-18',NULL,244.69,'SUMMER25',1047),('ORD62','2023-03-05',NULL,899.33,'NEWCUSTOMER',1161),('ORD63','2023-01-29',NULL,180.25,'NEWCUSTOMER',1164),('ORD64','2023-03-03',NULL,320,'SUMMER25',1005),('ORD65','2023-04-25',NULL,922.92,'DISCOUNT5',1032),('ORD66','2023-03-22',NULL,879.27,'DISCOUNT5',1160),('ORD67','2023-03-30',NULL,721.2,'DISCOUNT5',1175),('ORD68','2022-09-01',NULL,515.37,'FREESHIP',1132),('ORD69','2023-04-04',NULL,684.48,'FREESHIP',1086),('ORD70','2022-11-05',NULL,671.37,'SUMMER25',1085),('ORD700','2023-04-01',NULL,269.02,'FREESHIP',1169),('ORD71','2023-03-21',NULL,823.82,'NEWCUSTOMER',1023),('ORD72','2022-10-02',NULL,269.48,'FREESHIP',1009),('ORD73','2022-07-06',NULL,653.06,'DISCOUNT5',1071),('ORD74','2022-11-02',NULL,471.93,'SPRING10',1006),('ORD75','2022-09-08',NULL,513.95,'BIRTHDAY10',1146),('ORD76','2022-06-13',NULL,651.6,'DISCOUNT5',1046),('ORD77','2022-11-16',NULL,126.91,'SPRING10',1156),('ORD78','2022-12-19',NULL,672.64,'SPRING10',1024),('ORD79','2022-11-15',NULL,127.99,'DISCOUNT5',1094),('ORD80','2022-10-13',NULL,831.66,'SPRING10',1147),('ORD81','2023-03-01',NULL,375.21,'NEWCUSTOMER',1159),('ORD82','2023-03-06',NULL,583.77,'BIRTHDAY10',1067),('ORD83','2022-11-28',NULL,515.49,'SUMMER25',1097),('ORD84','2022-11-14',NULL,476.96,'SUMMER25',1168),('ORD85','2023-02-07',NULL,624.96,'NEWCUSTOMER',1100),('ORD86','2022-09-11',NULL,278.96,'NEWCUSTOMER',1055),('ORD87','2022-11-18',NULL,497.36,'SPRING10',1075),('ORD88','2022-07-31',NULL,602.18,'SPRING10',1105),('ORD89','2022-08-22',NULL,433.06,'SPRING10',1103),('ORD90','2022-12-27',NULL,113.19,'BIRTHDAY10',1126),('ORD91','2022-10-09',NULL,893.49,'FREESHIP',1025),('ORD92','2022-07-12',NULL,606.9,'SPRING10',1098),('ORD93','2023-02-06',NULL,822.64,'BIRTHDAY10',1138),('ORD94','2023-01-16',NULL,398.56,'DISCOUNT5',1036),('ORD95','2023-02-06',NULL,353.34,'NEWCUSTOMER',1154),('ORD96','2022-12-08',NULL,495.07,'SUMMER25',1119),('ORD97','2023-04-20',NULL,355.79,'DISCOUNT5',1084),('ORD98','2022-11-20',NULL,544.07,'NEWCUSTOMER',1163),('ORD99','2022-05-05',NULL,528.47,'FREESHIP',1157);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders_CreditCard`
--

DROP TABLE IF EXISTS `Orders_CreditCard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders_CreditCard` (
  `CreditCard` varchar(25) NOT NULL,
  `OrderID` varchar(25) NOT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`CreditCard`),
  KEY `OrdersFKC` (`OrderID`),
  KEY `fk_credit_cart_customer` (`CustomerID`),
  CONSTRAINT `fk_credit_cart_customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`),
  CONSTRAINT `OrdersFKC` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders_CreditCard`
--

LOCK TABLES `Orders_CreditCard` WRITE;
/*!40000 ALTER TABLE `Orders_CreditCard` DISABLE KEYS */;
INSERT INTO `Orders_CreditCard` VALUES ('4768708787987','ORD008',1003),('4867866667908','ORD175',1003),('4872697439750','ORD001',1003);
/*!40000 ALTER TABLE `Orders_CreditCard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Region`
--

DROP TABLE IF EXISTS `Region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Region` (
  `RegionID` varchar(25) NOT NULL,
  `RegionName` varchar(30) NOT NULL,
  PRIMARY KEY (`RegionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Region`
--

LOCK TABLES `Region` WRITE;
/*!40000 ALTER TABLE `Region` DISABLE KEYS */;
INSERT INTO `Region` VALUES ('R001','Napa Valley'),('R002','Sonoma County'),('R003','Central Coast'),('R004','Finger Lakes'),('R005','Willamette Valley');
/*!40000 ALTER TABLE `Region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `Username` varchar(25) NOT NULL,
  `Password` varchar(25) NOT NULL,
  `CustomerID` int NOT NULL,
  `SecurityQuestion` varchar(255) NOT NULL,
  `SecurityAnswer` varchar(255) NOT NULL,
  PRIMARY KEY (`Username`),
  KEY `UsersFK1` (`CustomerID`),
  CONSTRAINT `UsersFK1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES ('0BFAolNc','4dZ335ZWas',1131,'What is your mother\'s maiden name?','Blue'),('0CE5lsrL','SnPxdxvLdh',1092,'What is the name of your first pet?','12345'),('0HI6PqSB','HQkWy3MiXg',1126,'What city were you born in?','The Shawshank Redemption'),('0hn6ROIJ','x4EdfPl4cH',1073,'What is your favorite book?','12345'),('13X8c7DW','KLJJTiobqT',1134,'What is your mother\'s maiden name?','Blue'),('1ClOtvOo','pPyMqg4StR',1129,'What is your favorite book?','London'),('1Hd15aY1','Pavdr6ZV8t',1033,'What is your favorite book?','Pizza'),('1xY9g75u','XyjbkgeHon',1034,'What is the name of your first pet?','12345'),('2kOiCBDD','oev6lniEzh',1167,'What is the name of your first pet?','The Shawshank Redemption'),('3aoFxHX8','NxE0JtrcdU',1112,'What is the name of your first pet?','Pizza'),('3OMuVkny','IZgfVRA9Gi',1069,'What is your favorite book?','Pizza'),('4W6tUlX5','UnE1gLQl4V',1077,'What is your favorite book?','London'),('5FLS7ddG','yx8NRDxBik',1177,'What is your favorite book?','Blue'),('5Zf1THs4','8fO9F9s8Mv',1038,'What is your mother\'s maiden name?','The Shawshank Redemption'),('5ZUZxPZD','FqFTnG1Zj1',1165,'What city were you born in?','Blue'),('6irVtp52','wKM2tzu5fh',1035,'What is your favorite book?','Blue'),('6IZfrqMr','GUN9580KzE',1032,'What city were you born in?','London'),('6n4aNSdW','fqqQJX9Pir',1063,'What is your mother\'s maiden name?','London'),('96CIUW7n','i9JHWgDh2P',1009,'What is your favorite book?','Blue'),('9eosEi6S','VECeTGkiGJ',1154,'What is the name of your first pet?','12345'),('9lVjM5Sd','8Wk3HiQhUc',1044,'What is your mother\'s maiden name?','Blue'),('Ab5sUg26','OYrwfYL0JC',1132,'What is the name of your first pet?','Blue'),('aDPCy95P','VBkMhI2Eew',1029,'What city were you born in?','Blue'),('AdZyCv6K','8kPm3I6gO1',1054,'What is your favorite movie?','The Shawshank Redemption'),('Ah6OwEVw','DLA1Xeo0D1',1124,'What is your mother\'s maiden name?','London'),('aQsn8LzK','nWvLV8cj15',1068,'What is your favorite book?','The Shawshank Redemption'),('B0tYR6jE','xUqPRGxwbK',1061,'What is your mother\'s maiden name?','Pizza'),('BaO7QpOi','pFYQcc6oYY',1083,'What is your favorite movie?','London'),('Befj3pPU','B5ThwgkAOr',1008,'What city were you born in?','The Shawshank Redemption'),('bkIm01nI','FutZL22OmZ',1039,'What is your favorite movie?','12345'),('bKKhuxQU','6tPgPutCkQ',1030,'What is the name of your first pet?','London'),('BlueSky22','kY3$eX%mB7',1005,'What is your favorite movie?','The Shawshank Redemption'),('BmtkVKPu','qsvzllluSR',1102,'What is the name of your first pet?','Blue'),('bmwOxViK','tpVdPyLjjZ',1070,'What is your mother\'s maiden name?','12345'),('BossBunchTeam','password1',2173,'What is your favorite color?','blue'),('CoolCat21','password141',1003,'What is your mother\'s maiden name?','Smith'),('CRajGFyR','hTp6psKVk7',1004,'What is the name of your first pet?','12345'),('CSYb3hhe','hVQ5VdQC9j',1172,'What is your mother\'s maiden name?','Pizza'),('CuRAFQxX','8PAb3s3WFp',1151,'What is the name of your first pet?','The Shawshank Redemption'),('D54SlsSw','0uZI6wWP5p',1076,'What city were you born in?','London'),('d9oBmivu','XvmOXbM0Cm',1002,'What is your mother\'s maiden name?','The Shawshank Redemption'),('DAIrahig','CyTDpRchYc',1118,'What city were you born in?','The Shawshank Redemption'),('dBYYUI9d','PfhfVinxsb',1174,'What is your favorite movie?','Pizza'),('DivyaN','password1',2172,'What is your favorite color?','blue'),('DuisvaSY','Z3seZl6cnx',1041,'What city were you born in?','12345'),('E2aqHJWZ','rpOtD2zvgQ',1051,'What is the name of your first pet?','Pizza'),('Eqtkv9wn','v5oE70GAcF',1147,'What is the name of your first pet?','London'),('eUeybL9v','0uem07UWGR',1096,'What is your mother\'s maiden name?','12345'),('EvxMsRe8','JdGegrlEwC',1082,'What is your mother\'s maiden name?','Blue'),('EyPfsaHW','seCbA9t5C1',1122,'What city were you born in?','Pizza'),('F9mDe0Ko','bwAQR6UZWi',1064,'What is your favorite movie?','London'),('FkA15rdS','BacbE5cNCv',1113,'What is your favorite book?','The Shawshank Redemption'),('FlyingEagle99','sF4^gD#jK2',1009,'What is your favorite animal?','Eagle'),('G0b5iPwE','9hKSlUUby4',1099,'What city were you born in?','Pizza'),('G2ei6PHx','kM8qWMf0xa',1146,'What city were you born in?','London'),('gmTEMh0f','WULBjyIFLj',1114,'What is your favorite movie?','Blue'),('Gz03pPNx','qTSLHpnwFH',1150,'What is your mother\'s maiden name?','Blue'),('h21nHicH','530bI61lip',1145,'What is your favorite movie?','London'),('HadgSkPu','oijYVD2ybj',1164,'What is your mother\'s maiden name?','London'),('HappyCamper16','zV2^dS!nC9',1006,'What is your favorite food?','Pizza'),('HaSCGw8o','0Gp4ZaqINN',1169,'What is the name of your first pet?','12345'),('hDftYtTX','9pAfT0ArAk',1086,'What is your mother\'s maiden name?','The Shawshank Redemption'),('hDR90cq9','9Sk5tIdIup',1085,'What is your favorite movie?','London'),('hHFczQop','2OiuGlqwqI',1105,'What is your favorite book?','Pizza'),('HjjgGiGP','jaNWbfXZ2z',1081,'What is your favorite book?','The Shawshank Redemption'),('hn2E5NDd','NMVH8eTJoV',1080,'What is your favorite book?','The Shawshank Redemption'),('I8lPcJ92','srou2Bdm8j',1144,'What is the name of your first pet?','Blue'),('IKJRS4A7','e1bCgXNFPw',1093,'What is the name of your first pet?','12345'),('IybK6nbM','GsOV3vKWpu',1136,'What is your favorite book?','London'),('j05smHgy','wGKE2zOTqm',1047,'What is your mother\'s maiden name?','London'),('Jf9KJqYm','t40PPRIltz',1100,'What is the name of your first pet?','12345'),('JgWx4uQR','B06uXCeX7Q',1020,'What is the name of your first pet?','12345'),('jkdxfwYN','1gK0Yn0nBA',1143,'What is the name of your first pet?','Blue'),('jPU57kmO','wW1K46JSKX',1003,'What city were you born in?','Blue'),('KFctIKqd','guqWeF9Zas',1087,'What city were you born in?','The Shawshank Redemption'),('kMFxi0uF','sOj3rZDh77',1148,'What city were you born in?','Pizza'),('KnEwQBFx','sDIVZz6kI7',1050,'What city were you born in?','London'),('kOsuSLkR','h6vIhpYaHy',1055,'What is your favorite book?','London'),('KoWRWieH','huFra8u5s4',1026,'What city were you born in?','London'),('kpsofcFU','KQ6QUa002g',1072,'What is your favorite book?','The Shawshank Redemption'),('KwhOP8uZ','H51laAyGG8',1091,'What is your favorite book?','Blue'),('kYRKareg','lFiU6HZNKj',1052,'What is the name of your first pet?','London'),('kzvhJTN2','vSixOjfVus',1075,'What is the name of your first pet?','London'),('L24dAWgL','OdFAc3iCBy',1094,'What city were you born in?','Blue'),('lqtcGY3i','qgJn08ZQxb',1059,'What is your mother\'s maiden name?','12345'),('lW3EuPCk','7Od7z7vNTP',1049,'What is the name of your first pet?','12345'),('lW6dQPEG','0rLl4w7J4D',1156,'What is your mother\'s maiden name?','12345'),('LXxTcGde','bzTuF3JKKv',1120,'What is your favorite book?','London'),('M39DwJZh','eWYB9xAiQe',1067,'What city were you born in?','12345'),('M6fTluo8','r91JVsyLnV',1084,'What city were you born in?','London'),('MountainHiker45','lU7%mT!qE5',1008,'What is your favorite hobby?','Hiking'),('mvJEo76g','aAJ3sGEgD1',1079,'What is your favorite book?','12345'),('My6siHfG','aVNRgXkn06',1161,'What is your mother\'s maiden name?','The Shawshank Redemption'),('n9q0Ubh5','UNyMJ2zviA',1027,'What is the name of your first pet?','12345'),('Nchb37bM','T7FuCOljhx',1155,'What is the name of your first pet?','London'),('nFCnDgwF','icOO5ookBn',1175,'What city were you born in?','London'),('NiL1L7cS','969yGaIYGX',1108,'What city were you born in?','The Shawshank Redemption'),('nMIplxJW','uN0sBFXfXz',1179,'What city were you born in?','Blue'),('nQUdMaoY','yVRnObtvWt',1048,'What city were you born in?','London'),('Nu1E8T5y','D2k7nfwFdW',1104,'What is your mother\'s maiden name?','Blue'),('nXQFefg2','6yVt14c2I1',1071,'What is your favorite movie?','The Shawshank Redemption'),('OceanBreeze64','rH6@nP$yZ9',1010,'What is your favorite place to travel?','Hawaii'),('OgfvhZvB','8CXjjeEcGU',1060,'What is the name of your first pet?','The Shawshank Redemption'),('OGuquooZ','etdzA6pkI8',1058,'What city were you born in?','The Shawshank Redemption'),('OjVXxzQR','K5oJJzlnUz',1057,'What is your mother\'s maiden name?','Blue'),('omsqwW2I','k4viKIycu8',1001,'What is the name of your first pet?','Pizza'),('oQTI0tNQ','NGVovKOwFf',1140,'What is your favorite book?','12345'),('OSGqSLYN','cWWsypIOgR',1157,'What is your favorite book?','London'),('Ow3tRNAJ','o3KsjtuJIA',1053,'What is your mother\'s maiden name?','London'),('oZUAJ3mS','E0V3QfjvAr',1025,'What is your favorite book?','The Shawshank Redemption'),('pa8YCp1x','yb6qWDMlDe',1166,'What is your favorite book?','London'),('pLFPjiY0','Yp3v1OuopD',1115,'What is your favorite movie?','The Shawshank Redemption'),('PoojithaV','password1',2174,'What is your favorite color?','blue'),('pRpFqEMM','WYVautv7FL',1078,'What is the name of your first pet?','12345'),('pV5hAytH','IhzBoGwajY',1109,'What is your favorite book?','London'),('pxcaQBtz','RnmBEa3AV9',1045,'What city were you born in?','12345'),('PzqAmPXg','MR7lIdUAQ5',1042,'What is your favorite movie?','London'),('Q8alCBXr','xTlmG5JQ0j',1088,'What is the name of your first pet?','London'),('QcPoSKCP','RUbPidVWza',1133,'What city were you born in?','Pizza'),('qDATFmwx','cD9bLVG6MR',1170,'What is your mother\'s maiden name?','12345'),('qPm3iTuW','7Zw7mkAlPG',1023,'What is your favorite book?','Pizza'),('qxcdeZYz','ErgwXpZUoG',1138,'What is your mother\'s maiden name?','The Shawshank Redemption'),('r8Kgc0l4','CogxXrrsDD',1098,'What is your mother\'s maiden name?','Blue'),('RedRose77','wA1#iO@pF8',1007,'What is your favorite book?','To Kill a Mockingbird'),('RORMo08i','GIaOV5Hz87',1022,'What is your favorite movie?','The Shawshank Redemption'),('sd4YLHoM','vm9TXAo7ce',1116,'What is your favorite movie?','12345'),('ShrutiB','password1',2171,'What is your favorite color?','blue'),('sRqTCL9W','2jP2MpS0vk',1152,'What is the name of your first pet?','London'),('Starlight33','tG4#hM@uJ6',1004,'What city were you born in?','New York'),('SunnyDays42','pRi7@E#oK2',1001,'What is your favorite color?','Blue'),('suuABTov','HvJuwl4HU7',1103,'What is your favorite movie?','Blue'),('t79oe9Zy','cOQaVnBLiK',1010,'What is your mother\'s maiden name?','12345'),('TechGuru89','x5Z%bN!mP8',1002,'What was the name of your first pet?','Fluffy'),('tgRCFaaL','bTRQj126of',1173,'What is your favorite movie?','Blue'),('tI8dCwbJ','lcuoT71i7G',1031,'What is your favorite movie?','12345'),('tjQYcjDM','tb5HOGTdTT',1110,'What is your favorite book?','12345'),('tkask6Cn','7PRVWn10nZ',1074,'What is the name of your first pet?','London'),('tPumiO28','B370zDDwCe',1024,'What city were you born in?','The Shawshank Redemption'),('tq8I0VqQ','lGrLkLn5sk',1171,'What is your mother\'s maiden name?','Pizza'),('tuyhzB6W','PyjESoId9U',1159,'What is your favorite book?','12345'),('tz4X0xVQ','rVwFxNMnsb',1040,'What city were you born in?','Blue'),('U3LTHbP7','EEt2h7HrMq',1168,'What is your favorite movie?','Pizza'),('U3TK09BX','R3eRByci4m',1095,'What city were you born in?','Pizza'),('U9UGPeRJ','V6mbRjz7oz',1149,'What city were you born in?','London'),('UEWOvxIi','9KTHZjPHEr',1066,'What is your favorite book?','12345'),('Ufy8FgUX','8mUNs89B4v',1036,'What is your favorite movie?','Pizza'),('uKmuviMM','OmcXZIqSU7',1111,'What is the name of your first pet?','12345'),('UKTPeuHb','1rA5I8Zc5O',1160,'What is the name of your first pet?','London'),('uPoTZNT7','EyvXfxZFlZ',1043,'What city were you born in?','London'),('uWbwNoGR','34WA6V7wBc',1028,'What city were you born in?','Pizza'),('VcR29epu','OWBzi48GPZ',1056,'What is your favorite book?','Pizza'),('Vg0uSAcd','rFWJbBVFff',1119,'What is your favorite movie?','Pizza'),('VNQSysgJ','GCa48SkpA5',1046,'What is your mother\'s maiden name?','Blue'),('VvO1J1w0','jrnSvfUJY3',1137,'What is your favorite movie?','The Shawshank Redemption'),('Vz4W13O3','8AbVmmgSqu',1106,'What city were you born in?','The Shawshank Redemption'),('wERuBaa2','TaIOXbFEfs',1007,'What is your favorite book?','12345'),('wmDTmHAZ','LevlJK0jST',1006,'What is your favorite movie?','Blue'),('wrT052R3','RheRkFRD1a',1142,'What city were you born in?','The Shawshank Redemption'),('WUtG57PU','NOqD9VOcSG',1128,'What is your mother\'s maiden name?','12345'),('x0quQWxR','YvffiKZdXt',1127,'What is the name of your first pet?','The Shawshank Redemption'),('x0rPRZ26','BGeoCWPFko',1021,'What is the name of your first pet?','London'),('X8MdAFT8','fJslD9SexA',1005,'What is your favorite movie?','London'),('XlbCc5Br','qvQS8y60tM',1090,'What city were you born in?','The Shawshank Redemption'),('y5CzjjkB','68qKxOGula',1125,'What is your favorite movie?','Pizza'),('yl3YX2JW','ik5idlhXtJ',1037,'What city were you born in?','The Shawshank Redemption'),('YOuCgDvX','hmwuRjkna7',1121,'What is the name of your first pet?','12345'),('z8AHBuuH','b6kxMOmA75',1130,'What is your favorite movie?','12345'),('ZdnKOe7A','2TJhxBitqx',1153,'What is your favorite book?','Blue'),('zFuamgCS','BAMLNKYQ51',1158,'What is your mother\'s maiden name?','Pizza'),('Zg5paDA5','NCQpQ4dGf4',1097,'What is your mother\'s maiden name?','Blue'),('ZMuK9q9U','X7xpuK34UB',1163,'What is your mother\'s maiden name?','Blue'),('zN16xmbp','gctzlH4H33',1089,'What is your favorite movie?','Blue'),('Zs9T4FJA','Is3vYpRy6J',1062,'What is the name of your first pet?','London'),('zTJRC25W','Trail',1065,'What is the name of your first pet?','Pizza');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wine`
--

DROP TABLE IF EXISTS `Wine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Wine` (
  `WineID` varchar(25) NOT NULL,
  `WineName` varchar(200) DEFAULT NULL,
  `Vintage` int DEFAULT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  `WineTypeID` varchar(25) NOT NULL,
  `WineryID` varchar(30) NOT NULL,
  `VarietyID` varchar(25) NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `ImageURL` text,
  `ABV` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`WineID`),
  KEY `WineFK1` (`WineTypeID`),
  KEY `WineFK2` (`WineryID`),
  KEY `WineFK3` (`VarietyID`),
  CONSTRAINT `WineFK1` FOREIGN KEY (`WineTypeID`) REFERENCES `WineType` (`WineTypeID`),
  CONSTRAINT `WineFK2` FOREIGN KEY (`WineryID`) REFERENCES `Winery` (`WineryID`),
  CONSTRAINT `WineFK3` FOREIGN KEY (`VarietyID`) REFERENCES `GrapeVariety` (`VarietyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wine`
--

LOCK TABLES `Wine` WRITE;
/*!40000 ALTER TABLE `Wine` DISABLE KEYS */;
INSERT INTO `Wine` VALUES ('WINE001','Barefoot Pinot Grigio',2020,'Barefoot Pinot Grigio is a refreshing and zesty white wine that will transport your taste buds to a sunny afternoon in California. This light-bodied wine features flavors of crisp green apple and citrus, with a tart and refreshing finish that is perfect for a warm day.','WT001','WINERY01','V09',949.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/barefoot_pinot_grigio_2_2_900x.jpg?v=1603743968',12.50),('WINE002','Caymus Cabernet Sauvignon',2005,'From the first pour, you will be greeted with a beautiful deep, rich red color that promises to be an experience for the senses. The nose offers a complex bouquet of dark fruits, with blackberry, cassis, and black cherry intermingling with subtle hints of vanilla and mocha.','WT004','WINERY02','V04',993.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/CaymusCabernetSauvignon2020b_900x.jpg?v=1682785999',14.60),('WINE003','Chateau d Esclans Whispering Angel Rose',2020,'With a reputation for excellence, Chateau d\'Esclans Whispering Angel Rose is a wine you can drink from mid-day to midnight. Its pleasing pale color and full, lush taste profile make it an excellent choice for any occasion. Enjoy a glass of this premium rose wine with your favorite foods or on its own, and experience the exquisite taste that has made Whispering Angel a worldwide reference for Provence Rose.','WT003','WINERY03','V02',316.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Chateau_d_Esclans_Whispering_Angel_Rose_2018_Bottle_1_900x.jpg?v=1672849818',13.00),('WINE004','Barefoot Moscato',2011,'Barefoot Moscato is a crisp and refreshing white wine that\'s perfect for any occasion. This blend boasts the delicious flavors of juicy peaches and ripe apricots, along with hints of citrus and lemon. It has a bright and crisp finish that leaves a lasting impression on your palate. Crafted with care, Barefoot Moscato has a low alcohol content, making it a great choice for light drinking. The wine\'s fruity and bright character pairs well with spicy Asian cuisine, artisanal cheeses, and light desserts.','WT001','WINERY01','V05',807.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/barefoot_moscato_2_900x.jpg?v=1603744478',8.50),('WINE005','Bogle Chardonnay',2021,'Pairing well with grilled fish, roasted chicken, fresh green salads, and soft, mild cheeses, the Bogle Chardonnay 2021 is a versatile wine that is perfect for any occasion. So, whether you are looking to impress your dinner guests or unwind after a long day, this wine is sure to please. Order your bottle today and experience the delightful taste of Bogle Chardonnay 2021 for yourself.','WT001','WINERY04','V01',484.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Bogle_Chardonnay_900x.jpg?v=1678221059',14.50),('WINE006','Apothic Red Blend',2021,'Apothic Red Blend Winemaker\'s Blend Wine 2021 is a bold and intriguing wine that masterfully blends together rich Zinfandel, smooth Merlot, flavorful Syrah, and Cabernet Sauvignon grapes. The resulting wine is complex, with layers of flavor that tantalize the senses. Notes of black cherry and dark red fruit are complemented by hints of vanilla and mocha, delivering a unique flavor experience.','WT007','WINERY05','V11',600.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Apothic_Red_Blend_Bottle_1_1_900x.jpg?v=1603744755',13.50),('WINE007','Barefoot White Zinfandel',2020,'Barefoot White Zinfandel is the perfect balance of fruity flavors, refreshing sweetness, and crisp acidity, making it an ideal choice for any occasion. The wine opens up with sun-kissed strawberry notes, followed by juicy pear, sweet pineapple, and ripe Georgia peach flavors, making for a delightful drinking experience.','WT006','WINERY02','V06',546.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Barefoot_White_Zinfandel_1_900x.jpg?v=1603744810',9.00),('WINE008','Emmolo Sauvignon Blanc',2022,'Emmolo Sauvignon Blanc Napa Valley 2022 isa wine that embodies the spirit of simplicity and balance. From the moment you pour a glass, you are met with fresh aromas of citrus and green apple. On the palate, the wine is dry, crisp, and refreshing, with flavors of grapefruit, lemon, and lime. The bright minerality adds complexity and depth to the wine, while the low alcohol and bright acidity make it an easy-drinking delight.','WT001','WINERY03','V03',731.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/EmmoloSauvignonBlancNapaValley2021b_900x.webp?v=1657551331',12.60),('WINE009','Apothic Inferno Red Blend',2019,'Apothic Inferno Red Wine Blend 2019 is a unique and bold wine that offers a rich and complex flavor profile. This limited release red blend is aged in whiskey barrels for 60 days, imparting a distinctive smoky flavor that sets it apart from other wines. The palate is smooth and rich, with notes of ripe red and dark fruit, like blackberry and plum, complemented by layers of maple, vanilla, and charred spice. The finish is long and clean, leaving behind a delightful aftertaste that lingers on the tongue.','WT002','WINERY05','V07',216.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Apothic_Inferno_Red_Blend_2017_bottle_1_900x.jpg?v=1605564155',15.90),('WINE010','Barefoot Merlot',2004,'Barefoot Merlot is a crowd-pleasing red wine with an approachable style that makes it a perfect choice for any occasion. This classic Merlot is bursting with flavors of juicy plum, cherry, boysenberry, and chocolate, creating a deliciously rich taste experience.','WT002','WINERY01','V05',288.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Barefoot_Merlot_2_2_900x.jpg?v=1603744905',13.00),('WINE011','Bogle Sauvignon Blanc',2021,'Experience the refreshing taste of Bogle Sauvignon Blanc 2021, crafted using classic winemaking techniques. On the nose, this wine exudes beautiful aromas of lime, boxwood, and freshly cut grass, providing a refreshing and invigorating experience. The palate is further enriched with delicious flavors of pineapple and passion fruit, culminating in a long, textured finish that leaves a pleasant aftertaste. The grapes are carefully selected and picked a touch early in the ripening season to preserve their crisp and vibrant character. The cold fermentation in stainless steel tanks and reductive winemaking process enhance the wine\'s natural acidity, resulting in a mouthwatering sensation on the palate.','WT004','WINERY04','V03',419.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Bogle_Sauvignon_Blanc_2019_bottle_1_900x.jpg?v=1603747705',13.00),('WINE012','Bogle Vineyards Petite Sirah',2020,'Bogle Vineyards Petite Sirah 2020 is a rich and luxurious wine that will tantalize your taste buds with its deep purple color and complex aromas. On the nose, you\'ll be greeted with the delightful scent of freshly baked berry cobbler, alongside hints of vanilla wafer and anise. On the palate, the wine offers a soft, supple entry that gives way to plush blue fruits, boysenberry, black plum, and nutmeg spice. The ripe, textured tannins are a testament to the wine\'s aging process of 12 months in American oak, which has softened them beautifully.','WT002','WINERY04','V08',399.00,'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Bogle_Vineyards_petite_sirah_2017_bottle_2_900x.png?v=1603915727',13.50);
/*!40000 ALTER TABLE `Wine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WineType`
--

DROP TABLE IF EXISTS `WineType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WineType` (
  `WineTypeID` varchar(25) NOT NULL,
  `WineType` varchar(30) NOT NULL,
  PRIMARY KEY (`WineTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WineType`
--

LOCK TABLES `WineType` WRITE;
/*!40000 ALTER TABLE `WineType` DISABLE KEYS */;
INSERT INTO `WineType` VALUES ('WT001','White Wine'),('WT002','Red Wine'),('WT003','Rosé Wine'),('WT004','Cabernet'),('WT005','Merlot'),('WT006','Zinfandel'),('WT007','Mix of Wines');
/*!40000 ALTER TABLE `WineType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Winery`
--

DROP TABLE IF EXISTS `Winery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Winery` (
  `WineryID` varchar(30) NOT NULL,
  `WineryName` varchar(30) NOT NULL,
  `RegionID` varchar(25) NOT NULL,
  `InventoryID` varchar(25) NOT NULL,
  PRIMARY KEY (`WineryID`),
  KEY `WineryFK1` (`RegionID`),
  KEY `WineryFK2` (`InventoryID`),
  CONSTRAINT `WineryFK1` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Winery`
--

LOCK TABLES `Winery` WRITE;
/*!40000 ALTER TABLE `Winery` DISABLE KEYS */;
INSERT INTO `Winery` VALUES ('WINERY01','Barefoot Wineyards','R001','INV001'),('WINERY02','Chateau d\'Esclans','R002','INV002'),('WINERY03','Caymus Wineyards','R003','INV003'),('WINERY04','Bogle Wine','R004','INV004'),('WINERY05','Apothic','R005','INV005');
/*!40000 ALTER TABLE `Winery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wishlist`
--

DROP TABLE IF EXISTS `Wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Wishlist` (
  `WishlistID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `WineID` varchar(25) DEFAULT NULL,
  `AddedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`WishlistID`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wishlist`
--

LOCK TABLES `Wishlist` WRITE;
/*!40000 ALTER TABLE `Wishlist` DISABLE KEYS */;
INSERT INTO `Wishlist` VALUES (1,1092,'WINE001','2023-05-11 21:18:51'),(2,1092,'WINE004','2023-05-11 21:18:56'),(3,1048,'WINE001','2022-02-05 15:25:12'),(4,1042,'WINE004','2019-03-23 19:37:28'),(5,1024,'WINE007','2023-01-17 18:37:06'),(6,1049,'WINE002','2023-04-05 06:10:29'),(7,1141,'WINE008','2019-12-29 16:58:38'),(8,1028,'WINE012','2021-05-12 06:52:54'),(9,1094,'WINE003','2020-06-14 02:07:31'),(10,1042,'WINE012','2019-03-09 12:34:41'),(11,1155,'WINE002','2021-08-09 04:08:31'),(12,1098,'WINE003','2023-04-13 05:54:32'),(13,1137,'WINE011','2021-09-14 05:36:47'),(14,1132,'WINE001','2021-01-05 20:07:25'),(15,1085,'WINE007','2019-09-28 03:18:52'),(16,1088,'WINE001','2019-05-18 21:28:15'),(17,1152,'WINE008','2021-04-09 23:41:45'),(18,1040,'WINE006','2018-10-06 02:45:02'),(19,1072,'WINE008','2023-01-30 10:17:51'),(20,1158,'WINE005','2022-06-14 22:51:03'),(21,1124,'WINE001','2021-10-25 11:55:27'),(22,1095,'WINE007','2022-11-04 08:54:45'),(23,1022,'WINE010','2019-06-27 01:00:05'),(24,1175,'WINE005','2021-11-25 02:29:53'),(25,1031,'WINE006','2020-07-09 04:21:47'),(26,1109,'WINE008','2018-10-17 13:33:27'),(27,1124,'WINE003','2021-05-25 17:30:07'),(28,1104,'WINE006','2020-06-16 01:53:48'),(29,1132,'WINE003','2021-09-07 13:06:27'),(30,1106,'WINE002','2021-04-12 13:08:36'),(31,1027,'WINE005','2019-02-01 03:37:40'),(32,1167,'WINE009','2021-09-23 14:58:25'),(33,1000,'WINE004','2022-11-01 06:00:07'),(34,1105,'WINE004','2020-11-03 03:09:03'),(35,1102,'WINE005','2019-04-07 11:13:42'),(36,1046,'WINE009','2018-10-14 15:38:49'),(37,1021,'WINE001','2020-05-01 09:41:08'),(38,1111,'WINE005','2020-03-02 14:46:11'),(39,1037,'WINE010','2022-10-11 15:51:30'),(40,1001,'WINE004','2018-07-26 11:32:24'),(41,1066,'WINE007','2020-11-05 04:54:30'),(42,1086,'WINE008','2020-12-21 16:07:38'),(43,1059,'WINE005','2019-09-28 06:27:24'),(44,1126,'WINE011','2020-07-20 17:45:39'),(45,1031,'WINE010','2019-06-20 06:28:59'),(46,1097,'WINE004','2020-03-15 03:54:03'),(47,1120,'WINE006','2019-07-23 22:31:27'),(48,1164,'WINE012','2022-10-22 15:26:42'),(49,1028,'WINE002','2018-09-21 15:59:08'),(50,1131,'WINE007','2021-07-05 09:00:47'),(51,1027,'WINE005','2022-10-22 15:18:45'),(52,1058,'WINE007','2019-02-22 23:34:34'),(53,1032,'WINE010','2021-05-14 07:37:33'),(54,1157,'WINE001','2020-05-03 17:38:05'),(55,1050,'WINE007','2022-01-26 04:47:48'),(56,1117,'WINE009','2019-05-12 07:06:19'),(57,1026,'WINE007','2022-09-27 00:04:03'),(58,1141,'WINE002','2020-07-07 21:38:12'),(59,1046,'WINE009','2021-07-31 11:05:47'),(60,1034,'WINE006','2018-08-01 16:02:52'),(61,1017,'WINE007','2019-06-30 16:22:44'),(62,1054,'WINE007','2020-10-06 05:31:44'),(63,1074,'WINE010','2022-07-21 01:43:07'),(64,1134,'WINE009','2023-03-23 08:16:47'),(65,1051,'WINE003','2019-07-19 19:48:34'),(66,1049,'WINE011','2022-06-18 01:00:11'),(67,1149,'WINE007','2020-07-18 08:09:58'),(68,1129,'WINE010','2022-01-05 03:14:22'),(69,1039,'WINE011','2021-06-14 02:36:58'),(70,1148,'WINE008','2020-04-10 08:18:30'),(71,1100,'WINE007','2018-09-10 09:46:15'),(72,1006,'WINE003','2020-05-06 17:42:48'),(73,1165,'WINE009','2023-03-26 01:44:53'),(74,1175,'WINE006','2020-12-26 09:29:33'),(75,1090,'WINE006','2022-08-27 16:24:28'),(76,1112,'WINE011','2021-12-17 12:27:07'),(77,1055,'WINE011','2018-08-13 03:55:12'),(78,1150,'WINE002','2018-08-20 09:52:33'),(79,1048,'WINE011','2020-12-27 04:27:22'),(80,1044,'WINE012','2021-12-29 15:32:58'),(81,1140,'WINE005','2020-01-29 06:38:13'),(82,1157,'WINE002','2022-01-04 05:02:04'),(83,1119,'WINE002','2019-10-23 20:04:31'),(84,1097,'WINE006','2019-05-02 14:02:07'),(85,1051,'WINE010','2023-02-24 12:56:37'),(86,1030,'WINE010','2019-04-07 20:25:11'),(87,1059,'WINE006','2018-06-18 16:44:19'),(88,1109,'WINE011','2018-07-10 22:48:56'),(89,1134,'WINE011','2018-12-10 09:26:04'),(90,1119,'WINE001','2021-12-15 02:25:59'),(91,1065,'WINE003','2020-07-18 03:59:34'),(92,1165,'WINE009','2021-12-30 05:00:39'),(93,1018,'WINE005','2020-09-02 05:14:13'),(94,1024,'WINE004','2019-07-10 01:51:15'),(95,1151,'WINE007','2018-09-29 03:46:37'),(97,1160,'WINE004','2020-06-01 12:25:32'),(98,1005,'WINE007','2019-07-27 13:51:09'),(99,1128,'WINE012','2018-06-07 07:37:27'),(100,1048,'WINE007','2019-04-27 17:01:20'),(101,1175,'WINE012','2019-01-22 04:30:41'),(102,1141,'WINE003','2022-07-30 15:52:12'),(103,1161,'WINE011','2021-04-25 20:19:48'),(104,1161,'WINE001','2020-02-01 18:16:59'),(105,1061,'WINE009','2022-10-26 08:14:59'),(106,1100,'WINE011','2018-08-01 17:43:41'),(107,1119,'WINE010','2018-11-12 13:01:48'),(108,1060,'WINE004','2018-07-01 14:35:10'),(109,1121,'WINE003','2019-07-26 17:31:42'),(110,1078,'WINE010','2023-01-11 04:03:28'),(111,1158,'WINE007','2019-01-17 06:50:18'),(112,1074,'WINE004','2021-06-18 07:05:46'),(113,1138,'WINE012','2019-10-24 03:16:28'),(114,1118,'WINE001','2018-07-25 15:54:27'),(115,1126,'WINE010','2021-07-22 19:07:08'),(116,1059,'WINE011','2020-12-28 11:46:50'),(117,1147,'WINE003','2022-12-08 00:13:26'),(118,1079,'WINE011','2021-11-26 11:56:05'),(119,1175,'WINE003','2022-06-02 20:27:48'),(120,1142,'WINE007','2020-05-08 02:24:30'),(121,1045,'WINE008','2020-08-11 06:08:50'),(122,1080,'WINE012','2020-10-21 15:36:07'),(123,1092,'WINE002','2021-12-24 18:31:15'),(124,1143,'WINE012','2018-07-18 11:49:39'),(125,1131,'WINE005','2020-07-10 07:34:53'),(126,1069,'WINE007','2018-06-07 00:20:15'),(127,1106,'WINE012','2018-10-20 11:24:30'),(128,1023,'WINE008','2020-12-22 02:28:46'),(129,1024,'WINE012','2019-03-03 17:16:00'),(130,1037,'WINE001','2020-05-16 06:51:43'),(131,1084,'WINE007','2022-02-28 05:26:25'),(132,1018,'WINE003','2018-07-17 07:06:22'),(133,1103,'WINE001','2022-02-22 14:30:03'),(134,1097,'WINE002','2022-11-12 02:28:32'),(135,1052,'WINE006','2019-08-21 14:30:11'),(137,1118,'WINE004','2020-06-15 07:52:35'),(138,1164,'WINE012','2019-08-29 06:39:29'),(139,1002,'WINE006','2022-10-21 09:55:40'),(140,1112,'WINE001','2021-08-31 00:03:15'),(141,1139,'WINE012','2019-04-13 01:29:07'),(142,1097,'WINE002','2019-12-27 21:23:23'),(143,1090,'WINE008','2021-12-14 13:05:06'),(144,1105,'WINE001','2019-04-06 23:44:58'),(145,1071,'WINE001','2019-06-13 08:49:40'),(146,1170,'WINE012','2023-02-19 17:11:21'),(147,1164,'WINE008','2019-12-13 14:54:13'),(148,1129,'WINE010','2021-06-10 02:10:54'),(149,1160,'WINE002','2021-11-10 05:14:22'),(150,1053,'WINE002','2018-12-01 01:33:59'),(155,1003,'WINE004','2023-05-15 17:02:00'),(156,1003,'WINE001','2023-05-15 17:21:51'),(158,1003,'WINE003','2023-05-16 18:20:58'),(159,1003,'WINE002','2023-05-19 15:44:04');
/*!40000 ALTER TABLE `Wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customization`
--

DROP TABLE IF EXISTS `customization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customization` (
  `pers_id` varchar(10) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `bottle_name` varchar(1000) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`pers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customization`
--

LOCK TABLES `customization` WRITE;
/*!40000 ALTER TABLE `customization` DISABLE KEYS */;
INSERT INTO `customization` VALUES ('PERS001','cust_bottle1.png','Wild Birthday!',24.99),('PERS002','cust_bottle2.png','Symbol of remembrance!',20.45),('PERS003','cust_bottle3.png','Iconic Black!',29.99),('PERS004','cust_bottle4.png','Celebrate together!',19.99),('PERS005','cust_bottle5.png','Graduation YAYY!',23);
/*!40000 ALTER TABLE `customization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `r_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_details` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `CustomerID` int NOT NULL,
  `winery_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`r_id`),
  KEY `CustomerID_FK1` (`CustomerID`),
  CONSTRAINT `CustomerID_FK1` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES ('134371','Emma','98479583','12:00','2023-05-18',1001,'Bogle Wine');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `bossbunch_wh`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `bossbunch_wh` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `bossbunch_wh`;

--
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `SecurityQuestion` varchar(255) NOT NULL,
  `SecurityAnswer` varchar(255) NOT NULL,
  `EmployeeID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Username`),
  KEY `fk_Admin_EmployeeID` (`EmployeeID`),
  CONSTRAINT `fk_Admin_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `Employee` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES ('admin1','password1','What is your favorite color?','blue','EMP01'),('admin10','password10','What is your favorite book?','To Kill a Mockingbird','EMP10'),('admin2','password2','What is your pet\'s name?','fluffy','EMP02'),('admin3','password3','What is your mother\'s maiden name?','Smith','EMP03'),('admin4','password4','What is the name of the street you grew up on?','Maple','EMP04'),('admin5','password5','What is your favorite food?','pizza','EMP05'),('admin6','password6','What is your favorite hobby?','reading','EMP06'),('admin7','password7','What is your favorite animal?','cat','EMP07'),('admin8','password8','What is your favorite movie?','Star Wars','EMP08'),('admin9','password9','What is your favorite song?','Bohemian Rhapsody','EMP09');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AnalysisPerCaME`
--

DROP TABLE IF EXISTS `AnalysisPerCaME`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AnalysisPerCaME` (
  `TotalCost` float NOT NULL,
  `CalendarKey` int NOT NULL,
  `EventKey` int NOT NULL,
  `EmployeeKey` int NOT NULL,
  PRIMARY KEY (`CalendarKey`,`EventKey`,`EmployeeKey`),
  KEY `EventKey` (`EventKey`),
  KEY `EmployeeKey` (`EmployeeKey`),
  CONSTRAINT `AnalysisPerCaME_ibfk_1` FOREIGN KEY (`CalendarKey`) REFERENCES `Calendar` (`CalendarKey`),
  CONSTRAINT `AnalysisPerCaME_ibfk_2` FOREIGN KEY (`EventKey`) REFERENCES `MarketingEvent` (`EventKey`),
  CONSTRAINT `AnalysisPerCaME_ibfk_3` FOREIGN KEY (`EmployeeKey`) REFERENCES `Employee` (`EmployeeKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AnalysisPerCaME`
--

LOCK TABLES `AnalysisPerCaME` WRITE;
/*!40000 ALTER TABLE `AnalysisPerCaME` DISABLE KEYS */;
/*!40000 ALTER TABLE `AnalysisPerCaME` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AnalysisPerCuWyS`
--

DROP TABLE IF EXISTS `AnalysisPerCuWyS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AnalysisPerCuWyS` (
  `SalesAmount` decimal(10,2) NOT NULL,
  `CustomerKey` int NOT NULL,
  `WineryKey` int NOT NULL,
  `ShippingKey` int NOT NULL,
  `OrdersKey` int NOT NULL,
  KEY `AnalysisPerCuWyS_ibfk_2` (`WineryKey`),
  KEY `AnalysisPerCuWyS_ibfk_3` (`ShippingKey`),
  KEY `AnalysisPerCuWyS_ibfk_4` (`OrdersKey`),
  CONSTRAINT `AnalysisPerCuWyS_ibfk_2` FOREIGN KEY (`WineryKey`) REFERENCES `Winery` (`WineryKey`),
  CONSTRAINT `AnalysisPerCuWyS_ibfk_3` FOREIGN KEY (`ShippingKey`) REFERENCES `Shipping` (`ShippingKey`),
  CONSTRAINT `AnalysisPerCuWyS_ibfk_4` FOREIGN KEY (`OrdersKey`) REFERENCES `Orders` (`OrdersKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AnalysisPerCuWyS`
--

LOCK TABLES `AnalysisPerCuWyS` WRITE;
/*!40000 ALTER TABLE `AnalysisPerCuWyS` DISABLE KEYS */;
INSERT INTO `AnalysisPerCuWyS` VALUES (703.70,100,1,1,9000),(615.94,101,2,2,9001),(653.99,102,3,3,9006),(795.61,103,4,4,9016),(843.66,104,5,5,9023),(531.23,105,6,6,9026),(981.54,106,7,7,9028),(478.58,107,8,8,9030),(215.82,108,9,9,9041),(763.68,109,10,10,9060),(893.45,110,11,1,9063),(417.13,111,12,2,9066),(359.40,112,1,3,9072),(783.26,113,2,4,9083),(990.06,114,3,5,9088),(350.87,115,4,6,9092),(385.28,116,5,7,9096),(807.39,117,6,8,9097),(268.97,118,7,9,9098),(595.92,119,8,10,9103),(706.03,120,9,1,9106),(120.21,121,10,2,9114),(272.57,122,11,3,9122),(369.62,123,12,4,9128),(311.66,124,1,5,9129),(891.40,125,2,6,9132),(301.27,126,3,7,9158),(661.14,127,4,8,9168),(852.37,128,5,9,9172),(383.75,129,6,10,9198),(723.78,130,7,1,9201),(106.31,131,8,1,9205),(874.27,132,9,2,9207),(366.00,133,10,3,9208),(283.34,134,11,4,9210),(971.05,135,12,5,9212),(477.62,136,1,6,9253),(512.01,137,2,7,9255),(291.92,138,3,8,9260),(634.54,139,4,9,9266),(868.02,140,5,10,9267),(394.32,141,6,1,9270),(970.80,142,7,2,9271),(262.46,143,8,3,9272),(641.54,144,9,4,9280),(169.71,145,10,5,9286),(987.21,146,11,6,9287),(711.90,147,12,7,9297),(443.10,148,1,8,9305),(949.77,149,2,9,9306),(852.54,150,3,10,9307),(753.33,151,4,1,9316),(464.18,152,5,2,9317),(509.75,153,6,3,9318),(338.59,154,7,4,9320),(539.22,155,8,5,9339),(573.16,156,9,6,9342),(742.34,157,10,7,9345),(826.33,158,11,8,9363),(408.04,159,12,9,9370),(303.03,160,1,10,9371),(904.52,161,2,1,9376),(942.20,162,3,2,9379),(223.97,163,4,3,9383),(161.03,164,5,4,9389),(536.96,165,6,5,9390),(225.16,166,7,6,9392),(959.09,167,8,7,9399),(643.21,168,9,8,9405),(559.55,169,10,9,9412),(949.52,170,11,10,9424),(493.21,171,12,1,9425),(247.43,172,1,2,9433),(252.59,173,2,3,9459),(834.49,174,3,4,9464),(283.24,175,4,5,9466),(782.28,176,5,6,9473),(396.79,177,6,7,9478),(295.28,178,7,8,9493),(807.77,179,8,9,9495),(841.74,180,9,10,9510),(963.79,181,10,1,9513),(567.26,182,11,2,9531),(956.63,183,12,3,9532),(331.98,184,1,4,9533),(383.02,185,2,5,9540),(351.56,186,3,6,9547),(779.85,187,4,7,9549),(823.25,188,5,8,9551),(406.20,189,6,9,9553),(215.81,190,7,10,9561),(883.42,191,8,1,9576),(621.19,192,9,2,9577),(926.70,193,10,3,9586),(187.94,194,11,4,9590),(598.38,195,12,5,9595),(463.15,196,1,6,9598),(774.50,197,2,7,9614),(190.71,198,3,8,9615);
/*!40000 ALTER TABLE `AnalysisPerCuWyS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AnalysisPerWF`
--

DROP TABLE IF EXISTS `AnalysisPerWF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AnalysisPerWF` (
  `RatingCount` int NOT NULL,
  `WineKey` int NOT NULL,
  `FeedbackKey` int NOT NULL,
  KEY `WineKey` (`WineKey`),
  KEY `FeedbackKey` (`FeedbackKey`),
  CONSTRAINT `AnalysisPerWF_ibfk_1` FOREIGN KEY (`WineKey`) REFERENCES `Wine` (`WineKey`),
  CONSTRAINT `AnalysisPerWF_ibfk_2` FOREIGN KEY (`FeedbackKey`) REFERENCES `Feedback` (`FeedbackKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AnalysisPerWF`
--

LOCK TABLES `AnalysisPerWF` WRITE;
/*!40000 ALTER TABLE `AnalysisPerWF` DISABLE KEYS */;
INSERT INTO `AnalysisPerWF` VALUES (1,1,4),(1,1,5),(1,1,6),(1,1,7),(1,1,8),(1,1,9),(1,1,10),(1,1,11),(1,1,12),(1,1,13),(1,1,14),(1,2,15),(1,2,16),(1,2,17),(2,2,18),(2,2,19),(2,2,20),(2,2,21),(2,2,22),(2,2,23),(2,3,24),(2,3,25),(2,3,26),(2,3,27),(2,3,28),(2,3,29),(2,3,30),(2,3,31),(2,3,32),(2,4,33),(2,4,34),(3,4,35),(3,4,36),(3,4,37),(3,4,38),(3,4,39),(3,4,40),(3,4,41),(3,4,42),(3,4,43),(3,5,44),(3,5,45),(3,5,46),(3,5,47),(3,5,48),(3,5,49),(3,5,50),(3,5,51),(3,5,52),(3,5,53),(3,5,54),(3,6,55),(3,6,56),(3,6,57),(3,6,58),(3,6,59),(3,6,60),(3,6,61),(3,6,62),(4,6,63),(4,6,64),(4,6,65),(4,7,66),(4,7,67),(4,7,68),(4,7,69),(4,7,70),(4,7,71),(4,7,72),(4,7,73),(4,7,74),(4,7,75),(4,7,76),(4,8,77),(4,8,78),(4,8,79),(4,8,80),(4,8,81),(4,8,82),(4,8,83),(4,8,84),(4,9,85),(4,9,86),(4,9,87),(5,10,88),(5,10,89),(5,10,90),(5,11,91),(5,11,92),(5,11,93),(5,11,94),(5,11,95),(5,12,96),(5,12,97),(5,12,98),(5,12,99),(5,12,100),(5,12,101),(5,12,102);
/*!40000 ALTER TABLE `AnalysisPerWF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AnalysisPerWiCaFI`
--

DROP TABLE IF EXISTS `AnalysisPerWiCaFI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AnalysisPerWiCaFI` (
  `WishlistKey` int DEFAULT NULL,
  `StockSupplies` int NOT NULL,
  `InventoryKey` int NOT NULL,
  `CartKey` int NOT NULL,
  `FeedbackKey` int NOT NULL,
  KEY `WishlistKey` (`WishlistKey`),
  KEY `InventoryKey` (`InventoryKey`),
  KEY `CartKey` (`CartKey`),
  KEY `FeedbackKey` (`FeedbackKey`),
  CONSTRAINT `AnalysisPerWiCaFI_ibfk_1` FOREIGN KEY (`WishlistKey`) REFERENCES `Wishlist` (`WishlistKey`),
  CONSTRAINT `AnalysisPerWiCaFI_ibfk_2` FOREIGN KEY (`InventoryKey`) REFERENCES `Inventory` (`InventoryKey`),
  CONSTRAINT `AnalysisPerWiCaFI_ibfk_3` FOREIGN KEY (`CartKey`) REFERENCES `Cart` (`CartKey`),
  CONSTRAINT `AnalysisPerWiCaFI_ibfk_4` FOREIGN KEY (`FeedbackKey`) REFERENCES `Feedback` (`FeedbackKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AnalysisPerWiCaFI`
--

LOCK TABLES `AnalysisPerWiCaFI` WRITE;
/*!40000 ALTER TABLE `AnalysisPerWiCaFI` DISABLE KEYS */;
/*!40000 ALTER TABLE `AnalysisPerWiCaFI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Calendar`
--

DROP TABLE IF EXISTS `Calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Calendar` (
  `CalendarKey` int NOT NULL AUTO_INCREMENT,
  `FullDate` date DEFAULT NULL,
  `DayOfMonth` int DEFAULT NULL,
  `DayOfWeek` varchar(55) DEFAULT NULL,
  `CustomTimestamp` timestamp NULL DEFAULT NULL,
  `Month` varchar(55) DEFAULT NULL,
  `Quarter` varchar(55) DEFAULT NULL,
  `Year` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`CalendarKey`)
) ENGINE=InnoDB AUTO_INCREMENT=777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Calendar`
--

LOCK TABLES `Calendar` WRITE;
/*!40000 ALTER TABLE `Calendar` DISABLE KEYS */;
INSERT INTO `Calendar` VALUES (1,'2023-03-15',15,'Wednesday','2023-03-15 07:00:00','March','Q1','2023'),(2,'2023-04-01',1,'Saturday','2023-04-01 07:00:00','April','Q2','2023'),(3,'2023-05-10',10,'Wednesday','2023-05-10 07:00:00','May','Q2','2023'),(4,'2023-06-30',30,'Friday','2023-06-30 07:00:00','June','Q2','2023'),(5,'2023-07-20',20,'Thursday','2023-07-20 07:00:00','July','Q3','2023'),(6,'2023-08-15',15,'Tuesday','2023-08-15 07:00:00','August','Q3','2023'),(7,'2023-09-01',1,'Friday','2023-09-01 07:00:00','September','Q3','2023'),(8,'2023-10-10',10,'Tuesday','2023-10-10 07:00:00','October','Q4','2023'),(9,'2023-11-30',30,'Thursday','2023-11-30 08:00:00','November','Q4','2023'),(10,'2023-12-20',20,'Wednesday','2023-12-20 08:00:00','December','Q4','2023'),(11,'2023-05-05',5,'Friday','2023-05-05 07:00:00','May','Q2','2023'),(12,'2023-05-06',6,'Saturday','2023-05-06 07:00:00','May','Q2','2023'),(13,'2022-05-14',14,'Saturday','2022-05-14 07:00:00','May','Q2','2022'),(14,'2022-11-20',20,'Sunday','2022-11-20 08:00:00','November','Q4','2022'),(15,'2022-11-09',9,'Wednesday','2022-11-09 08:00:00','November','Q4','2022'),(16,'2022-08-06',6,'Saturday','2022-08-06 07:00:00','August','Q3','2022'),(17,'2022-07-18',18,'Monday','2022-07-18 07:00:00','July','Q3','2022'),(18,'2022-11-03',3,'Thursday','2022-11-03 07:00:00','November','Q4','2022'),(19,'2022-08-30',30,'Tuesday','2022-08-30 07:00:00','August','Q3','2022'),(20,'2022-10-10',10,'Monday','2022-10-10 07:00:00','October','Q4','2022'),(21,'2022-07-25',25,'Monday','2022-07-25 07:00:00','July','Q3','2022'),(22,'2022-07-26',26,'Tuesday','2022-07-26 07:00:00','July','Q3','2022'),(23,'2023-03-25',25,'Saturday','2023-03-25 07:00:00','March','Q1','2023'),(24,'2023-01-15',15,'Sunday','2023-01-15 08:00:00','January','Q1','2023'),(25,'2022-07-24',24,'Sunday','2022-07-24 07:00:00','July','Q3','2022'),(26,'2022-10-24',24,'Monday','2022-10-24 07:00:00','October','Q4','2022'),(27,'2022-10-21',21,'Friday','2022-10-21 07:00:00','October','Q4','2022'),(28,'2022-12-12',12,'Monday','2022-12-12 08:00:00','December','Q4','2022'),(29,'2022-10-13',13,'Thursday','2022-10-13 07:00:00','October','Q4','2022'),(30,'2022-05-29',29,'Sunday','2022-05-29 07:00:00','May','Q2','2022'),(31,'2022-08-17',17,'Wednesday','2022-08-17 07:00:00','August','Q3','2022'),(32,'2022-09-23',23,'Friday','2022-09-23 07:00:00','September','Q3','2022'),(33,'2023-02-24',24,'Friday','2023-02-24 08:00:00','February','Q1','2023'),(34,'2022-09-21',21,'Wednesday','2022-09-21 07:00:00','September','Q3','2022'),(35,'2023-03-09',9,'Thursday','2023-03-09 08:00:00','March','Q1','2023'),(36,'2023-03-18',18,'Saturday','2023-03-18 07:00:00','March','Q1','2023'),(37,'2022-10-14',14,'Friday','2022-10-14 07:00:00','October','Q4','2022'),(38,'2022-05-30',30,'Monday','2022-05-30 07:00:00','May','Q2','2022'),(39,'2023-01-31',31,'Tuesday','2023-01-31 08:00:00','January','Q1','2023'),(40,'2022-08-05',5,'Friday','2022-08-05 07:00:00','August','Q3','2022'),(41,'2022-09-06',6,'Tuesday','2022-09-06 07:00:00','September','Q3','2022'),(42,'2022-12-08',8,'Thursday','2022-12-08 08:00:00','December','Q4','2022'),(43,'2022-09-12',12,'Monday','2022-09-12 07:00:00','September','Q3','2022'),(44,'2023-03-19',19,'Sunday','2023-03-19 07:00:00','March','Q1','2023'),(45,'2022-12-25',25,'Sunday','2022-12-25 08:00:00','December','Q4','2022'),(46,'2022-10-06',6,'Thursday','2022-10-06 07:00:00','October','Q4','2022'),(47,'2022-12-15',15,'Thursday','2022-12-15 08:00:00','December','Q4','2022'),(48,'2022-09-09',9,'Friday','2022-09-09 07:00:00','September','Q3','2022'),(49,'2023-03-30',30,'Thursday','2023-03-30 07:00:00','March','Q1','2023'),(50,'2022-06-27',27,'Monday','2022-06-27 07:00:00','June','Q2','2022'),(51,'2022-07-29',29,'Friday','2022-07-29 07:00:00','July','Q3','2022'),(52,'2022-09-25',25,'Sunday','2022-09-25 07:00:00','September','Q3','2022'),(53,'2023-02-25',25,'Saturday','2023-02-25 08:00:00','February','Q1','2023'),(54,'2023-02-07',7,'Tuesday','2023-02-07 08:00:00','February','Q1','2023'),(55,'2022-07-11',11,'Monday','2022-07-11 07:00:00','July','Q3','2022'),(56,'2022-06-02',2,'Thursday','2022-06-02 07:00:00','June','Q2','2022'),(57,'2022-06-20',20,'Monday','2022-06-20 07:00:00','June','Q2','2022'),(58,'2023-01-13',13,'Friday','2023-01-13 08:00:00','January','Q1','2023'),(59,'2023-04-05',5,'Wednesday','2023-04-05 07:00:00','April','Q2','2023'),(60,'2023-03-03',3,'Friday','2023-03-03 08:00:00','March','Q1','2023'),(61,'2023-04-25',25,'Tuesday','2023-04-25 07:00:00','April','Q2','2023'),(62,'2023-01-16',16,'Monday','2023-01-16 08:00:00','January','Q1','2023'),(63,'2022-07-04',4,'Monday','2022-07-04 07:00:00','July','Q3','2022'),(64,'2022-06-24',24,'Friday','2022-06-24 07:00:00','June','Q2','2022'),(65,'2023-03-13',13,'Monday','2023-03-13 07:00:00','March','Q1','2023'),(66,'2022-06-19',19,'Sunday','2022-06-19 07:00:00','June','Q2','2022'),(67,'2023-04-03',3,'Monday','2023-04-03 07:00:00','April','Q2','2023'),(68,'2022-10-20',20,'Thursday','2022-10-20 07:00:00','October','Q4','2022'),(69,'2022-08-02',2,'Tuesday','2022-08-02 07:00:00','August','Q3','2022'),(70,'2022-08-12',12,'Friday','2022-08-12 07:00:00','August','Q3','2022'),(71,'2022-08-26',26,'Friday','2022-08-26 07:00:00','August','Q3','2022'),(72,'2022-10-30',30,'Sunday','2022-10-30 07:00:00','October','Q4','2022'),(73,'2022-11-26',26,'Saturday','2022-11-26 08:00:00','November','Q4','2022'),(74,'2023-02-14',14,'Tuesday','2023-02-14 08:00:00','February','Q1','2023'),(75,'2022-09-15',15,'Thursday','2022-09-15 07:00:00','September','Q3','2022'),(76,'2023-01-24',24,'Tuesday','2023-01-24 08:00:00','January','Q1','2023'),(77,'2022-05-05',5,'Thursday','2022-05-05 07:00:00','May','Q2','2022'),(78,'2022-11-01',1,'Tuesday','2022-11-01 07:00:00','November','Q4','2022'),(79,'2022-05-12',12,'Thursday','2022-05-12 07:00:00','May','Q2','2022'),(80,'2022-07-16',16,'Saturday','2022-07-16 07:00:00','July','Q3','2022'),(81,'2023-05-11',11,'Thursday','2023-05-11 07:00:00','May','Q2','2023'),(82,'2022-09-19',19,'Monday','2022-09-19 07:00:00','September','Q3','2022'),(83,'2023-05-12',12,'Friday','2023-05-12 07:00:00','May','Q2','2023'),(84,'2023-03-11',11,'Saturday','2023-03-11 08:00:00','March','Q1','2023'),(85,'2022-10-17',17,'Monday','2022-10-17 07:00:00','October','Q4','2022'),(86,'2023-04-24',24,'Monday','2023-04-24 07:00:00','April','Q2','2023'),(87,'2023-04-29',29,'Saturday','2023-04-29 07:00:00','April','Q2','2023'),(88,'2022-10-15',15,'Saturday','2022-10-15 07:00:00','October','Q4','2022'),(89,'2022-10-27',27,'Thursday','2022-10-27 07:00:00','October','Q4','2022'),(90,'2022-12-18',18,'Sunday','2022-12-18 08:00:00','December','Q4','2022'),(91,'2022-09-26',26,'Monday','2022-09-26 07:00:00','September','Q3','2022'),(92,'2023-03-27',27,'Monday','2023-03-27 07:00:00','March','Q1','2023'),(93,'2022-07-27',27,'Wednesday','2022-07-27 07:00:00','July','Q3','2022'),(94,'2022-07-21',21,'Thursday','2022-07-21 07:00:00','July','Q3','2022'),(95,'2022-08-01',1,'Monday','2022-08-01 07:00:00','August','Q3','2022'),(96,'2022-11-23',23,'Wednesday','2022-11-23 08:00:00','November','Q4','2022'),(97,'2022-12-20',20,'Tuesday','2022-12-20 08:00:00','December','Q4','2022'),(98,'2022-07-14',14,'Thursday','2022-07-14 07:00:00','July','Q3','2022'),(99,'2023-04-09',9,'Sunday','2023-04-09 07:00:00','April','Q2','2023'),(100,'2022-12-30',30,'Friday','2022-12-30 08:00:00','December','Q4','2022'),(101,'2022-11-22',22,'Tuesday','2022-11-22 08:00:00','November','Q4','2022'),(102,'2023-03-20',20,'Monday','2023-03-20 07:00:00','March','Q1','2023'),(103,'2022-08-19',19,'Friday','2022-08-19 07:00:00','August','Q3','2022'),(104,'2022-05-04',4,'Wednesday','2022-05-04 07:00:00','May','Q2','2022'),(105,'2023-02-08',8,'Wednesday','2023-02-08 08:00:00','February','Q1','2023'),(106,'2022-08-29',29,'Monday','2022-08-29 07:00:00','August','Q3','2022'),(107,'2022-06-13',13,'Monday','2022-06-13 07:00:00','June','Q2','2022'),(108,'2023-01-20',20,'Friday','2023-01-20 08:00:00','January','Q1','2023'),(109,'2022-07-20',20,'Wednesday','2022-07-20 07:00:00','July','Q3','2022'),(110,'2023-02-27',27,'Monday','2023-02-27 08:00:00','February','Q1','2023'),(111,'2022-07-08',8,'Friday','2022-07-08 07:00:00','July','Q3','2022'),(112,'2022-05-25',25,'Wednesday','2022-05-25 07:00:00','May','Q2','2022'),(113,'2022-11-06',6,'Sunday','2022-11-06 07:00:00','November','Q4','2022'),(114,'2023-01-01',1,'Sunday','2023-01-01 08:00:00','January','Q1','2023'),(115,'2022-05-06',6,'Friday','2022-05-06 07:00:00','May','Q2','2022'),(116,'2022-08-15',15,'Monday','2022-08-15 07:00:00','August','Q3','2022'),(117,'2022-11-05',5,'Saturday','2022-11-05 07:00:00','November','Q4','2022'),(118,'2022-11-11',11,'Friday','2022-11-11 08:00:00','November','Q4','2022'),(119,'2022-10-18',18,'Tuesday','2022-10-18 07:00:00','October','Q4','2022'),(120,'2023-03-05',5,'Sunday','2023-03-05 08:00:00','March','Q1','2023'),(121,'2023-01-29',29,'Sunday','2023-01-29 08:00:00','January','Q1','2023'),(122,'2023-03-22',22,'Wednesday','2023-03-22 07:00:00','March','Q1','2023'),(123,'2022-09-01',1,'Thursday','2022-09-01 07:00:00','September','Q3','2022'),(124,'2023-04-04',4,'Tuesday','2023-04-04 07:00:00','April','Q2','2023'),(125,'2023-04-01',1,'Saturday','2023-04-01 07:00:00','April','Q2','2023'),(126,'2023-03-21',21,'Tuesday','2023-03-21 07:00:00','March','Q1','2023'),(127,'2022-10-02',2,'Sunday','2022-10-02 07:00:00','October','Q4','2022'),(128,'2022-07-06',6,'Wednesday','2022-07-06 07:00:00','July','Q3','2022'),(129,'2022-11-02',2,'Wednesday','2022-11-02 07:00:00','November','Q4','2022'),(130,'2022-09-08',8,'Thursday','2022-09-08 07:00:00','September','Q3','2022'),(131,'2022-11-16',16,'Wednesday','2022-11-16 08:00:00','November','Q4','2022'),(132,'2022-12-19',19,'Monday','2022-12-19 08:00:00','December','Q4','2022'),(133,'2022-11-15',15,'Tuesday','2022-11-15 08:00:00','November','Q4','2022'),(134,'2023-03-01',1,'Wednesday','2023-03-01 08:00:00','March','Q1','2023'),(135,'2023-03-06',6,'Monday','2023-03-06 08:00:00','March','Q1','2023'),(136,'2022-11-28',28,'Monday','2022-11-28 08:00:00','November','Q4','2022'),(137,'2022-11-14',14,'Monday','2022-11-14 08:00:00','November','Q4','2022'),(138,'2022-09-11',11,'Sunday','2022-09-11 07:00:00','September','Q3','2022'),(139,'2022-11-18',18,'Friday','2022-11-18 08:00:00','November','Q4','2022'),(140,'2022-07-31',31,'Sunday','2022-07-31 07:00:00','July','Q3','2022'),(141,'2022-08-22',22,'Monday','2022-08-22 07:00:00','August','Q3','2022'),(142,'2022-12-27',27,'Tuesday','2022-12-27 08:00:00','December','Q4','2022'),(143,'2022-10-09',9,'Sunday','2022-10-09 07:00:00','October','Q4','2022'),(144,'2022-07-12',12,'Tuesday','2022-07-12 07:00:00','July','Q3','2022'),(145,'2023-02-06',6,'Monday','2023-02-06 08:00:00','February','Q1','2023'),(146,'2023-04-20',20,'Thursday','2023-04-20 07:00:00','April','Q2','2023'),(266,'2023-05-05',5,'Friday','2023-05-05 07:00:00','May','Q2','2023'),(267,'2023-05-06',6,'Saturday','2023-05-06 07:00:00','May','Q2','2023'),(268,'2022-05-14',14,'Saturday','2022-05-14 07:00:00','May','Q2','2022'),(269,'2022-11-20',20,'Sunday','2022-11-20 08:00:00','November','Q4','2022'),(270,'2022-11-09',9,'Wednesday','2022-11-09 08:00:00','November','Q4','2022'),(271,'2022-08-06',6,'Saturday','2022-08-06 07:00:00','August','Q3','2022'),(272,'2022-07-18',18,'Monday','2022-07-18 07:00:00','July','Q3','2022'),(273,'2022-11-03',3,'Thursday','2022-11-03 07:00:00','November','Q4','2022'),(274,'2022-08-30',30,'Tuesday','2022-08-30 07:00:00','August','Q3','2022'),(275,'2022-10-10',10,'Monday','2022-10-10 07:00:00','October','Q4','2022'),(276,'2022-07-25',25,'Monday','2022-07-25 07:00:00','July','Q3','2022'),(277,'2022-07-26',26,'Tuesday','2022-07-26 07:00:00','July','Q3','2022'),(278,'2023-03-25',25,'Saturday','2023-03-25 07:00:00','March','Q1','2023'),(279,'2023-01-15',15,'Sunday','2023-01-15 08:00:00','January','Q1','2023'),(280,'2022-07-24',24,'Sunday','2022-07-24 07:00:00','July','Q3','2022'),(281,'2022-10-24',24,'Monday','2022-10-24 07:00:00','October','Q4','2022'),(282,'2022-10-21',21,'Friday','2022-10-21 07:00:00','October','Q4','2022'),(283,'2022-12-12',12,'Monday','2022-12-12 08:00:00','December','Q4','2022'),(284,'2022-10-13',13,'Thursday','2022-10-13 07:00:00','October','Q4','2022'),(285,'2022-05-29',29,'Sunday','2022-05-29 07:00:00','May','Q2','2022'),(286,'2022-08-17',17,'Wednesday','2022-08-17 07:00:00','August','Q3','2022'),(287,'2022-09-23',23,'Friday','2022-09-23 07:00:00','September','Q3','2022'),(288,'2023-02-24',24,'Friday','2023-02-24 08:00:00','February','Q1','2023'),(289,'2022-09-21',21,'Wednesday','2022-09-21 07:00:00','September','Q3','2022'),(290,'2023-03-09',9,'Thursday','2023-03-09 08:00:00','March','Q1','2023'),(291,'2023-03-18',18,'Saturday','2023-03-18 07:00:00','March','Q1','2023'),(292,'2022-10-14',14,'Friday','2022-10-14 07:00:00','October','Q4','2022'),(293,'2022-05-30',30,'Monday','2022-05-30 07:00:00','May','Q2','2022'),(294,'2023-01-31',31,'Tuesday','2023-01-31 08:00:00','January','Q1','2023'),(295,'2022-08-05',5,'Friday','2022-08-05 07:00:00','August','Q3','2022'),(296,'2022-09-06',6,'Tuesday','2022-09-06 07:00:00','September','Q3','2022'),(297,'2022-12-08',8,'Thursday','2022-12-08 08:00:00','December','Q4','2022'),(298,'2022-09-12',12,'Monday','2022-09-12 07:00:00','September','Q3','2022'),(299,'2023-03-19',19,'Sunday','2023-03-19 07:00:00','March','Q1','2023'),(300,'2022-12-25',25,'Sunday','2022-12-25 08:00:00','December','Q4','2022'),(301,'2022-10-06',6,'Thursday','2022-10-06 07:00:00','October','Q4','2022'),(302,'2022-12-15',15,'Thursday','2022-12-15 08:00:00','December','Q4','2022'),(303,'2022-09-09',9,'Friday','2022-09-09 07:00:00','September','Q3','2022'),(304,'2023-03-30',30,'Thursday','2023-03-30 07:00:00','March','Q1','2023'),(305,'2022-06-27',27,'Monday','2022-06-27 07:00:00','June','Q2','2022'),(306,'2022-07-29',29,'Friday','2022-07-29 07:00:00','July','Q3','2022'),(307,'2022-09-25',25,'Sunday','2022-09-25 07:00:00','September','Q3','2022'),(308,'2023-02-25',25,'Saturday','2023-02-25 08:00:00','February','Q1','2023'),(309,'2023-02-07',7,'Tuesday','2023-02-07 08:00:00','February','Q1','2023'),(310,'2022-07-11',11,'Monday','2022-07-11 07:00:00','July','Q3','2022'),(311,'2022-06-02',2,'Thursday','2022-06-02 07:00:00','June','Q2','2022'),(312,'2022-06-20',20,'Monday','2022-06-20 07:00:00','June','Q2','2022'),(313,'2023-01-13',13,'Friday','2023-01-13 08:00:00','January','Q1','2023'),(314,'2023-04-05',5,'Wednesday','2023-04-05 07:00:00','April','Q2','2023'),(315,'2023-03-03',3,'Friday','2023-03-03 08:00:00','March','Q1','2023'),(316,'2023-04-25',25,'Tuesday','2023-04-25 07:00:00','April','Q2','2023'),(317,'2023-01-16',16,'Monday','2023-01-16 08:00:00','January','Q1','2023'),(318,'2022-07-04',4,'Monday','2022-07-04 07:00:00','July','Q3','2022'),(319,'2022-06-24',24,'Friday','2022-06-24 07:00:00','June','Q2','2022'),(320,'2023-03-13',13,'Monday','2023-03-13 07:00:00','March','Q1','2023'),(321,'2022-06-19',19,'Sunday','2022-06-19 07:00:00','June','Q2','2022'),(322,'2023-04-03',3,'Monday','2023-04-03 07:00:00','April','Q2','2023'),(323,'2022-10-20',20,'Thursday','2022-10-20 07:00:00','October','Q4','2022'),(324,'2022-08-02',2,'Tuesday','2022-08-02 07:00:00','August','Q3','2022'),(325,'2022-08-12',12,'Friday','2022-08-12 07:00:00','August','Q3','2022'),(326,'2022-08-26',26,'Friday','2022-08-26 07:00:00','August','Q3','2022'),(327,'2022-10-30',30,'Sunday','2022-10-30 07:00:00','October','Q4','2022'),(328,'2022-11-26',26,'Saturday','2022-11-26 08:00:00','November','Q4','2022'),(329,'2023-02-14',14,'Tuesday','2023-02-14 08:00:00','February','Q1','2023'),(330,'2022-09-15',15,'Thursday','2022-09-15 07:00:00','September','Q3','2022'),(331,'2023-01-24',24,'Tuesday','2023-01-24 08:00:00','January','Q1','2023'),(332,'2022-05-05',5,'Thursday','2022-05-05 07:00:00','May','Q2','2022'),(333,'2022-11-01',1,'Tuesday','2022-11-01 07:00:00','November','Q4','2022'),(334,'2022-05-12',12,'Thursday','2022-05-12 07:00:00','May','Q2','2022'),(335,'2022-07-16',16,'Saturday','2022-07-16 07:00:00','July','Q3','2022'),(336,'2023-05-11',11,'Thursday','2023-05-11 07:00:00','May','Q2','2023'),(337,'2022-09-19',19,'Monday','2022-09-19 07:00:00','September','Q3','2022'),(338,'2023-05-12',12,'Friday','2023-05-12 07:00:00','May','Q2','2023'),(339,'2023-05-13',13,'Saturday','2023-05-13 07:00:00','May','Q2','2023'),(340,'2023-03-11',11,'Saturday','2023-03-11 08:00:00','March','Q1','2023'),(341,'2022-10-17',17,'Monday','2022-10-17 07:00:00','October','Q4','2022'),(342,'2023-04-24',24,'Monday','2023-04-24 07:00:00','April','Q2','2023'),(343,'2020-08-21',21,'Friday','2020-08-21 07:00:00','August','Q3','2020'),(344,'2021-04-18',18,'Sunday','2021-04-18 07:00:00','April','Q2','2021'),(345,'2020-07-03',3,'Friday','2020-07-03 07:00:00','July','Q3','2020'),(346,'2019-04-01',1,'Monday','2019-04-01 07:00:00','April','Q2','2019'),(347,'2021-09-02',2,'Thursday','2021-09-02 07:00:00','September','Q3','2021'),(348,'2018-09-13',13,'Thursday','2018-09-13 07:00:00','September','Q3','2018'),(349,'2020-02-10',10,'Monday','2020-02-10 08:00:00','February','Q1','2020'),(350,'2018-05-19',19,'Saturday','2018-05-19 07:00:00','May','Q2','2018'),(351,'2019-12-04',4,'Wednesday','2019-12-04 08:00:00','December','Q4','2019'),(352,'2019-05-31',31,'Friday','2019-05-31 07:00:00','May','Q2','2019'),(353,'2023-04-29',29,'Saturday','2023-04-29 07:00:00','April','Q2','2023'),(354,'2020-04-05',5,'Sunday','2020-04-05 07:00:00','April','Q2','2020'),(355,'2018-11-01',1,'Thursday','2018-11-01 07:00:00','November','Q4','2018'),(356,'2018-09-17',17,'Monday','2018-09-17 07:00:00','September','Q3','2018'),(357,'2021-10-18',18,'Monday','2021-10-18 07:00:00','October','Q4','2021'),(358,'2021-11-06',6,'Saturday','2021-11-06 07:00:00','November','Q4','2021'),(359,'2018-06-22',22,'Friday','2018-06-22 07:00:00','June','Q2','2018'),(360,'2020-06-13',13,'Saturday','2020-06-13 07:00:00','June','Q2','2020'),(361,'2021-08-27',27,'Friday','2021-08-27 07:00:00','August','Q3','2021'),(362,'2021-04-08',8,'Thursday','2021-04-08 07:00:00','April','Q2','2021'),(363,'2018-10-07',7,'Sunday','2018-10-07 07:00:00','October','Q4','2018'),(364,'2022-10-15',15,'Saturday','2022-10-15 07:00:00','October','Q4','2022'),(365,'2018-10-18',18,'Thursday','2018-10-18 07:00:00','October','Q4','2018'),(366,'2020-12-12',12,'Saturday','2020-12-12 08:00:00','December','Q4','2020'),(367,'2019-05-25',25,'Saturday','2019-05-25 07:00:00','May','Q2','2019'),(368,'2020-09-19',19,'Saturday','2020-09-19 07:00:00','September','Q3','2020'),(369,'2019-07-22',22,'Monday','2019-07-22 07:00:00','July','Q3','2019'),(370,'2018-10-04',4,'Thursday','2018-10-04 07:00:00','October','Q4','2018'),(371,'2019-11-08',8,'Friday','2019-11-08 08:00:00','November','Q4','2019'),(372,'2021-12-15',15,'Wednesday','2021-12-15 08:00:00','December','Q4','2021'),(373,'2020-12-11',11,'Friday','2020-12-11 08:00:00','December','Q4','2020'),(374,'2019-07-07',7,'Sunday','2019-07-07 07:00:00','July','Q3','2019'),(375,'2021-08-31',31,'Tuesday','2021-08-31 07:00:00','August','Q3','2021'),(376,'2018-05-03',3,'Thursday','2018-05-03 07:00:00','May','Q2','2018'),(377,'2018-09-16',16,'Sunday','2018-09-16 07:00:00','September','Q3','2018'),(378,'2021-10-04',4,'Monday','2021-10-04 07:00:00','October','Q4','2021'),(379,'2021-11-19',19,'Friday','2021-11-19 08:00:00','November','Q4','2021'),(380,'2019-12-12',12,'Thursday','2019-12-12 08:00:00','December','Q4','2019'),(381,'2021-12-03',3,'Friday','2021-12-03 08:00:00','December','Q4','2021'),(382,'2019-11-27',27,'Wednesday','2019-11-27 08:00:00','November','Q4','2019'),(383,'2020-06-20',20,'Saturday','2020-06-20 07:00:00','June','Q2','2020'),(384,'2022-10-27',27,'Thursday','2022-10-27 07:00:00','October','Q4','2022'),(385,'2021-09-20',20,'Monday','2021-09-20 07:00:00','September','Q3','2021'),(386,'2019-06-10',10,'Monday','2019-06-10 07:00:00','June','Q2','2019'),(387,'2021-10-12',12,'Tuesday','2021-10-12 07:00:00','October','Q4','2021'),(388,'2020-08-26',26,'Wednesday','2020-08-26 07:00:00','August','Q3','2020'),(389,'2021-03-18',18,'Thursday','2021-03-18 07:00:00','March','Q1','2021'),(390,'2020-08-30',30,'Sunday','2020-08-30 07:00:00','August','Q3','2020'),(391,'2021-03-25',25,'Thursday','2021-03-25 07:00:00','March','Q1','2021'),(392,'2020-10-16',16,'Friday','2020-10-16 07:00:00','October','Q4','2020'),(393,'2018-08-27',27,'Monday','2018-08-27 07:00:00','August','Q3','2018'),(394,'2018-09-21',21,'Friday','2018-09-21 07:00:00','September','Q3','2018'),(395,'2022-12-18',18,'Sunday','2022-12-18 08:00:00','December','Q4','2022'),(396,'2021-04-03',3,'Saturday','2021-04-03 07:00:00','April','Q2','2021'),(397,'2019-10-24',24,'Thursday','2019-10-24 07:00:00','October','Q4','2019'),(398,'2020-10-28',28,'Wednesday','2020-10-28 07:00:00','October','Q4','2020'),(399,'2021-11-28',28,'Sunday','2021-11-28 08:00:00','November','Q4','2021'),(400,'2021-04-28',28,'Wednesday','2021-04-28 07:00:00','April','Q2','2021'),(401,'2020-08-16',16,'Sunday','2020-08-16 07:00:00','August','Q3','2020'),(402,'2019-12-03',3,'Tuesday','2019-12-03 08:00:00','December','Q4','2019'),(403,'2021-01-07',7,'Thursday','2021-01-07 08:00:00','January','Q1','2021'),(404,'2020-12-24',24,'Thursday','2020-12-24 08:00:00','December','Q4','2020'),(405,'2019-10-02',2,'Wednesday','2019-10-02 07:00:00','October','Q4','2019'),(406,'2021-11-14',14,'Sunday','2021-11-14 08:00:00','November','Q4','2021'),(407,'2018-06-26',26,'Tuesday','2018-06-26 07:00:00','June','Q2','2018'),(408,'2020-01-07',7,'Tuesday','2020-01-07 08:00:00','January','Q1','2020'),(409,'2021-11-13',13,'Saturday','2021-11-13 08:00:00','November','Q4','2021'),(410,'2020-03-30',30,'Monday','2020-03-30 07:00:00','March','Q1','2020'),(411,'2019-02-25',25,'Monday','2019-02-25 08:00:00','February','Q1','2019'),(412,'2020-06-29',29,'Monday','2020-06-29 07:00:00','June','Q2','2020'),(413,'2019-03-27',27,'Wednesday','2019-03-27 07:00:00','March','Q1','2019'),(414,'2020-02-05',5,'Wednesday','2020-02-05 08:00:00','February','Q1','2020'),(415,'2021-04-16',16,'Friday','2021-04-16 07:00:00','April','Q2','2021'),(416,'2018-09-11',11,'Tuesday','2018-09-11 07:00:00','September','Q3','2018'),(417,'2019-06-03',3,'Monday','2019-06-03 07:00:00','June','Q2','2019'),(418,'2019-04-25',25,'Thursday','2019-04-25 07:00:00','April','Q2','2019'),(419,'2019-04-17',17,'Wednesday','2019-04-17 07:00:00','April','Q2','2019'),(420,'2020-03-15',15,'Sunday','2020-03-15 07:00:00','March','Q1','2020'),(421,'2018-08-06',6,'Monday','2018-08-06 07:00:00','August','Q3','2018'),(422,'2021-11-08',8,'Monday','2021-11-08 08:00:00','November','Q4','2021'),(423,'2019-09-11',11,'Wednesday','2019-09-11 07:00:00','September','Q3','2019'),(424,'2018-08-04',4,'Saturday','2018-08-04 07:00:00','August','Q3','2018'),(425,'2022-09-26',26,'Monday','2022-09-26 07:00:00','September','Q3','2022'),(426,'2018-08-29',29,'Wednesday','2018-08-29 07:00:00','August','Q3','2018'),(427,'2021-11-24',24,'Wednesday','2021-11-24 08:00:00','November','Q4','2021'),(428,'2020-12-27',27,'Sunday','2020-12-27 08:00:00','December','Q4','2020'),(429,'2018-08-15',15,'Wednesday','2018-08-15 07:00:00','August','Q3','2018'),(430,'2021-09-28',28,'Tuesday','2021-09-28 07:00:00','September','Q3','2021'),(431,'2019-02-07',7,'Thursday','2019-02-07 08:00:00','February','Q1','2019'),(432,'2020-07-20',20,'Monday','2020-07-20 07:00:00','July','Q3','2020'),(433,'2019-03-05',5,'Tuesday','2019-03-05 08:00:00','March','Q1','2019'),(434,'2020-03-23',23,'Monday','2020-03-23 07:00:00','March','Q1','2020'),(435,'2019-10-16',16,'Wednesday','2019-10-16 07:00:00','October','Q4','2019'),(436,'2023-03-27',27,'Monday','2023-03-27 07:00:00','March','Q1','2023'),(437,'2021-12-26',26,'Sunday','2021-12-26 08:00:00','December','Q4','2021'),(438,'2020-10-27',27,'Tuesday','2020-10-27 07:00:00','October','Q4','2020'),(439,'2021-03-17',17,'Wednesday','2021-03-17 07:00:00','March','Q1','2021'),(440,'2021-07-03',3,'Saturday','2021-07-03 07:00:00','July','Q3','2021'),(441,'2021-03-24',24,'Wednesday','2021-03-24 07:00:00','March','Q1','2021'),(442,'2021-06-24',24,'Thursday','2021-06-24 07:00:00','June','Q2','2021'),(443,'2018-10-19',19,'Friday','2018-10-19 07:00:00','October','Q4','2018'),(444,'2018-12-08',8,'Saturday','2018-12-08 08:00:00','December','Q4','2018'),(445,'2019-06-05',5,'Wednesday','2019-06-05 07:00:00','June','Q2','2019'),(446,'2022-07-27',27,'Wednesday','2022-07-27 07:00:00','July','Q3','2022'),(447,'2021-03-15',15,'Monday','2021-03-15 07:00:00','March','Q1','2021'),(448,'2018-10-16',16,'Tuesday','2018-10-16 07:00:00','October','Q4','2018'),(449,'2020-12-19',19,'Saturday','2020-12-19 08:00:00','December','Q4','2020'),(450,'2019-03-07',7,'Thursday','2019-03-07 08:00:00','March','Q1','2019'),(451,'2018-11-28',28,'Wednesday','2018-11-28 08:00:00','November','Q4','2018'),(452,'2020-02-06',6,'Thursday','2020-02-06 08:00:00','February','Q1','2020'),(453,'2019-05-02',2,'Thursday','2019-05-02 07:00:00','May','Q2','2019'),(454,'2018-10-30',30,'Tuesday','2018-10-30 07:00:00','October','Q4','2018'),(455,'2018-08-14',14,'Tuesday','2018-08-14 07:00:00','August','Q3','2018'),(456,'2022-07-21',21,'Thursday','2022-07-21 07:00:00','July','Q3','2022'),(457,'2020-02-14',14,'Friday','2020-02-14 08:00:00','February','Q1','2020'),(458,'2018-05-13',13,'Sunday','2018-05-13 07:00:00','May','Q2','2018'),(459,'2019-08-05',5,'Monday','2019-08-05 07:00:00','August','Q3','2019'),(460,'2021-07-12',12,'Monday','2021-07-12 07:00:00','July','Q3','2021'),(461,'2020-01-10',10,'Friday','2020-01-10 08:00:00','January','Q1','2020'),(462,'2020-06-28',28,'Sunday','2020-06-28 07:00:00','June','Q2','2020'),(463,'2020-10-03',3,'Saturday','2020-10-03 07:00:00','October','Q4','2020'),(464,'2021-08-02',2,'Monday','2021-08-02 07:00:00','August','Q3','2021'),(465,'2019-02-21',21,'Thursday','2019-02-21 08:00:00','February','Q1','2019'),(466,'2019-12-29',29,'Sunday','2019-12-29 08:00:00','December','Q4','2019'),(467,'2018-11-19',19,'Monday','2018-11-19 08:00:00','November','Q4','2018'),(468,'2018-12-11',11,'Tuesday','2018-12-11 08:00:00','December','Q4','2018'),(469,'2021-02-15',15,'Monday','2021-02-15 08:00:00','February','Q1','2021'),(470,'2018-05-02',2,'Wednesday','2018-05-02 07:00:00','May','Q2','2018'),(471,'2020-07-16',16,'Thursday','2020-07-16 07:00:00','July','Q3','2020'),(472,'2019-09-02',2,'Monday','2019-09-02 07:00:00','September','Q3','2019'),(473,'2021-06-12',12,'Saturday','2021-06-12 07:00:00','June','Q2','2021'),(474,'2019-07-23',23,'Tuesday','2019-07-23 07:00:00','July','Q3','2019'),(475,'2022-08-01',1,'Monday','2022-08-01 07:00:00','August','Q3','2022'),(476,'2021-04-10',10,'Saturday','2021-04-10 07:00:00','April','Q2','2021'),(477,'2020-05-27',27,'Wednesday','2020-05-27 07:00:00','May','Q2','2020'),(478,'2021-02-25',25,'Thursday','2021-02-25 08:00:00','February','Q1','2021'),(479,'2021-06-21',21,'Monday','2021-06-21 07:00:00','June','Q2','2021'),(480,'2021-09-01',1,'Wednesday','2021-09-01 07:00:00','September','Q3','2021'),(481,'2019-03-09',9,'Saturday','2019-03-09 08:00:00','March','Q1','2019'),(482,'2021-08-18',18,'Wednesday','2021-08-18 07:00:00','August','Q3','2021'),(483,'2019-09-19',19,'Thursday','2019-09-19 07:00:00','September','Q3','2019'),(484,'2020-08-27',27,'Thursday','2020-08-27 07:00:00','August','Q3','2020'),(485,'2022-11-23',23,'Wednesday','2022-11-23 08:00:00','November','Q4','2022'),(486,'2018-09-01',1,'Saturday','2018-09-01 07:00:00','September','Q3','2018'),(487,'2020-05-01',1,'Friday','2020-05-01 07:00:00','May','Q2','2020'),(488,'2021-07-22',22,'Thursday','2021-07-22 07:00:00','July','Q3','2021'),(489,'2020-06-26',26,'Friday','2020-06-26 07:00:00','June','Q2','2020'),(490,'2020-05-14',14,'Thursday','2020-05-14 07:00:00','May','Q2','2020'),(491,'2021-10-06',6,'Wednesday','2021-10-06 07:00:00','October','Q4','2021'),(492,'2019-10-01',1,'Tuesday','2019-10-01 07:00:00','October','Q4','2019'),(493,'2018-07-31',31,'Tuesday','2018-07-31 07:00:00','July','Q3','2018'),(494,'2021-03-29',29,'Monday','2021-03-29 07:00:00','March','Q1','2021'),(495,'2022-12-20',20,'Tuesday','2022-12-20 08:00:00','December','Q4','2022'),(496,'2021-05-12',12,'Wednesday','2021-05-12 07:00:00','May','Q2','2021'),(497,'2019-10-22',22,'Tuesday','2019-10-22 07:00:00','October','Q4','2019'),(498,'2019-09-28',28,'Saturday','2019-09-28 07:00:00','September','Q3','2019'),(499,'2020-07-13',13,'Monday','2020-07-13 07:00:00','July','Q3','2020'),(500,'2021-05-01',1,'Saturday','2021-05-01 07:00:00','May','Q2','2021'),(501,'2021-04-02',2,'Friday','2021-04-02 07:00:00','April','Q2','2021'),(502,'2021-11-22',22,'Monday','2021-11-22 08:00:00','November','Q4','2021'),(503,'2019-08-08',8,'Thursday','2019-08-08 07:00:00','August','Q3','2019'),(504,'2021-02-27',27,'Saturday','2021-02-27 08:00:00','February','Q1','2021'),(505,'2022-07-14',14,'Thursday','2022-07-14 07:00:00','July','Q3','2022'),(506,'2023-04-09',9,'Sunday','2023-04-09 07:00:00','April','Q2','2023'),(507,'2022-12-30',30,'Friday','2022-12-30 08:00:00','December','Q4','2022'),(508,'2022-11-22',22,'Tuesday','2022-11-22 08:00:00','November','Q4','2022'),(509,'2023-03-20',20,'Monday','2023-03-20 07:00:00','March','Q1','2023'),(510,'2022-08-19',19,'Friday','2022-08-19 07:00:00','August','Q3','2022'),(511,'2022-05-04',4,'Wednesday','2022-05-04 07:00:00','May','Q2','2022'),(512,'2023-02-08',8,'Wednesday','2023-02-08 08:00:00','February','Q1','2023'),(513,'2022-08-29',29,'Monday','2022-08-29 07:00:00','August','Q3','2022'),(514,'2022-06-13',13,'Monday','2022-06-13 07:00:00','June','Q2','2022'),(515,'2023-01-20',20,'Friday','2023-01-20 08:00:00','January','Q1','2023'),(516,'2022-07-20',20,'Wednesday','2022-07-20 07:00:00','July','Q3','2022'),(517,'2023-02-27',27,'Monday','2023-02-27 08:00:00','February','Q1','2023'),(518,'2022-07-08',8,'Friday','2022-07-08 07:00:00','July','Q3','2022'),(519,'2022-05-25',25,'Wednesday','2022-05-25 07:00:00','May','Q2','2022'),(520,'2022-11-06',6,'Sunday','2022-11-06 07:00:00','November','Q4','2022'),(521,'2023-01-01',1,'Sunday','2023-01-01 08:00:00','January','Q1','2023'),(522,'2022-05-06',6,'Friday','2022-05-06 07:00:00','May','Q2','2022'),(523,'2022-08-15',15,'Monday','2022-08-15 07:00:00','August','Q3','2022'),(524,'2022-11-05',5,'Saturday','2022-11-05 07:00:00','November','Q4','2022'),(525,'2022-11-11',11,'Friday','2022-11-11 08:00:00','November','Q4','2022'),(526,'2022-10-18',18,'Tuesday','2022-10-18 07:00:00','October','Q4','2022'),(527,'2023-03-05',5,'Sunday','2023-03-05 08:00:00','March','Q1','2023'),(528,'2023-01-29',29,'Sunday','2023-01-29 08:00:00','January','Q1','2023'),(529,'2023-03-22',22,'Wednesday','2023-03-22 07:00:00','March','Q1','2023'),(530,'2022-09-01',1,'Thursday','2022-09-01 07:00:00','September','Q3','2022'),(531,'2023-04-04',4,'Tuesday','2023-04-04 07:00:00','April','Q2','2023'),(532,'2023-04-01',1,'Saturday','2023-04-01 07:00:00','April','Q2','2023'),(533,'2023-03-21',21,'Tuesday','2023-03-21 07:00:00','March','Q1','2023'),(534,'2022-10-02',2,'Sunday','2022-10-02 07:00:00','October','Q4','2022'),(535,'2022-07-06',6,'Wednesday','2022-07-06 07:00:00','July','Q3','2022'),(536,'2022-11-02',2,'Wednesday','2022-11-02 07:00:00','November','Q4','2022'),(537,'2022-09-08',8,'Thursday','2022-09-08 07:00:00','September','Q3','2022'),(538,'2022-11-16',16,'Wednesday','2022-11-16 08:00:00','November','Q4','2022'),(539,'2022-12-19',19,'Monday','2022-12-19 08:00:00','December','Q4','2022'),(540,'2022-11-15',15,'Tuesday','2022-11-15 08:00:00','November','Q4','2022'),(541,'2023-03-01',1,'Wednesday','2023-03-01 08:00:00','March','Q1','2023'),(542,'2023-03-06',6,'Monday','2023-03-06 08:00:00','March','Q1','2023'),(543,'2022-11-28',28,'Monday','2022-11-28 08:00:00','November','Q4','2022'),(544,'2022-11-14',14,'Monday','2022-11-14 08:00:00','November','Q4','2022'),(545,'2022-09-11',11,'Sunday','2022-09-11 07:00:00','September','Q3','2022'),(546,'2022-11-18',18,'Friday','2022-11-18 08:00:00','November','Q4','2022'),(547,'2022-07-31',31,'Sunday','2022-07-31 07:00:00','July','Q3','2022'),(548,'2022-08-22',22,'Monday','2022-08-22 07:00:00','August','Q3','2022'),(549,'2022-12-27',27,'Tuesday','2022-12-27 08:00:00','December','Q4','2022'),(550,'2022-10-09',9,'Sunday','2022-10-09 07:00:00','October','Q4','2022'),(551,'2022-07-12',12,'Tuesday','2022-07-12 07:00:00','July','Q3','2022'),(552,'2023-02-06',6,'Monday','2023-02-06 08:00:00','February','Q1','2023'),(553,'2023-04-20',20,'Thursday','2023-04-20 07:00:00','April','Q2','2023');
/*!40000 ALTER TABLE `Calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cart`
--

DROP TABLE IF EXISTS `Cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cart` (
  `CartKey` int NOT NULL,
  `CartID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `WineID` varchar(25) NOT NULL,
  `Total_Wine_Price` float NOT NULL,
  PRIMARY KEY (`CartKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cart`
--

LOCK TABLES `Cart` WRITE;
/*!40000 ALTER TABLE `Cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `CustomerKey` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `CustomerName` varchar(255) DEFAULT NULL,
  `CustomerAge` varchar(55) DEFAULT NULL,
  `CustomerEmail` varchar(255) DEFAULT NULL,
  `CustomerZip` int DEFAULT NULL,
  `CustomerCreditScore` int DEFAULT NULL,
  `RegionID` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`CustomerKey`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,1001,'John Smith','35','john.smith@gmail.com',10001,750,'R001'),(2,1002,'Jane Doe','28','jane.doe@hotmail.com',10002,680,'R002'),(3,1003,'Michael Brown','45','michael.brown@yahoo.com',10003,800,'R003'),(4,1004,'Emily Davis','50','emily.davis@gmail.com',10004,700,'R001'),(5,1005,'William Johnson','32','william.johnson@yahoo.com',10005,720,'R002'),(6,1006,'Sarah Garcia','41','sarah.garcia@hotmail.com',10006,750,'R002'),(7,1007,'David Wilson','53','david.wilson@gmail.com',10007,810,'R002'),(8,1008,'Jessica Rodriguez','29','jessica.rodriguez@yahoo.com',10008,690,'R004'),(9,1009,'Daniel Martinez','38','daniel.martinez@hotmail.com',10009,760,'R001'),(10,1010,'Megan Taylor','24','megan.taylor@gmail.com',10010,670,'R003'),(11,1011,'Christopher Anderson','47','christopher.anderson@yahoo.com',10011,780,'R003'),(12,1012,'Avery Moore','31','avery.moore@hotmail.com',10012,730,'R002'),(13,1013,'Madison Perez','27','madison.perez@gmail.com',10013,700,'R004'),(14,1014,'Joshua Brown','40','joshua.brown@yahoo.com',10014,790,'R002'),(15,1015,'Sophia Allen','34','sophia.allen@hotmail.com',10015,740,'R001'),(16,1016,'William Lee','25','william.lee@gmail.com',10016,660,'R005'),(17,1017,'Olivia Taylor','52','olivia.taylor@yahoo.com',10017,820,'R005'),(18,1018,'Ethan Johnson','37','ethan.johnson@hotmail.com',10018,750,'R004'),(19,1019,'Ava Davis','30','ava.davis@gmail.com',10019,710,'R002'),(20,1020,'Michael Rodriguez','43','michael.rodriguez@yahoo.com',10020,780,'R004'),(100,1024,'Emily Taylor','51','77ebPkNU@hotmail.com',92100,832,'R001'),(101,1025,'Emily Johnson','45','8008zIJv@yahoo.com',95799,834,'R002'),(102,1026,'Olivia Taylor','32','AarSlquf@yahoo.com',95855,700,'R003'),(103,1027,'Michael Wilson','27','XSw0iIg0@yahoo.com',97389,750,'R004'),(105,1028,'Jane Taylor','51','kNSgadKV@yahoo.com',97021,777,'R001'),(107,1029,'Jane Smith','32','wtpqRAjD@hotmail.com',96612,849,'R002'),(108,1030,'Emily Taylor','35','eexSD8pl@gmail.com',96112,724,'R003'),(109,1031,'Olivia Wilson','33','I6rbwQ2G@yahoo.com',94965,811,'R004'),(110,1032,'Jane Taylor','56','EeMJpAE2@hotmail.com',98360,750,'R001'),(111,1033,'David Johnson','55','1KEHM5IT@gmail.com',94501,738,'R002'),(112,1034,'John Smith','42','yiDKTQhK@hotmail.com',98347,805,'R003'),(113,1035,'Olivia Wilson','50','s8hAeQbn@hotmail.com',90551,746,'R004'),(114,1036,'Jane Taylor','51','3IazD1HD@hotmail.com',91673,740,'R001'),(115,1037,'Jane Brown','34','gHpKTGAb@yahoo.com',99466,799,'R002'),(116,1038,'Michael Smith','33','U4EezH9x@yahoo.com',98799,760,'R003'),(117,1039,'Jane Smith','37','razUmrIG@yahoo.com',95810,754,'R004'),(118,1040,'Emily Johnson','50','hnfXeqn7@hotmail.com',94189,701,'R001'),(119,1041,'Jane Johnson','53','iY4jkyRT@yahoo.com',91990,834,'R002'),(120,1042,'Michael Wilson','59','8jBI9LxI@hotmail.com',94524,798,'R003'),(121,1043,'Olivia Johnson','28','6cEddRzz@yahoo.com',93990,838,'R004'),(124,1044,'Emily Anderson','32','lYIJ3xeC@yahoo.com',94067,780,'R001'),(125,1045,'David Anderson','28','930ODzGc@gmail.com',92097,788,'R002'),(128,1046,'David Taylor','38','364eauiQ@yahoo.com',96619,701,'R003'),(130,1047,'David Brown','56','MzVscTI5@hotmail.com',92213,749,'R004'),(134,1048,'David Brown','41','2gPrfhyB@yahoo.com',91663,746,'R001'),(135,1049,'Olivia Taylor','26','bwobwXOR@hotmail.com',92368,738,'R002'),(136,1050,'Emily Anderson','32','LkOs6ft7@gmail.com',93833,829,'R003'),(137,1051,'Olivia Anderson','56','1WbChDMy@gmail.com',91689,776,'R004'),(139,1052,'John Brown','29','vGWLuQwX@yahoo.com',92343,850,'R001'),(140,1053,'Michael Johnson','56','CalhI0qi@yahoo.com',90178,773,'R002'),(141,1054,'John Johnson','36','jas90SLV@gmail.com',91776,746,'R003'),(142,1055,'David Wilson','56','P6PO2gf2@hotmail.com',98027,811,'R004'),(144,1056,'Olivia Taylor','47','ZjR53zan@yahoo.com',97656,823,'R001'),(145,1057,'Michael Taylor','49','7DZg1zze@gmail.com',94901,738,'R002'),(147,1058,'John Taylor','56','pf3rG9S6@hotmail.com',90437,759,'R003'),(148,1059,'Jane Anderson','53','vScosmL8@yahoo.com',98768,722,'R004'),(149,1060,'Michael Brown','50','2Kqj4W8A@yahoo.com',93394,743,'R001'),(152,1061,'Jane Anderson','54','nID68jgn@yahoo.com',96904,786,'R002'),(153,1062,'Michael Johnson','59','ySZZTtEm@hotmail.com',98759,756,'R003'),(154,1063,'Jane Anderson','40','imzpazm8@gmail.com',98341,731,'R004'),(155,1064,'David Brown','28','T8zV1k7R@gmail.com',94328,733,'R001'),(156,1065,'John Johnson','27','SnOhGqlU@yahoo.com',96967,820,'R002'),(157,1066,'David Anderson','55','UA73SyBC@yahoo.com',93164,751,'R003'),(158,1067,'John Taylor','56','LXY3cYPP@gmail.com',99781,788,'R004'),(159,1068,'Olivia Wilson','26','0RiJSBOA@hotmail.com',93435,794,'R001'),(160,1069,'Michael Smith','33','Nts96SKL@gmail.com',91663,811,'R002'),(161,1070,'Emily Johnson','58','xfMd1mJr@gmail.com',97639,780,'R003'),(162,1071,'Jane Anderson','54','a8fLEeSS@yahoo.com',90760,846,'R004'),(163,1072,'Olivia Brown','43','UqFatsKq@yahoo.com',95409,723,'R001'),(164,1073,'Emily Johnson','42','n1tEQeNQ@yahoo.com',95591,790,'R002'),(165,1074,'David Brown','49','U311prfB@yahoo.com',95819,821,'R003'),(166,1075,'David Johnson','29','Ky4hBSoF@hotmail.com',98128,717,'R004'),(167,1076,'David Wilson','38','fDNW9yjD@gmail.com',90551,744,'R001'),(168,1077,'Olivia Johnson','51','qB1sitcl@hotmail.com',94149,805,'R002'),(169,1078,'David Brown','44','SL6wcNIi@gmail.com',99308,770,'R003'),(170,1079,'Michael Wilson','32','lspksXf5@hotmail.com',99712,703,'R004'),(171,1080,'Emily Wilson','42','IHrXXrtB@hotmail.com',91418,726,'R001'),(173,1081,'Jane Johnson','31','mieKRJPV@gmail.com',95442,775,'R002'),(175,1082,'Olivia Johnson','60','EBvc91II@gmail.com',99516,816,'R003'),(176,1083,'David Taylor','54','GJJ6vAhv@yahoo.com',99601,825,'R004'),(178,1084,'David Smith','27','fvcOwqMt@hotmail.com',93582,717,'R001'),(179,1085,'John Anderson','46','3gIj0cqt@hotmail.com',90542,786,'R002'),(180,1086,'Olivia Brown','50','v6OqMxMl@yahoo.com',90386,797,'R003'),(181,1087,'David Brown','46','qVRknVOW@hotmail.com',97565,759,'R004'),(182,1088,'Michael Smith','36','cB3ym4uv@hotmail.com',99295,827,'R001'),(183,1089,'Jane Wilson','33','5EaTVItw@hotmail.com',96106,846,'R002'),(184,1090,'David Brown','38','CcIvK8do@gmail.com',94246,785,'R003'),(185,1091,'Michael Brown','51','W1rpOrT7@hotmail.com',99221,783,'R004'),(186,1092,'John Wilson','48','EgTZn1gC@hotmail.com',97204,717,'R001'),(187,1093,'John Wilson','30','UeM4pSM9@yahoo.com',96932,818,'R002'),(188,1094,'John Johnson','34','KbwXzWvi@yahoo.com',97463,744,'R003'),(189,1095,'Emily Anderson','36','MNLx7e9J@hotmail.com',95334,747,'R004'),(190,1096,'David Johnson','34','3EDMMC5c@hotmail.com',91700,818,'R001'),(191,1097,'Jane Taylor','26','bxfAX37v@gmail.com',93444,711,'R002'),(192,1098,'Jane Brown','44','XcXazN64@hotmail.com',93499,752,'R003'),(193,1099,'John Taylor','42','x80EZZZq@gmail.com',92387,715,'R004'),(194,1100,'Michael Brown','41','yzoqLbM1@hotmail.com',91593,747,'R001'),(195,1101,'Emily Anderson','57','EmhTXr8H@yahoo.com',92028,714,'R002'),(196,1102,'John Smith','40','sT0kL4t1@yahoo.com',92326,833,'R003'),(197,1103,'John Johnson','58','2B01NfAz@hotmail.com',90039,848,'R004'),(199,1104,'David Anderson','44','MQXITZbp@gmail.com',94891,772,'R001'),(200,1105,'Jane Smith','55','Vxaow3Vk@yahoo.com',94581,818,'R002'),(202,1106,'Jane Taylor','58','UOeFOin7@yahoo.com',90286,739,'R003'),(203,1107,'Jane Brown','26','f406jFwU@yahoo.com',96903,798,'R004'),(204,1108,'David Wilson','48','w8lDJIps@yahoo.com',98357,754,'R001'),(207,1109,'David Wilson','42','Mwd1Q2kL@gmail.com',99449,704,'R002'),(208,1110,'John Smith','38','XzHoPUJG@hotmail.com',90897,790,'R003'),(209,1111,'Emily Johnson','26','7k1JfO7O@hotmail.com',94260,706,'R004'),(210,1112,'John Wilson','56','xS8vqYXt@yahoo.com',96046,716,'R001'),(211,1113,'Emily Johnson','36','96HdTcM9@gmail.com',96898,796,'R002'),(212,1114,'Michael Smith','34','xMbmDrUL@yahoo.com',97265,806,'R003'),(213,1115,'Jane Anderson','58','Z3by1v48@yahoo.com',93458,774,'R004'),(216,1116,'Michael Smith','32','XlfQqB9N@yahoo.com',95310,812,'R001'),(217,1117,'Olivia Taylor','27','Lll8owoq@hotmail.com',95581,705,'R002'),(218,1118,'Olivia Wilson','52','GLKVsrck@hotmail.com',91058,759,'R003'),(219,1119,'John Brown','55','O6c7w5nH@yahoo.com',95787,834,'R004'),(220,1120,'John Wilson','55','lraIxJqx@hotmail.com',95694,789,'R001'),(221,1121,'Olivia Smith','57','oWNqmkSH@gmail.com',92538,813,'R002'),(222,1122,'Emily Brown','34','8VLZVuLw@yahoo.com',91647,702,'R003'),(223,1123,'Michael Smith','58','oFBdwmt7@hotmail.com',90434,825,'R004'),(224,1124,'Michael Johnson','34','eJeqTPCR@hotmail.com',90976,752,'R001'),(226,1125,'Olivia Wilson','52','Afmz6W6U@gmail.com',91963,739,'R002'),(227,1126,'Olivia Smith','53','GG0yOwPw@gmail.com',94333,775,'R003'),(228,1127,'David Taylor','33','H5nJVoty@yahoo.com',91277,845,'R004'),(229,1128,'Olivia Brown','53','jsQTnVCM@yahoo.com',96534,740,'R001'),(231,1129,'David Anderson','27','SWJ6Ny9v@hotmail.com',98872,832,'R002'),(232,1130,'Emily Brown','36','SyKEKjEt@hotmail.com',99530,739,'R003'),(233,1131,'John Wilson','51','rnJzGUaU@yahoo.com',95769,776,'R004'),(235,1132,'John Johnson','37','bnxgXmbL@gmail.com',99131,736,'R001'),(236,1133,'John Johnson','31','R9dBogdH@hotmail.com',93676,762,'R002'),(237,1134,'David Johnson','47','Bgt5mK6w@gmail.com',96724,774,'R003'),(238,1135,'Michael Smith','50','qn1r1bzO@yahoo.com',92789,726,'R004'),(239,1136,'John Johnson','52','FheVxTmy@hotmail.com',97529,802,'R001'),(241,1137,'Jane Anderson','54','XMbNfTuG@yahoo.com',92723,814,'R002'),(242,1138,'Emily Smith','53','roBVcrZ2@gmail.com',95574,704,'R003'),(244,1139,'Emily Anderson','34','lRZtomX0@yahoo.com',93356,781,'R004'),(245,1140,'Jane Taylor','27','pgClqmmU@gmail.com',93643,707,'R001'),(246,1141,'Michael Smith','41','uPXVBafn@gmail.com',96364,770,'R002'),(247,1142,'Olivia Smith','43','zEpHXjYH@hotmail.com',92051,780,'R003'),(250,1143,'Jane Anderson','51','5Q5Kybxj@hotmail.com',94234,830,'R004'),(252,1144,'John Brown','34','JATQMYcV@yahoo.com',98750,789,'R001'),(254,1145,'Olivia Johnson','35','Iml3J9KL@hotmail.com',91993,709,'R002'),(255,1146,'Emily Brown','58','zourq1uY@yahoo.com',98248,721,'R003'),(257,1147,'Emily Brown','32','kNX6xmZh@gmail.com',94400,722,'R004'),(258,1148,'Olivia Brown','48','sIeqGCDE@hotmail.com',96029,847,'R001'),(259,1149,'David Brown','44','5v18WTEO@hotmail.com',98858,834,'R002'),(260,1150,'David Anderson','32','9yPbRahY@gmail.com',93638,709,'R003'),(262,1151,'Emily Smith','55','qO72GDhr@yahoo.com',96208,755,'R004'),(264,1152,'Olivia Johnson','28','8UnJ8r3J@yahoo.com',91868,728,'R001'),(265,1153,'Michael Smith','24','eu41BWsV@yahoo.com',93713,792,'R002'),(266,1154,'Jane Wilson','42','Ga1mXwlW@hotmail.com',93117,711,'R003'),(268,1155,'Jane Taylor','48','GNPeo8JR@yahoo.com',97480,731,'R004'),(270,1156,'Jane Brown','25','Em1jd0PD@yahoo.com',93291,737,'R001'),(272,1157,'Jane Anderson','27','YhrwBJbM@yahoo.com',98229,782,'R002'),(273,1158,'John Brown','46','3051UqH5@gmail.com',98639,726,'R003'),(275,1159,'David Brown','49','aWY6bY29@hotmail.com',96991,792,'R004'),(276,1160,'David Smith','58','nzwchVfy@gmail.com',93063,721,'R001'),(277,1161,'David Anderson','35','Q7ZncYhR@hotmail.com',94191,792,'R002'),(278,1162,'Michael Smith','39','TBi9cNhb@yahoo.com',96108,841,'R003'),(279,1163,'David Brown','44','09ebp6Tb@hotmail.com',91001,750,'R004'),(280,1164,'David Johnson','60','m5b4pPwq@hotmail.com',92439,844,'R001'),(281,1165,'Emily Wilson','49','4cXxKlvr@hotmail.com',90801,777,'R002'),(282,1166,'John Brown','40','EltYAVp0@yahoo.com',96050,780,'R003'),(283,1167,'Michael Taylor','28','CDhlbIxB@hotmail.com',92542,836,'R004'),(284,1168,'John Anderson','24','BHUbmhec@yahoo.com',90525,845,'R001'),(285,1169,'Michael Wilson','42','mlNOLdGh@yahoo.com',91224,764,'R002'),(286,1170,'Michael Anderson','37','BtKciykE@yahoo.com',93091,790,'R003'),(287,1171,'Michael Brown','52','CcXVBn4F@hotmail.com',97979,718,'R004'),(288,1172,'Olivia Johnson','28','GjFQusDl@yahoo.com',98396,806,'R001'),(289,1173,'Michael Brown','33','3uvgRhhU@yahoo.com',99303,790,'R002'),(291,1174,'Michael Johnson','35','6QKFLumn@hotmail.com',98144,798,'R003'),(292,1175,'David Anderson','35','QE2DZQCi@gmail.com',96648,749,'R004'),(293,1176,'John Smith','37','5KKWEqW0@yahoo.com',97221,701,'R001'),(294,1177,'Emily Wilson','38','07dT0Ewe@yahoo.com',93149,803,'R002'),(295,1178,'Michael Anderson','35','erk2ChLn@yahoo.com',92978,730,'R003'),(296,1179,'Olivia Wilson','36','vX8KnXzN@yahoo.com',97786,736,'R004'),(297,1020,'Olivia Johnson','29','nTkaXl93@yahoo.com',92522,774,'R001'),(298,1021,'Emily Brown','27','deXcv9YG@yahoo.com',98272,848,'R002'),(299,1022,'Olivia Taylor','42','XXRczCzo@yahoo.com',97838,704,'R003'),(300,1023,'Michael Anderson','52','YPwEsoIx@gmail.com',92183,744,'R004');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `EmployeeID` varchar(10) DEFAULT NULL,
  `EmployeeName` varchar(55) NOT NULL,
  `EmployeeRating` int NOT NULL,
  `EmployeePhone` varchar(20) DEFAULT NULL,
  `EmployeeKey` int NOT NULL,
  PRIMARY KEY (`EmployeeKey`),
  KEY `idx_EmployeeKey` (`EmployeeKey`),
  KEY `idx1_EmployeeID` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES ('EMP01','John Smith',5,'+1 (212) 555-1234',1),('EMP02','Jane Doe',4,'+1 (213) 555-5678',2),('EMP03','Mike Johnson',4,'+1 (310) 555-9012',3),('EMP04','Sarah Lee',5,'+1 (415) 555-3456',4),('EMP05','David Kim',4,'+1 (312) 555-7890',5),('EMP06','Karen Chen',4,'+1 (650) 555-2345',6),('EMP07','Mark Davis',4,'+1 (202) 555-6789',7),('EMP08','Emily Brown',4,'+1 (617) 555-0123',8),('EMP09','Kevin Park',4,'+1 (347) 555-4567',9),('EMP10','Grace Kim',4,'+1 (305) 555-8901',10);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feedback`
--

DROP TABLE IF EXISTS `Feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feedback` (
  `FeedbackKey` int NOT NULL AUTO_INCREMENT,
  `Winename` varchar(255) NOT NULL DEFAULT '255',
  `Rating` int NOT NULL,
  `PurchaseExperience` int NOT NULL,
  PRIMARY KEY (`FeedbackKey`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feedback`
--

LOCK TABLES `Feedback` WRITE;
/*!40000 ALTER TABLE `Feedback` DISABLE KEYS */;
INSERT INTO `Feedback` VALUES (4,'Apothic Inferno Red Blend',4,4),(5,'Barefoot Pinot Grigio',5,5),(6,'Caymus Cabernet Sauvignon',4,5),(7,'Chateau d Esclans Whispering Angel Rose',4,5),(8,'Barefoot Moscato',5,3),(9,'Bogle Chardonnay',5,4),(10,'Bogle Vineyards Petite Sirah',3,4),(11,'Barefoot Moscato',5,4),(12,'Bogle Chardonnay',5,4),(13,'Apothic Red Blend',4,4),(14,'Barefoot White Zinfandel',5,4),(15,'Apothic Inferno Red Blend',4,4),(16,'Barefoot Merlot',4,5),(17,'Bogle Sauvignon Blanc',4,5),(18,'WineName',5,5),(19,'Barefoot Pinot Grigio',4,5),(20,'Caymus Cabernet Sauvignon',5,5),(21,'Chateau d Esclans Whispering Angel Rose',4,5),(22,'Barefoot Moscato',5,5),(23,'Bogle Chardonnay',5,5),(24,'Barefoot Moscato',4,5),(25,'Bogle Chardonnay',5,4),(26,'Apothic Red Blend',4,4),(27,'Barefoot White Zinfandel',4,4),(28,'Emmolo Sauvignon Blanc',4,4),(29,'Apothic Inferno Red Blend',5,4),(30,'Barefoot White Zinfandel',4,3),(31,'Emmolo Sauvignon Blanc',4,3),(32,'Apothic Inferno Red Blend',4,5),(33,'Barefoot Merlot',4,5),(34,'Bogle Sauvignon Blanc',4,5),(35,'Bogle Vineyards Petite Sirah',5,4),(36,'WineName',4,4),(37,'Barefoot Pinot Grigio',5,4),(38,'Caymus Cabernet Sauvignon',5,4),(39,'Chateau d Esclans Whispering Angel Rose',5,5),(40,'Barefoot Moscato',5,5),(41,'Bogle Chardonnay',5,5),(42,'Apothic Red Blend',5,5),(43,'Barefoot White Zinfandel',5,5),(44,'Emmolo Sauvignon Blanc',5,5),(45,'Apothic Inferno Red Blend',4,5),(46,'Barefoot Merlot',4,5),(47,'Bogle Sauvignon Blanc',4,5),(48,'Bogle Vineyards Petite Sirah',4,5),(49,'Barefoot Pinot Grigio',3,4),(50,'Caymus Cabernet Sauvignon',3,4),(51,'Chateau d Esclans Whispering Angel Rose',3,3),(52,'Barefoot Moscato',3,5),(53,'Bogle Chardonnay',3,3),(54,'Apothic Red Blend',3,4),(55,'Barefoot White Zinfandel',5,4),(56,'Emmolo Sauvignon Blanc',5,4),(57,'Apothic Inferno Red Blend',5,4),(58,'Barefoot Merlot',5,3),(59,'Bogle Sauvignon Blanc',5,4),(60,'Bogle Vineyards Petite Sirah',5,3),(61,'Caymus Cabernet Sauvignon',5,4),(62,'Chateau d Esclans Whispering Angel Rose',5,4),(63,'Barefoot Moscato',5,4),(64,'Bogle Chardonnay',5,4),(65,'Apothic Red Blend',5,4),(66,'Barefoot Pinot Grigio',5,4),(67,'Caymus Cabernet Sauvignon',5,4),(68,'Chateau d Esclans Whispering Angel Rose',5,4),(69,'Emmolo Sauvignon Blanc',3,4),(70,'Apothic Inferno Red Blend',3,3),(71,'Barefoot Merlot',3,3),(72,'Bogle Sauvignon Blanc',3,3),(73,'Bogle Vineyards Petite Sirah',3,5),(74,'Barefoot Pinot Grigio',2,3),(75,'Caymus Cabernet Sauvignon',1,2),(76,'Chateau d Esclans Whispering Angel Rose',2,3),(77,'Barefoot Moscato',1,3),(78,'Bogle Chardonnay',2,1),(79,'Apothic Red Blend',1,1),(80,'Barefoot White Zinfandel',2,2),(81,'Emmolo Sauvignon Blanc',1,3),(82,'Apothic Inferno Red Blend',2,1),(83,'Barefoot Merlot',1,3),(84,'Bogle Sauvignon Blanc',2,3),(85,'Bogle Vineyards Petite Sirah',2,3),(86,'Apothic Red Blend',5,5),(87,'Barefoot White Zinfandel',4,5),(88,'Emmolo Sauvignon Blanc',4,5),(89,'Apothic Inferno Red Blend',4,5),(90,'Barefoot Merlot',5,5),(91,'Bogle Sauvignon Blanc',5,4),(92,'Bogle Vineyards Petite Sirah',5,4),(93,'Caymus Cabernet Sauvignon',4,4),(94,'Chateau d Esclans Whispering Angel Rose',5,4),(95,'Barefoot Moscato',4,4),(96,'Bogle Chardonnay',4,3),(97,'Apothic Red Blend',4,3),(98,'Barefoot Pinot Grigio',5,5),(99,'Caymus Cabernet Sauvignon',4,5),(100,'Chateau d Esclans Whispering Angel Rose',5,5),(101,'Emmolo Sauvignon Blanc',4,3),(102,'Apothic Inferno Red Blend',5,4),(103,'Barefoot Merlot',5,4),(104,'Bogle Sauvignon Blanc',4,4),(105,'Bogle Vineyards Petite Sirah',5,4),(106,'Barefoot Pinot Grigio',4,4),(107,'Caymus Cabernet Sauvignon',4,4),(108,'Chateau d Esclans Whispering Angel Rose',4,4),(109,'Barefoot Moscato',5,4),(110,'Bogle Chardonnay',4,3),(111,'Apothic Red Blend',4,3),(112,'Barefoot White Zinfandel',4,5),(113,'Emmolo Sauvignon Blanc',4,5),(114,'Apothic Inferno Red Blend',4,5),(115,'Barefoot Merlot',5,3),(116,'Bogle Sauvignon Blanc',4,4),(117,'Barefoot Moscato',5,4),(118,'Bogle Chardonnay',5,5),(119,'Apothic Red Blend',5,3),(120,'Barefoot White Zinfandel',5,4),(121,'Emmolo Sauvignon Blanc',5,4),(122,'Apothic Inferno Red Blend',5,4),(123,'Barefoot White Zinfandel',5,4),(124,'Emmolo Sauvignon Blanc',4,4),(125,'Apothic Inferno Red Blend',5,4),(126,'Barefoot Merlot',5,4),(127,'Bogle Sauvignon Blanc',4,5),(128,'Bogle Vineyards Petite Sirah',5,5),(129,'WineName',4,5),(130,'Barefoot Pinot Grigio',4,5),(131,'Caymus Cabernet Sauvignon',4,5),(132,'Chateau d Esclans Whispering Angel Rose',5,5),(133,'Barefoot Moscato',4,5),(134,'Bogle Chardonnay',4,5),(135,'Apothic Red Blend',4,3),(136,'Barefoot White Zinfandel',4,1),(137,'Emmolo Sauvignon Blanc',4,1),(138,'Apothic Inferno Red Blend',5,2),(139,'Barefoot Merlot',3,3),(140,'Bogle Sauvignon Blanc',3,1),(141,'Bogle Vineyards Petite Sirah',3,3),(142,'Barefoot Pinot Grigio',3,3),(143,'Caymus Cabernet Sauvignon',3,3),(144,'Barefoot White Zinfandel',5,5),(145,'Emmolo Sauvignon Blanc',5,5),(146,'Apothic Inferno Red Blend',5,3),(147,'Barefoot Merlot',5,2),(148,'Bogle Sauvignon Blanc',5,3),(149,'Bogle Vineyards Petite Sirah',5,5),(150,'WineName',5,3),(151,'Barefoot Pinot Grigio',5,2),(152,'Caymus Cabernet Sauvignon',4,4);
/*!40000 ALTER TABLE `Feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inventory`
--

DROP TABLE IF EXISTS `Inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inventory` (
  `InventoryKey` int NOT NULL AUTO_INCREMENT,
  `InventoryID` int NOT NULL,
  `WineID` varchar(25) NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`InventoryKey`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inventory`
--

LOCK TABLES `Inventory` WRITE;
/*!40000 ALTER TABLE `Inventory` DISABLE KEYS */;
INSERT INTO `Inventory` VALUES (1,1,'WINE001',50),(2,2,'WINE002',66),(3,3,'WINE003',83),(4,4,'WINE004',22),(5,5,'WINE005',37),(6,6,'WINE006',15),(7,7,'WINE007',47),(8,8,'WINE008',90),(9,9,'WINE009',28),(10,10,'WINE010',41),(11,11,'WINE011',10),(12,12,'WINE012',5);
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MarketingEvent`
--

DROP TABLE IF EXISTS `MarketingEvent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MarketingEvent` (
  `EventKey` int NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `EventName` varchar(255) NOT NULL,
  `Attendees` int NOT NULL,
  `RSVPs` int NOT NULL,
  `FreeTastings` int NOT NULL,
  `Year` int NOT NULL,
  `Quarter` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`EventKey`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MarketingEvent`
--

LOCK TABLES `MarketingEvent` WRITE;
/*!40000 ALTER TABLE `MarketingEvent` DISABLE KEYS */;
INSERT INTO `MarketingEvent` VALUES (1,'2018-03-10','Wine Wonderland',200,180,50,2018,'Q1'),(2,'2018-06-15','Grape Escape',150,130,30,2018,'Q2'),(3,'2018-09-22','Bottles & Bites',100,90,20,2018,'Q3'),(4,'2018-11-17','Harvest Fest',180,160,40,2018,'Q4'),(5,'2019-03-09','Wine Wonderland',220,200,60,2019,'Q1'),(6,'2019-06-14','Grape Escape',170,150,35,2019,'Q2'),(7,'2019-09-21','Bottles & Bites',120,100,25,2019,'Q3'),(8,'2019-11-16','Harvest Fest',200,180,50,2019,'Q4'),(9,'2020-03-14','Wine Wonderland',180,160,40,2020,'Q1'),(10,'2020-06-19','Grape Escape',130,110,30,2020,'Q2'),(11,'2020-09-26','Bottles & Bites',90,70,15,2020,'Q3'),(12,'2020-11-21','Harvest Fest',170,150,35,2020,'Q4'),(13,'2021-03-13','Wine Wonderland',240,220,70,2021,'Q1'),(14,'2021-06-18','Grape Escape',180,160,40,2021,'Q2'),(15,'2021-09-25','Bottles & Bites',130,110,30,2021,'Q3'),(16,'2021-11-20','Harvest Fest',200,180,50,2021,'Q4'),(17,'2022-03-12','Wine Wonderland',200,180,50,2022,'Q1'),(18,'2022-06-17','Grape Escape',150,130,30,2022,'Q2'),(19,'2022-09-24','Bottles & Bites',100,90,20,2022,'Q3'),(20,'2022-11-19','Harvest Fest',180,160,40,2022,'Q4'),(21,'2023-03-11','Wine Wonderland',220,200,60,2023,'Q1'),(22,'2023-06-16','Grape Escape',170,150,35,2023,'Q2'),(23,'2023-09-23','Bottles & Bites',120,100,25,2023,'Q3'),(24,'2023-11-18','Harvest Fest',200,180,50,2023,'Q4'),(25,'2018-04-14','Wine & Dine',100,90,20,2018,'Q2'),(26,'2018-07-21','Vino Fiesta',150,130,30,2018,'Q3'),(27,'2018-10-27','Sip & Savor',200,180,50,2018,'Q4'),(28,'2019-04-13','Wine & Dine',120,100,25,2019,'Q2'),(29,'2019-07-20','Vino Fiesta',170,150,35,2019,'Q3'),(30,'2019-10-26','Sip & Savor',220,200,60,2019,'Q4');
/*!40000 ALTER TABLE `MarketingEvent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `OrderID` varchar(25) NOT NULL,
  `TotalAmount` float NOT NULL,
  `Coupon` varchar(30) NOT NULL,
  `CustomerID` int NOT NULL,
  `OrdersKey` int NOT NULL AUTO_INCREMENT,
  `Date` date DEFAULT NULL,
  PRIMARY KEY (`OrdersKey`)
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES ('ORD001',748.3,'SPRING10',1003,1,'2023-05-05'),('ORD002',623.99,'SUMMER25',1003,2,'2023-05-05'),('ORD003',623.99,'SUMMER25',1003,3,'2023-05-05'),('ORD004',623.99,'SUMMER25',1003,4,'2023-05-05'),('ORD005',748.3,'SPRING10',1003,5,'2023-05-05'),('ORD006',711.75,'SUMMER25',1003,6,'2023-05-06'),('ORD007',836.99,'',1003,7,'2023-05-06'),('ORD008',884.68,'SPRING10',1003,8,'2023-05-06'),('ORD10',997.94,'NEWCUSTOMER',1108,9,'2022-05-14'),('ORD100',465.76,'SUMMER25',1120,10,'2022-11-20'),('ORD101',773.93,'DISCOUNT5',1068,11,'2022-11-09'),('ORD102',985.46,'BIRTHDAY10',1130,12,'2022-08-06'),('ORD103',335.45,'SUMMER25',1059,13,'2022-07-18'),('ORD104',929.7,'NEWCUSTOMER',1003,14,'2022-11-03'),('ORD105',719.56,'SPRING10',1112,15,'2022-08-30'),('ORD106',231.9,'SUMMER25',1077,16,'2022-10-10'),('ORD107',698.28,'BIRTHDAY10',1165,17,'2022-07-25'),('ORD108',670.91,'SUMMER25',1096,18,'2022-07-26'),('ORD109',208.38,'SUMMER25',1089,19,'2023-03-25'),('ORD11',165.93,'FREESHIP',1074,20,'2023-01-15'),('ORD110',624.22,'FREESHIP',1121,21,'2022-07-24'),('ORD111',544.62,'NEWCUSTOMER',1030,22,'2022-10-24'),('ORD112',504.06,'SUMMER25',1114,23,'2022-10-21'),('ORD113',165.04,'NEWCUSTOMER',1109,24,'2022-12-12'),('ORD114',885.55,'SPRING10',1087,25,'2022-10-13'),('ORD115',115.39,'NEWCUSTOMER',1052,26,'2022-05-14'),('ORD116',150.76,'SUMMER25',1092,27,'2022-05-29'),('ORD117',412.86,'BIRTHDAY10',1116,28,'2022-08-17'),('ORD118',650.39,'FREESHIP',1104,29,'2022-09-23'),('ORD119',859.4,'BIRTHDAY10',1031,30,'2023-02-24'),('ORD12',515.23,'SPRING10',1111,31,'2022-09-21'),('ORD120',969.92,'NEWCUSTOMER',1173,32,'2023-03-09'),('ORD121',325.27,'SUMMER25',1091,33,'2023-03-18'),('ORD122',106.61,'DISCOUNT5',1061,34,'2022-10-14'),('ORD123',877.51,'FREESHIP',1029,35,'2022-05-30'),('ORD124',541.88,'NEWCUSTOMER',1062,36,'2023-01-31'),('ORD125',220.54,'BIRTHDAY10',1037,37,'2022-08-05'),('ORD126',109.42,'FREESHIP',1035,38,'2022-09-06'),('ORD127',349.7,'NEWCUSTOMER',1127,39,'2022-12-08'),('ORD128',940.93,'FREESHIP',1020,40,'2022-09-12'),('ORD129',859.8,'SPRING10',1073,41,'2023-03-19'),('ORD13',250.31,'FREESHIP',1174,42,'2022-12-25'),('ORD130',367.9,'BIRTHDAY10',1088,43,'2022-10-06'),('ORD131',904.59,'FREESHIP',1172,44,'2022-12-15'),('ORD132',110,'SPRING10',1155,45,'2022-09-09'),('ORD133',899.16,'BIRTHDAY10',1066,46,'2023-03-30'),('ORD134',788.6,'FREESHIP',1050,47,'2022-06-27'),('ORD135',159.74,'BIRTHDAY10',1078,48,'2022-07-29'),('ORD136',305.69,'FREESHIP',1113,49,'2022-09-23'),('ORD137',434.65,'NEWCUSTOMER',1110,50,'2022-09-25'),('ORD138',728.49,'BIRTHDAY10',1145,51,'2023-02-25'),('ORD139',164.28,'FREESHIP',1140,52,'2023-02-07'),('ORD14',149.86,'SPRING10',1051,53,'2022-07-24'),('ORD140',798.44,'NEWCUSTOMER',1026,54,'2022-07-11'),('ORD141',982.24,'BIRTHDAY10',1033,55,'2022-06-02'),('ORD142',353.54,'DISCOUNT5',1082,56,'2022-10-14'),('ORD143',640.95,'DISCOUNT5',1070,57,'2022-06-20'),('ORD144',941.76,'NEWCUSTOMER',1137,58,'2023-01-13'),('ORD145',790.57,'NEWCUSTOMER',1053,59,'2023-04-05'),('ORD146',808.27,'NEWCUSTOMER',1034,60,'2023-03-03'),('ORD147',150.24,'SUMMER25',1042,61,'2023-04-25'),('ORD148',166.1,'SPRING10',1056,62,'2023-01-16'),('ORD149',693.93,'BIRTHDAY10',1106,63,'2022-07-04'),('ORD15',865.83,'FREESHIP',1134,64,'2022-06-24'),('ORD150',201.46,'BIRTHDAY10',1057,65,'2023-03-13'),('ORD151',340.1,'SUMMER25',1080,66,'2022-06-19'),('ORD152',701.98,'SUMMER25',1124,67,'2022-11-09'),('ORD153',701.39,'SPRING10',1004,68,'2023-04-03'),('ORD154',953.6,'BIRTHDAY10',1038,69,'2022-10-20'),('ORD155',353.14,'BIRTHDAY10',1045,70,'2022-08-02'),('ORD156',745.46,'NEWCUSTOMER',1170,71,'2022-08-12'),('ORD157',956.82,'FREESHIP',1002,72,'2022-08-26'),('ORD158',592.7,'BIRTHDAY10',1166,73,'2022-10-30'),('ORD159',273.68,'DISCOUNT5',1133,74,'2022-11-26'),('ORD16',836.71,'DISCOUNT5',1179,75,'2022-10-06'),('ORD160',602.38,'NEWCUSTOMER',1099,76,'2022-08-02'),('ORD161',467.49,'DISCOUNT5',1090,77,'2023-02-14'),('ORD162',458.98,'BIRTHDAY10',1021,78,'2022-09-15'),('ORD163',145.29,'FREESHIP',1125,79,'2023-01-24'),('ORD164',209.87,'BIRTHDAY10',1060,80,'2022-05-05'),('ORD165',761.87,'NEWCUSTOMER',1081,81,'2022-11-01'),('ORD166',383.59,'BIRTHDAY10',1149,82,'2022-05-12'),('ORD167',659.74,'DISCOUNT5',1171,83,'2022-07-16'),('ORD168',4419.98,'',1003,84,'2023-05-11'),('ORD169',4419.98,'',1003,85,'2023-05-11'),('ORD17',501.84,'SPRING10',1129,86,'2022-09-19'),('ORD170',4419.98,'',1003,87,'2023-05-11'),('ORD171',4419.98,'',1003,88,'2023-05-11'),('ORD172',4419.98,'',1003,89,'2023-05-11'),('ORD173',4419.98,'',1003,90,'2023-05-11'),('ORD174',4775.4,'',1003,91,'2023-05-12'),('ORD175',807,'',1003,92,'2023-05-12'),('ORD176',3000.58,'',1003,93,'2023-05-12'),('ORD177',1945.96,'',1003,94,'2023-05-12'),('ORD178',2840,'',1003,95,'2023-05-13'),('ORD179',1130,'',1003,96,'2023-05-13'),('ORD18',392.38,'BIRTHDAY10',1152,97,'2023-03-11'),('ORD19',643.78,'SPRING10',1148,98,'2022-10-17'),('ORD20',570.26,'FREESHIP',1043,99,'2023-04-24'),('ORD200',1280.25,'FREESHIP',1079,100,'2020-08-21'),('ORD201',1606.42,'BIRTHDAY10',1077,101,'2021-04-18'),('ORD202',1837.79,'SUMMER25',1126,102,'2020-07-03'),('ORD203',1858,'SUMMER25',1147,103,'2019-04-01'),('ORD204',1367.58,'SUMMER25',1161,104,'2021-09-02'),('ORD205',1558.55,'BIRTHDAY10',1060,105,'2018-09-13'),('ORD206',1902.34,'BIRTHDAY10',1065,106,'2020-02-10'),('ORD207',1442.63,'DISCOUNT5',1061,107,'2018-05-19'),('ORD208',634.37,'SUMMER25',1055,108,'2019-12-04'),('ORD209',1798.41,'NEWCUSTOMER',1053,109,'2019-05-31'),('ORD21',844.32,'SPRING10',1039,110,'2023-04-29'),('ORD210',1865.68,'SPRING10',1047,111,'2020-04-05'),('ORD211',871.5,'BIRTHDAY10',1075,112,'2018-11-01'),('ORD212',1905.7,'BIRTHDAY10',1004,113,'2018-09-17'),('ORD213',1149.41,'DISCOUNT5',1026,114,'2021-10-18'),('ORD214',714.68,'NEWCUSTOMER',1169,115,'2021-11-06'),('ORD215',1242.99,'SPRING10',1174,116,'2018-06-22'),('ORD216',671.48,'SPRING10',1144,117,'2020-06-13'),('ORD217',908.49,'FREESHIP',1095,118,'2021-08-27'),('ORD218',1496.11,'FREESHIP',1102,119,'2021-04-08'),('ORD219',858.34,'SPRING10',1090,120,'2018-10-07'),('ORD22',221.5,'SPRING10',1076,121,'2022-10-15'),('ORD220',1788.12,'FREESHIP',1028,122,'2018-10-18'),('ORD221',752.7,'BIRTHDAY10',1109,123,'2020-12-12'),('ORD222',1359.62,'SPRING10',1125,124,'2019-05-25'),('ORD223',1979.86,'DISCOUNT5',1005,125,'2020-09-19'),('ORD224',1239.53,'DISCOUNT5',1029,126,'2019-07-22'),('ORD225',1768.3,'NEWCUSTOMER',1008,127,'2018-10-04'),('ORD226',1860.32,'SPRING10',1148,128,'2019-11-08'),('ORD227',1889.71,'SPRING10',1171,129,'2021-12-15'),('ORD228',565.93,'SPRING10',1049,130,'2020-12-11'),('ORD229',895.48,'SUMMER25',1163,131,'2019-07-07'),('ORD23',837.69,'FREESHIP',1041,132,'2023-03-09'),('ORD230',549.23,'BIRTHDAY10',1051,133,'2021-10-18'),('ORD231',517.25,'NEWCUSTOMER',1045,134,'2021-08-31'),('ORD232',1582.55,'FREESHIP',1033,135,'2018-05-03'),('ORD233',1131.86,'NEWCUSTOMER',1035,136,'2018-09-16'),('ORD234',1794.77,'SPRING10',1099,137,'2021-10-04'),('ORD235',912.02,'SUMMER25',1159,138,'2021-11-19'),('ORD236',1306.26,'NEWCUSTOMER',1009,139,'2019-12-12'),('ORD237',1584.06,'NEWCUSTOMER',1066,140,'2021-12-03'),('ORD238',1110.95,'SPRING10',1132,141,'2019-11-27'),('ORD239',1092.58,'SUMMER25',1069,142,'2020-06-20'),('ORD24',164.4,'BIRTHDAY10',1001,143,'2022-10-27'),('ORD240',776.66,'BIRTHDAY10',1111,144,'2021-09-20'),('ORD241',540.37,'FREESHIP',1145,145,'2019-06-10'),('ORD242',1952.14,'SPRING10',1110,146,'2021-10-12'),('ORD243',564.73,'NEWCUSTOMER',1052,147,'2020-08-26'),('ORD244',795.45,'SUMMER25',1112,148,'2021-03-18'),('ORD245',1691.4,'DISCOUNT5',1022,149,'2020-08-30'),('ORD246',921.43,'NEWCUSTOMER',1166,150,'2021-03-25'),('ORD247',1126.03,'SPRING10',1103,151,'2020-10-16'),('ORD248',1287.26,'SPRING10',1041,152,'2018-08-27'),('ORD249',967.02,'SPRING10',1115,153,'2018-09-21'),('ORD25',114.11,'FREESHIP',1008,154,'2022-12-18'),('ORD250',1214,'BIRTHDAY10',1133,155,'2021-04-03'),('ORD251',634.34,'SPRING10',1032,156,'2019-10-24'),('ORD252',542.57,'SUMMER25',1170,157,'2020-10-28'),('ORD253',963.71,'NEWCUSTOMER',1082,158,'2021-11-28'),('ORD254',876.66,'SUMMER25',1050,159,'2021-04-28'),('ORD255',1225.76,'NEWCUSTOMER',1059,160,'2020-08-16'),('ORD256',527.39,'SUMMER25',1093,161,'2019-12-03'),('ORD257',1879.58,'DISCOUNT5',1149,162,'2021-01-07'),('ORD258',1317.3,'SPRING10',1048,163,'2020-12-24'),('ORD259',1100.57,'SPRING10',1038,164,'2019-10-02'),('ORD26',570.43,'FREESHIP',1153,165,'2022-08-05'),('ORD260',1841.86,'SPRING10',1120,166,'2021-11-14'),('ORD261',1348.8,'FREESHIP',1058,167,'2018-06-26'),('ORD262',1856.06,'NEWCUSTOMER',1096,168,'2020-01-07'),('ORD263',1294.92,'FREESHIP',1001,169,'2021-11-13'),('ORD264',701.87,'SUMMER25',1113,170,'2020-03-30'),('ORD265',1461.02,'NEWCUSTOMER',1128,171,'2019-02-25'),('ORD266',626.31,'SPRING10',1106,172,'2020-06-29'),('ORD267',1093.68,'DISCOUNT5',1172,173,'2019-03-27'),('ORD268',678.97,'BIRTHDAY10',1154,174,'2020-02-05'),('ORD269',1307.71,'DISCOUNT5',1021,175,'2018-05-03'),('ORD27',943.21,'SUMMER25',1028,176,'2022-07-29'),('ORD270',506.42,'SUMMER25',1138,177,'2021-04-16'),('ORD271',1135.16,'NEWCUSTOMER',1003,178,'2018-09-11'),('ORD272',1587.65,'FREESHIP',1124,179,'2019-06-03'),('ORD273',792.45,'DISCOUNT5',1136,180,'2019-04-25'),('ORD274',1784.56,'DISCOUNT5',1119,181,'2019-04-17'),('ORD275',1959.02,'DISCOUNT5',1156,182,'2020-03-15'),('ORD276',745.24,'SUMMER25',1031,183,'2018-08-06'),('ORD277',720.45,'SPRING10',1168,184,'2021-11-08'),('ORD278',1227.64,'FREESHIP',1152,185,'2019-09-11'),('ORD279',1709.96,'SUMMER25',1063,186,'2018-08-04'),('ORD28',175.68,'BIRTHDAY10',1049,187,'2022-09-26'),('ORD280',573.89,'FREESHIP',1027,188,'2018-08-29'),('ORD281',1007.49,'NEWCUSTOMER',1121,189,'2021-11-24'),('ORD282',897.64,'DISCOUNT5',1078,190,'2020-12-27'),('ORD283',1158.93,'SPRING10',1129,191,'2018-08-15'),('ORD284',1656.45,'SUMMER25',1108,192,'2021-09-28'),('ORD285',1343.77,'BIRTHDAY10',1105,193,'2019-02-07'),('ORD286',861.49,'FREESHIP',1071,194,'2020-07-20'),('ORD287',1839.93,'BIRTHDAY10',1118,195,'2019-03-05'),('ORD288',1315.09,'FREESHIP',1153,196,'2020-03-23'),('ORD289',1456.11,'SUMMER25',1024,197,'2019-10-16'),('ORD29',470.49,'BIRTHDAY10',1040,198,'2023-03-27'),('ORD290',854.23,'NEWCUSTOMER',1057,199,'2021-12-26'),('ORD291',1764.64,'BIRTHDAY10',1067,200,'2020-10-27'),('ORD292',1273.78,'SPRING10',1062,201,'2019-12-12'),('ORD293',1676.55,'FREESHIP',1023,202,'2021-03-17'),('ORD294',1397.29,'DISCOUNT5',1143,203,'2021-07-03'),('ORD295',1793.72,'BIRTHDAY10',1137,204,'2021-03-24'),('ORD296',1633.17,'NEWCUSTOMER',1146,205,'2021-06-24'),('ORD297',1417.07,'BIRTHDAY10',1100,206,'2018-10-19'),('ORD298',1251.13,'DISCOUNT5',1056,207,'2018-12-08'),('ORD299',1345.82,'SUMMER25',1114,208,'2019-06-05'),('ORD30',773.86,'BIRTHDAY10',1069,209,'2022-07-27'),('ORD300',807.2,'SPRING10',1097,210,'2021-03-15'),('ORD301',901.01,'FREESHIP',1025,211,'2018-10-16'),('ORD302',1524.11,'SUMMER25',1151,212,'2020-12-19'),('ORD303',936.62,'DISCOUNT5',1046,213,'2019-03-07'),('ORD304',1409.32,'FREESHIP',1036,214,'2018-11-28'),('ORD305',1717.85,'BIRTHDAY10',1006,215,'2020-02-06'),('ORD306',1540.69,'FREESHIP',1020,216,'2019-05-02'),('ORD307',1404.36,'FREESHIP',1080,217,'2018-10-30'),('ORD308',582.94,'SUMMER25',1157,218,'2019-05-25'),('ORD309',1546.62,'SUMMER25',1177,219,'2018-08-14'),('ORD31',970.33,'SUMMER25',1093,220,'2022-07-21'),('ORD310',848.24,'SUMMER25',1088,221,'2020-02-14'),('ORD311',1864.01,'SUMMER25',1072,222,'2021-03-24'),('ORD312',1533.24,'FREESHIP',1127,223,'2018-05-13'),('ORD313',1497.01,'SUMMER25',1002,224,'2019-08-05'),('ORD314',1559.22,'DISCOUNT5',1037,225,'2021-07-12'),('ORD315',527.76,'NEWCUSTOMER',1160,226,'2020-01-10'),('ORD316',1697.92,'FREESHIP',1068,227,'2020-06-28'),('ORD317',675.07,'FREESHIP',1074,228,'2020-10-03'),('ORD318',1043.21,'BIRTHDAY10',1064,229,'2021-08-02'),('ORD319',1989.95,'NEWCUSTOMER',1087,230,'2019-02-21'),('ORD32',589.34,'FREESHIP',1044,231,'2022-09-21'),('ORD320',706.18,'DISCOUNT5',1054,232,'2018-06-22'),('ORD321',1169.72,'SUMMER25',1092,233,'2019-12-29'),('ORD322',1028.02,'BIRTHDAY10',1155,234,'2018-11-19'),('ORD323',539.17,'NEWCUSTOMER',1081,235,'2018-12-11'),('ORD324',511.21,'FREESHIP',1134,236,'2021-02-15'),('ORD325',917.47,'SUMMER25',1150,237,'2018-05-02'),('ORD326',1709.85,'DISCOUNT5',1158,238,'2020-07-16'),('ORD327',1216.31,'DISCOUNT5',1085,239,'2019-09-02'),('ORD328',1230.67,'SPRING10',1044,240,'2021-06-12'),('ORD329',553.08,'BIRTHDAY10',1042,241,'2019-07-23'),('ORD33',252.83,'NEWCUSTOMER',1010,242,'2022-08-01'),('ORD330',1659.21,'SPRING10',1007,243,'2021-04-10'),('ORD331',1598.59,'SPRING10',1164,244,'2020-05-27'),('ORD332',1129.58,'DISCOUNT5',1131,245,'2021-02-25'),('ORD333',1596.1,'DISCOUNT5',1073,246,'2021-06-21'),('ORD334',879.79,'DISCOUNT5',1039,247,'2021-09-01'),('ORD335',1309.56,'SUMMER25',1086,248,'2019-03-09'),('ORD336',500.49,'SUMMER25',1142,249,'2021-08-18'),('ORD337',546.94,'BIRTHDAY10',1130,250,'2019-09-19'),('ORD338',1796.16,'FREESHIP',1094,251,'2021-03-25'),('ORD339',893.75,'FREESHIP',1040,252,'2020-08-27'),('ORD34',658.42,'SUMMER25',1007,253,'2022-11-23'),('ORD340',1648.08,'SPRING10',1175,254,'2018-09-01'),('ORD341',1211.56,'NEWCUSTOMER',1030,255,'2020-05-01'),('ORD342',1530.94,'BIRTHDAY10',1076,256,'2021-07-22'),('ORD343',1721.8,'BIRTHDAY10',1010,257,'2020-06-26'),('ORD344',1556.08,'BIRTHDAY10',1034,258,'2020-05-14'),('ORD345',989.5,'FREESHIP',1173,259,'2021-10-06'),('ORD346',1765.82,'BIRTHDAY10',1089,260,'2019-10-01'),('ORD347',1761.11,'BIRTHDAY10',1083,261,'2018-10-19'),('ORD348',873.55,'SPRING10',1122,262,'2018-07-31'),('ORD349',1697.12,'FREESHIP',1084,263,'2021-03-29'),('ORD35',102.91,'NEWCUSTOMER',1143,264,'2022-12-20'),('ORD350',1516.11,'NEWCUSTOMER',1104,265,'2018-07-31'),('ORD351',1395.27,'NEWCUSTOMER',1179,266,'2021-05-12'),('ORD352',552.35,'NEWCUSTOMER',1043,267,'2019-10-22'),('ORD353',1004.4,'FREESHIP',1165,268,'2019-09-28'),('ORD354',864.86,'BIRTHDAY10',1116,269,'2020-07-13'),('ORD355',647.74,'SPRING10',1167,270,'2021-05-01'),('ORD356',1853.91,'SPRING10',1091,271,'2021-04-02'),('ORD357',1562.84,'SUMMER25',1140,272,'2021-11-22'),('ORD358',1425.73,'SPRING10',1070,273,'2019-08-08'),('ORD359',1887.29,'BIRTHDAY10',1098,274,'2021-02-27'),('ORD36',918.41,'NEWCUSTOMER',1058,275,'2022-07-14'),('ORD37',404.36,'BIRTHDAY10',1167,276,'2022-11-26'),('ORD38',150.28,'NEWCUSTOMER',1122,277,'2023-04-09'),('ORD39',578.44,'SUMMER25',1131,278,'2022-12-18'),('ORD40',171.84,'BIRTHDAY10',1095,279,'2022-12-30'),('ORD41',462.81,'DISCOUNT5',1083,280,'2022-11-22'),('ORD42',916.28,'SUMMER25',1177,281,'2023-03-20'),('ORD43',828.23,'DISCOUNT5',1136,282,'2022-08-19'),('ORD44',697.9,'BIRTHDAY10',1118,283,'2022-05-04'),('ORD45',853.05,'BIRTHDAY10',1142,284,'2023-02-08'),('ORD46',463.56,'SPRING10',1027,285,'2022-08-29'),('ORD47',462.29,'FREESHIP',1054,286,'2022-06-13'),('ORD48',363.91,'SUMMER25',1144,287,'2023-01-20'),('ORD49',359.8,'NEWCUSTOMER',1064,288,'2022-07-20'),('ORD50',235.39,'DISCOUNT5',1150,289,'2023-02-27'),('ORD51',617.38,'DISCOUNT5',1065,290,'2022-07-08'),('ORD52',643.66,'NEWCUSTOMER',1115,291,'2022-05-25'),('ORD53',236.73,'SUMMER25',1063,292,'2022-11-06'),('ORD54',865.84,'FREESHIP',1072,293,'2022-11-22'),('ORD55',256.5,'DISCOUNT5',1102,294,'2023-01-01'),('ORD56',257.58,'SUMMER25',1048,295,'2022-05-06'),('ORD57',956.47,'SPRING10',1079,296,'2022-08-15'),('ORD58',647.76,'FREESHIP',1158,297,'2022-11-05'),('ORD59',193.11,'FREESHIP',1151,298,'2022-11-11'),('ORD60',776.68,'FREESHIP',1022,299,'2022-12-18'),('ORD61',244.69,'SUMMER25',1047,300,'2022-10-18'),('ORD62',899.33,'NEWCUSTOMER',1161,301,'2023-03-05'),('ORD63',180.25,'NEWCUSTOMER',1164,302,'2023-01-29'),('ORD64',320,'SUMMER25',1005,303,'2023-03-03'),('ORD65',922.92,'DISCOUNT5',1032,304,'2023-04-25'),('ORD66',879.27,'DISCOUNT5',1160,305,'2023-03-22'),('ORD67',721.2,'DISCOUNT5',1175,306,'2023-03-30'),('ORD68',515.37,'FREESHIP',1132,307,'2022-09-01'),('ORD69',684.48,'FREESHIP',1086,308,'2023-04-04'),('ORD70',671.37,'SUMMER25',1085,309,'2022-11-05'),('ORD700',269.02,'FREESHIP',1169,310,'2023-04-01'),('ORD71',823.82,'NEWCUSTOMER',1023,311,'2023-03-21'),('ORD72',269.48,'FREESHIP',1009,312,'2022-10-02'),('ORD73',653.06,'DISCOUNT5',1071,313,'2022-07-06'),('ORD74',471.93,'SPRING10',1006,314,'2022-11-02'),('ORD75',513.95,'BIRTHDAY10',1146,315,'2022-09-08'),('ORD76',651.6,'DISCOUNT5',1046,316,'2022-06-13'),('ORD77',126.91,'SPRING10',1156,317,'2022-11-16'),('ORD78',672.64,'SPRING10',1024,318,'2022-12-19'),('ORD79',127.99,'DISCOUNT5',1094,319,'2022-11-15'),('ORD80',831.66,'SPRING10',1147,320,'2022-10-13'),('ORD81',375.21,'NEWCUSTOMER',1159,321,'2023-03-01'),('ORD82',583.77,'BIRTHDAY10',1067,322,'2023-03-06'),('ORD83',515.49,'SUMMER25',1097,323,'2022-11-28'),('ORD84',476.96,'SUMMER25',1168,324,'2022-11-14'),('ORD85',624.96,'NEWCUSTOMER',1100,325,'2023-02-07'),('ORD86',278.96,'NEWCUSTOMER',1055,326,'2022-09-11'),('ORD87',497.36,'SPRING10',1075,327,'2022-11-18'),('ORD88',602.18,'SPRING10',1105,328,'2022-07-31'),('ORD89',433.06,'SPRING10',1103,329,'2022-08-22'),('ORD90',113.19,'BIRTHDAY10',1126,330,'2022-12-27'),('ORD91',893.49,'FREESHIP',1025,331,'2022-10-09'),('ORD92',606.9,'SPRING10',1098,332,'2022-07-12'),('ORD93',822.64,'BIRTHDAY10',1138,333,'2023-02-06'),('ORD94',398.56,'DISCOUNT5',1036,334,'2023-01-16'),('ORD95',353.34,'NEWCUSTOMER',1154,335,'2023-02-06'),('ORD96',495.07,'SUMMER25',1119,336,'2022-12-08'),('ORD97',355.79,'DISCOUNT5',1084,337,'2023-04-20'),('ORD98',544.07,'NEWCUSTOMER',1163,338,'2022-11-20'),('ORD99',528.47,'FREESHIP',1157,339,'2022-05-05');
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RevenuePerEvent`
--

DROP TABLE IF EXISTS `RevenuePerEvent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RevenuePerEvent` (
  `Revenue` decimal(10,2) DEFAULT NULL,
  `EventKey` int DEFAULT NULL,
  `EmployeeKey` int DEFAULT NULL,
  KEY `fk_EventKey` (`EventKey`),
  KEY `fk_EmployeeKey` (`EmployeeKey`),
  CONSTRAINT `fk_EmployeeKey` FOREIGN KEY (`EmployeeKey`) REFERENCES `Employee` (`EmployeeKey`),
  CONSTRAINT `fk_EventKey` FOREIGN KEY (`EventKey`) REFERENCES `MarketingEvent` (`EventKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RevenuePerEvent`
--

LOCK TABLES `RevenuePerEvent` WRITE;
/*!40000 ALTER TABLE `RevenuePerEvent` DISABLE KEYS */;
INSERT INTO `RevenuePerEvent` VALUES (40000.00,1,1),(25000.00,2,2),(15000.00,3,3),(35000.00,4,4),(45000.00,5,1),(28000.00,6,2),(18000.00,7,3),(40000.00,8,4),(42000.00,9,1),(27000.00,10,2),(16000.00,11,3),(32000.00,12,4),(50000.00,13,1),(30000.00,14,2),(20000.00,15,3),(40000.00,16,4),(48000.00,17,1),(25000.00,18,2),(14000.00,19,3),(35000.00,20,4),(50000.00,21,1),(28000.00,22,2),(17000.00,23,3),(42000.00,24,4),(15000.00,25,5),(28000.00,26,6),(35000.00,27,7),(18000.00,28,5),(30000.00,29,6),(45000.00,30,7);
/*!40000 ALTER TABLE `RevenuePerEvent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SalesPerCuWO`
--

DROP TABLE IF EXISTS `SalesPerCuWO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SalesPerCuWO` (
  `TotalAmount` float NOT NULL,
  `CustomerKey` int NOT NULL,
  `OrdersKey` int NOT NULL,
  `WineKey` int NOT NULL,
  KEY `CustomerKey` (`CustomerKey`),
  KEY `OrdersKey` (`OrdersKey`),
  KEY `WineKey` (`WineKey`),
  CONSTRAINT `SalesPerCuWO_ibfk_1` FOREIGN KEY (`CustomerKey`) REFERENCES `Customer` (`CustomerKey`),
  CONSTRAINT `SalesPerCuWO_ibfk_2` FOREIGN KEY (`OrdersKey`) REFERENCES `Orders` (`OrdersKey`),
  CONSTRAINT `SalesPerCuWO_ibfk_3` FOREIGN KEY (`WineKey`) REFERENCES `Wine` (`WineKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SalesPerCuWO`
--

LOCK TABLES `SalesPerCuWO` WRITE;
/*!40000 ALTER TABLE `SalesPerCuWO` DISABLE KEYS */;
/*!40000 ALTER TABLE `SalesPerCuWO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SalesPerWOC`
--

DROP TABLE IF EXISTS `SalesPerWOC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SalesPerWOC` (
  `CalendarKey` int NOT NULL,
  `WineKey` int NOT NULL,
  `OrdersKey` int NOT NULL,
  `RevenueInDollars` decimal(10,2) DEFAULT NULL,
  `UnitsSold` int DEFAULT NULL,
  PRIMARY KEY (`CalendarKey`,`WineKey`,`OrdersKey`),
  KEY `fk_wine` (`WineKey`),
  KEY `fk_orders` (`OrdersKey`),
  CONSTRAINT `SalesPerWOC_ibfk_1` FOREIGN KEY (`CalendarKey`) REFERENCES `Calendar` (`CalendarKey`),
  CONSTRAINT `SalesPerWOC_ibfk_2` FOREIGN KEY (`WineKey`) REFERENCES `Wine` (`WineKey`),
  CONSTRAINT `SalesPerWOC_ibfk_3` FOREIGN KEY (`OrdersKey`) REFERENCES `Orders` (`OrdersKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SalesPerWOC`
--

LOCK TABLES `SalesPerWOC` WRITE;
/*!40000 ALTER TABLE `SalesPerWOC` DISABLE KEYS */;
INSERT INTO `SalesPerWOC` VALUES (2,12,310,1995.00,5),(11,1,2,3796.00,4),(11,2,2,4965.00,5),(11,3,2,1580.00,5),(11,3,4,632.00,2),(11,4,1,807.00,1),(11,4,2,3228.00,4),(11,5,1,2420.00,5),(11,6,4,600.00,1),(11,7,3,2730.00,5),(11,8,2,731.00,1),(11,8,4,731.00,1),(11,8,5,2193.00,3),(11,9,1,648.00,3),(11,9,2,864.00,4),(11,12,1,798.00,2),(12,4,6,2421.00,3),(12,4,8,1614.00,2),(12,6,8,2400.00,4),(12,12,7,798.00,2),(13,2,26,993.00,1),(13,10,9,864.00,3),(13,10,26,864.00,3),(14,2,10,993.00,1),(14,11,10,838.00,2),(14,12,338,1596.00,4),(15,2,67,4965.00,5),(15,4,11,4035.00,5),(15,6,67,1200.00,2),(16,8,12,731.00,1),(17,3,13,1264.00,4),(18,1,14,3796.00,4),(19,5,15,2420.00,5),(20,5,16,1452.00,3),(20,12,16,1995.00,5),(21,2,17,3972.00,4),(21,11,17,1676.00,4),(22,5,18,1936.00,4),(22,12,18,1197.00,3),(23,5,19,484.00,1),(23,11,19,2095.00,5),(24,9,20,216.00,1),(25,2,53,993.00,1),(25,6,53,600.00,1),(25,11,21,2095.00,5),(26,4,22,3228.00,4),(26,10,22,576.00,2),(27,4,23,4035.00,5),(27,6,23,2400.00,4),(28,2,24,993.00,1),(28,6,24,2400.00,4),(29,2,25,1986.00,2),(29,6,25,3000.00,5),(29,12,320,399.00,1),(30,1,27,2847.00,3),(30,4,27,3228.00,4),(30,11,27,419.00,1),(31,3,28,632.00,2),(31,7,28,2184.00,4),(31,9,28,216.00,1),(32,1,29,949.00,1),(32,1,49,4745.00,5),(32,2,29,993.00,1),(32,5,29,2420.00,5),(32,11,49,1257.00,3),(33,7,30,546.00,1),(33,8,30,2924.00,4),(33,11,30,419.00,1),(34,1,31,949.00,1),(34,2,31,4965.00,5),(34,6,31,1200.00,2),(34,6,231,1200.00,2),(35,1,32,4745.00,5),(35,6,32,1800.00,3),(35,10,132,1440.00,5),(35,12,32,1995.00,5),(36,3,33,1264.00,4),(36,4,33,2421.00,3),(36,5,33,968.00,2),(36,11,33,1257.00,3),(37,2,34,3972.00,4),(37,3,34,1580.00,5),(37,3,56,316.00,1),(37,7,34,1638.00,3),(37,8,34,2193.00,3),(38,7,35,1638.00,3),(38,8,35,1462.00,2),(38,10,35,864.00,3),(38,11,35,1257.00,3),(39,2,36,993.00,1),(39,4,36,2421.00,3),(39,7,36,2730.00,5),(39,8,36,2924.00,4),(40,2,37,2979.00,3),(40,5,37,2420.00,5),(40,9,37,648.00,3),(40,10,165,1152.00,4),(40,12,37,1995.00,5),(41,2,38,993.00,1),(41,4,38,2421.00,3),(41,5,38,1452.00,3),(41,6,38,1200.00,2),(41,8,38,3655.00,5),(41,11,38,838.00,2),(41,12,38,798.00,2),(42,5,336,1452.00,3),(42,6,39,1800.00,3),(42,8,39,3655.00,5),(42,9,39,1080.00,5),(42,12,336,798.00,2),(43,6,40,2400.00,4),(43,7,40,2184.00,4),(43,8,40,2924.00,4),(44,5,41,968.00,2),(44,6,41,2400.00,4),(44,11,41,419.00,1),(45,1,42,949.00,1),(45,5,42,1936.00,4),(45,11,42,1257.00,3),(46,4,43,1614.00,2),(46,6,43,600.00,1),(46,10,75,576.00,2),(47,3,44,316.00,1),(47,8,44,3655.00,5),(47,9,44,432.00,2),(47,11,44,1257.00,3),(48,3,45,1580.00,5),(48,12,45,1995.00,5),(49,2,306,993.00,1),(49,4,46,3228.00,4),(49,9,46,432.00,2),(49,12,306,1596.00,4),(50,6,47,1200.00,2),(50,12,47,1995.00,5),(51,4,176,3228.00,4),(51,6,48,600.00,1),(51,7,48,546.00,1),(52,4,50,1614.00,2),(52,7,50,1638.00,3),(53,6,51,1800.00,3),(53,12,51,1596.00,4),(54,2,52,4965.00,5),(54,4,325,2421.00,3),(54,6,52,3000.00,5),(54,9,325,432.00,2),(55,1,54,949.00,1),(55,3,54,1580.00,5),(55,6,54,3000.00,5),(55,8,54,2193.00,3),(56,4,55,1614.00,2),(56,5,55,1936.00,4),(56,7,55,1092.00,2),(57,6,57,3000.00,5),(58,4,58,807.00,1),(58,7,58,546.00,1),(58,8,58,2193.00,3),(59,2,59,4965.00,5),(59,7,59,2730.00,5),(59,9,59,216.00,1),(60,2,60,2979.00,3),(60,5,303,484.00,1),(61,1,61,1898.00,2),(61,8,304,2924.00,4),(61,12,61,1596.00,4),(62,6,62,1800.00,3),(62,7,334,2184.00,4),(62,11,334,419.00,1),(63,6,63,3000.00,5),(63,7,63,546.00,1),(64,2,64,2979.00,3),(65,6,65,2400.00,4),(65,11,65,838.00,2),(66,5,66,484.00,1),(66,9,66,648.00,3),(67,3,68,948.00,3),(67,9,68,432.00,2),(68,9,69,648.00,3),(68,10,69,864.00,3),(69,6,76,2400.00,4),(69,11,70,1257.00,3),(70,2,71,1986.00,2),(70,5,71,1936.00,4),(70,6,71,1800.00,3),(71,11,72,1676.00,4),(72,12,73,798.00,2),(73,2,276,1986.00,2),(73,4,276,807.00,1),(73,8,74,731.00,1),(74,2,77,993.00,1),(75,4,78,1614.00,2),(76,12,79,399.00,1),(77,4,339,1614.00,2),(77,8,339,2924.00,4),(77,11,80,2095.00,5),(78,1,81,1898.00,2),(79,5,82,484.00,1),(80,7,83,1092.00,2),(81,4,84,2421.00,3),(81,6,90,2400.00,4),(81,7,87,546.00,1),(81,7,88,546.00,1),(81,8,85,1462.00,2),(81,12,89,1995.00,5),(82,7,86,1638.00,3),(83,3,92,948.00,3),(83,6,94,2400.00,4),(83,8,91,2193.00,3),(83,10,93,1152.00,4),(84,1,97,1898.00,2),(85,1,98,949.00,1),(86,4,99,3228.00,4),(87,4,110,1614.00,2),(88,12,121,1596.00,4),(89,8,143,2193.00,3),(90,2,154,1986.00,2),(90,3,278,1264.00,4),(90,8,299,3655.00,5),(90,10,278,1440.00,5),(91,10,187,576.00,2),(92,2,198,2979.00,3),(93,10,209,1152.00,4),(94,1,220,4745.00,5),(95,3,242,316.00,1),(96,11,253,2095.00,5),(97,10,264,576.00,2),(98,6,275,1800.00,3),(99,3,277,948.00,3),(99,12,277,1596.00,4),(100,5,279,1936.00,4),(100,12,279,1596.00,4),(101,5,280,1452.00,3),(101,10,293,864.00,3),(101,12,280,798.00,2),(102,6,281,3000.00,5),(102,12,281,1197.00,3),(103,3,282,316.00,1),(104,5,283,1452.00,3),(105,1,284,3796.00,4),(106,9,285,864.00,4),(107,1,286,4745.00,5),(107,1,316,4745.00,5),(107,6,316,600.00,1),(107,10,316,1440.00,5),(108,7,287,2730.00,5),(109,5,288,2420.00,5),(110,3,289,1264.00,4),(111,1,290,1898.00,2),(112,5,291,2420.00,5),(113,10,292,576.00,2),(114,2,294,1986.00,2),(115,4,295,2421.00,3),(116,1,296,1898.00,2),(117,2,309,993.00,1),(117,5,297,484.00,1),(117,8,309,1462.00,2),(118,4,298,2421.00,3),(119,2,300,4965.00,5),(120,6,301,1800.00,3),(121,12,302,1596.00,4),(122,2,305,3972.00,4),(122,6,305,3000.00,5),(123,7,307,1638.00,3),(123,9,307,648.00,3),(124,3,308,1580.00,5),(124,4,308,2421.00,3),(125,12,310,1995.00,5),(126,1,311,4745.00,5),(126,5,311,484.00,1),(126,7,311,2184.00,4),(127,1,312,4745.00,5),(127,4,312,1614.00,2),(127,6,312,600.00,1),(128,3,313,948.00,3),(128,8,313,2193.00,3),(129,4,314,2421.00,3),(129,6,314,2400.00,4),(130,2,315,2979.00,3),(130,3,315,316.00,1),(130,5,315,2420.00,5),(131,2,317,4965.00,5),(131,5,317,1452.00,3),(132,3,318,948.00,3),(132,5,318,2420.00,5),(132,7,318,1638.00,3),(133,9,319,216.00,1),(134,12,321,1596.00,4),(135,8,322,3655.00,5),(136,8,323,2924.00,4),(137,7,324,2184.00,4),(138,9,326,216.00,1),(138,11,326,1257.00,3),(139,1,327,949.00,1),(139,3,327,632.00,2),(140,2,328,4965.00,5),(140,11,328,2095.00,5),(141,1,329,4745.00,5),(141,7,329,2184.00,4),(142,4,330,3228.00,4),(142,6,330,600.00,1),(143,7,331,2730.00,5),(143,11,331,1676.00,4),(144,3,332,948.00,3),(144,5,332,1936.00,4),(145,1,335,2847.00,3),(145,6,333,1800.00,3),(145,8,335,1462.00,2),(145,10,333,576.00,2),(146,3,337,948.00,3),(146,8,337,2924.00,4),(266,1,2,3796.00,4),(266,2,2,4965.00,5),(266,3,2,1580.00,5),(266,3,4,632.00,2),(266,4,1,807.00,1),(266,4,2,3228.00,4),(266,5,1,2420.00,5),(266,6,4,600.00,1),(266,7,3,2730.00,5),(266,8,2,731.00,1),(266,8,4,731.00,1),(266,8,5,2193.00,3),(266,9,1,648.00,3),(266,9,2,864.00,4),(266,12,1,798.00,2),(267,4,6,2421.00,3),(267,4,8,1614.00,2),(267,6,8,2400.00,4),(267,12,7,798.00,2),(268,2,26,993.00,1),(268,10,9,864.00,3),(268,10,26,864.00,3),(269,2,10,993.00,1),(269,11,10,838.00,2),(269,12,338,1596.00,4),(270,2,67,4965.00,5),(270,4,11,4035.00,5),(270,6,67,1200.00,2),(271,8,12,731.00,1),(272,3,13,1264.00,4),(273,1,14,3796.00,4),(274,5,15,2420.00,5),(275,5,16,1452.00,3),(275,12,16,1995.00,5),(276,2,17,3972.00,4),(276,11,17,1676.00,4),(277,5,18,1936.00,4),(277,12,18,1197.00,3),(278,5,19,484.00,1),(278,11,19,2095.00,5),(279,9,20,216.00,1),(280,2,53,993.00,1),(280,6,53,600.00,1),(280,11,21,2095.00,5),(281,4,22,3228.00,4),(281,10,22,576.00,2),(282,4,23,4035.00,5),(282,6,23,2400.00,4),(283,2,24,993.00,1),(283,6,24,2400.00,4),(284,2,25,1986.00,2),(284,6,25,3000.00,5),(284,12,320,399.00,1),(285,1,27,2847.00,3),(285,4,27,3228.00,4),(285,11,27,419.00,1),(286,3,28,632.00,2),(286,7,28,2184.00,4),(286,9,28,216.00,1),(287,1,29,949.00,1),(287,1,49,4745.00,5),(287,2,29,993.00,1),(287,5,29,2420.00,5),(287,11,49,1257.00,3),(288,7,30,546.00,1),(288,8,30,2924.00,4),(288,11,30,419.00,1),(289,1,31,949.00,1),(289,2,31,4965.00,5),(289,6,31,1200.00,2),(289,6,231,1200.00,2),(290,1,32,4745.00,5),(290,6,32,1800.00,3),(290,10,132,1440.00,5),(290,12,32,1995.00,5),(291,3,33,1264.00,4),(291,4,33,2421.00,3),(291,5,33,968.00,2),(291,11,33,1257.00,3),(292,2,34,3972.00,4),(292,3,34,1580.00,5),(292,3,56,316.00,1),(292,7,34,1638.00,3),(292,8,34,2193.00,3),(293,7,35,1638.00,3),(293,8,35,1462.00,2),(293,10,35,864.00,3),(293,11,35,1257.00,3),(294,2,36,993.00,1),(294,4,36,2421.00,3),(294,7,36,2730.00,5),(294,8,36,2924.00,4),(295,2,37,2979.00,3),(295,5,37,2420.00,5),(295,9,37,648.00,3),(295,10,165,1152.00,4),(295,12,37,1995.00,5),(296,2,38,993.00,1),(296,4,38,2421.00,3),(296,5,38,1452.00,3),(296,6,38,1200.00,2),(296,8,38,3655.00,5),(296,11,38,838.00,2),(296,12,38,798.00,2),(297,5,336,1452.00,3),(297,6,39,1800.00,3),(297,8,39,3655.00,5),(297,9,39,1080.00,5),(297,12,336,798.00,2),(298,6,40,2400.00,4),(298,7,40,2184.00,4),(298,8,40,2924.00,4),(299,5,41,968.00,2),(299,6,41,2400.00,4),(299,11,41,419.00,1),(300,1,42,949.00,1),(300,5,42,1936.00,4),(300,11,42,1257.00,3),(301,4,43,1614.00,2),(301,6,43,600.00,1),(301,10,75,576.00,2),(302,3,44,316.00,1),(302,8,44,3655.00,5),(302,9,44,432.00,2),(302,11,44,1257.00,3),(303,3,45,1580.00,5),(303,12,45,1995.00,5),(304,2,306,993.00,1),(304,4,46,3228.00,4),(304,9,46,432.00,2),(304,12,306,1596.00,4),(305,6,47,1200.00,2),(305,12,47,1995.00,5),(306,4,176,3228.00,4),(306,6,48,600.00,1),(306,7,48,546.00,1),(307,4,50,1614.00,2),(307,7,50,1638.00,3),(308,6,51,1800.00,3),(308,12,51,1596.00,4),(309,2,52,4965.00,5),(309,4,325,2421.00,3),(309,6,52,3000.00,5),(309,9,325,432.00,2),(310,1,54,949.00,1),(310,3,54,1580.00,5),(310,6,54,3000.00,5),(310,8,54,2193.00,3),(311,4,55,1614.00,2),(311,5,55,1936.00,4),(311,7,55,1092.00,2),(312,6,57,3000.00,5),(313,4,58,807.00,1),(313,7,58,546.00,1),(313,8,58,2193.00,3),(314,2,59,4965.00,5),(314,7,59,2730.00,5),(314,9,59,216.00,1),(315,2,60,2979.00,3),(315,5,303,484.00,1),(316,1,61,1898.00,2),(316,8,304,2924.00,4),(316,12,61,1596.00,4),(317,6,62,1800.00,3),(317,7,334,2184.00,4),(317,11,334,419.00,1),(318,6,63,3000.00,5),(318,7,63,546.00,1),(319,2,64,2979.00,3),(320,6,65,2400.00,4),(320,11,65,838.00,2),(321,5,66,484.00,1),(321,9,66,648.00,3),(322,3,68,948.00,3),(322,9,68,432.00,2),(323,9,69,648.00,3),(323,10,69,864.00,3),(324,6,76,2400.00,4),(324,11,70,1257.00,3),(325,2,71,1986.00,2),(325,5,71,1936.00,4),(325,6,71,1800.00,3),(326,11,72,1676.00,4),(327,12,73,798.00,2),(328,2,276,1986.00,2),(328,4,276,807.00,1),(328,8,74,731.00,1),(329,2,77,993.00,1),(330,4,78,1614.00,2),(331,12,79,399.00,1),(332,4,339,1614.00,2),(332,8,339,2924.00,4),(332,11,80,2095.00,5),(333,1,81,1898.00,2),(334,5,82,484.00,1),(335,7,83,1092.00,2),(336,4,84,2421.00,3),(336,6,90,2400.00,4),(336,7,87,546.00,1),(336,7,88,546.00,1),(336,8,85,1462.00,2),(336,12,89,1995.00,5),(337,7,86,1638.00,3),(338,3,92,948.00,3),(338,6,94,2400.00,4),(338,8,91,2193.00,3),(338,10,93,1152.00,4),(339,9,95,648.00,3),(339,9,96,648.00,3),(340,1,97,1898.00,2),(341,1,98,949.00,1),(342,4,99,3228.00,4),(343,11,100,1257.00,3),(344,11,101,2095.00,5),(345,9,102,216.00,1),(346,3,103,316.00,1),(347,10,104,864.00,3),(348,5,105,2420.00,5),(349,2,106,993.00,1),(350,7,107,2184.00,4),(351,5,108,2420.00,5),(352,10,109,1152.00,4),(353,4,110,1614.00,2),(354,9,111,432.00,2),(355,9,112,432.00,2),(356,4,113,1614.00,2),(357,5,133,1936.00,4),(357,6,114,1800.00,3),(358,6,115,1800.00,3),(359,2,232,1986.00,2),(359,8,116,731.00,1),(360,8,117,2924.00,4),(361,6,118,2400.00,4),(362,4,119,807.00,1),(363,2,120,1986.00,2),(364,12,121,1596.00,4),(365,9,122,648.00,3),(366,8,123,3655.00,5),(367,2,218,993.00,1),(367,9,124,648.00,3),(368,9,125,432.00,2),(369,3,126,948.00,3),(370,12,127,399.00,1),(371,5,128,968.00,2),(372,3,129,316.00,1),(373,12,130,798.00,2),(374,1,131,1898.00,2),(375,7,134,546.00,1),(376,4,135,807.00,1),(376,5,175,1452.00,3),(377,7,136,2730.00,5),(378,5,137,2420.00,5),(379,10,138,1152.00,4),(380,7,139,2184.00,4),(380,10,201,1152.00,4),(381,10,140,864.00,3),(382,12,141,1596.00,4),(383,12,142,1596.00,4),(384,8,143,2193.00,3),(385,8,144,2193.00,3),(386,10,145,864.00,3),(387,6,146,600.00,1),(388,6,147,3000.00,5),(389,5,148,2420.00,5),(390,8,149,731.00,1),(391,3,150,1580.00,5),(391,3,251,1580.00,5),(392,5,151,1452.00,3),(393,2,152,1986.00,2),(394,1,153,2847.00,3),(395,2,154,1986.00,2),(395,3,278,1264.00,4),(395,8,299,3655.00,5),(395,10,278,1440.00,5),(396,6,155,3000.00,5),(397,2,156,3972.00,4),(398,9,157,432.00,2),(399,7,158,546.00,1),(400,3,159,948.00,3),(401,3,160,1264.00,4),(402,10,161,576.00,2),(403,11,162,838.00,2),(404,12,163,798.00,2),(405,9,164,648.00,3),(406,9,166,216.00,1),(407,1,167,3796.00,4),(408,7,168,1092.00,2),(409,6,169,2400.00,4),(410,4,170,4035.00,5),(411,6,171,1800.00,3),(412,12,172,1995.00,5),(413,2,173,4965.00,5),(414,5,174,1452.00,3),(415,12,177,1197.00,3),(416,12,178,1197.00,3),(417,9,179,648.00,3),(418,8,180,3655.00,5),(419,9,181,1080.00,5),(420,8,182,3655.00,5),(421,9,183,648.00,3),(422,8,184,2924.00,4),(423,5,185,1452.00,3),(424,12,186,1995.00,5),(425,10,187,576.00,2),(426,7,188,2730.00,5),(427,10,189,576.00,2),(428,7,190,546.00,1),(429,1,191,949.00,1),(430,2,192,1986.00,2),(431,2,193,1986.00,2),(432,2,194,993.00,1),(433,8,195,3655.00,5),(434,7,196,1092.00,2),(435,10,197,864.00,3),(436,2,198,2979.00,3),(437,2,199,993.00,1),(438,2,200,993.00,1),(439,7,202,2730.00,5),(440,7,203,1638.00,3),(441,1,204,1898.00,2),(441,11,222,419.00,1),(442,2,205,2979.00,3),(443,7,261,2184.00,4),(443,11,206,2095.00,5),(444,7,207,2730.00,5),(445,4,208,2421.00,3),(446,10,209,1152.00,4),(447,9,210,432.00,2),(448,8,211,731.00,1),(449,8,212,3655.00,5),(450,3,213,316.00,1),(451,10,214,1440.00,5),(452,1,215,4745.00,5),(453,10,216,576.00,2),(454,7,217,546.00,1),(455,10,219,288.00,1),(456,1,220,4745.00,5),(457,6,221,1800.00,3),(458,3,223,1580.00,5),(459,4,224,2421.00,3),(460,6,225,600.00,1),(461,4,226,1614.00,2),(462,7,227,1092.00,2),(463,2,228,3972.00,4),(464,2,229,2979.00,3),(465,11,230,838.00,2),(466,3,233,1580.00,5),(467,11,234,2095.00,5),(468,6,235,1800.00,3),(469,12,236,399.00,1),(470,7,237,1092.00,2),(471,10,238,1152.00,4),(472,1,239,4745.00,5),(473,3,240,632.00,2),(474,12,241,1197.00,3),(475,3,242,316.00,1),(476,1,243,1898.00,2),(477,2,244,2979.00,3),(478,12,245,798.00,2),(479,7,246,546.00,1),(480,1,247,949.00,1),(481,8,248,2924.00,4),(482,11,249,2095.00,5),(483,2,250,3972.00,4),(484,3,252,632.00,2),(485,11,253,2095.00,5),(486,10,254,1440.00,5),(487,11,255,2095.00,5),(488,6,256,3000.00,5),(489,4,257,807.00,1),(490,2,258,4965.00,5),(491,4,259,4035.00,5),(492,2,260,1986.00,2),(493,3,265,948.00,3),(493,7,262,2184.00,4),(494,8,263,731.00,1),(495,10,264,576.00,2),(496,11,266,419.00,1),(497,7,267,2730.00,5),(498,2,268,1986.00,2),(498,8,268,1462.00,2),(498,12,268,1995.00,5),(499,4,269,3228.00,4),(499,7,269,1092.00,2),(499,12,269,399.00,1),(500,4,270,3228.00,4),(500,7,270,2184.00,4),(501,5,271,1452.00,3),(501,9,271,1080.00,5),(501,12,271,399.00,1),(502,4,272,4035.00,5),(502,8,272,2193.00,3),(502,9,272,864.00,4),(503,5,273,1452.00,3),(503,6,273,3000.00,5),(503,10,273,1440.00,5),(504,2,274,993.00,1),(504,6,274,1800.00,3),(504,7,274,1638.00,3),(505,6,275,1800.00,3),(506,3,277,948.00,3),(506,12,277,1596.00,4),(507,5,279,1936.00,4),(507,12,279,1596.00,4),(508,5,280,1452.00,3),(508,10,293,864.00,3),(508,12,280,798.00,2),(509,6,281,3000.00,5),(509,12,281,1197.00,3),(510,3,282,316.00,1),(511,5,283,1452.00,3),(512,1,284,3796.00,4),(513,9,285,864.00,4),(514,1,286,4745.00,5),(514,1,316,4745.00,5),(514,6,316,600.00,1),(514,10,316,1440.00,5),(515,7,287,2730.00,5),(516,5,288,2420.00,5),(517,3,289,1264.00,4),(518,1,290,1898.00,2),(519,5,291,2420.00,5),(520,10,292,576.00,2),(521,2,294,1986.00,2),(522,4,295,2421.00,3),(523,1,296,1898.00,2),(524,2,309,993.00,1),(524,5,297,484.00,1),(524,8,309,1462.00,2),(525,4,298,2421.00,3),(526,2,300,4965.00,5),(527,6,301,1800.00,3),(528,12,302,1596.00,4),(529,2,305,3972.00,4),(529,6,305,3000.00,5),(530,7,307,1638.00,3),(530,9,307,648.00,3),(531,3,308,1580.00,5),(531,4,308,2421.00,3),(532,12,310,1995.00,5),(533,1,311,4745.00,5),(533,5,311,484.00,1),(533,7,311,2184.00,4),(534,1,312,4745.00,5),(534,4,312,1614.00,2),(534,6,312,600.00,1),(535,3,313,948.00,3),(535,8,313,2193.00,3),(536,4,314,2421.00,3),(536,6,314,2400.00,4),(537,2,315,2979.00,3),(537,3,315,316.00,1),(537,5,315,2420.00,5),(538,2,317,4965.00,5),(538,5,317,1452.00,3),(539,3,318,948.00,3),(539,5,318,2420.00,5),(539,7,318,1638.00,3),(540,9,319,216.00,1),(541,12,321,1596.00,4),(542,8,322,3655.00,5),(543,8,323,2924.00,4),(544,7,324,2184.00,4),(545,9,326,216.00,1),(545,11,326,1257.00,3),(546,1,327,949.00,1),(546,3,327,632.00,2),(547,2,328,4965.00,5),(547,11,328,2095.00,5),(548,1,329,4745.00,5),(548,7,329,2184.00,4),(549,4,330,3228.00,4),(549,6,330,600.00,1),(550,7,331,2730.00,5),(550,11,331,1676.00,4),(551,3,332,948.00,3),(551,5,332,1936.00,4),(552,1,335,2847.00,3),(552,6,333,1800.00,3),(552,8,335,1462.00,2),(552,10,333,576.00,2),(553,3,337,948.00,3),(553,8,337,2924.00,4);
/*!40000 ALTER TABLE `SalesPerWOC` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Shipping`
--

DROP TABLE IF EXISTS `Shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shipping` (
  `ShippingKey` int NOT NULL AUTO_INCREMENT,
  `RegionID` varchar(6) DEFAULT NULL,
  `RegionName` varchar(255) DEFAULT NULL,
  `CountryID` varchar(55) DEFAULT NULL,
  `CountryName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ShippingKey`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shipping`
--

LOCK TABLES `Shipping` WRITE;
/*!40000 ALTER TABLE `Shipping` DISABLE KEYS */;
INSERT INTO `Shipping` VALUES (1,'R001','North America','US','United States'),(2,'R002','North America','CA','Canada'),(3,'R003','South America','BR','Brazil'),(4,'R004','South America','AR','Argentina'),(5,'R005','Europe','GB','United Kingdom'),(6,'R006','Europe','FR','France'),(7,'R007','Asia','CN','China'),(8,'R008','Asia','JP','Japan'),(9,'R009','Australia','AU','Australia'),(10,'R010','Africa','ZA','South Africa');
/*!40000 ALTER TABLE `Shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wine`
--

DROP TABLE IF EXISTS `Wine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Wine` (
  `WineKey` int NOT NULL AUTO_INCREMENT,
  `WineID` varchar(10) DEFAULT NULL,
  `Winename` varchar(255) NOT NULL,
  `WineType` varchar(255) DEFAULT NULL,
  `WineGrapeVariety` varchar(255) DEFAULT NULL,
  `WineVintage` varchar(255) DEFAULT NULL,
  `WineColor` varchar(255) DEFAULT NULL,
  `WinePricePerUnit` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`WineKey`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wine`
--

LOCK TABLES `Wine` WRITE;
/*!40000 ALTER TABLE `Wine` DISABLE KEYS */;
INSERT INTO `Wine` VALUES (1,'WINE001','Barefoot Pinot Grigio','White Wine','Pinot Grigio','2020',NULL,949.00),(2,'WINE002','Caymus Cabernet Sauvignon','Cabernet','Cabernet Sauvignon','2005',NULL,993.00),(3,'WINE003','Chateau d Esclans Whispering Angel Rose','Rose Wine','Pinot Noir','2020',NULL,316.00),(4,'WINE004','Barefoot Moscato','White Wine','Merlot','2011',NULL,807.00),(5,'WINE005','Bogle Chardonnay','White Wine','Chardonnay','2021',NULL,484.00),(6,'WINE006','Apothic Red Blend','Mix of Wines','Mixed Grape Blend','2021',NULL,600.00),(7,'WINE007','Barefoot White Zinfandel','Zinfandel','Zinfandel','2020',NULL,546.00),(8,'WINE008','Emmolo Sauvignon Blanc','White Wine','Sauvignon Blanc','2022',NULL,731.00),(9,'WINE009','Apothic Inferno Red Blend','Red Wine','Riesling','2019',NULL,216.00),(10,'WINE010','Barefoot Merlot','Red Wine','Merlot','2004',NULL,288.00),(11,'WINE011','Bogle Sauvignon Blanc','Cabernet','Sauvignon Blanc','2021',NULL,419.00),(12,'WINE012','Bogle Vineyards Petite Sirah','Red Wine','Syrah','2020',NULL,399.00);
/*!40000 ALTER TABLE `Wine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Winery`
--

DROP TABLE IF EXISTS `Winery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Winery` (
  `WineryID` varchar(30) NOT NULL,
  `WineryName` varchar(30) NOT NULL,
  `RegionID` varchar(25) NOT NULL,
  `InventoryID` varchar(25) NOT NULL,
  `WineryKey` int NOT NULL,
  PRIMARY KEY (`WineryKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Winery`
--

LOCK TABLES `Winery` WRITE;
/*!40000 ALTER TABLE `Winery` DISABLE KEYS */;
/*!40000 ALTER TABLE `Winery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wishlist`
--

DROP TABLE IF EXISTS `Wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Wishlist` (
  `WishlistKey` int NOT NULL AUTO_INCREMENT,
  `WishlistID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `WineID` varchar(25) NOT NULL,
  `AddedDate` timestamp NOT NULL,
  PRIMARY KEY (`WishlistKey`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wishlist`
--

LOCK TABLES `Wishlist` WRITE;
/*!40000 ALTER TABLE `Wishlist` DISABLE KEYS */;
INSERT INTO `Wishlist` VALUES (1,1,1092,'WINE001','2023-05-12 04:18:51'),(2,2,1092,'WINE004','2023-05-12 04:18:56'),(3,3,1048,'WINE001','2022-02-05 23:25:12'),(4,4,1042,'WINE004','2019-03-24 02:37:28'),(5,5,1024,'WINE007','2023-01-18 02:37:06'),(6,6,1049,'WINE002','2023-04-05 13:10:29'),(7,7,1141,'WINE008','2019-12-30 00:58:38'),(8,8,1028,'WINE012','2021-05-12 13:52:54'),(9,9,1094,'WINE003','2020-06-14 09:07:31'),(10,10,1042,'WINE012','2019-03-09 20:34:41'),(11,11,1155,'WINE002','2021-08-09 11:08:31'),(12,12,1098,'WINE003','2023-04-13 12:54:32'),(13,13,1137,'WINE011','2021-09-14 12:36:47'),(14,14,1132,'WINE001','2021-01-06 04:07:25'),(15,15,1085,'WINE007','2019-09-28 10:18:52'),(16,16,1088,'WINE001','2019-05-19 04:28:15'),(17,17,1152,'WINE008','2021-04-10 06:41:45'),(18,18,1040,'WINE006','2018-10-06 09:45:02'),(19,19,1072,'WINE008','2023-01-30 18:17:51'),(20,20,1158,'WINE005','2022-06-15 05:51:03'),(21,21,1124,'WINE001','2021-10-25 18:55:27'),(22,22,1095,'WINE007','2022-11-04 15:54:45'),(23,23,1022,'WINE010','2019-06-27 08:00:05'),(24,24,1175,'WINE005','2021-11-25 10:29:53'),(25,25,1031,'WINE006','2020-07-09 11:21:47'),(26,26,1109,'WINE008','2018-10-17 20:33:27'),(27,27,1124,'WINE003','2021-05-26 00:30:07'),(28,28,1104,'WINE006','2020-06-16 08:53:48'),(29,29,1132,'WINE003','2021-09-07 20:06:27'),(30,30,1106,'WINE002','2021-04-12 20:08:36'),(31,31,1027,'WINE005','2019-02-01 11:37:40'),(32,32,1167,'WINE009','2021-09-23 21:58:25'),(33,33,1000,'WINE004','2022-11-01 13:00:07'),(34,34,1105,'WINE004','2020-11-03 11:09:03'),(35,35,1102,'WINE005','2019-04-07 18:13:42'),(36,36,1046,'WINE009','2018-10-14 22:38:49'),(37,37,1021,'WINE001','2020-05-01 16:41:08'),(38,38,1111,'WINE005','2020-03-02 22:46:11'),(39,39,1037,'WINE010','2022-10-11 22:51:30'),(40,40,1001,'WINE004','2018-07-26 18:32:24'),(41,41,1066,'WINE007','2020-11-05 12:54:30'),(42,42,1086,'WINE008','2020-12-22 00:07:38'),(43,43,1059,'WINE005','2019-09-28 13:27:24'),(44,44,1126,'WINE011','2020-07-21 00:45:39'),(45,45,1031,'WINE010','2019-06-20 13:28:59'),(46,46,1097,'WINE004','2020-03-15 10:54:03'),(47,47,1120,'WINE006','2019-07-24 05:31:27'),(48,48,1164,'WINE012','2022-10-22 22:26:42'),(49,49,1028,'WINE002','2018-09-21 22:59:08'),(50,50,1131,'WINE007','2021-07-05 16:00:47'),(51,51,1027,'WINE005','2022-10-22 22:18:45'),(52,52,1058,'WINE007','2019-02-23 07:34:34'),(53,53,1032,'WINE010','2021-05-14 14:37:33'),(54,54,1157,'WINE001','2020-05-04 00:38:05'),(55,55,1050,'WINE007','2022-01-26 12:47:48'),(56,56,1117,'WINE009','2019-05-12 14:06:19'),(57,57,1026,'WINE007','2022-09-27 07:04:03'),(58,58,1141,'WINE002','2020-07-08 04:38:12'),(59,59,1046,'WINE009','2021-07-31 18:05:47'),(60,60,1034,'WINE006','2018-08-01 23:02:52'),(61,61,1017,'WINE007','2019-06-30 23:22:44'),(62,62,1054,'WINE007','2020-10-06 12:31:44'),(63,63,1074,'WINE010','2022-07-21 08:43:07'),(64,64,1134,'WINE009','2023-03-23 15:16:47'),(65,65,1051,'WINE003','2019-07-20 02:48:34'),(66,66,1049,'WINE011','2022-06-18 08:00:11'),(67,67,1149,'WINE007','2020-07-18 15:09:58'),(68,68,1129,'WINE010','2022-01-05 11:14:22'),(69,69,1039,'WINE011','2021-06-14 09:36:58'),(70,70,1148,'WINE008','2020-04-10 15:18:30'),(71,71,1100,'WINE007','2018-09-10 16:46:15'),(72,72,1006,'WINE003','2020-05-07 00:42:48'),(73,73,1165,'WINE009','2023-03-26 08:44:53'),(74,74,1175,'WINE006','2020-12-26 17:29:33'),(75,75,1090,'WINE006','2022-08-27 23:24:28'),(76,76,1112,'WINE011','2021-12-17 20:27:07'),(77,77,1055,'WINE011','2018-08-13 10:55:12'),(78,78,1150,'WINE002','2018-08-20 16:52:33'),(79,79,1048,'WINE011','2020-12-27 12:27:22'),(80,80,1044,'WINE012','2021-12-29 23:32:58'),(81,81,1140,'WINE005','2020-01-29 14:38:13'),(82,82,1157,'WINE002','2022-01-04 13:02:04'),(83,83,1119,'WINE002','2019-10-24 03:04:31'),(84,84,1097,'WINE006','2019-05-02 21:02:07'),(85,85,1051,'WINE010','2023-02-24 20:56:37'),(86,86,1030,'WINE010','2019-04-08 03:25:11'),(87,87,1059,'WINE006','2018-06-18 23:44:19'),(88,88,1109,'WINE011','2018-07-11 05:48:56'),(89,89,1134,'WINE011','2018-12-10 17:26:04'),(90,90,1119,'WINE001','2021-12-15 10:25:59'),(91,91,1065,'WINE003','2020-07-18 10:59:34'),(92,92,1165,'WINE009','2021-12-30 13:00:39'),(93,93,1018,'WINE005','2020-09-02 12:14:13'),(94,94,1024,'WINE004','2019-07-10 08:51:15'),(95,95,1151,'WINE007','2018-09-29 10:46:37'),(96,97,1160,'WINE004','2020-06-01 19:25:32'),(97,98,1005,'WINE007','2019-07-27 20:51:09'),(98,99,1128,'WINE012','2018-06-07 14:37:27'),(99,100,1048,'WINE007','2019-04-28 00:01:20'),(100,101,1175,'WINE012','2019-01-22 12:30:41'),(101,102,1141,'WINE003','2022-07-30 22:52:12'),(102,103,1161,'WINE011','2021-04-26 03:19:48'),(103,104,1161,'WINE001','2020-02-02 02:16:59'),(104,105,1061,'WINE009','2022-10-26 15:14:59'),(105,106,1100,'WINE011','2018-08-02 00:43:41'),(106,107,1119,'WINE010','2018-11-12 21:01:48'),(107,108,1060,'WINE004','2018-07-01 21:35:10'),(108,109,1121,'WINE003','2019-07-27 00:31:42'),(109,110,1078,'WINE010','2023-01-11 12:03:28'),(110,111,1158,'WINE007','2019-01-17 14:50:18'),(111,112,1074,'WINE004','2021-06-18 14:05:46'),(112,113,1138,'WINE012','2019-10-24 10:16:28'),(113,114,1118,'WINE001','2018-07-25 22:54:27'),(114,115,1126,'WINE010','2021-07-23 02:07:08'),(115,116,1059,'WINE011','2020-12-28 19:46:50'),(116,117,1147,'WINE003','2022-12-08 08:13:26'),(117,118,1079,'WINE011','2021-11-26 19:56:05'),(118,119,1175,'WINE003','2022-06-03 03:27:48'),(119,120,1142,'WINE007','2020-05-08 09:24:30'),(120,121,1045,'WINE008','2020-08-11 13:08:50'),(121,122,1080,'WINE012','2020-10-21 22:36:07'),(122,123,1092,'WINE002','2021-12-25 02:31:15'),(123,124,1143,'WINE012','2018-07-18 18:49:39'),(124,125,1131,'WINE005','2020-07-10 14:34:53'),(125,126,1069,'WINE007','2018-06-07 07:20:15'),(126,127,1106,'WINE012','2018-10-20 18:24:30'),(127,128,1023,'WINE008','2020-12-22 10:28:46'),(128,129,1024,'WINE012','2019-03-04 01:16:00'),(129,130,1037,'WINE001','2020-05-16 13:51:43'),(130,131,1084,'WINE007','2022-02-28 13:26:25'),(131,132,1018,'WINE003','2018-07-17 14:06:22'),(132,133,1103,'WINE001','2022-02-22 22:30:03'),(133,134,1097,'WINE002','2022-11-12 10:28:32'),(134,135,1052,'WINE006','2019-08-21 21:30:11'),(135,137,1118,'WINE004','2020-06-15 14:52:35'),(136,138,1164,'WINE012','2019-08-29 13:39:29'),(137,139,1002,'WINE006','2022-10-21 16:55:40'),(138,140,1112,'WINE001','2021-08-31 07:03:15'),(139,141,1139,'WINE012','2019-04-13 08:29:07'),(140,142,1097,'WINE002','2019-12-28 05:23:23'),(141,143,1090,'WINE008','2021-12-14 21:05:06'),(142,144,1105,'WINE001','2019-04-07 06:44:58'),(143,145,1071,'WINE001','2019-06-13 15:49:40'),(144,146,1170,'WINE012','2023-02-20 01:11:21'),(145,147,1164,'WINE008','2019-12-13 22:54:13'),(146,148,1129,'WINE010','2021-06-10 09:10:54'),(147,149,1160,'WINE002','2021-11-10 13:14:22'),(148,150,1053,'WINE002','2018-12-01 09:33:59'),(149,152,1003,'WINE006','2023-05-12 17:51:58'),(150,153,1003,'WINE012','2023-05-12 18:20:02');
/*!40000 ALTER TABLE `Wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `coupon_analysis`
--

DROP TABLE IF EXISTS `coupon_analysis`;
/*!50001 DROP VIEW IF EXISTS `coupon_analysis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `coupon_analysis` AS SELECT 
 1 AS `Coupon`,
 1 AS `year`,
 1 AS `round(sum(TotalAmount),2)`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `overall_coupon_rev`
--

DROP TABLE IF EXISTS `overall_coupon_rev`;
/*!50001 DROP VIEW IF EXISTS `overall_coupon_rev`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `overall_coupon_rev` AS SELECT 
 1 AS `year`,
 1 AS `month`,
 1 AS `round(sum(TotalAmount),2)`*/;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `bossbunch_db`
--

USE `bossbunch_db`;

--
-- Current Database: `bossbunch_wh`
--

USE `bossbunch_wh`;

--
-- Final view structure for view `coupon_analysis`
--

/*!50001 DROP VIEW IF EXISTS `coupon_analysis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`bossbunch_user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `coupon_analysis` AS select `o`.`Coupon` AS `Coupon`,`c`.`Year` AS `year`,round(sum(`o`.`TotalAmount`),2) AS `round(sum(TotalAmount),2)` from ((`SalesPerWOC` `sp` join `Orders` `o` on((`sp`.`OrdersKey` = `o`.`OrdersKey`))) join `Calendar` `c` on((`sp`.`CalendarKey` = `c`.`CalendarKey`))) group by `o`.`Coupon`,`c`.`Year` order by `o`.`Coupon`,`c`.`Year` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `overall_coupon_rev`
--

/*!50001 DROP VIEW IF EXISTS `overall_coupon_rev`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`bossbunch_user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `overall_coupon_rev` AS select `c`.`Year` AS `year`,`c`.`Month` AS `month`,round(sum(`o`.`TotalAmount`),2) AS `round(sum(TotalAmount),2)` from ((`SalesPerWOC` `sp` join `Orders` `o` on((`sp`.`OrdersKey` = `o`.`OrdersKey`))) join `Calendar` `c` on((`sp`.`CalendarKey` = `c`.`CalendarKey`))) group by `c`.`Year`,`c`.`Month` order by `c`.`Year`,`c`.`Month` */;
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

-- Dump completed on 2023-05-19 18:17:31
