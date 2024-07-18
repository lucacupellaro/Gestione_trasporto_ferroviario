-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: trasporto_ferroviario
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `acquirente`
--

DROP TABLE IF EXISTS `acquirente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acquirente` (
  `CF` varchar(16) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `dataDiNascita` date NOT NULL,
  `numeroCartaCredito` bigint NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`CF`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acquirente`
--

LOCK TABLES `acquirente` WRITE;
/*!40000 ALTER TABLE `acquirente` DISABLE KEYS */;
INSERT INTO `acquirente` VALUES ('CPLLCU02L02G698R','cup','luca','2002-07-02',1234567123456789,'luca','f3f58ee455ae41da2ad5de06bf55e8de'),('CPLLCU04L04G332R','felice','ascac','1999-11-11',1234567890123456,'felix','189bbbb00c5f1fb7fba9ad9285f193d1');
/*!40000 ALTER TABLE `acquirente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_or_update_trigger_acquirente` BEFORE INSERT ON `acquirente` FOR EACH ROW BEGIN
    DECLARE user_count INT;

    -- Verifica che il nome utente non sia già presente in nessuna delle tabelle
    SELECT COUNT(*) INTO user_count
    FROM (
        SELECT username FROM gestoredelservizio WHERE username = NEW.username
        UNION ALL
        SELECT username FROM lavoratore WHERE username = NEW.username
        UNION ALL
        SELECT username FROM manutentore WHERE username = NEW.username
        UNION ALL
        SELECT username FROM acquirente WHERE username = NEW.username
    ) AS user_union;

    IF user_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Il nome utente è già in uso in una delle tabelle';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `corsa`
--

DROP TABLE IF EXISTS `corsa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corsa` (
  `idCorsa` int NOT NULL,
  `dataCorsa` date NOT NULL,
  `idTratta` int NOT NULL,
  `matricolaTreno` varchar(4) NOT NULL,
  `CFLavoratore1` varchar(16) NOT NULL,
  `CFLavoratore2` varchar(16) NOT NULL,
  PRIMARY KEY (`idCorsa`,`dataCorsa`),
  KEY `idTratta` (`idTratta`),
  KEY `idx_dataCorsa` (`dataCorsa`),
  KEY `corsa_ibfk_3` (`matricolaTreno`),
  KEY `fk_CFLavoratore1` (`CFLavoratore1`),
  KEY `fk_CFLavoratore2` (`CFLavoratore2`),
  CONSTRAINT `corsa_ibfk_2` FOREIGN KEY (`idTratta`) REFERENCES `tratta` (`id`),
  CONSTRAINT `corsa_ibfk_3` FOREIGN KEY (`matricolaTreno`) REFERENCES `treno` (`matricola`),
  CONSTRAINT `fk_CFLavoratore1` FOREIGN KEY (`CFLavoratore1`) REFERENCES `lavoratore` (`CF`),
  CONSTRAINT `fk_CFLavoratore2` FOREIGN KEY (`CFLavoratore2`) REFERENCES `lavoratore` (`CF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsa`
--

LOCK TABLES `corsa` WRITE;
/*!40000 ALTER TABLE `corsa` DISABLE KEYS */;
INSERT INTO `corsa` VALUES (1,'2024-05-19',1,'1234','FDRLRZ92L07D612Y','BNCMTT85C15F205D'),(2,'2024-09-09',2,'1234','FDRLRZ92L07D612Y','BNCMTT85C15F205D'),(3,'2024-03-17',3,'1234','FDRLRZ92L07D612Y','BNCMTT85C15F205D'),(4,'2024-03-19',6,'1234','FDRLRZ92L07D612Y','BNCMTT85C15F205D');
/*!40000 ALTER TABLE `corsa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fermate`
--

DROP TABLE IF EXISTS `fermate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fermate` (
  `stazione` varchar(50) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`stazione`,`citta`,`provincia`),
  KEY `idx_citta` (`citta`),
  KEY `idx_provincia` (`provincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fermate`
--

LOCK TABLES `fermate` WRITE;
/*!40000 ALTER TABLE `fermate` DISABLE KEYS */;
INSERT INTO `fermate` VALUES ('FirenzeC','Firenze','Firenze'),('MilanoC','Milano','Milano'),('NapoliC','Napoli','Napoli'),('pomezia','pomezia','Roma'),('fossanova','Priverno','Latina'),('rocca','Roccagorga','Latina'),('termini','Roma','Roma');
/*!40000 ALTER TABLE `fermate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestoredelservizio`
--

DROP TABLE IF EXISTS `gestoredelservizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestoredelservizio` (
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestoredelservizio`
--

LOCK TABLES `gestoredelservizio` WRITE;
/*!40000 ALTER TABLE `gestoredelservizio` DISABLE KEYS */;
INSERT INTO `gestoredelservizio` VALUES ('gestore1','feb78cc258bdc76867354f01c22dbe43'),('gestore3','098f6bcd4621d373cade4e832627b4f6');
/*!40000 ALTER TABLE `gestoredelservizio` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_or_update_trigger_gestore` BEFORE INSERT ON `gestoredelservizio` FOR EACH ROW BEGIN
    DECLARE user_count INT;

    -- Verifica che il nome utente non sia già presente in nessuna delle tabelle
    SELECT COUNT(*) INTO user_count
    FROM (
        SELECT username FROM gestoredelservizio WHERE username = NEW.username
        UNION ALL
        SELECT username FROM lavoratore WHERE username = NEW.username
        UNION ALL
        SELECT username FROM manutentore WHERE username = NEW.username
        UNION ALL
        SELECT username FROM acquirente WHERE username = NEW.username
    ) AS user_union;

    IF user_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Il nome utente è già in uso in una delle tabelle';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `include`
--

DROP TABLE IF EXISTS `include`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `include` (
  `idTratta` int NOT NULL,
  `stazione` varchar(50) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `provincia` varchar(50) NOT NULL,
  `numeroFermata` int NOT NULL,
  PRIMARY KEY (`stazione`,`citta`,`provincia`,`idTratta`),
  KEY `idTratta` (`idTratta`),
  CONSTRAINT `include_ibfk_1` FOREIGN KEY (`idTratta`) REFERENCES `tratta` (`id`),
  CONSTRAINT `include_ibfk_2` FOREIGN KEY (`stazione`, `citta`, `provincia`) REFERENCES `fermate` (`stazione`, `citta`, `provincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `include`
--

LOCK TABLES `include` WRITE;
/*!40000 ALTER TABLE `include` DISABLE KEYS */;
INSERT INTO `include` VALUES (1,'FirenzeC','Firenze','Firenze',3),(2,'FirenzeC','Firenze','Firenze',3),(3,'FirenzeC','Firenze','Firenze',1),(5,'fossanova','Priverno','Latina',3),(6,'fossanova','Priverno','Latina',2),(1,'MilanoC','Milano','Milano',1),(3,'MilanoC','Milano','Milano',3),(4,'MilanoC','Milano','Milano',1),(4,'NapoliC','Napoli','Napoli',2),(6,'NapoliC','Napoli','Napoli',1),(6,'pomezia','pomezia','Roma',3),(2,'rocca','Roccagorga','Latina',2),(4,'rocca','Roccagorga','Latina',3),(5,'rocca','Roccagorga','Latina',2),(1,'termini','Roma','Roma',2),(2,'termini','Roma','Roma',1),(3,'termini','Roma','Roma',2),(5,'termini','Roma','Roma',1),(6,'termini','Roma','Roma',4);
/*!40000 ALTER TABLE `include` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lavoratore`
--

DROP TABLE IF EXISTS `lavoratore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lavoratore` (
  `CF` varchar(16) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `dataNascita` date NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `ruolo` varchar(45) NOT NULL,
  PRIMARY KEY (`CF`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lavoratore`
--

LOCK TABLES `lavoratore` WRITE;
/*!40000 ALTER TABLE `lavoratore` DISABLE KEYS */;
INSERT INTO `lavoratore` VALUES ('BNCMTT85C15F205D','matteo','bianchi','1990-05-06','matteo','3e8d6d897297415ef1a1a172035cc3f3','capotreno'),('FDRLRZ92L07D612Y','lorenzo','federici','1993-11-11','lorenzo','3e1c14c019d48470b4e861b6eb8eae96','macchinista'),('RSSMRA80A01H501Z','filippo','casto','1995-11-13','falvio','2e4a9ef8e97a5d2e071dab4312b89e57','capotreno'),('RSSMRO75D20H501V','mario','rossi','1998-07-08','mario','e2f15d014d40b93578d255e6221fd60','macchinista');
/*!40000 ALTER TABLE `lavoratore` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_or_update_trigger_lavoratore` BEFORE INSERT ON `lavoratore` FOR EACH ROW BEGIN
    DECLARE user_count INT;

    -- Verifica che il nome utente non sia già presente in nessuna delle tabelle
    SELECT COUNT(*) INTO user_count
    FROM (
        SELECT username FROM gestoredelservizio WHERE username = NEW.username
        UNION ALL
        SELECT username FROM lavoratore WHERE username = NEW.username
        UNION ALL
        SELECT username FROM manutentore WHERE username = NEW.username
        UNION ALL
        SELECT username FROM acquirente WHERE username = NEW.username
    ) AS user_union;

    IF user_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Il nome utente è già in uso in una delle tabelle';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `locomotrici`
--

DROP TABLE IF EXISTS `locomotrici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locomotrici` (
  `codice` varchar(10) NOT NULL,
  `marca` varchar(20) NOT NULL,
  `modello` varchar(20) NOT NULL,
  `matricolaTreno` varchar(4) NOT NULL,
  PRIMARY KEY (`codice`,`matricolaTreno`),
  KEY `matricolaTreno` (`matricolaTreno`),
  CONSTRAINT `locomotrici_ibfk_1` FOREIGN KEY (`matricolaTreno`) REFERENCES `treno` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locomotrici`
--

LOCK TABLES `locomotrici` WRITE;
/*!40000 ALTER TABLE `locomotrici` DISABLE KEYS */;
INSERT INTO `locomotrici` VALUES ('34','best','classic','1234');
/*!40000 ALTER TABLE `locomotrici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manutentore`
--

DROP TABLE IF EXISTS `manutentore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manutentore` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manutentore`
--

LOCK TABLES `manutentore` WRITE;
/*!40000 ALTER TABLE `manutentore` DISABLE KEYS */;
INSERT INTO `manutentore` VALUES ('filippo','6e6bc4e49dd477ebc98ef4046c067b5f');
/*!40000 ALTER TABLE `manutentore` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_or_update_trigger_manutentore` BEFORE INSERT ON `manutentore` FOR EACH ROW BEGIN
    DECLARE user_count INT;

    -- Verifica che il nome utente non sia già presente in nessuna delle tabelle
    SELECT COUNT(*) INTO user_count
    FROM (
        SELECT username FROM gestoredelservizio WHERE username = NEW.username
        UNION ALL
        SELECT username FROM lavoratore WHERE username = NEW.username
        UNION ALL
        SELECT username FROM manutentore WHERE username = NEW.username
        UNION ALL
        SELECT username FROM acquirente WHERE username = NEW.username
    ) AS user_union;

    IF user_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Il nome utente è già in uso in una delle tabelle';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orari`
--

DROP TABLE IF EXISTS `orari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orari` (
  `numeroFermata` int NOT NULL,
  `orarioPartenza` time DEFAULT NULL,
  `orarioArrivo` time DEFAULT NULL,
  `idCorsa` int NOT NULL,
  `dataCorsa` date NOT NULL,
  PRIMARY KEY (`numeroFermata`,`idCorsa`,`dataCorsa`),
  KEY `idCorsa` (`dataCorsa`,`idCorsa`),
  CONSTRAINT `orari_ibfk_1` FOREIGN KEY (`dataCorsa`, `idCorsa`) REFERENCES `corsa` (`dataCorsa`, `idCorsa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orari`
--

LOCK TABLES `orari` WRITE;
/*!40000 ALTER TABLE `orari` DISABLE KEYS */;
INSERT INTO `orari` VALUES (1,'12:00:00','00:00:00',1,'2024-05-19'),(1,'17:00:00','00:00:00',3,'2024-03-17'),(1,'17:00:00','00:00:00',4,'2024-03-19'),(2,'14:00:00','13:50:00',1,'2024-05-19'),(2,'18:00:00','17:50:00',3,'2024-03-17'),(2,'18:00:00','17:50:00',4,'2024-03-19'),(3,'00:00:00','15:00:00',1,'2024-05-19'),(3,'00:00:00','19:00:00',3,'2024-03-17'),(3,'19:00:00','18:50:00',4,'2024-03-19'),(4,'00:00:00','19:00:00',4,'2024-03-19');
/*!40000 ALTER TABLE `orari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posto`
--

DROP TABLE IF EXISTS `posto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posto` (
  `id_vagone` varchar(10) NOT NULL,
  `posto_treno` int NOT NULL,
  `matricolaTreno` varchar(4) NOT NULL,
  PRIMARY KEY (`id_vagone`,`posto_treno`,`matricolaTreno`),
  KEY `idx_posto_treno` (`posto_treno`) /*!80000 INVISIBLE */,
  KEY `posto_ibfk_1_idx` (`matricolaTreno`),
  CONSTRAINT `fk_id_vagone` FOREIGN KEY (`id_vagone`) REFERENCES `vagone` (`codice`),
  CONSTRAINT `fk_posto_vagone` FOREIGN KEY (`matricolaTreno`) REFERENCES `vagone` (`matricolaTreno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posto`
--

LOCK TABLES `posto` WRITE;
/*!40000 ALTER TABLE `posto` DISABLE KEYS */;
INSERT INTO `posto` VALUES ('12',1,'1234'),('12',2,'1234'),('12',3,'1234'),('12',4,'1234'),('12',5,'1234');
/*!40000 ALTER TABLE `posto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenotazione`
--

DROP TABLE IF EXISTS `prenotazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenotazione` (
  `codicePrenotazione` varchar(20) NOT NULL,
  `postoTreno` int NOT NULL,
  `CFAcquirente` varchar(16) NOT NULL,
  `matricolaTreno` varchar(4) NOT NULL,
  `id_vagone` varchar(10) NOT NULL,
  `id_corsa` int NOT NULL,
  `data_` date NOT NULL,
  PRIMARY KEY (`codicePrenotazione`),
  KEY `CFAcquirente` (`CFAcquirente`),
  KEY `matricolaTreno` (`matricolaTreno`),
  KEY `fk_id_PrenotazioneVagone` (`id_vagone`),
  KEY `fk_postoPrenotazione` (`postoTreno`),
  KEY `fk_id_data_prenotazione` (`data_`,`id_corsa`),
  KEY `idx_cfacquirente` (`CFAcquirente`),
  KEY `idx_CF` (`CFAcquirente`),
  CONSTRAINT `fk_id_data_prenotazione` FOREIGN KEY (`data_`, `id_corsa`) REFERENCES `corsa` (`dataCorsa`, `idCorsa`),
  CONSTRAINT `fk_id_PrenotazioneVagone` FOREIGN KEY (`id_vagone`) REFERENCES `posto` (`id_vagone`),
  CONSTRAINT `fk_postoPrenotazione` FOREIGN KEY (`postoTreno`) REFERENCES `posto` (`posto_treno`),
  CONSTRAINT `prenotazione_ibfk_1` FOREIGN KEY (`CFAcquirente`) REFERENCES `acquirente` (`CF`),
  CONSTRAINT `prenotazione_ibfk_2` FOREIGN KEY (`matricolaTreno`) REFERENCES `posto` (`matricolaTreno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenotazione`
--

LOCK TABLES `prenotazione` WRITE;
/*!40000 ALTER TABLE `prenotazione` DISABLE KEYS */;
INSERT INTO `prenotazione` VALUES ('a508d3721f4938a3472d',1,'CPLLCU02L02G698R','1234','12',1,'2024-05-19');
/*!40000 ALTER TABLE `prenotazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storico_manutenzione`
--

DROP TABLE IF EXISTS `storico_manutenzione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storico_manutenzione` (
  `matricolaTreno` varchar(4) NOT NULL,
  `dataManutenzione` date NOT NULL,
  `manutenzione` varchar(100) NOT NULL,
  PRIMARY KEY (`matricolaTreno`,`dataManutenzione`),
  CONSTRAINT `storico_manutenzione_ibfk_1` FOREIGN KEY (`matricolaTreno`) REFERENCES `treno` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storico_manutenzione`
--

LOCK TABLES `storico_manutenzione` WRITE;
/*!40000 ALTER TABLE `storico_manutenzione` DISABLE KEYS */;
/*!40000 ALTER TABLE `storico_manutenzione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tratta`
--

DROP TABLE IF EXISTS `tratta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratta` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tratta`
--

LOCK TABLES `tratta` WRITE;
/*!40000 ALTER TABLE `tratta` DISABLE KEYS */;
INSERT INTO `tratta` VALUES (1),(2),(3),(4),(5),(6);
/*!40000 ALTER TABLE `tratta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treno`
--

DROP TABLE IF EXISTS `treno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treno` (
  `matricola` varchar(4) NOT NULL,
  `DataAcquisto` date NOT NULL,
  `CFMacchinista` varchar(16) NOT NULL,
  `CFCapotreno` varchar(16) NOT NULL,
  PRIMARY KEY (`matricola`),
  KEY `CFMacchinista_idx` (`CFMacchinista`),
  KEY `CFCapotreno_idx` (`CFCapotreno`),
  CONSTRAINT `CFCapotreno` FOREIGN KEY (`CFCapotreno`) REFERENCES `lavoratore` (`CF`),
  CONSTRAINT `CFMacchinista` FOREIGN KEY (`CFMacchinista`) REFERENCES `lavoratore` (`CF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treno`
--

LOCK TABLES `treno` WRITE;
/*!40000 ALTER TABLE `treno` DISABLE KEYS */;
INSERT INTO `treno` VALUES ('1234','2002-11-11','FDRLRZ92L07D612Y','BNCMTT85C15F205D'),('4567','2005-12-12','RSSMRO75D20H501V','RSSMRA80A01H501Z');
/*!40000 ALTER TABLE `treno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vagone`
--

DROP TABLE IF EXISTS `vagone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vagone` (
  `codice` varchar(10) NOT NULL,
  `marca` varchar(20) NOT NULL,
  `classe` int NOT NULL,
  `modello` varchar(20) NOT NULL,
  `maxPasseggeri` int NOT NULL,
  `matricolaTreno` varchar(4) NOT NULL,
  PRIMARY KEY (`codice`,`matricolaTreno`),
  KEY `matricolaTreno` (`matricolaTreno`),
  CONSTRAINT `vagone_ibfk_1` FOREIGN KEY (`matricolaTreno`) REFERENCES `treno` (`matricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vagone`
--

LOCK TABLES `vagone` WRITE;
/*!40000 ALTER TABLE `vagone` DISABLE KEYS */;
INSERT INTO `vagone` VALUES ('12','sasmsung',1,'new',19,'1234'),('13','samsung',1,'new',17,'1234');
/*!40000 ALTER TABLE `vagone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'trasporto_ferroviario'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `eliminazione_dati_vecchi` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `eliminazione_dati_vecchi` ON SCHEDULE EVERY 1 YEAR STARTS '2024-06-23 11:29:41' ON COMPLETION PRESERVE ENABLE COMMENT 'Rimozione dati più vecchi di 10 anni - Test' DO BEGIN
    DELETE FROM orari
    WHERE dataCorsa <= DATE_SUB(NOW(), INTERVAL 10 YEAR);

    DELETE FROM prenotazione
    WHERE data_ <= DATE_SUB(NOW(), INTERVAL 10 YEAR);

    DELETE FROM corsa
    WHERE dataCorsa <= DATE_SUB(NOW(), INTERVAL 10 YEAR);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'trasporto_ferroviario'
--
/*!50003 DROP FUNCTION IF EXISTS `controlla_classe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `controlla_classe`(classe int) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	if classe =1 OR classe=2 then
		return true;
	else
		return false;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `controlla_lavoratori_treno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `controlla_lavoratori_treno`(var_macchinista varchar(16),var_capotreno varchar(16),matricolaTreno varchar(4)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN

	DECLARE macchinista VARCHAR(16);
    DECLARE capotreno VARCHAR(16);

	SELECT CFMacchinista,CFCapotreno
    INTO macchinista,capotreno
    from treno
    WHERE matricola=matricolaTreno;
    

    
	if var_macchinista=macchinista AND var_capotreno=capotreno  then
		return true;
	else
		return false;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `controllo_carta_di_credito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `controllo_carta_di_credito`(carta_di_credito varchar(16)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	if carta_di_credito regexp '[0-9]{16}$' then
		return true;
	else
		return false;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `controllo_cf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `controllo_cf`(codice_fiscale varchar(16)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	if codice_fiscale regexp '[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$' then
		return true;
	else
		return false;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `controllo_lavoratore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `controllo_lavoratore`(
    CFLavoratore1_ VARCHAR(16), 
    CFLavoratore2_ VARCHAR(16), 
    var_data DATE,
    orario_partenza TIME,
    orario_arrivo TIME
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE sovrapposizione BOOLEAN;

    SELECT 
        EXISTS (
            SELECT 1
            FROM (
                SELECT 
                    orarioPartenza,
                    orarioArrivo
                FROM
                    (SELECT 
                        corsa.idCorsa,
                        corsa.dataCorsa,
                        corsa.matricolaTreno,
                        CASE WHEN orari.orarioArrivo = '00:00:00' THEN orari.orarioPartenza ELSE orari.orarioArrivo END AS orarioPartenza,
                        CASE WHEN orari.orarioPartenza = '00:00:00' THEN orari.orarioArrivo ELSE orari.orarioPartenza END AS orarioArrivo
                    FROM 
                        orari
                    JOIN 
                        corsa ON corsa.dataCorsa = orari.dataCorsa AND corsa.idCorsa = orari.idCorsa
                    WHERE 
                        (corsa.CFLavoratore1 = CFLavoratore1_ OR corsa.CFLavoratore2 = CFLavoratore2_)
                        AND corsa.dataCorsa = var_data
                    ) AS combined_results
            ) AS subquery
            WHERE 
                (orario_partenza BETWEEN orarioPartenza AND orarioArrivo
                OR orario_arrivo BETWEEN orarioPartenza AND orarioArrivo
                OR orarioPartenza BETWEEN orario_partenza AND orario_arrivo
                OR orarioArrivo BETWEEN orario_partenza AND orario_arrivo)
        ) INTO sovrapposizione;

    RETURN sovrapposizione;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `controllo_matricola` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `controllo_matricola`(matricola VARCHAR(4)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    IF LENGTH(matricola) = 4 THEN
        RETURN 1; -- Restituisce vero (1) se la lunghezza è 4
    ELSE
        RETURN 0; -- Restituisce falso (0) se la lunghezza non è 4
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `controllo_orari` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `controllo_orari`(orario_partenza Time, oraraio_arrivo time) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	if orario_partenza > oraraio_arrivo THEN
		return true;
	else
		return false;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `controllo_treno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `controllo_treno`(
    treno VARCHAR(16), 
    var_data DATE,
    orario_partenza TIME,
    orario_arrivo TIME
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE sovrapposizione BOOLEAN;

    SELECT 
        EXISTS (
            SELECT 1
            FROM (
                SELECT 
                    orarioPartenza,
                    orarioArrivo
                FROM
                    (SELECT 
                        corsa.idCorsa,
                        corsa.dataCorsa,
                        corsa.matricolaTreno,
                        CASE WHEN orari.orarioArrivo = '00:00:00' THEN orari.orarioPartenza ELSE orari.orarioArrivo END AS orarioPartenza,
                        CASE WHEN orari.orarioPartenza = '00:00:00' THEN orari.orarioArrivo ELSE orari.orarioPartenza END AS orarioArrivo
                    FROM 
                        orari
                    JOIN 
                        corsa ON corsa.dataCorsa = orari.dataCorsa AND corsa.idCorsa = orari.idCorsa
                    WHERE 
                        corsa.matricolaTreno = treno AND corsa.dataCorsa = var_data
                    ) AS combined_results
            ) AS subquery
            WHERE 
                (orario_partenza BETWEEN orarioPartenza AND orarioArrivo
                OR orario_arrivo BETWEEN orarioPartenza AND orarioArrivo
                OR orarioPartenza BETWEEN orario_partenza AND orario_arrivo
                OR orarioArrivo BETWEEN orario_partenza AND orario_arrivo)
        ) INTO sovrapposizione;

    RETURN sovrapposizione;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `max_passeggeri` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `max_passeggeri`(max_passeggeri INT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	if max_passeggeri <= 20 then
		return true;
	else
		return false;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CF_Acquirenti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CF_Acquirenti`(
	IN var_username VARCHAR(20)
)
BEGIN

declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level read committed;
	start transaction;
    
    select CF
    from acquirente
    WHERE username=var_username;
    
    commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CF_Lavoratori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CF_Lavoratori`(
	IN var_username VARCHAR(20)
)
BEGIN

declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level read committed;
	start transaction;
    
    select CF
    from lavoratore
    WHERE username=var_username;
    
    commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login`(in var_username
				VARCHAR(45), in var_password VARCHAR(45), out var_role INT)
BEGIN

-- var_role = 0 --> login
-- var_role = 1 --> acquirente
-- var_role = 2 --> gestore
-- var_role = 3 --> lavoratore
-- var_role = 4 --> manutentore

		set var_role = 0;
        if exists(
			select * from acquirente
			WHERE username = var_username AND
			password = md5(var_password))
		then set var_role = 1;
        end if;
        
        if exists(
			select * from gestoredelservizio
			WHERE username = var_username AND
			password =  md5(var_password))
		then set var_role = 2;
        end if;
        
        if exists(
			select * from lavoratore
			WHERE username = var_username AND
			password =  md5(var_password))
		then set var_role = 3;
        end if;
        
        if exists(
			select * from manutentore
			WHERE username = var_username AND
			password =  md5(var_password))
		then set var_role = 4;
        end if;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_registra_corsa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_registra_corsa`(
    IN var_macchinista VARCHAR(16),
    IN var_capotreno VARCHAR(16),
    IN var_treno VARCHAR(4),
    IN var_data DATE,
    IN var_idTratta INT,
    IN var_orari TEXT
)
BEGIN
    DECLARE var_idCorsa INT;
    DECLARE str_orario TEXT DEFAULT '';
    DECLARE orarioPartenza TIME;
    DECLARE orarioArrivo TIME;
    DECLARE numeroFermata INT DEFAULT 1;
    DECLARE primo_orario TIME;
    DECLARE ultimo_orario TIME;
    DECLARE a INT DEFAULT 1;
    DECLARE total_orari INT;
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL repeatable read;
    START TRANSACTION;

    -- Calcolare il numero totale di orari
    SET total_orari = LENGTH(var_orari) - LENGTH(REPLACE(var_orari, ',', '')) + 1;

    -- Rimuovere eventuali caratteri non numerici dagli orari
    SET var_orari = REPLACE(REPLACE(REPLACE(REPLACE(var_orari, '[', ''), ']', ''), ' ', ''), '(', '');
    
    SET primo_orario = SUBSTRING_INDEX(var_orari, ',', 1);
    SET ultimo_orario = SUBSTRING_INDEX(REVERSE(SUBSTRING_INDEX(REVERSE(var_orari), ',', 1)), ',', 1);
    
    IF (`trasporto_ferroviario`.controlla_lavoratori_treno(var_macchinista,var_capotreno,var_treno) IS FALSE) THEN
        SIGNAL SQLSTATE '45025' SET MESSAGE_TEXT = 'Questo treno ha assegnati diversi lavoratori';
    END IF;
   
    IF (`trasporto_ferroviario`.controllo_treno(var_treno,var_data,primo_orario,ultimo_orario) IS TRUE) THEN
        SIGNAL SQLSTATE '45020' SET MESSAGE_TEXT = 'Il treno è già impegnato in un altra corsa.';
    END IF;
    
    IF (`trasporto_ferroviario`.controllo_lavoratore(var_macchinista,var_capotreno,var_data,primo_orario,ultimo_orario) IS TRUE) THEN
        SIGNAL SQLSTATE '45021' SET MESSAGE_TEXT = 'Il lavoratore è già impegnato in un altra corsa.';
    END IF;

    -- Genera un nuovo idCorsa
    SELECT IFNULL(MAX(idCorsa), 0) + 1 INTO var_idCorsa FROM corsa;

    -- Inserire la nuova corsa nella tabella corsa
    INSERT INTO corsa (idCorsa, dataCorsa, idTratta, matricolaTreno, CFLavoratore1, CFLavoratore2)
    VALUES (var_idCorsa, var_data, var_idTratta, var_treno, var_macchinista, var_capotreno);
    
    -- Etichetta per il loop WHILE
    WHILE_LOOP: WHILE LENGTH(var_orari) > 0 DO
        -- Estrarre l'orario corrente dalla stringa
        SET str_orario = TRIM(SUBSTRING_INDEX(var_orari, ',', 1));

        -- Aggiungi la validazione degli orari
        IF INSTR(str_orario, '-') > 0 THEN
            -- Orario nel formato HH:MM-HH:MM (partenza e arrivo)
            SET orarioPartenza = STR_TO_DATE(SUBSTRING_INDEX(str_orario, '-', 1), '%H:%i');
            SET orarioArrivo = STR_TO_DATE(SUBSTRING_INDEX(str_orario, '-', -1), '%H:%i');
            
            IF (`trasporto_ferroviario`.controllo_orari(orarioPartenza, orarioArrivo) IS FALSE) THEN
                SIGNAL SQLSTATE '45003' SET MESSAGE_TEXT = 'Orario di partenza è minore di quello di arrivo';
            END IF;
        ELSE
            -- Gestione del primo orario singolo e dell'ultimo orario singolo
            IF a = 1 THEN
                -- Primo orario singolo nel formato HH:MM
                SET orarioPartenza = STR_TO_DATE(str_orario, '%H:%i');
                SET orarioArrivo = STR_TO_DATE('00:00', '%H:%i');
            ELSEIF a = total_orari THEN
                -- Ultimo orario singolo nel formato HH:MM
                SET orarioPartenza = STR_TO_DATE('00:00', '%H:%i');
                SET orarioArrivo = STR_TO_DATE(str_orario, '%H:%i');
            ELSE
                -- Gestione intermedia, ma dovrebbe essere inesistente secondo l'input fornito
                SET orarioPartenza = STR_TO_DATE(str_orario, '%H:%i');
                SET orarioArrivo = STR_TO_DATE('00:00', '%H:%i');
            END IF;
        END IF;

        -- Inserire l'orario nella tabella orari
        INSERT INTO orari (numeroFermata, orarioPartenza, orarioArrivo, idCorsa, dataCorsa)
        VALUES (numeroFermata, orarioPartenza, orarioArrivo, var_idCorsa, var_data);

        -- Aggiornare la stringa di orari rimanente
        SET var_orari = TRIM(SUBSTRING(var_orari, LENGTH(str_orario) + 2));

        -- Incrementare il numero della fermata e la posizione
        SET numeroFermata = numeroFermata + 1;
        SET a = a + 1;
    END WHILE WHILE_LOOP;
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrazione`(
    IN p_codiceFiscale VARCHAR(16),
    IN p_nome VARCHAR(50),
    IN p_cognome VARCHAR(50),
    IN p_dataDiNascita DATE,
    IN p_numeroCartaDiCredito bigint,
    IN p_username VARCHAR(20),
    IN p_password VARCHAR(20)
)
BEGIN
declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;

	set transaction isolation level read uncommitted;
	start transaction;
    
	if(`trasporto_ferroviario`.controllo_cf(p_codiceFiscale) is false) then
		signal sqlstate '45001' set message_text = 'Il codice fiscale inserito non è valido.';
	end if;
    
    if(`trasporto_ferroviario`.controllo_carta_di_credito(p_numeroCartaDiCredito) is false) then
		signal sqlstate '45002' set message_text = 'la carta di credito non è valida.';
	end if;
    -- Inserimento dell'utente nel database
    INSERT INTO acquirente (CF, cognome, nome, dataDiNascita, numeroCartaCredito,username,password)
    VALUES (p_codiceFiscale, p_cognome ,p_nome, p_dataDiNascita, p_numeroCartaDiCredito,p_username,md5(p_password));
    
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_Fermate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_Fermate`(
    IN stazione VARCHAR(50), 
    IN citta VARCHAR(50),
    IN provincia VARCHAR(50)
)
BEGIN
    
    
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
   

    SET TRANSACTION ISOLATION LEVEL READ uncommitted;
    START TRANSACTION;

    INSERT INTO fermate VALUES(stazione, citta, provincia);

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_locomotrici` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_locomotrici`(
	IN vard_id INT,
    IN var_marca VARCHAR(20), 
    IN var_modello VARCHAR(20), 
    IN var_matricolaTreno INT)
BEGIN
	declare exit handler for sqlexception
	begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level Read Uncommitted ;
	start transaction;

		insert into `locomotrici` (`codice`, `marca`, `modello`, `matricolaTreno`)
			values (vard_id, var_marca, var_modello, var_matricolaTreno);
	commit;
            
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_manutenzione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_manutenzione`(
	in var_matricola varchar(45),
    in var_data varchar(45),
    in descrizione varchar(200)
)
BEGIN

declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;

	set transaction isolation level read uncommitted;
	start transaction;
		
	insert into storico_manutenzione values (var_matricola, var_data,descrizione);
	
    commit;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_prenotazione2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_prenotazione2`(
    IN tratta INT,
    IN var_partenza TIME,
    IN var_data DATE,
    IN CF VARCHAR(16)
)
BEGIN
    DECLARE codicePrenotazione VARCHAR(20);
    DECLARE conta INT;
    DECLARE vagoneC VARCHAR(10);
    DECLARE maxP INT;
    DECLARE cur_corsa INT;
    DECLARE cur_treno VARCHAR(4);
    DECLARE vagone_candidato VARCHAR(10);
    DECLARE vagone_trovato BOOLEAN DEFAULT FALSE;
    DECLARE posto_trovato INT;
    DECLARE ultimo_posto INT;
    DECLARE vagoni_cursor CURSOR FOR
        SELECT codice, maxPasseggeri
        FROM vagone
        WHERE matricolaTreno = cur_treno;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      
        ROLLBACK;
        RESIGNAL;
    END;
    
    SET TRANSACTION ISOLATION LEVEL repeatable read;
    START TRANSACTION;

-- mi trovo l'id della corsa
    SELECT corsa.idCorsa 
    INTO cur_corsa 
    FROM orari, corsa
    WHERE corsa.dataCorsa = orari.dataCorsa 
      AND corsa.idCorsa = orari.idCorsa 
      AND orarioPartenza = var_partenza 
      AND corsa.dataCorsa = var_data 
      AND corsa.idTratta = tratta;
      
	

-- mi trovo la matricola del treno
    SELECT matricolaTreno 
    INTO cur_treno 
    FROM corsa
    WHERE idCorsa = cur_corsa;

    OPEN vagoni_cursor;
    
    vagoni_loop: LOOP
        FETCH vagoni_cursor INTO vagoneC, maxP;

        IF vagone_trovato THEN
            LEAVE vagoni_loop;
        END IF;

        SELECT COUNT(*)
        INTO conta
        FROM prenotazione
        WHERE id_corsa = cur_corsa AND id_vagone = vagoneC;

        IF conta < maxP THEN
            SET vagone_candidato = vagoneC;
            LEAVE vagoni_loop;
        END IF;
    END LOOP;

    CLOSE vagoni_cursor;
    
   
    IF vagone_candidato IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45030' SET MESSAGE_TEXT = 'La corsa ha raggiunto la capienza massima';
    END IF;

    SELECT MAX(postoTreno)
    INTO ultimo_posto
    FROM prenotazione
    WHERE id_vagone = vagone_candidato AND id_corsa = cur_corsa;

    IF ultimo_posto THEN
        SET posto_trovato = ultimo_posto + 1;
    ELSE
        SET ultimo_posto = 0;
        SET posto_trovato = 1;
    END IF;

  

    SET codicePrenotazione = SUBSTRING(MD5(CONCAT(UUID(), RAND())), 1, 20);

    INSERT INTO prenotazione (codicePrenotazione, postoTreno, CFAcquirente, matricolaTreno, id_vagone, id_corsa, data_) 
    VALUES (codicePrenotazione, posto_trovato, CF, cur_treno, vagone_candidato, cur_corsa, var_data);

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_Tratta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_Tratta`(
    IN fermate TEXT
)
BEGIN
    DECLARE citta_ VARCHAR(20);
    DECLARE provincia_ VARCHAR(20);
    DECLARE current_fermata VARCHAR(20);
    DECLARE start INT DEFAULT 1;
    DECLARE length INT DEFAULT 0;
    DECLARE done INT DEFAULT 0;
    DECLARE max_id INT DEFAULT 1;
    DECLARE counter INT DEFAULT 1;
    
    declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level repeatable read;
	start transaction;

    -- Ottiene il massimo ID dalla tabella tratta
    SELECT MAX(id)
    INTO max_id
    FROM tratta;
    
    -- Gestisce il caso in cui max_id sia NULL
    IF max_id IS NULL THEN
        SET max_id = 1;
    ELSE
        SET max_id = max_id + 1;
    END IF;
    
    -- Inserisce il nuovo ID nella tabella tratta
    INSERT INTO tratta(id) VALUES(max_id);

    -- Loop per processare le fermate
    cursor_loop: LOOP
        SET length = LOCATE(',', fermate, start) - start;

        IF length <= 0 THEN
            SET current_fermata = TRIM(SUBSTRING(fermate, start));
            SET done = 1;
        ELSE
            SET current_fermata = TRIM(SUBSTRING(fermate, start, length));
        END IF;

        -- Ottiene le informazioni della fermata corrente
        SELECT citta, provincia
        INTO citta_, provincia_
        FROM fermate
        WHERE stazione = current_fermata;

        -- Debug output (puoi rimuovere o commentare questa riga se non necessaria)
        -- SELECT current_fermata AS debug_fermata, citta_ AS debug_citta, provincia_ AS debug_provincia;

        -- Inserisce le informazioni nella tabella include
        INSERT INTO include (idTratta, stazione, citta, provincia, numeroFermata)
        VALUES (max_id, current_fermata, citta_, provincia_, counter);

        -- Aggiorna gli indici per la prossima iterazione
        SET start = start + length + 1;
        SET counter = counter + 1;

        -- Esce dal loop se tutte le fermate sono state processate
        IF done THEN
            LEAVE cursor_loop;
        END IF;
    END LOOP;
    
    -- Conferma la transazione
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_treno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_treno`(
	in var_matricola varchar(4),
    in var_dataDiAcquisto varchar(45),
    in var_macchinista varchar(45),
    in var_capotreno varchar(45)
)
BEGIN
	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;

	set transaction isolation level READ uncommitted;
	start transaction;
		
	if(`trasporto_ferroviario`.controllo_matricola(var_matricola) is false) then
		signal sqlstate '45011' set message_text = 'Inserire il codice del treno di 4 caratteri.';
	end if;
	insert into treno values (var_matricola, var_dataDiAcquisto,var_macchinista,var_capotreno);
	
    commit;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registra_vagone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registra_vagone`(
	IN var_id int,
    IN var_marca VARCHAR(45), 
    IN var_classe INT,
    IN var_modello VARCHAR(45), 
    IN var_numMaxPasseggeri INT,
    IN var_matricolaTreno INT
)
BEGIN
	declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level read uncommitted;
	start transaction;
   
   if(`trasporto_ferroviario`.max_passeggeri(var_numMaxPasseggeri) is false) then
		signal sqlstate '45008' set message_text = 'Il numero di passeggeri è maggiore di 25.';
	end if;
    
    if(`trasporto_ferroviario`.controlla_classe(var_classe) is false) then
		signal sqlstate '45013' set message_text = 'Il vagone puo esssere di 1 o 2 classe.';
	end if;
   
    
    INSERT INTO vagone 
    VALUES(var_id, var_marca,var_classe, var_modello,var_numMaxPasseggeri, var_matricolaTreno);

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `report_turni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_turni`(
	In CF VARCHAR(16)
)
BEGIN

	DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    START TRANSACTION;

SELECT 
    idCorsa,
    dataCorsa,
    matricolaTreno,
    MAX(orarioPartenza) AS orarioPartenza,
    MAX(orarioArrivo) AS orarioArrivo
FROM
    (SELECT 
        corsa.idCorsa,
        corsa.dataCorsa,
        corsa.matricolaTreno,
        CASE WHEN orari.orarioArrivo = '00:00:00' THEN orari.orarioPartenza ELSE NULL END AS orarioPartenza,
        CASE WHEN orari.orarioPartenza = '00:00:00' THEN orari.orarioArrivo ELSE NULL END AS orarioArrivo
    FROM 
        orari
    JOIN 
        corsa ON corsa.dataCorsa = orari.dataCorsa AND corsa.idCorsa = orari.idCorsa
    WHERE 
        (corsa.CFLavoratore1 = CF OR corsa.CFLavoratore2 = CF)
    ) AS combined_results
GROUP BY 
    idCorsa, dataCorsa, matricolaTreno
ORDER By(dataCorsa);

commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visualizza_fermate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `visualizza_fermate`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

    SELECT stazione, citta, provincia
    FROM fermate;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visualizza_lavoratori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `visualizza_lavoratori`(
    IN var_matricola VARCHAR(4),
    IN a INT
)
BEGIN
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL repeatable read;
    START TRANSACTION;

    IF a = 0 THEN
        SELECT CF
        FROM lavoratore
        WHERE ruolo = 'capotreno';
    ELSEIF a = 1 THEN
        SELECT CF
        FROM lavoratore
        WHERE ruolo = 'macchinista';
    ELSEIF a = 2 THEN
        SELECT CFMacchinista
        FROM treno
        WHERE matricola = var_matricola;
    ELSEIF a = 3 THEN
        SELECT CFCapotreno
        FROM treno
        WHERE matricola = var_matricola;
    END IF;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visualizza_orari` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `visualizza_orari`(
    IN deta DATE,
    IN id_Tratta INT
    )
BEGIN

DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL repeatable read;
    START TRANSACTION;


	SELECT 
    idCorsa,
    dataCorsa,
    matricolaTreno,
    MAX(orarioPartenza) AS orarioPartenza,
    MAX(orarioArrivo) AS orarioArrivo
FROM
    (SELECT 
        corsa.idCorsa,
        corsa.dataCorsa,
        corsa.matricolaTreno,
        CASE WHEN orari.orarioArrivo = '00:00:00' THEN orari.orarioPartenza ELSE NULL END AS orarioPartenza,
        CASE WHEN orari.orarioPartenza = '00:00:00' THEN orari.orarioArrivo ELSE NULL END AS orarioArrivo
    FROM 
        orari
    JOIN 
        corsa ON corsa.dataCorsa = orari.dataCorsa AND corsa.idCorsa = orari.idCorsa
    WHERE 
        ( orari.dataCorsa=deta AND corsa.idTratta=id_Tratta)
    ) AS combined_results
GROUP BY 
    idCorsa, dataCorsa, matricolaTreno
ORDER BY 
    dataCorsa;
    
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visualizza_prenotazione` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `visualizza_prenotazione`(
	IN Cf VARCHAR(16)
)
BEGIN

declare exit handler for sqlexception
    begin
		rollback;
        resignal;
	end;
    
    set transaction isolation level read committed;
	start transaction;
    
   SELECT prenotazione.matricolaTreno, prenotazione.id_vagone, prenotazione.data_, prenotazione.postoTreno, MIN(orari.orarioPartenza) AS minOrarioPartenza
FROM prenotazione
JOIN corsa ON prenotazione.id_corsa = corsa.idCorsa AND prenotazione.data_ = corsa.dataCorsa
JOIN orari ON corsa.idCorsa = orari.idCorsa AND corsa.dataCorsa = orari.dataCorsa
WHERE prenotazione.CFAcquirente = Cf AND orari.orarioPartenza != 0
GROUP BY corsa.idCorsa, corsa.dataCorsa, prenotazione.matricolaTreno, prenotazione.id_vagone, prenotazione.data_, prenotazione.postoTreno;

    
    commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visualizza_tratte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `visualizza_tratte`()
BEGIN
    
    
	DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL repeatable read;
    START TRANSACTION;
		
    
    SELECT numeroFermata, idTratta, stazione
    FROM include
    ORDER BY idTratta,numeroFermata;
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `visualizza_treni` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `visualizza_treni`()
BEGIN

	 DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL repeatable read;
    START TRANSACTION;
		
    select matricola
    from treno
     
    
    commit;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-23 14:42:15
