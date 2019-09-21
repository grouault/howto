RESET - REVERT - CHECKOUT
=========================

## CHECKOUT
* pour déplacer le pointeur HEAD vers un commit spécifique ou basculer entre les branches
* Il annule tout changement de contenu par rapport à ceux du commit spécifique
* Cela n’apportera pas de changements à l’historique de validation
* Possibilité d’écraser des fichiers dans le répertoire de travail

## REVERT
* Annule les changements validés
* Crée un nouveau commit à partir d’un commit spécifié en l’inversant. Par conséquent, ajoute un nouvel historique de validation au projet, mais il ne modifie pas l’historique existant.
* Possibilité d’écraser des fichiers dans le répertoire de travail
* *git revert*: outils pour annulé les **changements validés** ==> *git revert HEAD~1*

## RESET
* A utiliser pour retourner au dernier état validé. Ceci éliminera les commits dans une branche privée ou élimera les changements non validés.
* altère l'historique des commits
* peut-être utilisé pour désindexé un fichier
* *git reset HEAD* : annulé les **changements non validés**

---

Chaque commande vous permet d’annuler une sorte de changement dans votre dépôt, seulement checkout et reset peut être utilisé pour manipuler des commits ou des fichiers individuels
Il existe de nombreuses façons différentes d’annuler vos changements, tout dépend du scénario actuel. Le choix d’une méthode appropriée dépend si vous avez ou non validé le changement par erreur, et si vous l’avez validé, si vous l’avez partagé ou non.

---
## RESET
* RESET à partir du HEAD.
> git reset HEAD
> git reset --soft
==> Remet dans l'état Modifié : supprime l'index et pas les modifs.

> git reset HARD
==> Remet dans l'état initial avant indexation : supprime l'index et les modifications.

* RESET à partir d'un autre Commit
> git reset --soft

> git reset --hard HEAD~3

## REVERT
* Sans Merge préalable
> git revert HEAD~2
* Avec Merge préalable
> git revert -m 1 c53c4e7a0a0c91977160e1b83c0d2d52a76d39b8



## DIFF-INDEX
https://git-scm.com/docs/git-diff-index
> git diff-index --abbrev HEAD
> git diff-index --cached HEAD
