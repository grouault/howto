## trouver les locks sur une table
'''

    SELECT 
    --*
    OBJECT_NAME(p.OBJECT_ID) AS TableName,
    resource_type, resource_description,
    request_owner_id, request_owner_type
    FROM
      sys.dm_tran_locks l
      JOIN sys.partitions p ON l.resource_associated_entity_id = p.hobt_id
      where OBJECT_NAME(p.OBJECT_ID) = 'ArticleUniteAssortiment'

'''
