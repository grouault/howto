-- ===============================
-- AGREGAT ET NIVEAU DE PRECISION
-- ===============================
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
