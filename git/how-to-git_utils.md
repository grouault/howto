RESET - REVERT - CHECKOUT
=========================

## CHECKOUT
* pour déplacer le pointeur HEAD vers un commit spécifique ou basculer entre les branches
* Il annule tout changement de contenu par rapport à ceux du commit spécifique
* Cela n’apportera pas de changements à l’historique de validation
* Possibilité d’écraser des fichiers dans le répertoire de travail

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
