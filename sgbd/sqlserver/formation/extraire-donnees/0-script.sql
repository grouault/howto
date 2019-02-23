-- ================= --
-- == SELECTION   == --
-- ================= --
SELECT * FROM ARTICLES;
GO
SELECT CODE_CAT, REFERENCE_ART FROM ARTICLES;
GO
SELECT Catégorie=CODE_CAT, 
       'Désignation de l''article'=DESIGNATION_ART 
       FROM ARTICLES;
-- ================= --
-- == RESTRICTION == --
-- ================= --
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
-- ======================== --
-- == CALCUL ELEMENTAIRE == --
-- ======================== --
SELECT REFERENCE_ART,
	'Ancien Prix'=PRIXHT_ART,
	'Nouveau Prix'=PRIXHT_ART*1.1
	FROM ARTICLES;
GO
SELECT RTRIM(nom)+' '+RTRIM(prenom) AS Patronyme,
	SUBSTRING(codepostal,1,2) AS DEPARTEMENT
	FROM CLIENTS;
