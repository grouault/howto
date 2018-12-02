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
select c.libelle, a.designation
from [dbo].[CATEGORIES] c cross join [dbo].[ARTICLES] a;
