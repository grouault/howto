# Principe
- VCS : git est système de gestion de version distribué (vs local ou centralisé (SVN))
==> il n'y a pas à proprement parlé de serveur central. 
Chaque dépot local embarque la totalité des version du projet, y compris les branches et les tags.

# Besoin
Gérer le code source et ses versions
Pouvoir restaurer une version antérieure d'un fichier

# Rôle
- Ramener un fichier à un état précédent
- Visualiser les changements au cours du temps
- voir qui a modifié quoi
- déterminer quel changement a causé des problèmes

# Type de VCS : 
- locaux : connexion et travail sur le serveur
- centralisés : code source stocké sur le serveur. Le développeur s'approprie le code source et travail sur son poste.
- distribués : tout noeud (serveur, poste développeur ...) est un référentiel. On ne dépend plus d'un serveur central.
Chaque serveur est un noeud du réseau sur lequel on peut s'alimenter.
Avantage : Suppression du point unique de panne 
==> chaque client a une copie complète du dépot ; tout l'historique (toutes les versions) du projet est présente.
==> si le serveur est perdu, n'importe quel dépôt client peut servir de serveur
Git : 
- système décentralisé : dcvs ==> aucun serveur maître n'est requis / chaque développeur a son dépôt.
- Fichier identifiés par un hash sha-1 : aucun diff n'est stocké, si un fichier est modifié, deux versions sont enregistés
- Robustesse : stable et rodé
- Architecture distribuée
- Conception simple (4 commandes)
- Support de milliers de branches en parallèles
- Gestion efficace des projets d'envergure.

# Intégrité  des données
A la différence de svn, qui enregistre les diff., chaque modification de fichier entraine sa duplication 
et son identification par un hash sha-1 ; une signature qui garantit que le fichier n'a pas été altéré lors du téléchargement
ou autre process.
Si un maillon est perdu à svn, il peut être impossible de regénérer le fichier final.
Dans git, les fichiers dupliquées sont chainés.

# Etat d'un fichier : Non suivi, Validé, Modifié, Indexé.
Modifié : le fichier est modifié ; un fichier modifié n'est pas ajouté à l'index. 
Pour prendre en compte les modification il faut l'indexé.
Indexé : les changements sont enregistrés, le fichier peut-être validé. 
Indexxé permet de dupliquer le fichier et la création d'une nouvelle signature, nouveau hash.
Validé : fichier est versionné et en sécurité 
