Mysql sur mon poste:
Compte Pomona:
- root/gildas

## Processus MySQL qui tourne sur le poste
windows
netstat -ano | findstr :3306
linux
netstat -ln | grep mysql

##
# Sites.
##
http://tecfa.unige.ch/guides/tie/html/mysql-intro/mysql-intro-7.html
http://tecfa.unige.ch/guides/mysql/fr-man/manuel_toc.html

# Connection ligne de commande.
##
mysql -h localhost -u root -p
==> saisir le password.
		
##
# Mysql.ini ==> 
##
C:\Program Files\MySQL\MySQL Server 5.1\My.ini

##
# IMPORT DATA : gros volume.
# Pour pouvoir importer de gros fichier, il faut faire la 
# 	conf. suivante.
##
- Dans le fichier my.ini

[mysqld]

# The TCP/IP Port the MySQL Server will listen on
port=3306
max_allowed_packet=20M


##
# Création d'un nouveau shéma.
##
CREATE USER 'bugzilla'@'localhost' IDENTIFIED BY 'bugzilla';
GRANT USAGE ON * . * TO 'bugzilla'@'localhost' IDENTIFIED BY 'bugzilla';
CREATE DATABASE IF NOT EXISTS `bugzilla` ;
GRANT ALL PRIVILEGES ON `bugzilla` . * TO 'bugzilla'@'localhost';
