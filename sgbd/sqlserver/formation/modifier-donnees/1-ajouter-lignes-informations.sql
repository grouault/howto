# insert

INSERT INTO CLIENTS(numero, nom, prenom, adresse, codepostal, ville, telephone,CODEREP)
VALUES (251, 'DUPONT','Jean',Null,'44000',Default,'02 44 44 25 10','CD');
go
--
-- renseigné un certains nombre de colonne
--
INSERT INTO ARTICLES (REFERENCE_ART,DESIGNATION_ART, CODE_CAT)
VALUES ('SOU26','Microsft Arc Mouse',40);
go
--
-- insertion d'un grand nombre de colonnes
--
INSERT INTO STOCKS (REFERENCE_ART, DEPOT, QTE_STK)
  SELECT REFERENCE_ART,'P2',0 FROM ARTICLES;
go
--
-- Connaître tous les noms des tables actuellement créé sur la base de données GESCOM.
--
create procedure noms_tables as
  select TABLE_SCHEMA, TABLE_NAME  from INFORMATION_SCHEMA.TABLES;
go
execute dbo.noms_tables
go
--
-- sysname (synonyme): permet de créer une colonne qui peut stocker un identifiant au format sql-server
--
CREATE TABLE #TBN(leSchema sysname, leNom sysname);
go
INSERT INTO #TBN execute dbo.noms_tables
go
--
-- inserer plusieurs données d'un coup
-- 
INSERT INTO CATEGORIES (libelle_cat)
  VALUES ('Moniteur LCD'),('Switch');
