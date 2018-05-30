-- Adminer 4.6.2 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `connection`;
CREATE TABLE `connection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) DEFAULT NULL,
  `Connector` varchar(256) DEFAULT NULL,
  `JDBCDriverClass` varchar(256) DEFAULT NULL,
  `JDBCConnectionString` varchar(256) DEFAULT NULL,
  `Username` varchar(32) DEFAULT NULL,
  `Password` varchar(32) DEFAULT NULL,
  `DBSchemaName` varchar(64) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_Connection_user_idx` (`user_id`),
  CONSTRAINT `fk_Connection_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `connection` (`id`, `Name`, `Connector`, `JDBCDriverClass`, `JDBCConnectionString`, `Username`, `Password`, `DBSchemaName`, `user_id`) VALUES
(4,	'NEW TEST CONNECTION',	'localhost',	'mysql',	'mysql:host=localhost;dbname=testdatabase',	'root',	'cloudera',	'testdatabase',	1),
(8,	'MySQL RetailDB Connection',	'localhost',	'mysql',	'mysql:host=localhost;dbname=retail_db',	'root',	'cloudera',	'retail_db',	3),
(10,	'Gynimo testas',	'localhost',	'mysql',	'mysql:host=localhost;dbname=retail_db',	'root',	'cloudera',	'retail_db',	1),
(11,	'ConnectionToRetailDB',	'localhost',	'mysql',	'mysql:host=localhost;dbname=retail_db',	'root',	'cloudera',	'retail_db',	1),
(12,	'MySQL RetailDB Connection',	'localhost',	'mysql',	'mysql:host=localhost;dbname=retail_db',	'root',	'cloudera',	'retail_db',	1);

DROP TABLE IF EXISTS `executions`;
CREATE TABLE `executions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Status` varchar(32) DEFAULT NULL,
  `JobSteps_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_Executions_JobSteps1_idx` (`JobSteps_id`),
  CONSTRAINT `fk_Executions_JobSteps1` FOREIGN KEY (`JobSteps_id`) REFERENCES `jobsteps` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) DEFAULT NULL,
  `Type` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `jobs` (`id`, `Name`, `Type`) VALUES
(1,	'test job',	'import'),
(11,	'Export from Retail DB to test',	'export'),
(12,	'Departments and categories import',	'import'),
(13,	'Departments and categories import2',	'import'),
(14,	'testttttttt',	'import'),
(15,	'test with delete dir',	'import'),
(16,	'testdelete',	'import'),
(17,	'lol',	'import'),
(18,	'NAUJAS TEST JOB1',	'import'),
(19,	'Import Job 05-18',	'import'),
(20,	'Retail_db_job',	'import'),
(23,	'Gynimo_test_import',	'import'),
(24,	'new test',	'import'),
(25,	'transfer_data',	'import'),
(28,	'ex',	'export'),
(29,	'export test',	'export'),
(30,	'ImportFromRetailDB',	'import'),
(31,	'Import_from_mysql',	'import');

DROP TABLE IF EXISTS `jobsteps`;
CREATE TABLE `jobsteps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `SqoopCommand` text,
  `DBTableName` varchar(128) DEFAULT NULL,
  `Jobs_id` int(11) NOT NULL,
  `Connection_id` int(11) NOT NULL,
  `Connection_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_JobSteps_Jobs1_idx` (`Jobs_id`),
  KEY `fk_JobSteps_Connection1_idx` (`Connection_id`,`Connection_user_id`),
  CONSTRAINT `fk_JobSteps_Connection1` FOREIGN KEY (`Connection_id`) REFERENCES `connection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_JobSteps_Jobs1` FOREIGN KEY (`Jobs_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `jobsteps` (`id`, `SqoopCommand`, `DBTableName`, `Jobs_id`, `Connection_id`, `Connection_user_id`) VALUES
(34,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table categories --delete-target-dir --target-dir /Jobs/Import/categories -m 1',	'categories',	19,	8,	3),
(35,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table departments --delete-target-dir --target-dir /Jobs/Import/departments -m 1',	'departments',	19,	8,	3),
(39,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table categories --delete-target-dir --target-dir /bakalaurinis/categories -m 1',	'categories',	23,	10,	1),
(40,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table departments --delete-target-dir --target-dir /bakalaurinis/departments -m 1',	'departments',	23,	10,	1),
(41,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table products --delete-target-dir --target-dir /gynimas/import3/products -m 1 --hive-import --hive-overwrite  --hive-table products',	'products',	25,	10,	1),
(46,	'sqoop export --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table products --export-dir /gynimas/import5 -m 1 --hive-import --hive-overwrite  --hive-table products',	'products',	28,	10,	1),
(47,	'sqoop export --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table products --export-dir /gynimas/import5 -m 1 ',	'products',	29,	10,	1),
(48,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table customers --delete-target-dir --target-dir /outputdirectory/customers -m 1 --hive-import --hive-overwrite  --hive-table customers',	'customers',	30,	11,	1),
(49,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table order_items --delete-target-dir --target-dir /outputdirectory/order_items -m 1 --hive-import --hive-overwrite  --hive-table order_items',	'order_items',	30,	11,	1),
(50,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table orders --delete-target-dir --target-dir /outputdirectory/orders -m 1 --hive-import --hive-overwrite  --hive-table orders',	'orders',	30,	11,	1),
(51,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table categories --delete-target-dir --target-dir /outputdirectory/categories -m 1 --hive-import --hive-overwrite  --hive-table categories',	'categories',	31,	12,	1),
(52,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table customers --delete-target-dir --target-dir /outputdirectory/customers -m 1 --hive-import --hive-overwrite  --hive-table customers',	'customers',	31,	12,	1),
(53,	'sqoop import --connect jdbc:mysql://localhost/retail_db --username root --password cloudera --table order_items --delete-target-dir --target-dir /outputdirectory/order_items -m 1 --hive-import --hive-overwrite  --hive-table order_items',	'order_items',	31,	12,	1);

DROP TABLE IF EXISTS `migration`;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base',	1515004892),
('m180103_184609_init',	1515005254);

DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `StartDate` datetime DEFAULT NULL,
  `PeriodInDays` int(10) unsigned DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `Jobs_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_Schedules_Jobs1_idx` (`Jobs_id`),
  CONSTRAINT `fk_Schedules_Jobs1` FOREIGN KEY (`Jobs_id`) REFERENCES `jobs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `user` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `created_at`, `updated_at`) VALUES
(1,	'admin',	'mNIAnD1E3TFgIlPIKlenPsqvLTPvhP9J',	'$2y$13$1dds3dDeGtBL9tvo18U.mOqqV0IL/OFUCjavg6vzuyn9AIu.X/SXG',	NULL,	'anatolijus@s-e.lt',	10,	0,	0),
(2,	'test',	'Udsn8W0-Tp6CqfiBli3z6mgxewZQ9Gr3',	'$2y$13$./6o2ALgXStsePPCYG4pWeWGC.j4n9PPAjmbqyTDcPRXwHjAHhDP6',	NULL,	'test@test.com',	10,	1515108318,	1515108318),
(3,	'Rokas',	'YfZVRcHYGTAb_sGGM-PvfldD9x9B0veM',	'$2y$13$nTE0quNycEvHRaP0boSRAOI5IuOQBPOhWns80COTv0EGCaf.9FRUS',	NULL,	'r.kanapienis@gmail.com',	10,	1515112816,	1515112816);

-- 2018-05-30 18:04:56
