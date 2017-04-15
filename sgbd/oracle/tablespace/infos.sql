select substr(d.name,1,50) "FICHIER", d.TS#
from V$datafile d, V$tablespace t
where d.TS#=t.TS#
order by d.TS#;

select s.TABLESPACE_NAME, s.STATUS, s.CONTENTS
from SYS.DBA_TABLESPACES s;

select tablespace_name
from SYS.DBA_TABLESPACES;

select *
from SYS.DBA_TABLESPACES;

select *
from SYS.DBA_DATA_FILES;
