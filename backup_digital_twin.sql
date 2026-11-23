/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.29-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: digital_twin_ponte
-- ------------------------------------------------------
-- Server version	10.4.34-MariaDB-1:10.4.34+maria~ubu2004

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Allarme`
--

DROP TABLE IF EXISTS `Allarme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Allarme` (
  `id_allarme` int(11) NOT NULL AUTO_INCREMENT,
  `id_sensore` int(11) NOT NULL,
  `timestamp_inizio` datetime NOT NULL,
  `timestamp_fine` datetime DEFAULT NULL,
  `livello` varchar(20) NOT NULL,
  `descrizione` text DEFAULT NULL,
  PRIMARY KEY (`id_allarme`),
  KEY `fk_allarme_sensore` (`id_sensore`),
  CONSTRAINT `fk_allarme_sensore` FOREIGN KEY (`id_sensore`) REFERENCES `Sensore` (`id_sensore`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Allarme`
--

LOCK TABLES `Allarme` WRITE;
/*!40000 ALTER TABLE `Allarme` DISABLE KEYS */;
INSERT INTO `Allarme` VALUES (1,1,'2026-11-20 08:35:10','2026-11-20 11:15:00','Critico','Vibrazione eccessiva rilevata sulla campata centrale'),(2,2,'2026-11-21 14:00:00',NULL,'Medio','Deformazione superiore alla soglia sul pilone Nord');
/*!40000 ALTER TABLE `Allarme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manutenzione`
--

DROP TABLE IF EXISTS `Manutenzione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Manutenzione` (
  `id_manutenzione` int(11) NOT NULL AUTO_INCREMENT,
  `id_allarme` int(11) NOT NULL,
  `tecnico` varchar(100) NOT NULL,
  `data_intervento` date NOT NULL,
  `esito` varchar(100) NOT NULL,
  PRIMARY KEY (`id_manutenzione`),
  KEY `fk_manutenzione_allarme` (`id_allarme`),
  CONSTRAINT `fk_manutenzione_allarme` FOREIGN KEY (`id_allarme`) REFERENCES `Allarme` (`id_allarme`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manutenzione`
--

LOCK TABLES `Manutenzione` WRITE;
/*!40000 ALTER TABLE `Manutenzione` DISABLE KEYS */;
INSERT INTO `Manutenzione` VALUES (1,1,'Ing. Marco Rossi','2026-11-20','Risolto - Taratura supporto sensore'),(2,2,'Ing. Laura Bianchi','2026-11-22','In verifica - Monitoraggio in corso');
/*!40000 ALTER TABLE `Manutenzione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rilevazione`
--

DROP TABLE IF EXISTS `Rilevazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rilevazione` (
  `id_rilevazione` int(11) NOT NULL AUTO_INCREMENT,
  `id_sensore` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `valore` decimal(10,4) NOT NULL,
  `qualita` varchar(30) DEFAULT 'Valida',
  PRIMARY KEY (`id_rilevazione`),
  KEY `fk_rilevazione_sensore` (`id_sensore`),
  CONSTRAINT `fk_rilevazione_sensore` FOREIGN KEY (`id_sensore`) REFERENCES `Sensore` (`id_sensore`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rilevazione`
--

LOCK TABLES `Rilevazione` WRITE;
/*!40000 ALTER TABLE `Rilevazione` DISABLE KEYS */;
INSERT INTO `Rilevazione` VALUES (1,1,'2026-11-20 08:30:00',0.1450,'Valida'),(2,1,'2026-11-20 08:35:00',1.8900,'Anomala'),(3,2,'2026-11-20 08:30:00',120.5000,'Valida'),(4,3,'2026-11-20 08:30:00',14.2000,'Valida');
/*!40000 ALTER TABLE `Rilevazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sensore`
--

DROP TABLE IF EXISTS `Sensore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sensore` (
  `id_sensore` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `posizione` varchar(100) NOT NULL,
  `unita_misura` varchar(20) NOT NULL,
  `data_installazione` date NOT NULL,
  PRIMARY KEY (`id_sensore`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sensore`
--

LOCK TABLES `Sensore` WRITE;
/*!40000 ALTER TABLE `Sensore` DISABLE KEYS */;
INSERT INTO `Sensore` VALUES (1,'Accelerometro','Campata centrale','m/s2','2025-03-10'),(2,'Estensimetro','Pilone Nord','microstrain','2025-03-10'),(3,'Sensore di temperatura','Arcata Sud','°C','2025-03-12');
/*!40000 ALTER TABLE `Sensore` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-22 20:29:00
