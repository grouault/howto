-- ===============================
-- AGREGAT ET NIVEAU DE PRECISION
-- ===============================
-- Enrichir le jeu d'enregistrement avec les instructions
-- with rollup
-- with cube
-- afficher pour un dépôt donné, un libellé_cat, une désignation_art la somme des quantité en stock
-- ==> pratique mais on ne sait pas au total 
---- combien on dispose de clavier
---- combien on a d'articles dans le dépôt de Nantes
----
SELECT depot, libelle_cat , designation_art ,sum(qte_stk) as total
  FROM STOCKS stk
  INNER JOIN ARTICLES art
  ON stk.reference_art=art.reference_art
  INNER JOIN CATEGORIES cat
  ON cat.code_cat=art.code_cat
  WHERE depot IN ('N','P1')
  GROUP BY depot, libelle_cat , designation_art;
-- ===============================
-- with rollup
-- ===============================
-- permet de faire des sous-totaux par groupe d'agrégats
-- 1- calcul agrégat normal
-- 2- sous-total par groupe d'agrégats de droite à gauche
-- group-by a1, a2, a3
-- sous-total 1 : a1, a2, a3
-- sous-total 2 : a1, a2
-- sous-total 3 : a1, 
-- sous-total 4 : - (tout agregat confondu voila ce que j'ai)
-- élargit le critère de regroupement
  ...
  GROUP BY depot, libelle_cat , designation_art
  WITH ROLLUP;
 -- mais ne permet pas de dire :
 ---- tout dépôt confondu pour les souris combien j'en ai en stock
 ---- tout dépôt confondu, par catégorie, pour les souris pour logitech G500 combien j'en ai en stock
 ---- tout dépôt confondu toute catégories confondues pour logitech G500, combien j'en ai en stock
 -- ===============================
-- with cube
-- ================================
-- permet de faire des sous-totaux par groupe d'agrégats
-- 1- calcul agrégat normal
-- 2- sous-total par groupe d'agrégats de gauche à droite
-- group-by a1, a2, a3
-- sous-total 1 : a1, a2, a3
-- sous-total 2 : a2,a3
-- sous-total 3 : a3
  ...
  GROUP BY depot, libelle_cat , designation_art
  WITH CUBE;
