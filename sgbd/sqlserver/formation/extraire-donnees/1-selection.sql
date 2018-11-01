--
-- Selectionner une ou plusieurs colonnes
-- Opérateur Select auquel 
--

-- 0- like
-- % : remplace 0 à N caractères
-- _ : remplace 1 caractère
where (ville like 'N%')

-- 1- Critère de selection Null
-- NULL = Absence de saisie.
-- Toute comparaison avec Null est faux.
where ville IS NULL
