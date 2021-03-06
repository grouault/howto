-- =================
-- Produit Cartésien
-- =================
-- fait toutes les combinaisons possibles entre deux tables
-- pour chaque enregistrement, on fait correspondre tous les autres enregistrements d'une autre table
-- Opérateur compétitif :
-- quand on se retrouve avec une table/ensemble avec une seule ligne d'information : 
-- si on veut rajouter cette information sur toutes les lignes d'une autre table.
-- Ecriture normalisé : cross join
select c.libelle, a.designation
from [dbo].[CATEGORIES] c cross join [dbo].[ARTICLES] a;

-- ========
-- Jointure
-- ========- 
-- produit-cartésien auquel on rajoute une restriction ou un critère de jointure
-- Pour un article, savoir dans quelle catégorie il est classé
-- avec produit cartésien
select a.designation, c.code, c.libelle 
from [dbo].[CATEGORIES] c, [dbo].[ARTICLES] a
where a.code_cat = c.code;
-- ecriture normalisé
-- A utilisé de préférence à l'écriture du produit-cartésien ; mis en conformité avec les évolutions possibles de la norme SQL
-- optimiseur de requête sql-server reconnaît une syntaxe non normalisé exprime une jointure comme la syntaxe normalisé
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
-- ================
-- Jointure externe
-- ================
-- jointure ne permette pas de sélectionner / afficher les lignes que l'on ne peut pas mettre en correspondance
-- pkoi : parce qu'elle ne respecte pas / réponde pas aux critère de jointure
-- ==> jointure externe : left outer join pour afficher les lignes que l'on ne peut pas mettre en correspondance
-- ex: rapproché les clients des commandes : clients qui n'ont pas passés de commandes
-- client left outer join commandes
SELECT Client=cli.numero, nom, cde.numero_cde
  FROM CLIENTS cli LEFT OUTER JOIN COMMANDES cde
  ON cli.numero=cde.numero_cli;
-- ==> depuis la table des clients, je considère tous les clients ;
-- ==> jointure ouverte à gauche : Left : je prend tous les clients (client est à gauche)
-- qd je satisfait le critère de jointure, j'affiche là ou les commandes
-- si pas de commandes trouvées, j'affiche quand même le client sans la commande
