-- # contraintes d'intégrité
-- permettre de garantir l'intégrité des données
-- mettre en place une structure qui permet à sql_server de travailler correctement et d'appliquer les différentes formes normales 
-- cad s'assurer que les données sont conformes aux règles de gestion fixées par le modèle relationnel.

-- # 1- clé primaire: 
-- plus petite clé d'identification possible dans une table
-- applique la non nullité
-- mise en place d'un index : organise physiquement les données de la table
-- clustered : par défaut, organise physiquement les données de la table
-- requête simple : les données apparaissent trié dans l'ordre de l'index de la clé primaire, ordre des données tel que stockées
-- dans la base
CREATE TABLE HISTO_FAC(
  numero_fac int identity(1000,1) not null,
  date_fac datetime,
  numeor_cde int,
  montantht smallmoney,
  etat_fac char(2),
  constraint pk_histo_fact primary_key(numero_fac)
);
CREATE TABLE LIGNES_CDE(
  numero_cde int not null,
  numero_ligne int not null,
  reference_art nvarchar(16) not null,
  qte_cde int default 1
);
GO
-- table avec index 
-- nonclustered: index non-organisé : index qui ne réogarnise pas physiquement les données de la table
ALTER TABLE LIGNES_CDE
  ADD CONSTRAINT pk_lignes
  PRIMARY KEY NONCLUSTERED (numero_cde, numero_lig);

-- # 2 : unicité ou clé secondaire
-- complète les données de clés primaires
-- ne pas avoir deux lignes qui possèdent exactement la même contrainte
-- ex: ne pas avoir deux clients ayant le même nom et numéro de téléphone
-- ex: un email

ALTER TABLE ARTICLES
  ALTER COLUMN reference_art nvarchar(16) not null;
ALTER TABLE ARTICLES
  ADD CONSTRAINT pk_articles PRIMARY_KEY(refernce_art);
-- exemple : constainte unicicé: prix et désignation
ALTER TABLE ARTICLES
  ADD CONSTRAINT uq_des_prix
  UNIQUE NONCLUSTERED(designation_art, prixht_art);
  
-- # 3: clé étrangère
-- contrainte d'intégrité référentiel
-- elle référence la clé primaire d'une autre table et permet de lier la structure de deux tables
-- exemple entre table catégorie et articles :
-- on udpate cascade : si on modifie le code_categorie dans la table des catégories, la modification est reportée sur tous les articles 
-- qui font référence à cette catégorie
-- par défaut: no_action : impossible de mettre à jour car référencé par autre table
-- set null : mettre null au niveau du code_categorie de la table article pour les articles appartenant à cet catégorie
-- set default : reprendre la valeur par défaut
-- deux options delete ou mis à jour
ALTER TABLE CATEGORIES ADD CONSTRAINT pk_categories primary key (code_cat);
ALTER TABLE ARTICLES 
  ADD CONSTRAINT fk_articles_categories
  FOREIGN KEY (code_cat)
  REFERENCES CATEGORIES(code_cat) 
  ON UPDATE CASCADE;

-- # 4: contraintes de validation
-- contrainte de type check - faire des validation simples
-- ex: prix d'un article est bien positif
-- sur une ligne courante, s'assurer que cette validation est bien faite.
ALTER TABLE ARTICLES
  ADD CONSTRAINT ck_articles_prixht
  CHECK (prixht_art >= 0);
