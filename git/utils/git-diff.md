git diff
========

L'index (stage) peut-être analysé en différentiel :
* soit sur l'espace de travail [wd]
* soit sur le repository [r]

## git diff [filename]
- différence entre [wd] et [i]
- Qu'est-ce qui a été modifié mais pas encore indexé?

## git diff --cached [filename]
- différence entre [i] et [r]
- Quelle modification a été indexée et est prête pour la validation?

<<<<<<< HEAD
# Vocabulaire
* Unstage : désindexer, enelver de l'index, dé-présélectionner
* discard changes : annuler les modifications
=======
>>>>>>> restructuration git rollback


<<<<<<< HEAD
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)
=======


## DIFF-INDEX
https://git-scm.com/docs/git-diff-index
> git diff-index --abbrev HEAD
> git diff-index --cached HEAD  
