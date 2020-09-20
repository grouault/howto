## git reset
===============


## RESET
* Important : � utiliser sur des fichers valid�s, uniquement si ces derniers n'ont pas �t� rendu public et partag� sur le repo distant.
* A utiliser pour retourner au dernier �tat valid�
==> *git reset HEAD* : annul� les **changements non valid�s**
==> permet aussi de d�sindexer un fichier
* Eliminer les commits dans une branche priv�e
==> annul� les 2 derniers commits : *git reset HEAD~2*
* alt�re l'historique des commits
* peut-�tre utilis� pour d�sindex� un fichier


## RESET
* --soft : dit � git de se positionner sur un autre 'commit', index et working-directory ne sont pas alt�r�s.
Tous les fichiers chang�s entre le HEAD d'origine et le 'commit' seront index�s
> git reset --soft HEAD~1

* --mixed : dit � git de se positionner sur un autre 'commit', index est supprim� et working-directory n'est pas alt�r�.

* --hard : supprimme tous ; repostionne le HEAD � un autre commit ; index et working directory sont align�s sur le HEAD.
> git reset --hard HEAD~3

* RESET � partir du HEAD
1. Sc�nario : fichiers modifi�s et pr�sent dans l'index
> *git reset* : supprime de l'index et garde les modifs dans le working directory.

> *git reset --soft* : ne fait rien : garde les fichiers dans l'index

> *git reset --mixed* : supprime de l'index et garde les modifs dans le working directory.

> *git reset --hard* : remet dans l'�tat initial avant indexation : supprime l'index et les modifications.  
  
  
# 
Changes to be committed:
use "git reset HEAD <file>..." to unstage