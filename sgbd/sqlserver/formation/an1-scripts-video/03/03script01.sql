INSERT INTO CLIENTS(numero, nom, prenom, adresse, codepostal, ville, telephone,CODEREP)
VALUES (251, 'DUPONT','Jean',Null,'44000',Default,'02 44 44 25 10','CD');
go
INSERT INTO ARTICLES (REFERENCE_ART,DESIGNATION_ART, CODE_CAT)
VALUES ('SOU26','Microsft Arc Mouse',40);
go
INSERT INTO STOCKS (REFERENCE_ART, DEPOT, QTE_STK)
  SELECT REFERENCE_ART,'P2',0 FROM ARTICLES;
go
create procedure noms_tables as
  select TABLE_SCHEMA, TABLE_NAME  from INFORMATION_SCHEMA.TABLES;
go
execute dbo.noms_tables
go
CREATE TABLE #TBN(leSchema sysname, leNom sysname);
go
INSERT INTO #TBN execute dbo.noms_tables
go
INSERT INTO CATEGORIES (libelle_cat)
  VALUES ('Moniteur LCD'),('Switch');

