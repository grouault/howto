--
-- permettre à SQL-SERVER de bien exploité ces index
-- ==> Voir sql-server lorsqu'il dresse le plan d'exéction d'une requête comme si l'on décide d'un chemin pour aller 
-- d'un point A à un point B
-- tient compte de tout un tas d'élément : le jours, l'heure et autres paramètres que l'on connaît tel que la densité du traffic
-- En fonction des différents paramètres, on choisit le chemin optimum
-- Pour sql-server c'est la même chose, si on met en place des index, mais si on ne lui donne pas la pertinence des index, 
-- qu'est ce qu'il va pouvoir gagner comme temps d'exécution ==> comme si on met à disposition une route sans connaître la destination,
-- les différentes sorties, le nombre de voies, la largeur ==> incidence sur la vitesse à laquelle on peut se déplacer sur cette route
--
ALTER DATABASE GESCOM
  SET AUTO_CREATE_STATISTICS ON;
GO
-- verifier que la création des stats est activé
SELECT name, is_auto_update_stats_on
  FROM sys.databases;
GO
-- travailler de façon manuelle
exec sp_createstats
