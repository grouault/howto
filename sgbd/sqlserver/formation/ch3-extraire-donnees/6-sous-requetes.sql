-- =============
-- sous-requete
-- =============
-- éviter l'utilisation de tables temporaires
-- toutes les commandes d'un client
-- ==> exécuter une requête (requête externe) en se basant sur le résultat d'une sous-requête
-- La sous-requête (requête interne) est exécutée une seule-fois et est appelé requête imbriquée.
-- Les requêtes sont imbriquées mais sont indépendantes.
-- exécution de la requête interne puis la requête externe.
SELECT *
  FROM COMMANDES
  WHERE numero_cli=(SELECT numero
	FROM CLIENTS
	WHERE nom LIKE 'Kornu'
  );
--
-- quand la requête interne envoit plus d'un résultat, on utilise des opérateurs différents
-- IN ou =ANY
SELECT *
  FROM ARTICLES
  WHERE code_cat IN (SELECT code_cat
	FROM CATEGORIES
	WHERE libelle_cat like 'Cl%'
  );
-- =======================
-- sous-requete corrélée
-- =======================
-- tous les articles non présents sur une ligne de commandes
SELECT reference_art
  FROM ARTICLES
  WHERE NOT EXISTS(SELECT *
    FROM LIGNES_CDE
	WHERE LIGNES_CDE.reference_art= ARTICLES.reference_art);
-- à chaque fois que l'on parcours un article dans la table des articles
-- on cherche à exécuter la sous-requête
-- La sous-requête peut renvoyer soit 0, soit 1 ou plusieurs lignes
-- L'instruction EXISTS renvoit VRAI lorsque la requête passé en paramètre renvoit au moins une ligne
-- Renvoit 0 lignes, EXISTS renvoie Faux et not exists renvoie VRAI

-- =======================
-- NOTES
-- =======================
-- une sous-requête imbriqué est exécuté une fois
-- une sous-requête corrélé est exécuté n fois
