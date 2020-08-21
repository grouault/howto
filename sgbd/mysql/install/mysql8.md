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
