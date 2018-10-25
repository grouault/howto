SET NAMES utf8;

DROP TABLE IF EXISTS Animal;

CREATE TABLE Animal (
  id smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  espece varchar(40) NOT NULL,
  sexe char(1) DEFAULT NULL,
  date_naissance datetime NOT NULL,
  nom varchar(30) DEFAULT NULL,
  commentaires text,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
