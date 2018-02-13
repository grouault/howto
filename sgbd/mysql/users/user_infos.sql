-- show info from users
select * from mysql.user;
select host, user, password from mysql.user;

-- Create-user
CREATE SCHEMA `salsa-lot2` DEFAULT CHARACTER SET utf8;
CREATE USER 'salsa2'@'localhost' IDENTIFIED BY 'salsa2';
GRANT USAGE ON * . * TO 'salsa2'@'localhost' IDENTIFIED BY 'salsa2';
GRANT ALL PRIVILEGES ON `salsa-lot2` . * TO 'salsa2'@'localhost';
