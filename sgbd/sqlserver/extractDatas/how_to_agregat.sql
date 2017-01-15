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
