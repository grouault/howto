--
-- sql-server propose un niveau intermédiaire d'orgnaisation entre la base de données et les tables
-- appelé schéma
-- schéma unique par défaut : dbo (data base ownner)
-- constituer des ensemble logiques qui organise logiquement les tables pour donner un sens supplémentaire, 
-- un niveau intermédiare de compréhension de ces tables
--
CREATE SCHEMA LIVRE;
CREATE TABLE LIVRE.AUTEUR(int id, varchar nom);
