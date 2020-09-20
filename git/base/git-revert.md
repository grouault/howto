## git revert
===============


## REVERT
* *git revert*: outils pour annul� les **changements valid�s et partag�s** ==> *git revert HEAD~1*
* Cr�e un nouveau commit � partir d�un commit sp�cifi� en l�inversant. 
* Par cons�quent, ajoute un nouvel historique de validation au projet, mais il ne modifie pas l�historique existant.
* Possibilit� d��craser des fichiers dans le r�pertoire de travail


## REVERT
* Sans Merge pr�alable
> git revert HEAD~2
* Avec Merge pr�alable
> git revert -m 1 c53c4e7a0a0c91977160e1b83c0d2d52a76d39b8