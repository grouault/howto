## opcon

### D�finition
Outils de pilotage des jobs.
- Il permet d'ex�ctuer des jobs c'est � dire de les lancer (par planification ou � la demande)
- par contre, il ne permet pas d'arr�ter la t�che associ� au job si ce dernier a �t� lanc�.

### mode de fonctionnement
* Dans OpCon, les jobs sont cr��s dans une partie master
* Apr�s, pour leur ex�cution, ces derniers sont instanci�s pour tous les jours du mois.
* Ainsi, il est possible d'avoir une visu et un historique des jobs journaliers dans le mois.
* Les jobs sont dupliqu�s avec leur configuration. Il est ainsi possible de la modifier pour un jour pr�cis sans modifier la configuration de base du job.