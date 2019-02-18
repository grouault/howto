-- procédure pour connaître les gens qui sont connectés.
sp_who2

-- Descrit les options de la connexion au moteur
-- Util pour le format de date pour les tests
DBCC USEROPTIONS;

-- Procédure stockées d'aide sur les tables
exec sp_help ARTICLES

-- Changer le nom d'une colonne dans une table
exec sp_rename N'dbo.Table.AncienNom', N'NouveauNom', 'COLUMN'
GO

-- Connaître le nom des tables
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = N'TBL_IN_THIER_CLNT'

--
-- Infos sur les databases
--
select *
from sys.databases;

--
-- Infos sur les locks
--
select  resource_database_id 
FROM sys.dm_tran_locks AS TL;

--
-- locks par database
--
SELECT 
     TL.resource_type,
     TL.resource_database_id,
     TL.resource_associated_entity_id,
     TL.request_mode,
     TL.request_session_id,
     WT.blocking_session_id,
     O.name AS [object name],
     O.type_desc AS [object descr],
     P.partition_id AS [partition id],
     P.rows AS [partition/page rows],
     AU.type_desc AS [index descr],
     AU.container_id AS [index/page container_id]
FROM sys.dm_tran_locks AS TL
INNER JOIN sys.dm_os_waiting_tasks AS WT 
 ON TL.lock_owner_address = WT.resource_address
LEFT OUTER JOIN sys.objects AS O 
 ON O.object_id = TL.resource_associated_entity_id
LEFT OUTER JOIN sys.partitions AS P 
 ON P.hobt_id = TL.resource_associated_entity_id
LEFT OUTER JOIN sys.allocation_units AS AU 
 ON AU.allocation_unit_id = TL.resource_associated_entity_id;

--
-- Requête des logs
--
SELECT top 1  @session = c.session_id, @text = t.text
FROM sys.dm_exec_connections c
CROSS APPLY sys.dm_exec_sql_text (c.most_recent_sql_handle) t   --- jointure avec une table resultante d'une fonction
where c.session_id in 
		(SELECT distinct blocking_session_id as Session_bloquante
				FROM sys.dm_os_waiting_tasks
				WHERE blocking_session_id IS NOT NULL and wait_type like 'LCK%' and wait_duration_ms >= 60000
				and blocking_session_id not in 
						(SELECT session_id 
							FROM sys.dm_os_waiting_tasks
							WHERE blocking_session_id IS NOT NULL and wait_type like 'LCK%' and wait_duration_ms >= 60000
							)
		)

