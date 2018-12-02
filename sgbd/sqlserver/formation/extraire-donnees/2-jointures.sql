-- =================
-- Produit Cartésien
-- =================
-- Opérateur compétitif :
-- une table avec une seule ligne d'information : on veut rajouter cette information sur toutes les lignes d'une autre table.
-- Ecriture normalisé : cross join
select c.libelle, a.designation
from [dbo].[CATEGORIES] c cross join [dbo].[ARTICLES] a;

-- ========
-- Jointure
-- ========
-- Pour un article, savoir dans quelle catégorie il est placé
--
select a.designation, c.code, c.libelle 
from [dbo].[CATEGORIES] c, [dbo].[ARTICLES] a
where a.code_cat = c.code;
