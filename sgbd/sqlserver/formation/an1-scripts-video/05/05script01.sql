
BEGIN TRAN
  SELECT reference_art, prixht_art FROM ARTICLES WHERE CODE_CAT=30;
  UPDATE ARTICLES
    SET prixht_art=prixht_art*1.02
	WHERE code_cat=30;
  SELECT reference_art, prixht_art FROM ARTICLES WHERE CODE_CAT=30;
  SAVE TRAN P1
  UPDATE ARTICLES
    SET prixht_art=prixht_art*1.01
	WHERE code_cat=30;
  SELECT reference_art, prixht_art FROM ARTICLES WHERE CODE_CAT=30;
  ROLLBACK TRAN P1  
  SELECT reference_art, prixht_art FROM ARTICLES WHERE CODE_CAT=30;
COMMIT TRAN
GO
SELECT ville, COUNT(*) 'Nbre Clients'
  FROM CLIENTS WITH (TABLOCK HOLDLOCK)
  GROUP BY ville;