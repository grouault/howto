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
