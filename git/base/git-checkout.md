git checkout
============

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
	|----c1----c2-------C3--------------------------->	

--- 

## Récupérer une version d'un fichier
* Remplacer un fichier par sa révision dans le référentiel à instant t
> *git checkhout [SHA] [filename]*

# Récupérer les modifs de la branche optim
git checkout -b optim origin/optim

## Réparer une erreur non committée
* pour **annuler les changement** dans l'espace de travail, en manipulant un **fichier individuel**
1. *git checkout [filename]* : restauration à partir de l'index (annulation [wd])
2. *git checkout HEAD [filename]* : restauration à partir du HEAD (annulation [wd] et [i])

* possibilité de traiter l'ensemble des fichiers : 
*IMPORTANT*: annule les mofifications dans le [wd].
1. *git checkout HEAD [*]*
2. *git reset --hard HEAD*

## Exemple
1. Scénario : un fichier modifié mais non présent dans l'index
> *git checkout mon_fichier* : positionne le ficher à la dernière version connu de git (index ou commit).

2. Scénario : fichiers modifiés et poussé dans l'index
> *git checkout mon_fichier* : positionne le ficher tel que sur l'index.

> *git checkout HEAD mon_fichier* : positionne le fichier tel que sur le HEAD <==> git reset HEAD

3. Scénario : plusieurs fichiers modifiés
> *git checkout HEAD * : traite l'ensemble des fichiers

## Fichier modifier mais pas encore mis à l'index
---

	Changes not staged for commit:
  		(use "git add <file>..." to update what will be committed)
  		(use "git checkout -- <file>..." to discard changes in working directory)
---
