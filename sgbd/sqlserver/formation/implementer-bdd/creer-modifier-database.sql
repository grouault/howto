
-- # créer une base de données
- interface graphique / objet Base de données ==> Nouvelle BDD
objet de base de données : create / alter / drop
==> table / procédure / fonction / vue ... tous les objets d'une base de données

--> création d'un fichier de données (type Primary) et un fichier Journal
- création à partir d'une bdd system (model) pour la structurer
-- base master : contient info dont sql server a besoin pour administrer correctement son instance
-- base model : modèle de création à de nouvelle base utilisateur ; peut-être modifier
-- base msdb : base système ; base utilisé par l'agent sql-server
-- tempdb : objet temporaire
-- distribution : mécanisme de réplication

-- # créer à partir d'un script
Collate : ordre de tri utilisé 
exemple French_CI_AI : tri suivant ordre alpahabétique francais, case insentivive, accent insensitive
