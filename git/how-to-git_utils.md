RESET - REVERT - CHECKOUT
=========================

## CHECKOUT
* pour déplacer le pointeur HEAD vers un commit spécifique ou basculer entre les branches
* Il annule tout changement de contenu par rapport à ceux du commit spécifique
* Cela n’apportera pas de changements à l’historique de validation
* Possibilité d’écraser des fichiers dans le répertoire de travail

## REVERT
* *git revert*: outils pour annulé les **changements validés et partagés** ==> *git revert HEAD~1*
* Crée un nouveau commit à partir d’un commit spécifié en l’inversant. Par conséquent, ajoute un nouvel historique de validation au projet, mais il ne modifie pas l’historique existant.
* Possibilité d’écraser des fichiers dans le répertoire de travail

## RESET
* Important : à utiliser sur des fichers validés, uniquement si ces derniers n'ont pas été rendu public et partagé sur le repo distant.
* A utiliser pour retourner au dernier état validé
==> *git reset HEAD* : annulé les **changements non validés**
==> permet aussi de désindexer un fichier
* Eliminer les commits dans une branche privée
==> annulé les 2 derniers commits : *git reset HEAD~2*
* altère l'historique des commits
* peut-être utilisé pour désindexé un fichier

---

Chaque commande vous permet d’annuler une sorte de changement dans votre dépôt, seulement checkout et reset peut être utilisé pour manipuler des commits ou des fichiers individuels
Il existe de nombreuses façons différentes d’annuler vos changements, tout dépend du scénario actuel. Le choix d’une méthode appropriée dépend si vous avez ou non validé le changement par erreur, et si vous l’avez validé, si vous l’avez partagé ou non.

---
## CHECKOUT
> git checkout mon_fichier
positionne le ficher tel que sur l'index.

> git checkout HEAD mon_fichier
positionne le fichier tel que sur le HEAD <==> git reset HEAD

## RESET


* --soft : dit à git de se positionner sur un autre 'commit', index et working-directory ne sont pas altérés.
Tous les fichiers changés entre le HEAD d'origine et le 'commit' seront indexés
> git reset --soft HEAD~1

* --mixed : dit à git de se positionner sur un autre 'commit', index est supprimé et working-directory n'est pas altéré.

* --hard : supprimme tous ; repostionne le HEAD à un autre commit ; index et working directory sont alignés sur le HEAD.
> git reset --hard HEAD~3

* RESET à partir du HEAD ==> permet de désindexer
> git reset --soft ==> ne fait rien ???
> git reset --mixed
==> Remet dans l'état Modifié : supprime l'index et pas les modifs.
> git reset HARD
==> Remet dans l'état initial avant indexation : supprime l'index et les modifications.

## REVERT
* Sans Merge préalable
> git revert HEAD~2
* Avec Merge préalable
> git revert -m 1 c53c4e7a0a0c91977160e1b83c0d2d52a76d39b8



## DIFF-INDEX
https://git-scm.com/docs/git-diff-index
> git diff-index --abbrev HEAD
> git diff-index --cached HEAD
