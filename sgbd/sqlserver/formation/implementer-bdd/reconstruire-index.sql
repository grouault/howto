--
-- index sous forme d'arbre balancé est équitablement mis en place
-- structure optimum au début de la vie de la table se déséquilibre avec le temps (plus suffisament d'espace dans une branche ou l'autre 
-- de l'arbre) - sqlserver va rajouter un niveau intermédiaire pour pouvoir tjrs indexer la totalité des infos de la table
-- ==> nécessité de reconstruire l'index pour garantir que l'arbre soit toujours corretement équilibré
--

--
-- on ne casse pas la structure mais on la rééquilibre
-- FILLFACTOR : je souhaite qu'au niveau feuille mes pages ne sont pas remplis à 50%
-- on se garde ainsi une marge de maneuvre pour les ajouts et modification futures
--
ALTER INDEX ALL
  ON CLIENTS
  REBUILD WITH (FILLFACTOR=50);

--
-- on reconstruit un index particulier
-- PAS_INDEX : reproduit le pourcentage de remplissage sur toutes les pages de niveau intermédiaire là aussi pour permettre la bonne
-- évolution de mon arbre
--
ALTER INDEX I_LIGNES_REFART
  ON LIGNES_CDE
  REBUILD WITH (PAD_INDEX=ON,FILLFACTOR=50);
