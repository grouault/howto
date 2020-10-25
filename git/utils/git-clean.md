nettoyer espace travail
=======================

Au choix:
* nettoyer tous les fichiers qui ne font pas partis du referentiel (ne font pas partis du .gitignore et pas indexé)
* nettoyer tous les fichiers qui font partis du .gitignore

## explique ce que la commande ferait
> git clean -n

## suppression de tous les fichiers/folder non référencés par Git
> git clean -df

## explique ce que la commande ferait à propos des fichiers paramétré dans le .gitignore
> git clean -xn

## supprimer de l'espace de travail les fichiers paramétrés .gitignore
> git clean -xdf