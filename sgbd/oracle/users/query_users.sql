--
-- Se connecter avec un users
conn  system/password;

--
-- Delocker un compte
alter user scott account unlock;

-- changer le mot de passe
alter user scott identified by tiger;
 conn scott/tiger; 

-- Tous les users
select username, account_status, expiry_date, created, profile 
from dba_users;

-- les tables du user SCOTT
SELECT table_name  
from all_tables where owner = 'SCOTT';

SELECT * 
FROM  ALL_TABLES WHERE OWNER in 'SCOTT';

