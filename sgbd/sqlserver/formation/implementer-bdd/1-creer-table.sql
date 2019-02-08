-- création des tables
-- conteneur qui vont contenir l'information
-- - définir les colonnes : nom lisible et compréhensible
-- - typer les données : 
-- chaine caractère unicode(nvarchar : 2 octets) ou format classique (char : 1 octet)
-- date : date, datetime, datetime2, time, smallDateTime...
-- numérique : entier=> int(4 octets), tinyint(1 octet)

--
-- instruction
--
USE GESCOM
GO ==> séparateur d'instuction
CREATE TABLE ARTICLES(
  REFERENCE_ART nvarchar(16), ==> chaine caractère longueur variable format caractères 16 caracètres maximum
  DESIGNATION_ART nvarchar(200),
  PRIXHT_ART decimal(10,2), ==> décimal avec au maximum 2 chiffres après la virgule
  CODE_CAT int
);

--
-- ==> Syntaxe minimum sans clé primaire ou secondaire
-- ==> Créer avec un préfixe dbo.ARTICLES 
-- DataBaseOwner 
-- correspond schéma par défaut ; les tables sont regroupées dans des ensemble logiques : schéma.
-- étant administrateur : on travaille par défaut dans le schéma dbo

--
-- infos sur la table
--
exec sp_help ARTICLES;
