-- =========================================================================
-- Distinct = Group by
-- Distinct => au fur et à mesure que l'information est présentée
-- Group by => Opération de tri, avec sous ensemble, on affiche l'étiquette
--    ou les étiquettes si plusieurs champs dans le group by
-- =========================================================================
select distinct ville
from clients;
go
select ville
from clients
group by ville;

-- =========================================================================
-- Prix Minimum, Moyen, Maximum des articles
-- =========================================================================
select MIN(a.prixht) as 'Prix minimum',
	AVG(a.prixht) as 'Prix moyen',
	MAX(a.prixht) as 'Prix maximum'
from articles a;

-- =========================================================================
-- Sortir le prix minimun et maximum sur la meme ligne
-- =========================================================================
select a1.prixht as 'Prix maximum', a1.reference, a2.prixht as 'Prix minimum', a2.reference
 from articles a1 
	left join articles a2 on a1.code_cat<>a2.code_cat 
 where a1.prixht >=any(
	select max(a2.prixht)
	from ARTICLES a2
 ) and a2.prixht <=any(
	select min(a2.prixht)
	from ARTICLES a2
 );
