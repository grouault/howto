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

-- =========================================================================
-- Sortir le prix minimun et maximum sur deux lignes
-- =========================================================================
select a1.prixht, a1.reference
 from articles a1 
 where a1.prixht >=any(
	select max(a2.prixht)
	from ARTICLES a2
 ) or a1.prixht <=any(
	select min(a2.prixht)
	from ARTICLES a2
 );
 
-- =========================================================================
-- Sortir le prix minimun, le maximum et le prix moyen sur une ligne
-- prix moyen sorti dans une table T1
-- prix maximum et prix minimum sortis dans une table T2 (Left join)
-- croos join entre T1 et T2
-- =========================================================================
Select avg(a.prixht) as 'Prix moyen' 
	INTO #ArticlePrixMoyen
from ARTICLES a; 
with PrixExtreme as (
	select a1.prixht as 'Prix maximum', a1.reference as 'Réf. prix maximum', a2.prixht as 'Prix minimum', a2.reference 'Réf. prix minimum'
	 from articles a1 
		left join articles a2 on a1.code_cat<>a2.code_cat 
	 where a1.prixht >=any(
		select max(a2.prixht)
		from ARTICLES a2
	 ) and a2.prixht <=any(
		select min(a2.prixht)
		from ARTICLES a2
	)
)
Select pe.[Prix maximum], pe.[Réf. prix maximum], pe.[Prix minimum], pe.[Réf. prix minimum], pm.[Prix moyen]
from PrixExtreme pe cross join #ArticlePrixMoyen pm;
Drop table #ArticlePrixMoyen;

-- =========================================================================
-- Sortir le prix minimun, le maximum et le prix moyen sur une ligne
-- prix moyen sorti dans une table temporaire T1
-- prix maximum sorti dans une tablee temporaire T2 
-- prix minimum sortis dans une table CTE T3
-- Cross Join : T1xT2xT3
-- =========================================================================
select art.designation as 'designation', art.prixht as 'prixht'
	into #PrixMaximum
  from ARTICLES art
  where art.prixht >= any (
	select max(a1.prixht)
	from ARTICLES a1
  );
Select avg(a.prixht) as 'Prix moyen' 
	INTO #ArticlePrixMoyen
from ARTICLES a; 
With PrixMinimum as (
	select art.designation, art.prixht
	  from ARTICLES art
	  where art.prixht <= any (
		select min(a2.prixht)
		from ARTICLES a2
	  )
)
Select pmi.designation as 'Ref. Minimum', pmi.prixht as 'Prix minimum', pma.designation as 'Ref. Maximum', pma.prixht as 'Prix.Maximum', pm.[Prix moyen]
	from PrixMinimum pmi cross join #PrixMaximum pma cross join #ArticlePrixMoyen pm;
Drop table #PrixMaximum;
Drop table #ArticlePrixMoyen;
