USE GESCOM
GO

CREATE TABLE ARTICLES(
	REFERENCE_ART nvarchar(16),
	DESIGNATION_ART nvarchar(200),
	PRIXHT_ART decimal(10,2),
	CODE_CAT int
);
exec sp_help ARTICLES

CREATE TABLE CATEGORIES(
  code_cat int identity(100,1),
  libelle_cat nvarchar(200)
);

GO
CREATE TABLE COMMANDES(
  numero_cde int identity(1350,1),
  date_cde date,
  taux_remise numeric(2,0),
  numero_cli int,
  etat_cde char(2));
