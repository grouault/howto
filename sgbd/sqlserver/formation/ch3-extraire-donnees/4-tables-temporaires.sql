--
-- Stocker de manières définitive
-- SELECT ... INTO ....
-- Table créée de manière permanente, sans clé, sans contraintes d'intégrité
-- Cette table est définitive ; il faut faire un drop table pour pouvoir rejouer la requête.
--
SELECT numero, nom, prenom
  INTO CLINANTES
  FROM CLIENTS
  WHERE ville='Nantes';
--
-- Table temporaire Globale : ##nom_table
-- il faut la supprimer quand on en a plus besoin
SELECT reference_art, sum(qte_cde) as quantite
  INTO ##artCde
  FROM LIGNES_CDE
  GROUP BY reference_art;
-- 
-- Table temporaire locale : #nom_table
-- locale à la connexion
-- table non visible d'une autre connexion
--
  
  
