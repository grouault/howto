--
-- Selectionner une ou plusieurs colonnes
-- Opérateur Select auquel 
-- Requête d'extraction : Select
-- Restriction :
-- Données proviennent de plusieurs tables
-- calcul plus ou moins complexes
--
-- ================= --
-- == SELECTION   == --
-- ================= --
Sélectionné une ou plusieurs colonnes dans un ordre souhaitée:
* : toutes les colonnes
renommage :
SELECT Catégorie=CODE_CAT, 
       'Désignation de l''article'=DESIGNATION_ART

-- ================= --
-- == RESTRICTION == --
-- ================= --
--  = : restriction sur valeur fixe
-- between : valeur comprise entre deux bornes ; les bornes sont prises en compte
-- and / or : combiner les clauses de restrictions
-- Opérationeur : like
-- % : remplace 0 à N caractères
-- _ : remplace 1 caractère
where (ville like 'N%')
where (prenom like 'NO_m%')

-- Critère de selection Null
-- soit une valeur est saisie, soit la valeur est null
-- NULL = Absence de saisie ==> pas de comparaison avec l'opérateur = possible
-- est-ce qu'une absence de saisie est égale à une autre absence de saisie ==> c'est faux
-- Toute comparaison avec Null est faux.
where ville IS NULL

-- 2- Date
-- extraire une partie de la date
where DATEPART (mm, date_cde) = 6
-- difference en nombre d'année entre la date courante et la date de commande
where DATEDIFF(year, GETDATE(), date_cde) < 3


-- ============ --
-- == CALCUL == --
-- ============ --
-- Calcul élémentaire --
-- ================== --
-- calcul élémentaire sur chaine numérique et affichage dans une nouvelle colonne
-- Portée : que sur le jeu de résultat, que sur l'instruction SELECT qui n'est pas une instruction UPDATE
-- 
select REFERENCE_ART, 'Ancien Prix'=PRIX_HT, 'Nouveau Prix'=PRIX_HT*1.1
from articles
--
-- calcul élémentaire sur chaine de caractère
--
select RTRIM(nom) + ' ' + RTRIM(prenom) as Patronyme,
  substring(codepostal, 1, 2) as Departement
From Clients;
--
-- Calcul d'agégat --
-- =============== --
-- fonction de calcul d'agrégat, fonction qui permet :
-- 1- le regroupement
-- 2- extraire un calcul : MIN, MAX, AVT, COUNT, SUM
-- 3- restriction sur calcul: HAVING
select ref_art, sum(qte) from stock group by ref_art
select departement=substring(codepostal, 1, 2), count(client) 
from client group by substring(codepostal, 1, 2);

-- ============== --
-- == DISTINCT == --
-- ============== --
--
-- distinct
-- ==> Permet de faire un affichage différent de l'information au fur et à mesure que cette dernière
-- est présentée
-- au moment de l'affichage, on ne retient que des noms différents les uns des autres
--
Select distinct ville from CLIENTS;

-- 
-- distinct par Group By
-- Permet de faire un distinct nécessitant une opération de tri qui est toutefois performante.
-- Constitue des sous-ensemble et on sort l'étiquette du sous-ensemble
-- On ne peut afficher que ces étiquette
select ville from clients group by ville;
--
