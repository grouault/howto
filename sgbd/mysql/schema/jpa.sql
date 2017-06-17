CREATE SCHEMA `jpa` DEFAULT CHARACTER SET utf8;

CREATE USER 'jpa'@'localhost' IDENTIFIED BY 'jpa';
GRANT USAGE ON * . * TO 'jpa'@'localhost' IDENTIFIED BY 'jpa';
GRANT ALL PRIVILEGES ON `jpa` . * TO 'jpa'@'localhost';
