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

CREATE TABLE HISTO_FAC(
  numero_fac int identity(1000,1) not null,
  date_fac datetime,
  numero_cde int,
  montantht smallmoney,
  etat_fac char(2),
  constraint pk_histo_fac primary key(numero_fac)
);

GO
CREATE TABLE LIGNES_CDE(
  numero_cde int not null,
  numero_lig int not null,
  reference_art nvarchar(16) not null,
  qte_cde int default 1
);
GO

ALTER TABLE LIGNES_CDE
  ADD CONSTRAINT pk_lignes
  PRIMARY KEY NONCLUSTERED (numero_cde, numero_lig);
