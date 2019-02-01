-- # type identity

-- séquence : on peut avoir des absences dans la séquences
-- distributeur de billets ; le billet peut ne pas être utiliser et jeter
-- ==> spécification compteur
CREATE TABLE CATEGORIES(
  code_cat int identity(100,1);
  libelle_cat nvarchar(200)
);

-- pour cette colonne, on ne fournit jamais de valeur explicit
-- sqlserver fournit un code catégorie : commence à 100, incrémentation par pas de 1
