## git diff

L'index (stage) peut-�tre analys� en diff�rentiel :
* soit sur l'espace de travail [wd]
* soit sur le repository [r]

* git diff [filename]
- diff�rene entre [wd] et [i]
- Qu'est-ce qui a �t� modifi� mais pas encore index�?


* git diff --cached [filename]
- diff�rence entre [i] et [r]
- Quelle modification a �t� index�e et est pr�te pour la validation?

# Vocabulaire
* Unstage : d�sindexer, enelver de l'index, d�-pr�s�lectionner
* discard changes : annuler les modifications

# 
Changes to be committed:
use "git reset HEAD <file>..." to unstage

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)