## trouver les locks sur une table

    SELECT 
    --*
    OBJECT_NAME(p.OBJECT_ID) AS TableName,
    resource_type, resource_description,
    request_owner_id, request_owner_type
    FROM
      sys.dm_tran_locks l
      JOIN sys.partitions p ON l.resource_associated_entity_id = p.hobt_id
      where OBJECT_NAME(p.OBJECT_ID) = 'ArticleUniteAssortiment'

## Infos sur les locks

    select  resource_database_id 
    FROM sys.dm_tran_locks AS TL;


## locks par database
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


## Requête des logs
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
