## opcon

### Définition
Outils de pilotage des jobs.
- Il permet d'exéctuer des jobs c'est à dire de les lancer (par planification ou à la demande)
- par contre, il ne permet pas d'arrêter la tâche associé au job si ce dernier a été lancé.

### mode de fonctionnement
* Dans OpCon, les jobs sont créés dans une partie master
* Après, pour leur exécution, ces derniers sont instanciés pour tous les jours du mois.
* Ainsi, il est possible d'avoir une visu et un historique des jobs journaliers dans le mois.
* Les jobs sont dupliqués avec leur configuration. Il est ainsi possible de la modifier pour un jour précis sans modifier la configuration de base du job.