
SELECT *
  FROM COMMANDES
  WHERE numero_cli=(SELECT numero
	FROM CLIENTS
	WHERE nom LIKE 'Kornu'
  );
GO
SELECT *
  FROM ARTICLES
  WHERE code_cat IN (SELECT code_cat
	FROM CATEGORIES
	WHERE libelle_cat like 'Cl%'
  );
GO
SELECT reference_art
  FROM ARTICLES
  WHERE NOT EXISTS(SELECT *
    FROM LIGNES_CDE
	WHERE LIGNES_CDE.reference_art= ARTICLES.reference_art);
GO
SELECT reference_art, prixht_art
  FROM ARTICLES art1
  WHERE prixht_art=(SELECT distinct art2.prixht_art
    FROM ARTICLES art2
	WHERE art2.prixht_art=art1.prixht_art
	  AND art2.reference_art!=art1.reference_art)
  ORDER BY prixht_art DESC;