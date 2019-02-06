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
