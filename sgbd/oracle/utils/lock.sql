--select locks
select
   c.owner,
   c.object_name,
   c.object_type,
   b.sid,
   b.serial#,
   b.status,
   b.osuser,
   b.machine
from
   v$locked_object a ,
   v$session b,
   dba_objects c
where
   b.sid = a.session_id
and
   a.object_id = c.object_id;
   
--kill locks
alter system kill session '33,11047' IMMEDIATE

il faut que tu te connectes avec l’utilisateur system/manager
