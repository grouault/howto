ALTER DATABASE GESCOM
  SET AUTO_CREATE_STATISTICS ON;
GO
SELECT name, is_auto_update_stats_on
  FROM sys.databases;
GO
exec sp_createstats
