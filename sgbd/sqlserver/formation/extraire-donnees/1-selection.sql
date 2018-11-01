--
-- Selectionner une ou plusieurs colonnes
-- Opérateur Select auquel 
--

-- 0- like
-- % : remplace 0 à N caractères
-- _ : remplace 1 caractère
where (ville like 'N%')
where (prenom like 'NO_m%')

-- 1- Critère de selection Null
-- NULL = Absence de saisie.
-- Toute comparaison avec Null est faux.
where ville IS NULL

-- 2- Date
-- extraire une partie de la date
where DATEPART (mm, date_cde) = 6
-- difference en nombre d'année entre la date courante et la date de commande
where DATEDIFF(year, GETDATE(), date_cde) < 3
