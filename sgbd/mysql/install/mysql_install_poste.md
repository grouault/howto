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

## Installation de MySQL5.6
###########

#1- dézipper l'archive

# Lancer MySql en console
> mysqld --console

# Lancer MySql
> mysqld

# Fermer MySql
> mysqladmin -u root -p shutdown

# Password
# show password
mysql> SELECT User, Host, Password FROM mysql.user;

## change password
shell> mysql -u root
> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('gildas');
> SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('gildas');
> SET PASSWORD FOR 'root'@'::1' = PASSWORD('gildas');
> SET PASSWORD FOR 'root'@'%' = PASSWORD('gildas');

ou

shell> mysql -u root
mysql> UPDATE mysql.user SET Password = PASSWORD('new_password')
    ->     WHERE User = 'root';
mysql> FLUSH PRIVILEGES;
