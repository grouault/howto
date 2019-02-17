--
-- supprimer tous les clients
-- attention aux contraintes
--
DELETE FROM CLIENTS;
go
DELETE FROM HISTO_FAC WHERE etat_fac='SO';
go

DELETE FROM H
  FROM HISTO_FAC H, COMMANDES C
  WHERE H.numero_cde=c.numero_cde
   AND C.numero_cli=1;
go
TRUNCATE TABLE HISTO_FAC;
