## git diff

L'index (stage) peut-être analysé en différentiel :
* soit sur l'espace de travail [wd]
* soit sur le repository [r]

## git diff [filename]
- différene entre [wd] et [i]
- Qu'est-ce qui a été modifié mais pas encore indexé?


## git diff --cached [filename]
- différence entre [i] et [r]
- Quelle modification a été indexée et est prête pour la validation?

# Vocabulaire
* Unstage : désindexer, enelver de l'index, dé-présélectionner
* discard changes : annuler les modifications

# 
Changes to be committed:
use "git reset HEAD <file>..." to unstage

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)
