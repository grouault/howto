## git diff
===========

L'index (stage) peut-être analysé en différentiel :
* soit sur l'espace de travail [wd]
* soit sur le repository [r]

## git diff [filename]
- différene entre [wd] et [i]
- Qu'est-ce qui a été modifié mais pas encore indexé?

## git diff --cached [filename]
- différence entre [i] et [r]
- Quelle modification a été indexée et est prête pour la validation?

## DIFF-INDEX
https://git-scm.com/docs/git-diff-index
> git diff-index --abbrev HEAD
> git diff-index --cached HEAD  
