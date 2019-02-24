-- 
-- TRI
--
-- sql-server qui va décider de l'ordre d'affichage des infos.
-- non garantit d'une exécution à l'autre de la requête
-- si sql fait un parcours de la table sous-jacente à la requête, sql-server organise physiquement les données de la table 
-- grace à l'index sous-jacent qui est index clustered 
-- ou utilisation d'un index
-- D'une éxecution à une autre de la requête, il y a eu peut-être mis à jour de cet index qui permet de tirer profit de cet index
-- ayant pour incidence de réorganiser les données 
-- ==> l'ordre des résultats peut-être alors modifier
--
-- Pour pallier, cela, il faut utiliser l'instruction ORDER BY
--

