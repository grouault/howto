
--
-- créer un index unique ordonnée
-- index mis en place une contrainte de clé primaire
-- définit pas une contrainte de clé primaire ==> ne pourrait pas référencé cet index comme étant une clé primaire 
-- si derrière j'ai besoin d'une contrainte de clé étrangère qui doit faire référence aux clients 
--
CREATE UNIQUE CLUSTERED INDEX INOCLI
  ON CLIENTS (numero)
  WITH (FILLFACTOR=50); -- au niveau feuille, elles vont être complété à 50%
go
CREATE INDEX I_LIGNES_REFART
  ON LIGNES_CDE(reference_art)
  INCLUDE (numero_cde);
go
CREATE INDEX IDESIGNATION_ARTICLES
  ON ARTICLES(designation_art)
  WHERE code_cat IN (1,2);
