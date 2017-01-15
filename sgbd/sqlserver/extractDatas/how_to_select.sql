-- ====================
-- BASIC Select rename.
-- ====================
select 'référence'=reference, 'désignatin de l''article'=designation 
from ARTICLES;

-- ====================
-- Restriction
-- ====================
Select nom, prenom, numero, ville
FROM CLIENTS
where ville = 'Nantes';

Select nom, prenom, numero, ville
FROM CLIENTS
where codepostal between 44000 and 44999

Select nom, prenom, numero, ville
FROM CLIENTS
where ville like 'V%' and ville is not NULL
	AND prenom like 'V_l%';

-- ============================================================
-- Commande du mois de janvier fait lors des 3 dernières années
-- ============================================================
select c.numero_cde, c.date_cde 
  from commandes c
  where DATEPART(mm, c.date_cde) = 1
	and DATEDIFF(yyyy, GETDATE(), c.date_cde) < 3;

-- ============================================================
-- Commande réalisée lors du mois précédent la date courante
-- ============================================================
select c.numero_cde, c.date_cde
  from COMMANDES c
  where DATEDIFF(mm, GETDATE(), c.date_cde) > 1 
	and DATEDIFF(mm, GETDATE(), c.date_cde) < 3;
	
-- ============================================================
-- Calcul élémentaire ; portée sur le select
-- ============================================================
select a.reference, 'Ancien prix'=prixht, 'Nouveau prix'=prixht * 1.1
from ARTICLES a;

select rtrim(cli.prenom) + ' ' +  rtrim(cli.nom) AS patronyme,
	substring(cli.codepostal, 1, 2)
	from CLIENTS cli;

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
