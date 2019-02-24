
SELECT numero, nom, prenom
  INTO CLINANTES
  FROM CLIENTS
  WHERE ville='Nantes';
GO
SELECT *
  FROM CLINANTES;
GO
SELECT reference_art, sum(qte_cde) as quantite
  INTO ##artCde
  FROM LIGNES_CDE
  GROUP BY reference_art;
GO
SELECT * FROM ##artCde;