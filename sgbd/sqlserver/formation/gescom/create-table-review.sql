-- ===============
-- TABLE CATEGORIE
-- ===============	
CREATE TABLE CATEGORIES(
  code_cat int identity(100,1),
  libelle_cat nvarchar(200),
  constraint pk_categories PRIMARY KEY(code_cat)
);
GO
-- ==============
-- TABLE ARTICLES
-- ==============
CREATE TABLE ARTICLES(
	reference_art nvarchar(16),
	designation_art nvarchar(200),
	prixht_art decimal(10,2),
	code_cat int
);
GO
ALTER TABLE ARTICLES
  ALTER COLUMN reference_art nvarchar(16) not null;
GO
ALTER TABLE ARTICLES
  ADD CONSTRAINT pk_articles PRIMARY KEY(reference_art);
go
ALTER TABLE ARTICLES
  ADD CONSTRAINT uq_des_prix
  UNIQUE NONCLUSTERED (designation_art, prixht_art);
ALTER TABLE ARTICLES
	ADD CONSTRAINT fk_articles_categories FOREIGN KEY(code_cat) REFERENCES CATEGORIES(code_cat);
CREATE INDEX IDESIGNATION_ARTICLES
  ON ARTICLES(designation_art)
  WHERE code_cat IN (1,2);
-- =================
-- TABLE STOCKS
-- =================
CREATE TABLE STOCKS(
	reference_art nvarchar(16) NOT NULL,
	depot char(2) NOT NULL,
	qte_stk int NULL,
	stock_mini int NULL DEFAULT 0,
	stock_maxi int NULL,
	constraint pk_stocks PRIMARY KEY(reference_art, depot),
	constraint fk_stocks_articles FOREIGN KEY(reference_art) REFERENCES ARTICLES(reference_art)
);
GO	
-- =============
-- TABLE CLIENTS
-- =============
CREATE TABLE CLIENTS(
	numero int NOT NULL,
	nom varchar(30) NOT NULL,
	prenom varchar(30) NOT NULL,
	adresse nvarchar(80) NULL,
	codepostal char(5) NULL,
	ville nvarchar(30) NULL,
	telephone char(14) NULL,
	ca numeric(10,2) NULL,
	gps geography NULL,
  constraint pk_clients PRIMARY KEY(numero),	
  constraint ck_clients_codepostal CHECK 
	((CONVERT(int,codepostal)>=10000) AND (CONVERT(int,codepostal)<=95999))
); 

-- Ajout d'une colonne
ALTER TABLE CLIENTS 
	ADD COLUMN CODEREP char(2) NOT NULL;
-- Modification d'une colonne existante
ALTER TABLE 
	CLIENTS ALTER COLUMN TELEPHONE char(14) NOT NULL;
ALTER TABLE CLIENTS
	ADD CONSTRAINT df_nom
	DEFAULT 'anonyme' FOR nom;
ALTER TABLE ARTICLES
  ADD CONSTRAINT ck_articles_prixht
  CHECK (prixht_art>=0);

-- CREATE UNIQUE CLUSTERED INDEX INOCLI
--   ON CLIENTS (numero)
--   WITH (FILLFACTOR=50);
GO
-- ===============
-- TABLE COMMANDES
-- ===============
CREATE TABLE COMMANDES(
  numero_cde int identity(1350,1),
  date_cde date,
  taux_remise numeric(2,0),
  numero_cli int,
  etat_cde char(2),
  constraint pk_commandes PRIMARY KEY(numero_cde),
  constraint fk_commandes_clients FOREIGN KEY(numero_cli) REFERENCES CLIENTS(numero)
);
GO
-- =================
-- TABLE LIGNES_CDE
-- =================
CREATE TABLE LIGNES_CDE(
  numero_cde int not null,
  numero_lig int not null,
  reference_art nvarchar(16) not null,
  qte_cde int default 0,
  constraint fk_lignes_cde_commandes FOREIGN KEY(numero_cde) REFERENCES COMMANDES(numero_cde),
  constraint fk_lignes_cde_articles FOREIGN KEY(reference_art) REFERENCES ARTICLES(reference_art)
);
GO
ALTER TABLE LIGNES_CDE
  ADD CONSTRAINT pk_lignes
  PRIMARY KEY NONCLUSTERED (numero_cde, numero_lig);
GO
CREATE INDEX I_LIGNES_REFART
  ON LIGNES_CDE(reference_art)
  INCLUDE (numero_cde);
GO
-- ===============
-- TABLE HISTO_FAC
-- ===============  
CREATE TABLE HISTO_FAC(
  numero_fac int identity(1000,1) not null,
  date_fac datetime,
  numero_cde int,
  montantht smallmoney,
  etat_fac char(2),
  constraint pk_histo_fac PRIMARY KEY(numero_fac),
  constraint fk_histo_fac_commandes FOREIGN KEY(numero_cde) REFERENCES COMMANDES(numero_cde)
);
GO

	
	
