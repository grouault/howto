-- DROP SCHEMA
drop schema `aurora`;
CREATE SCHEMA `aurora` DEFAULT CHARACTER SET utf8;

CREATE USER 'bugzilla'@'localhost' IDENTIFIED BY 'bugzilla';
GRANT USAGE ON * . * TO 'bugzilla'@'localhost' IDENTIFIED BY 'bugzilla';
CREATE DATABASE IF NOT EXISTS `bugzilla` ;
GRANT ALL PRIVILEGES ON `bugzilla` . * TO 'bugzilla'@'localhost';


CREATE USER 'customtype'@'localhost' IDENTIFIED BY 'customtype';
GRANT USAGE ON * . * TO 'customtype'@'localhost' IDENTIFIED BY 'customtype';
CREATE DATABASE IF NOT EXISTS `customtype`;
GRANT ALL PRIVILEGES ON `customtype` . * TO 'customtype'@'localhost';
