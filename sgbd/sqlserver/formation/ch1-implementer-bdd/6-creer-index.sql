
--
-- Index
-- - accéder rapidement et de manière efficace à l'information
-- - égalité de traitement pour accéder à l'information
-- - parcourir l'index, accéder directement à l'information une fois trouvée l'info pertinente trouvé dans l'index
-- - organise ou non physiquement les données de la table
-- - information stockée dans des pages - sans index les pages sont chainées. L'index permet de construire alors un arbre balancée
--  de pages permettant d'accéder plus rapidement à l'information
--
-- index qui n'organise pas physiquement les données de la table
-- - index classique : ex: ville ==> accéder à l'ensemble des client par ville
-- - index couvrant : contient les valeurs indexées, puis une partie de la table pour tenter  de répondre aux demandes
-- ce certaines requêtes et que les requêtes n'accèdent qu'à l'index dans accéder à la table
--

--
-- créer un index unique ordonnée
-- index mis en place une contrainte de clé primaire
-- définit pas une contrainte de clé primaire ==> ne pourrait pas référencé cet index comme étant une clé primaire 
-- si derrière j'ai besoin d'une contrainte de clé étrangère qui doit faire référence aux clients 
--
CREATE UNIQUE CLUSTERED INDEX INOCLI
  ON CLIENTS (numero)
  WITH (FILLFACTOR=50); -- au niveau feuille, elles vont être complété à 50%
go

--
-- index couvrant
-- contient les informations indexées et des infos qui vont permettent de répondre directement aux demandes des requêtes.
-- indexe la colonne reference_art (accès rapide aux différenctes ref.article présente dans cette table)
-- inclure dans les pages au niveau feuille les numéros de commande
-- ==> on parcours l'index via la ref.article, une fois trouvé, on trouve directement dans l'index, au niveau feuille, l'information.
--
CREATE INDEX I_LIGNES_REFART
  ON LIGNES_CDE(reference_art)
  INCLUDE (numero_cde);
go


--
-- index filtré
-- ne vont pas indexé la totalité des infos de la table mais un sous-ensemble de la table filtré avec une clause where
-- utilisable par sql_server quand on fait une recherche d'articles dans le code est 1 ou 2.
--
CREATE INDEX IDESIGNATION_ARTICLES
  ON ARTICLES(designation_art)
  WHERE code_cat IN (1,2);
