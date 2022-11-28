CREATE USER 'dvdstore'@'localhost' IDENTIFIED BY '1234';
-- GRANT USAGE ON * . * TO 'dvdstore'@'localhost' IDENTIFIED BY 'dvdstore';
CREATE DATABASE `DVDSTORE` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON `dvdstore` . * TO 'dvdstore'@'localhost';