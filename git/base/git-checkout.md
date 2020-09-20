## git checkout
===============

## CHECKOUT
* pour d�placer le pointeur HEAD vers un commit sp�cifique ou basculer entre les branches
* Il annule tout changement de contenu par rapport � ceux du commit sp�cifique
* Cela n�apportera pas de changements � l�historique de validation
* Possibilit� d��craser des fichiers dans le r�pertoire de travail
* git checkout mon_fichier ==> permet de manipuler un fichier individuel


## CHECKOUT
1. Sc�nario : un fichier modifi� mais non pr�sent dans l'index
> *git checkout mon_fichier* : positionne le ficher � la derni�re version connu de git (index ou commit).

2. Sc�nario : fichiers modifi�s et pouss� dans l'index
> *git checkout mon_fichier* : positionne le ficher tel que sur l'index.

> *git checkout HEAD mon_fichier* : positionne le fichier tel que sur le HEAD <==> git reset HEAD

3. Sc�nario : plusieurs fichiers modifi�s
> *git checkout HEAD * : traite l'ensemble des fichiers

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)