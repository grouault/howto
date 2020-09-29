## RESET
========

## Désindexer
1- desindexé : supprime les modifications de l'[i] en conservant les modifications dans le [wd]
> git reset [filename]
2-



## RESET
* Important : à utiliser sur des fichers validés, uniquement si ces derniers n'ont pas été rendu public et partagé sur le repo distant.
* A utiliser pour retourner au dernier état validé
==> *git reset HEAD* : annulé les **changements non validés**
==> permet aussi de désindexer un fichier
* Eliminer les commits dans une branche privée
==> annulé les 2 derniers commits : *git reset HEAD~2*
* altère l'historique des commits
* peut-être utilisé pour désindexé un fichier


## RESET
* --soft : dit à git de se positionner sur un autre 'commit', index et working-directory ne sont pas altérés.
Tous les fichiers changés entre le HEAD d'origine et le 'commit' seront indexés
> git reset --soft HEAD~1

* --mixed : dit à git de se positionner sur un autre 'commit', index est supprimé et working-directory n'est pas altéré.

* --hard : supprimme tous ; repostionne le HEAD à un autre commit ; index et working directory sont alignés sur le HEAD.
> git reset --hard HEAD~3

* RESET à partir du HEAD
1. Scénario : fichiers modifiés et présent dans l'index
> *git reset* : supprime de l'index et garde les modifs dans le working directory.

> *git reset --soft* : ne fait rien : garde les fichiers dans l'index

> *git reset --mixed* : supprime de l'index et garde les modifs dans le working directory.

> *git reset --hard* : remet dans l'état initial avant indexation : supprime l'index et les modifications.  
  
  
# 
Changes to be committed:
use "git reset HEAD <file>..." to unstage
