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
-- avec produit cartésien
select a.designation, c.code, c.libelle 
from [dbo].[CATEGORIES] c, [dbo].[ARTICLES] a
where a.code_cat = c.code;
-- ecriture normalisé
select a.designation, c.code, c.libelle 
from [dbo].[CATEGORIES] c inner join [dbo].[ARTICLES] a
on a.code_cat = c.code;
-- jointure plus complexe
select co.numero_cde as num_co, co.date_cde as date_cmd, cli.nom as nom_client, lc.reference_art, 
	a.prixht as Prix_Ht, lc.qte_cde
from [dbo].[COMMANDES] co 
	inner join [dbo].[LIGNES_CDE] lc on lc.numero_cde = co.numero_cde 
	inner join [dbo].[ARTICLES] a on a.reference = lc.reference_art
	inner join [dbo].[CLIENTS] cli on cli.numero = co.numero_cli
