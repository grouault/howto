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
