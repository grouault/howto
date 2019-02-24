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
