CREATE DATABASE  IF NOT EXISTS `appix` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `appix`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: appix
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `IDEmpresa` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(60) DEFAULT NULL,
  `Telefono` varchar(12) DEFAULT NULL,
  `Correo` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`IDEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,'Grupo Industrial Azteca','55-1234-5678','contacto@grupoazteca.com.mx'),(2,'Constructora Hidalgo SA de CV','33-9876-5432','info@constructorahidalgo.com.m'),(3,'Comercializadora Maya SAPI de ','81-2468-1357','ventas@mayacomercial.com.mx'),(4,'Ingeniería del Norte SA','686-555-1234','contacto@ingenierianorte.com.m'),(5,'Consultores y Asesores Morales','55-7890-4321','info@moralesconsulting.com.mx'),(6,'Desarrollos Urbanos del Surest','999-369-2580','ventas@dusureste.com.mx'),(7,'Energía Renovable SA','33-1478-9632','contacto@energiarenovable.com.'),(8,'Grupo Financiero Azul','55-2580-1478','info@grupofinancieroazul.com.m'),(9,'Manufacturas del Bajío SA de C','477-369-2580','ventas@manufacturasbajio.com.m'),(10,'Servicios Logísticos del Pacíf','322-654-7890','info@logisticapacifico.com.mx'),(11,'Tecnología Avanzada del Golfo','833-135-2468','contacto@tecnologiagolfo.com.m'),(12,'Grupo Gastronómico Luna','55-3698-1478','info@grupoluna.com.mx'),(13,'Despachos Legales Ramírez','662-789-1234','contacto@ramirezlegal.com.mx'),(14,'Comercializadora del Norte','81-6543-9876','ventas@comernorte.com.mx'),(15,'Consultoría Estratégica Maya','998-369-2580','info@consultmayas.com.mx'),(16,'Industria Automotriz del Bajío','462-369-2580','ventas@automotrizbajio.com.mx'),(17,'Constructora del Sureste SA','999-1478-963','contacto@consursureste.com.mx'),(18,'Soluciones Tecnológicas del Ce','55-9876-5432','info@solucionescentro.com.mx'),(19,'Inmobiliaria del Caribe','998-369-1478','contacto@inmocaribe.com.mx'),(20,'Grupo Turístico del Pacífico','322-2580-147','info@grupoturisticopacifico.co'),(21,'EmpresaX','4446667777','companyname@icemail.com'),(22,'EmpresaX','4446667777','companyname@icemail.com'),(23,'Tesla Foundations','2158675309','musk@elon.elon'),(24,'Gregory Inc','982903213','happymeal@mcds.com'),(25,'nintendo','9232034234','nintendo@nintendo.com'),(26,'andreIndustries','9611868350','andreIndustries@tec.mx'),(27,'Chiapas Industries','9621868350','chiapas@tec.mx'),(28,'ITESM','9631868350','itesm@tec.mx'),(29,'brrr','66787576','a01664407@tec.mx'),(30,'appix','6546545456','companyname@icemail.com'),(31,'Oxxo','4832905','oxxo@oxxo.com');
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyectoriesgos`
--

