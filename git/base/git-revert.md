## git revert
===============


## REVERT
* *git revert*: outils pour annulé les **changements validés et partagés** ==> *git revert HEAD~1*
* Crée un nouveau commit à partir d’un commit spécifié en l’inversant. 
* Par conséquent, ajoute un nouvel historique de validation au projet, mais il ne modifie pas l’historique existant.
* Possibilité d’écraser des fichiers dans le répertoire de travail


## REVERT
* Sans Merge préalable
> git revert HEAD~2
* Avec Merge préalable
> git revert -m 1 c53c4e7a0a0c91977160e1b83c0d2d52a76d39b8