## Installation de MySql 8
##########################

#1- dézipper l'archive

#2- lancer la commande suivante
> mysqld --initialize --console
==> initialise un mot de passe pour root.

#3 Lancer mysql
> mysqld --console

#4 changer le mot de passe Root

## show process mysql
> netstat -an | find "3306"

## MySQL5
##########

# Lancer MySql en console
> mysqld --console

# Lancer MySql
> mysqld

# Fermer MySql
> mysqladmin -u root -p shutdown
