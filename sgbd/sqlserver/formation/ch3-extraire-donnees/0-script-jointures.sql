-- ========
-- Produit-Cartésien
-- ========	
SELECT CAT.libelle_cat, ART.DESIGNATION_ART
	FROM CATEGORIES CAT, ARTICLES ART;
GO
SELECT CAT.libelle_cat, ART.DESIGNATION_ART
	FROM CATEGORIES CAT CROSS JOIN ARTICLES ART;
GO
-- ========
-- Jointure
-- ========	
SELECT CAT.CODE_CAT, CAT.LIBELLE_CAT, ART.DESIGNATION_ART
	FROM CATEGORIES CAT, ARTICLES ART
	WHERE ART.CODE_CAT=CAT.CODE_CAT;
GO
SELECT CAT.CODE_CAT, CAT.LIBELLE_CAT, ART.DESIGNATION_ART
	FROM CATEGORIES CAT INNER JOIN ARTICLES ART
	ON ART.CODE_CAT=CAT.CODE_CAT;
GO
--
-- Afficher par clients :
-- le liste des articles commandés
-- info: date_cde, Nom_client, article, prix_ht, qte_cde
-- 
SELECT CDE.numero_cde,
	CONVERT(char(10), date_cde,103) as DateCde,
	SUBSTRING(nom,1,10) Nom,
	ART.reference_art, prixht_art, qte_cde
	FROM CLIENTS CLI INNER JOIN COMMANDES CDE
	  ON CLI.numero=CDE.numero_cli
	INNER JOIN LIGNES_CDE LIG
	  ON CDE.numero_cde=LIG.numero_cde
	INNER JOIN ARTICLES ART
	  ON LIG.reference_art=ART.reference_art;


-- =================
-- Jointure externe
-- =================
-- affiché tous les clients avec leur commande associé
-- même les clients qui n'ont pas de commandes
SELECT Client=cli.numero, nom, cde.numero_cde
  FROM CLIENTS cli LEFT OUTER JOIN COMMANDES cde
  ON cli.numero=cde.numero_cli;
  GO
-- ==> syntaxe non normalisé
SELECT Client=cli.numero, nom, cde.numero_cde
  FROM CLIENTS cli ,COMMANDES cde
  WHERE cli.numero *= cde.numero_cli;
-- =================
-- TRI
-- =================
SELECT nom, prenom, adresse, codepostal, ville
  FROM CLIENTS
  ORDER BY nom, prenom, codepostal, ville;
GO
SELECT nom, prenom, adresse, codepostal, ville
  FROM CLIENTS
  ORDER BY nom, prenom, codepostal, ville
  OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;


-- =======================
-- Opérateurs-ensembliste
-- =======================
-- UNION
-- Pour un depot/un article : voir la quantite commande et la quantité en stock
-- Deux requête : stock / commande
-- Union des requête et tri surt ref_art et origine
--
SELECT origine='Stock',convert(char(6), depot) as "Commande/dépot",
       reference_art, qte_stk
   FROM STOCKS
UNION
SELECT 'Commande', convert(char(6), cde.numero_cde), 
       reference_art, qte_cde
  FROM LIGNES_CDE lig INNER JOIN COMMANDES cde
  ON lig.numero_cde=cde.numero_cde
ORDER BY reference_art, origine;
GO
-- INTERSECTION
-- client qui habitent dans une villes commencant par Nantes
-- client qui habient en Loire Altantique
SELECT *
  FROM CLIENTS
  WHERE ville LIKE 'Nantes%'
INTERSECT
SELECT *
  FROM CLIENTS
  WHERE codepostal BETWEEN 44000 and 44999;
GO
--
-- Difference
-- affiché tous les clients sauf ceux qui habitent en Loire-Atlantique
--
SELECT nom, prenom
  FROM CLIENTS
EXCEPT
SELECT nom, prenom
  FROM CLIENTS
  WHERE codepostal BETWEEN 44000 and 44999;
  
  
-- =======================
-- TOP
-- =======================  
--
-- affiché les numéros de commandes, le CA de la commandes
-- Ne retenir que les 3 plus grosses commandes de la base
--
SELECT TOP (3) cde.numero_cde,
       ca=SUM(qte_cde*prixht_art)
  FROM COMMANDES cde INNER JOIN LIGNES_CDE lig
  ON cde.numero_cde=lig.numero_cde
  INNER JOIN ARTICLES art
  ON lig.reference_art=art.reference_art
  GROUP BY cde.numero_cde
  ORDER BY ca DESC;
