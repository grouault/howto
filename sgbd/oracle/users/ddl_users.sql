-- Création d'un user avec ses droits associés
create user SURSAUD_DEV identified by SURSAUD_DEV
default tablespace SURSAUD
temporary tablespace TEMP;

-- GRANT resource to SURSAUD_DEV;
-- GRANT CREATE ANY VIEW to SURSAUD_DEV;
-- GRANT CREATE session to SURSAUD_DEV;
-- GRANT DEBUG ANY PROCEDURE to SURSAUD_DEV;
-- GRANT DEBUG CONNECT SESSION to SURSAUD_DEV;
-- GRANT UNLIMITED TABLESPACE to SURSAUD_DEV;

GRANT execute on dbms_lock to SURSAUD_DEV; -- sys
