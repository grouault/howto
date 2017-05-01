-- création tablespace FILE
CREATE TABLESPACE SURSAUD
DATAFILE '/ora01/app/oracle/oradata/ORA11G/SURSAUD_01.dbf' SIZE 100M
AUTOEXTEND OFF
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 65K;

-- création tablespace INDEX
CREATE TABLESPACE SURSAUD_IDX
DATAFILE '/ora01/app/oracle/oradata/ORA11G/SURSAUD_IDX_01.dbf' SIZE 100M
AUTOEXTEND OFF
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 65K;