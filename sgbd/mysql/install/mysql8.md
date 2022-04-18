## Installation de MySQL en local
- C:\Services\devs\sgbd\mysql\8.0.21

### MySQL 5.6
- C:\Services\devs\sgbd\mysql\5.6.36
- root / gildas

## Savoir si une instance de MySql tourne 
windows
netstat -ano | findstr :3306
linux
netstat -ln | grep mysql

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

mysql> UPDATE mysql.user SET Password = PASSWORD('new_password') WHERE User = 'root';
    
mysql> FLUSH PRIVILEGES;
