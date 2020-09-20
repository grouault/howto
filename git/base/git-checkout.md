git checkout
=========================

## pour déplacer le pointeur HEAD
* soit pour basculer entre les branches
---
	* changer de branche : git co branche1
	|--------------------master---------------------->	
		|
        	|----branche1-----|
 
--- 

* soit sur une branche donnée, se positionner sur un commit spécifique
---
	* Branche master, se positionner sur le commit c1 : git co C1
	|----c1----c2-------C3---------------------->	

 
--- 

## Réparer une erreur non committée
* pour annuler les changement dans l'espace de travail
> *git checkout [filename]* : restauration à partir de l'index 
> *git checkout HEAD [filename]* : restauration à partir du HEAD


* pour déplacer le pointeur HEAD vers un commit spécifique ou basculer entre les branches
* Il annule tout changement de contenu par rapport à ceux du commit spécifique
* Cela n’apportera pas de changements à l’historique de validation
* Possibilité d’écraser des fichiers dans le répertoire de travail
* git checkout mon_fichier ==> permet de manipuler un fichier individuel


## CHECKOUT
1. Scénario : un fichier modifié mais non présent dans l'index
> *git checkout mon_fichier* : positionne le ficher à la dernière version connu de git (index ou commit).

2. Scénario : fichiers modifiés et poussé dans l'index
> *git checkout mon_fichier* : positionne le ficher tel que sur l'index.

> *git checkout HEAD mon_fichier* : positionne le fichier tel que sur le HEAD <==> git reset HEAD

3. Scénario : plusieurs fichiers modifiés
> *git checkout HEAD * : traite l'ensemble des fichiers

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)
