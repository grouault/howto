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
  
  
  
