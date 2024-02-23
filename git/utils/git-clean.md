nettoyer espace travail
=======================

Au choix:
* nettoyer tous les fichiers qui ne font pas partis du referentiel (ne font pas partis du .gitignore et pas index�)
* nettoyer tous les fichiers qui font partis du .gitignore

## explique ce que la commande ferait
> git clean -n

## suppression de tous les fichiers/folder non r�f�renc�s par Git
> git clean -df

## explique ce que la commande ferait � propos des fichiers param�tr� dans le .gitignore
> git clean -xn

## supprimer de l'espace de travail les fichiers param�tr�s .gitignore
> git clean -xdf