USE GESCOM
GO
-- TABLE ARTICLES
CREATE TABLE ARTICLES(
	reference_art nvarchar(16),
	designation_art nvarchar(200),
	prixht_art decimal(10,2),
	code_art int
);
exec sp_help ARTICLES
--
-- TABLE CLIENTS
CREATE TABLE CLIENTS(
	[numero] [int] NOT NULL,
	[nom] [varchar](30) NOT NULL,
	[prenom] [varchar](30) NOT NULL,
	[adresse] [nvarchar](80) NULL,
	[codepostal] [char](5) NULL,
	[ville] [nvarchar](30) NULL,
	[telephone] [char](14) NULL
) ON [PRIMARY]
GO
--
-- Ajout d'une colonne
ALTER TABLE CLIENTS ADD CODEREP char(2) NOT NULL;
-- Modification d'une colonne existante
ALTER TABLE CLIENTS ALTER COLUMN TELEPHONE char(14) NOT NULL;
--
-- TABLE CATEGORIE
CREATE TABLE CATEGORIES(
  code_cat int identity(100,1),
  libelle_cat nvarchar(200)
);
--
-- TABLE COMMANDES
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