GO
SELECT COUNT(*) FROM COMMANDES;
--
-- SELECT TOP 5 PERCENT
--
SELECT TOP 5 PERCENT cde.numero_cde,
       ca=SUM(qte_cde*prixht_art)
  FROM COMMANDES cde INNER JOIN LIGNES_CDE lig
  ON cde.numero_cde=lig.numero_cde
  INNER JOIN ARTICLES art
  ON lig.reference_art=art.reference_art
  GROUP BY cde.numero_cde
  ORDER BY ca DESC;  

-- =======================
-- TABLES TEMPORAIRES
-- =======================  
-- table permanente
SELECT numero, nom, prenom
  INTO CLINANTES
  FROM CLIENTS
  WHERE ville='Nantes';
GO
SELECT *
  FROM CLINANTES;
GO
-- table temporaire
SELECT reference_art, sum(qte_cde) as quantite
  INTO ##artCde
  FROM LIGNES_CDE
  GROUP BY reference_art;
GO
SELECT * FROM ##artCde;
-- =======================
-- TABLES CTE
-- =======================  
WITH CLI44 AS(
  SELECT numero, nom, prenom
    FROM CLIENTS
	WHERE codepostal BETWEEN 44000 AND 44999
)
SELECT * FROM CLI44;
GO
WITH CLI44 AS(
  SELECT numero, nom, prenom
    FROM CLIENTS
	WHERE codepostal BETWEEN 44000 AND 44999
)
SELECT COUNT(*) FROM CLIENTS ;

SELECT * FROM CLI44;

-- =====================================
-- CALCUL AGREGAT ET NIVEAU DE PRECISION
-- =====================================  
-- afficher pour un dépôt donné, un libellé_cat, une désignation_art la somme des quantité en stock
--
SELECT depot, libelle_cat , designation_art ,sum(qte_stk) as total
  FROM STOCKS stk
  INNER JOIN ARTICLES art
  ON stk.reference_art=art.reference_art
  INNER JOIN CATEGORIES cat
  ON cat.code_cat=art.code_cat
  WHERE depot IN ('N','P1')
  GROUP BY depot, libelle_cat , designation_art;
GO
SELECT depot, libelle_cat , designation_art ,sum(qte_stk) as total
  FROM STOCKS stk
  INNER JOIN ARTICLES art
  ON stk.reference_art=art.reference_art
  INNER JOIN CATEGORIES cat
  ON cat.code_cat=art.code_cat
  WHERE depot IN ('N','P1')
  GROUP BY depot, libelle_cat , designation_art
  WITH ROLLUP;
GO
SELECT depot, libelle_cat , designation_art ,sum(qte_stk) as total
  FROM STOCKS stk
  INNER JOIN ARTICLES art
  ON stk.reference_art=art.reference_art
  INNER JOIN CATEGORIES cat
  ON cat.code_cat=art.code_cat
  WHERE depot IN ('N','P1')
  GROUP BY depot, libelle_cat , designation_art
  WITH CUBE;
-- =====================================
-- SOUS-REQUETE
-- ===================================== 
SELECT *
  FROM COMMANDES
  WHERE numero_cli=(SELECT numero
	FROM CLIENTS
	WHERE nom LIKE 'Kornu'
  );
GO
SELECT *
  FROM ARTICLES
  WHERE code_cat IN (SELECT code_cat
	FROM CATEGORIES
	WHERE libelle_cat like 'Cl%'
  );
GO
SELECT reference_art
  FROM ARTICLES
  WHERE NOT EXISTS(SELECT *
    FROM LIGNES_CDE
	WHERE LIGNES_CDE.reference_art= ARTICLES.reference_art);
GO
--
-- Tous les articles qui ont le même prix
-- Tous les articles qui ont le même prix qu'un autre
--
SELECT reference_art, prixht_art
  FROM ARTICLES art1
  WHERE prixht_art=(SELECT distinct art2.prixht_art
    FROM ARTICLES art2
	WHERE art2.prixht_art=art1.prixht_art
	  AND art2.reference_art!=art1.reference_art)
  ORDER BY prixht_art DESC;
