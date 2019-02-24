SELECT numero, nom, prenom, ville
  FROM CLIENTS
  WHERE ville='NANTES';
GO
SELECT numero, nom, prenom, ville
  FROM CLIENTS
  WHERE CODEPOSTAL BETWEEN 44000 AND 44999;
GO
SELECT numero, nom, prenom, ville
  FROM CLIENTS
  WHERE (ville like 'N%' OR ville IS NULL)
    AND prenom like 'No_m%';
GO
SELECT numero_cde, numero_cli
  FROM COMMANDES
  WHERE DATEPART(mm, date_cde)=6
    AND DATEDIFF(year, GETDATE(), date_cde)<3;	