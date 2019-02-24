# contrainte valeur par défaut
- éviter d'avoir trop de valeur NULL dans une table
- NULL: physiquement stocké comme 0 caractères (stockage condensé de l'info)
- si on modifie: l'info va grossir et entraîne un chainage de ligne et déborde du bloc de 8ko et répartis sur différents blocs
==> 2 lectures phyiques ensuite ce qui n'est pas optimum

ALTER TABLE CLIENTS
  ADD CONSTRAINT df_nom DEFAULT 'anonyme' FOR nom;
