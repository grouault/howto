
CREATE FUNCTION nbre_cde(@nocli int) RETURNS int AS
BEGIN
	DECLARE @nbre int;
	SELECT @nbre=COUNT(*)
	  FROM COMMANDES
	  WHERE numero_cli=@nocli;
	RETURN @nbre;
END;
GO
select dbo.nbre_cde(1);
GO
CREATE FUNCTION ArticlesPetitPrix(@seuil int)
	RETURNS TABLE 
  AS
	RETURN(SELECT * FROM ARTICLES WHERE prixht_art<@seuil);
GO
SELECT * FROM ArticlesPetitPrix(50);
GO
CREATE FUNCTION AnalyseClient (@nocli int)
	RETURNS @FicheClient TABLE(libelle nchar(30), valeur int)
AS
BEGIN
	INSERT INTO @FicheClient
		VALUES ('Nombre de commandes',dbo.nbre_cde(@nocli));
	INSERT INTO @FicheClient
		SELECT 'Montant total', CONVERT(int,SUM(qte_cde*prixht_art))
		FROM COMMANDES cde INNER JOIN LIGNES_CDE lig
		  ON cde.numero_cde=lig.numero_cde
		  INNER JOIN ARTICLES art
		  ON lig.reference_art=art.reference_art;
	RETURN;
END;
GO
SELECT * FROM AnalyseClient(1);
GO
CREATE FUNCTION ftest()
  RETURNS int
  WITH SCHEMABINDING
AS
BEGIN
	DECLARE @retour int;
	SELECT @retour=COUNT(*) FROM dbo.HISTO_FAC;
	RETURN @retour;
END;
go
DROP TABLE HISTO_FAC;