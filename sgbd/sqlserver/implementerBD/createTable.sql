USE GESCOM
GO
-- ==============
-- TABLE ARTICLES
-- ==============
CREATE TABLE ARTICLES(
	reference nvarchar(16) NOT NULL,
	designation nvarchar(200) NULL,
	prixht decimal(10,2) NULL,
	code_cat int NULL,
	prixttc as (prixht_art * 1.196) PERSISTED
  constraint pk_articles PRIMARY KEY (reference),
  constraint uq_des_prix UNIQUE NONCLUSTERED(
	designation_art asc, 
	prixht_art asc
  ),
  constraint fk_articles_categories FOREIGN KEY(code_cat) 
	REFERENCES CATEGORIE(code_cat) ON UPDATE CASCADE,
  constraint ck_articles_prixht CHECK (prixht>=0),
);
GO
-- ===============
-- TABLE CATEGORIE
-- ===============
CREATE TABLE CATEGORIES(
	code_cat int IDENTITY(100,1) NOT NULL,
	libelle nvarchar(200) NOT NULL,
  constraint pk_categories PRIMARY KEY(code_cat)
);
GO
-- =============
-- TABLE CLIENTS
-- =============
CREATE TABLE CLIENTS(
	numero_cli int NOT NULL,
	nom varchar(30) NOT NULL,
	prenom varchar(30) NOT NULL,
	adresse nvarchar(80) NULL,
	codepostal char(5) NULL,
	ville nvarchar(30) NULL,
	telephone char(14) NULL,
	coderep char(2) NOT NULL,
	ca numeric(10,2) NULL,
	gps geography NULL,
  constraint pk_clients PRIMARY KEY(numero_cli)	
  constraint ck_clients_codepostal CHECK 
	((CONVERT(int,codepostal)>=10000) AND (CONVERT(int,codepostal)<=95999))
); 
GO
-- ===============
-- TABLE COMMANDES
-- ===============
CREATE TABLE COMMANDES(
	numero_cde int identity(1,1) NOT NULL,
	date_cde date NULL,
	taux_remise numeric(2,0) NULL,
	numero_cli int NOT NULL,
	etat_cde char(2) NULL
  constraint pk_commandes PRIMARY KEY(numero_cde),
  constraint fk_commandes_clients FOREIGN KEY(numero_cli) REFERENCES CLIENTS(numero_cli)
);
GO
-- ===============
-- TABLE HISTO_FAC
-- ===============
CREATE TABLE HISTO_FAC(
	numero_fac int identity(1,1) NOT NULL,
	date_fac datetime NULL,
	numero_cde int NULL,
	montantht smallmoney NULL,
	etat_fac char(2) NULL,
  constraint pk_histo_fac PRIMARY KEY(numero_fac)
  constraint fk_histo_fac_commandes FOREIGN KEY(numero_cde) REFERENCES COMMANDES(numero_cde)
);
GO
-- =================
-- TABLE LIGNES_CDE
-- =================
CREATE TABLE LIGNES_CDE(
	numero_cde int NOT NULL,
	numero_lig int NOT NULL,
	reference_art nvarchar(16) NOT NULL,
	qte_cde int NULL DEFAULT 1
  constraint pk_lignes_cde PRIMARY KEY(numero_cde, numero_lig),
  constraint fk_lignes_cde_commandes FOREIGN KEY(numero_cde) REFERENCES COMMANDES(numero_cde),
  constraint fk_lignes_cde_articles FOREIGN KEY(reference_art) REFERENCES ARTICLES(reference_art)
);
GO
-- =================
-- TABLE STOCKS
-- =================
CREATE TABLE STOCKS(
	reference_art nvarchar(16) NOT NULL,
	depot char(2) NOT NULL,
	qte_stock int NULL,
	stock_mini int NULL DEFAULT 0,
	stock_maxi int NULL,
	constraint pk_stocks PRIMARY_KEY(reference_art, depot),
	constraint fk_stocks_articles FOREIGN KEY(reference_art) REFERENCES ARTICLES(reference_art)
);
GO
