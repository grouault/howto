CREATE USER 'websystique'@'localhost' IDENTIFIED BY 'websystique';
GRANT USAGE ON * . * TO 'websystique'@'localhost' IDENTIFIED BY 'websystique';
CREATE SCHEMA `websystique` DEFAULT CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON `websystique` . * TO 'websystique'@'localhost';
