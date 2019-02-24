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

-- ===================================
-- Table CTE : Common Table Expression
-- ===================================
-- stocké les infos de manière temporaire ; portée locale - reste définit que pour la requête qui suit immédiatement
-- pas besoin de supprimer la table temporaire
-- une fois passée le point-virgule, la requête Select qui suit la définition de la table CTE, la table temporaire
-- n'existe plus
--
WITH CLI44 AS(
  SELECT numero, nom, prenom
    FROM CLIENTS
	WHERE codepostal BETWEEN 44000 AND 44999
)
SELECT * FROM CLI44;

  
  
