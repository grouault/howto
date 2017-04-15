-- info sur Tablespace et Fichier de données
select substr(d.name,1,50) "FICHIER", d.TS#
from V$datafile d, V$tablespace t
where d.TS#=t.TS#
order by d.TS#;

-- infos sur les tablespaces
select s.TABLESPACE_NAME, s.STATUS, s.CONTENTS
from SYS.DBA_TABLESPACES s;

-- infos sur les fichiers de données
select *
from SYS.DBA_DATA_FILES;
