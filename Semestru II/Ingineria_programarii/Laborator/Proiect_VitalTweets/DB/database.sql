CREATE DATABASE IPDB;

CREATE TABLE IF NOT EXISTS `KeyTerms` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `rumanian` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `english` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `german` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `french` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `spanish` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `Tweets` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `create_date` date NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `disease` varchar(200) COLLATE  utf8_unicode_ci NOT NULL,
  `username` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `text` varchar(700) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) AUTO_INCREMENT=1 ;

INSERT INTO KeyTerms 
VALUES(NULL,'pojar','measles','Masern','rougeole','sarampión');

INSERT INTO KeyTerms 
VALUES(NULL,'varicelă','chicken pox','Windpocken','varicelle','varicela');

INSERT INTO Tweets 
VALUES (NULL,sysdate(),27,35,"measles","DummyPerson","Hey everybody! I am the only one who have measles?");

CREATE INDEX lat_long
ON Tweets (longitude, latitude);

INSERT INTO Tweets 
VALUES (NULL,sysdate(),100,21,"pojar","Popescu Mihai","Ah! O zi obișnuită în care să ai pojar.");