DROP TABLE IF EXISTS `proyectoriesgos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyectoriesgos` (
  `IDProyectoRiesgo` int(11) NOT NULL AUTO_INCREMENT,
  `IDProyecto` int(11) DEFAULT NULL,
  `IDRiesgo` int(11) DEFAULT NULL,
  `FechaAgregado` date DEFAULT NULL,
  PRIMARY KEY (`IDProyectoRiesgo`),
  KEY `IDProyecto` (`IDProyecto`),
  KEY `IDRiesgo` (`IDRiesgo`),
  CONSTRAINT `proyectoriesgos_ibfk_1` FOREIGN KEY (`IDProyecto`) REFERENCES `proyectos` (`IDProyecto`),
  CONSTRAINT `proyectoriesgos_ibfk_2` FOREIGN KEY (`IDRiesgo`) REFERENCES `riesgos` (`IDRiesgo`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyectoriesgos`
--

LOCK TABLES `proyectoriesgos` WRITE;
/*!40000 ALTER TABLE `proyectoriesgos` DISABLE KEYS */;
INSERT INTO `proyectoriesgos` VALUES (1,1,3,'2024-05-26'),(2,1,1,'2024-04-19'),(3,1,9,'2024-05-06'),(9,3,7,'2024-04-22'),(10,3,12,'2024-05-06'),(11,3,13,'2024-04-08'),(12,3,19,'2024-04-23'),(13,4,2,'2024-05-31'),(14,4,3,'2024-04-15'),(15,4,4,'2024-05-20'),(16,4,6,'2024-06-02'),(17,4,10,'2024-05-25'),(18,4,14,'2024-04-13'),(19,4,15,'2024-05-18'),(20,4,22,'2024-05-13'),(21,4,26,'2024-05-09'),(22,4,29,'2024-05-22'),(23,7,1,'2024-05-19'),(24,7,5,'2024-05-30'),(25,7,6,'2024-05-25'),(26,7,8,'2024-05-28'),(27,7,10,'2024-05-27'),(28,7,11,'2024-04-08'),(29,7,13,'2024-05-05'),(30,7,16,'2024-05-11'),(31,7,19,'2024-05-26'),(32,7,22,'2024-04-21'),(33,7,27,'2024-05-08'),(34,7,28,'2024-05-15'),(35,7,31,'2024-04-13'),(36,5,1,'2024-04-28'),(37,6,5,'2024-04-30'),(38,8,6,'2024-05-09'),(39,9,8,'2024-05-04'),(40,10,10,'2024-05-14'),(41,11,11,'2024-05-06'),(42,11,14,'2024-04-08'),(43,12,13,'2024-05-29'),(44,13,16,'2024-05-18'),(45,14,19,'2024-05-13'),(46,15,22,'2024-05-22'),(47,17,27,'2024-05-20'),(48,17,28,'2024-05-29'),(49,17,31,'2024-04-12'),(53,2,3,'2024-04-06'),(54,2,4,'2024-05-01'),(55,2,5,'2024-05-31'),(56,3,29,NULL),(57,9,3,NULL),(58,9,26,NULL),(59,22,3,NULL),(60,22,8,NULL),(61,22,9,NULL),(62,22,22,NULL),(63,22,23,NULL),(64,22,26,NULL),(65,15,6,NULL),(66,15,21,NULL),(67,15,23,NULL),(68,15,26,NULL),(69,6,1,NULL),(70,6,9,NULL),(71,6,14,NULL),(72,6,15,NULL),(73,6,16,NULL),(74,6,18,NULL),(75,6,21,NULL),(76,6,28,NULL);
/*!40000 ALTER TABLE `proyectoriesgos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyectos`
--

DROP TABLE IF EXISTS `proyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyectos` (
  `IDProyecto` int(11) NOT NULL AUTO_INCREMENT,
  `IDEmpresa` int(11) DEFAULT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Descripcion` varchar(240) DEFAULT NULL,
  `Estado` enum('activo','finalizado') DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFinal` date DEFAULT NULL,
  `Costo` int(11) DEFAULT NULL,
  `RazonCerrado` varchar(120) DEFAULT NULL,
  `FechaCerrado` date DEFAULT NULL,
  PRIMARY KEY (`IDProyecto`),
  KEY `IDEmpresa` (`IDEmpresa`),
  CONSTRAINT `proyectos_ibfk_1` FOREIGN KEY (`IDEmpresa`) REFERENCES `empresas` (`IDEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyectos`
--

LOCK TABLES `proyectos` WRITE;
/*!40000 ALTER TABLE `proyectos` DISABLE KEYS */;
INSERT INTO `proyectos` VALUES (1,4,'TiendaOnline.com','Una tienda en linea para venta de zapatos','activo','2024-02-28','2024-08-28',200000,NULL,NULL),(2,1,'Proyecto Beta','Desarrollo de plataforma e-commerce','finalizado','2024-02-15','2024-09-30',200000,'Insuficiente Funding','2024-06-05'),(3,2,'Proyecto Gamma','Optimización de procesos logísticos','activo','2024-03-10','2024-08-15',120000,NULL,NULL),(4,3,'Proyecto Delta','Diseño de nuevo producto tecnológico','activo','2024-04-20','2024-11-10',180000,NULL,NULL),(5,5,'Proyecto Epsilon','Implementación de estrategia de marketing digital','activo','2024-05-05','2024-12-20',160000,NULL,NULL),(6,6,'Proyecto Zeta','Desarrollo de aplicación móvil','activo','2024-06-30','2025-01-31',220000,NULL,NULL),(7,7,'Proyecto Eta','Reestructuración de sistemas informáticos','finalizado','2024-07-15','2025-02-28',190000,'Falta de desarrolladores disponibles','2024-06-01'),(8,8,'Proyecto Theta','Investigación de mercado internacional','activo','2024-08-10','2025-03-15',250000,NULL,NULL),(9,9,'Proyecto Iota','Implementación de sistema de gestión ambiental','activo','2024-09-25','2025-04-30',210000,NULL,NULL),(10,10,'Sitio E-Commerce Tenis Jurica','Venta en linea de tenis en Jurica','activo','2024-02-15','2024-09-30',80000,NULL,NULL),(11,11,'Stickers el Guero','Venta de stickers digitales','activo','2024-03-10','2024-08-15',50000,NULL,NULL),(12,12,'Pagina de Ferreteria','Plataforma e-commerce de ferretaria local','activo','2024-04-20','2024-11-10',240000,NULL,NULL),(13,13,'Sitio Pet Shelter','Difusion de venta de mascotas','activo','2024-05-05','2024-12-20',110000,NULL,NULL),(14,14,'Sistema Seguridad','sistema de entrada y salida de empleados','activo','2024-06-30','2025-01-31',440000,NULL,NULL),(15,15,'Task Manager','aplicacion movil para manejar juntas, tareas, entregas','activo','2024-07-15','2025-02-28',190000,NULL,NULL),(16,16,'Streaming Services','pagina web de peliculas y series','activo','2024-08-10','2025-03-15',230000,NULL,NULL),(17,17,'Crypto App','app movil para comprar/vender cryptomonedas','activo','2024-09-25','2025-04-30',300000,NULL,NULL),(19,24,'Proyecto SeguroX','este es un proyecto de prueba','activo','2024-05-21','2025-07-16',420000,NULL,NULL),(20,8,'Poker Stars','un sitio web para jugar poker multiplayer','activo','2024-05-18','2024-11-30',200000,NULL,NULL),(21,27,'Chiapasionate','Este proyecto es un software para el canon del sumidero','activo','2024-05-16','2024-05-17',6666666,NULL,NULL),(22,28,'EDIFICIO SIETE','Un software para el edificio siete del itesm queretaro.','finalizado','2024-05-14','2024-05-17',77777777,'demasiados riesgso','2024-06-05'),(23,29,'presentacion','brrr','activo','2024-05-07','2024-06-19',1000,NULL,NULL),(24,30,'proyecto appix','cadcac','activo','2024-05-17','2024-05-17',100,NULL,NULL),(25,31,'Oxxo Proyecto','proyecto de oxxo','activo','2024-05-24','2024-06-21',478329,NULL,NULL);
/*!40000 ALTER TABLE `proyectos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riesgos`
--

DROP TABLE IF EXISTS `riesgos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riesgos` (
  `IDRiesgo` int(11) NOT NULL AUTO_INCREMENT,
  `Categoria` enum('Alcance','Tiempo','Calidad','Recursos','Costo') DEFAULT NULL,
  `Probabilidad` enum('Baja','Media','Alta') DEFAULT NULL,
  `Impacto` enum('Bajo','Medio','Alto') DEFAULT NULL,
  `Estrategia` varchar(120) DEFAULT NULL,
  `Riesgo` varchar(50) DEFAULT NULL,
  `ImpactoNumerico` float DEFAULT NULL,
  PRIMARY KEY (`IDRiesgo`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riesgos`
--

LOCK TABLES `riesgos` WRITE;
/*!40000 ALTER TABLE `riesgos` DISABLE KEYS */;
INSERT INTO `riesgos` VALUES (1,'Alcance','Media','Alto','Realizar reuniones detalladas con el cliente.','Incomprensión de los requisitos del cliente',0.05),(2,'Tiempo','Alta','Medio','Establecer plazos claros y roles para entrega de contenido.','Retrasos en la entrega del contenido',0.03),(3,'Alcance','Media','Medio','Definir un alcance claro y limitar las revisiones del diseño.','Cambios frecuentes en el diseño',0.03),(4,'Calidad','Baja','Alto','Realizar pruebas de compatibilidad al inicio.','Problemas de compatibilidad de plugins ',0.05),(5,'Calidad','Baja','Alto','Aplicar estándares de seguridad y realizar actualizaciones.','Problemas de seguridad en el sitio web',0.05),(6,'Calidad','Media','Alto','Validar integraciones y tener proveedores de respaldo.','Fallos en la integración de pasarelas de pago',0.05),(7,'Costo','Baja','Medio','Monitorear y ajustar el presupuesto continuamente.','Aumento inesperado en los costos del proyecto',0.03),(8,'Calidad','Baja','Alto','Implementar estrategias de respaldo y recuperación ante desastres.','Pérdida de datos o fallo de hosting',0.05),(9,'Tiempo','Media','Medio','Establecer expectativas y procesos claros de aprobación.','Retrasos en la aprobación del cliente',0.03),(10,'Calidad','Media','Medio','Mantenerse actualizado con las últimas versiones y soporte.','Dificultades técnicas con WordPress o WooCommerce',0.03),(11,'Recursos','Media','Alto','Gestionar la carga de trabajo y los recursos adecuadamente.','Sobrecarga de trabajo del equipo de diseño',0.05),(12,'Calidad','Media','Alto','Capacitar al equipo o contratar talento especializado.','Falta de experiencia en tecnologías específicas',0.05),(13,'Alcance','Alta','Alto','Implementar un sistema estructurado de gestión de cambios.','Inadecuada gestión del cambio',0.05),(14,'Costo','Baja','Medio','Tener alternativas y planes de contingencia.','Interrupciones en la cadena de suministro digital',0.03),(15,'Calidad','Media','Medio','Aplicar técnicas SEO desde el inicio del proyecto.','Problemas de SEO y visibilidad en buscadores',0.03),(16,'Recursos','Media','Alto','Crear planes de transición por si pasa esto.','Cambio de persona responsable durante y después de',0.05),(17,'','Media','Alto','Utilizar datos históricos para estimaciones precisas.','Subestimación de tiempos y costos',0.05),(18,'Alcance','Alta','Alto','Mantener un proceso de gestión de cambios robusto.','Cambios en los requisitos del software',0.05),(19,'Costo','Media','Alto','Asegurar disponibilidad de recursos y personal cualificado.','Falta de recursos técnicos',0.05),(20,'Calidad','Alta','Medio','Implementar pruebas exhaustivas y QA constante.','Problemas técnicos y bugs en el desarrollo',0.03),(21,'Calidad','Baja','Alto','Realizar auditorías tecnológicas y actualizaciones regulares.','Tecnología obsoleta o inadecuada',0.05),(22,'Alcance','Media','Alto','Ejecutar pruebas de integración frecuentes y tempranas.','Dificultades de integración con otros sistemas',0.05),(23,'Costo','Media','Medio','Establecer contratos sólidos y buscar proveedores alternativos.','Dependencia de terceros para componentes críticos',0.03),(24,'Calidad','Media','Alto','Cumplir con todas las regulaciones y estándares de la industria.','Incumplimiento de estándares de regulación y calid',0.05),(25,'Tiempo','Alta','Alto','Planificar adecuadamente y establecer márgenes de tiempo realistas.','Retrasos en la entrega de software',0.05),(26,'Recursos','Media','Medio','Fomentar la comunicación y resolver conflictos prontamente.','Conflictos dentro del equipo de desarrollo',0.03),(27,'Calidad','Media','Alto','Involucrar al usuario final en las pruebas desde etapas tempranas.','Insuficiencia de pruebas del usuario final',0.05),(28,'Calidad','Media','Medio','Establecer estándares de documentación y seguimiento continuo.','Falta de documentación adecuada',0.03),(29,'Costo','Alta','Medio','Gestionar eficazmente los recursos y planificar la rotación.','Variaciones en la disponibilidad de recursos',0.03),(30,'Calidad','Alta','Alto','Implementar medidas de seguridad de datos robustas.','Riesgos asociados a la seguridad de datos',0.05),(31,'Calidad','Media','Alto','Garantizar compatibilidad a través de pruebas y validaciones.','Problemas de compatibilidad entre sistemas',0.05),(32,'Recursos','Media','Alto','Crear planes de transición por si pasa esto.','Cambio de persona responsable durante y después de',0.05);
/*!40000 ALTER TABLE `riesgos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarioproyectos`
--

DROP TABLE IF EXISTS `usuarioproyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarioproyectos` (
  `IDUsuario` int(11) DEFAULT NULL,
  `IDProyecto` int(11) DEFAULT NULL,
  `FechaAgregado` date DEFAULT NULL,
  KEY `IDUsuario` (`IDUsuario`),
  KEY `IDProyecto` (`IDProyecto`),
  CONSTRAINT `usuarioproyectos_ibfk_1` FOREIGN KEY (`IDUsuario`) REFERENCES `usuarios` (`IDUsuario`),
  CONSTRAINT `usuarioproyectos_ibfk_2` FOREIGN KEY (`IDProyecto`) REFERENCES `proyectos` (`IDProyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarioproyectos`
--

LOCK TABLES `usuarioproyectos` WRITE;
/*!40000 ALTER TABLE `usuarioproyectos` DISABLE KEYS */;
INSERT INTO `usuarioproyectos` VALUES (1,3,'2024-04-19'),(6,7,'2024-04-27'),(1,4,'2024-04-21'),(6,4,'2024-04-21'),(4,5,'2024-04-23'),(4,20,'2024-05-23'),(4,19,'2024-05-21'),(4,6,'2024-04-25'),(5,16,'2024-05-15'),(5,24,'2024-05-31'),(5,12,'2024-05-07'),(5,13,'2024-05-09'),(5,1,'2024-04-15'),(6,20,'2024-05-23'),(6,1,'2024-04-15'),(6,17,'2024-05-17'),(7,10,'2024-05-03'),(7,5,'2024-04-23'),(7,17,'2024-05-17'),(8,19,'2024-05-21'),(8,3,'2024-04-19'),(8,7,'2024-04-27'),(8,17,'2024-05-17'),(8,8,'2024-04-29'),(9,3,'2024-04-19'),(9,16,'2024-05-15'),(9,1,'2024-04-15'),(9,4,'2024-04-21'),(10,3,'2024-04-19'),(10,6,'2024-04-25'),(10,20,'2024-05-23'),(10,25,'2024-06-02'),(10,7,'2024-04-27'),(11,2,'2024-04-17'),(11,24,'2024-05-31'),(11,1,'2024-04-15'),(11,12,'2024-05-07'),(11,23,'2024-05-29'),(12,9,'2024-05-01'),(12,4,'2024-04-21'),(12,21,'2024-05-25'),(13,10,'2024-05-03'),(13,15,'2024-05-13'),(13,5,'2024-04-23'),(13,11,'2024-05-05'),(13,9,'2024-05-01'),(14,11,'2024-05-05'),(14,22,'2024-05-27'),(15,3,'2024-04-19'),(15,10,'2024-05-03'),(15,24,'2024-05-31'),(15,13,'2024-05-09'),(15,19,'2024-05-21'),(16,15,'2024-05-13'),(16,13,'2024-05-09'),(17,22,'2024-05-27'),(17,13,'2024-05-09'),(17,2,'2024-04-17'),(17,14,'2024-05-11'),(17,11,'2024-05-05'),(18,3,'2024-04-19'),(18,15,'2024-05-13'),(18,6,'2024-04-25'),(18,20,'2024-05-23'),(19,25,'2024-06-02'),(19,6,'2024-04-25'),(19,20,'2024-05-23'),(19,19,'2024-05-21'),(19,1,'2024-04-15'),(20,10,'2024-05-03'),(20,23,'2024-05-29'),(20,17,'2024-05-17'),(20,8,'2024-04-29'),(11,3,'2024-06-05'),(62,3,'2024-06-05');
/*!40000 ALTER TABLE `usuarioproyectos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `IDUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(30) DEFAULT NULL,
  `Contrasena` varchar(20) DEFAULT NULL,
  `Rol` enum('desarrollador','manager') DEFAULT NULL,
  `Correo` varchar(80) DEFAULT NULL,
  `FechaCreado` date DEFAULT NULL,
  PRIMARY KEY (`IDUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Carlos López','Carlos123','manager','carlos.lopez@ejemplo.com','2024-04-02'),(2,'Sofia Martinez','Sofia456','manager','sofia.martinez@ejemplo.com','2024-04-10'),(3,'Alejandro Ramirez','Alejandrito789','manager','alejandro.ramirez@ejemplo.com','2024-04-18'),(4,'Valeria Hernandez','Valeria1234','desarrollador','valeria.hernandez@ejemplo.com','2024-04-22'),(5,'Diego Gonzalez','Diego4567','desarrollador','diego.gonzalez@ejemplo.com','2024-04-25'),(6,'Ana Rodriguez','Ana7890','desarrollador','ana.rodriguez@ejemplo.com','2024-05-01'),(7,'Luisa Sanchez','Luisa12345','desarrollador','luisa.sanchez@ejemplo.com','2024-05-07'),(8,'Jorge Cruz','Jorge6789','desarrollador','jorge.cruz@ejemplo.com','2024-05-10'),(9,'Natalia Garcia','Natalia123','desarrollador','natalia.garcia@ejemplo.com','2024-05-13'),(10,'Rodrigo Torres','Rodrigo456','desarrollador','rodrigo.torres@ejemplo.com','2024-05-15'),(11,'Maria Flores','Maria789','desarrollador','maria.flores@ejemplo.com','2024-05-18'),(12,'Eduardo Diaz','Eduardo1234','desarrollador','eduardo.diaz@ejemplo.com','2024-05-21'),(13,'Andrea Vazquez','Andrea5678','desarrollador','andrea.vazquez@ejemplo.com','2024-05-23'),(14,'Francisco Reyes','Francisco12345','desarrollador','francisco.reyes@ejemplo.com','2024-05-26'),(15,'Pamela Torres','Pamela6789','desarrollador','pamela.torres@ejemplo.com','2024-05-28'),(16,'Javier Gomez','Javier123','desarrollador','javier.gomez@ejemplo.com','2024-05-30'),(17,'Daniela Martinez','Daniela456','desarrollador','daniela.martinez@ejemplo.com','2024-06-01'),(18,'Sergio Hernandez','Sergio789','desarrollador','sergio.hernandez@ejemplo.com','2024-06-03'),(19,'Adriana Aguilar','Adriana1234','desarrollador','adriana.aguilar@ejemplo.com','2024-06-05'),(20,'Ricardo Mendoza','Ricardo5678','desarrollador','ricardo.mendoza@ejemplo.com','2024-06-07'),(61,'Kerrick Alberca','kerrick$%77','desarrollador','kerrick@appix.ai','2024-06-01'),(62,'Philip Hellmuth','badbeat','desarrollador','loser@poker.bad','2024-06-03'),(63,'famchiyaque','fam123','manager','fam@chiyaque.com','2024-06-05'),(64,'Erick Bautista','Erick456','manager','erick@gmail.com','2024-06-07'),(65,'Testhius Usunder','Testhius','desarrollador','testhius@test.com','2024-06-03');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-07 13:36:40
