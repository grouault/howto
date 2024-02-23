## git branch

### BRANCHE LOCAL 

# Cr�er une branche � partir du master sur le repo local
>$ git branch v2.0

# Passer sur une branch ==> je m'aligne sur la nouvelle branche
>$ git checkout v2.0

# Raccourci pour cr�er et se positionner sur la nouvelle branche
>$ git checkout v2.0 -b v2.1 

# Cr�er la branche sur le repo distant
>$ git push origin v2.O
 
### BRANCHE REMOTE

#### Informations sur les branches
>$ git remote show origin

#### R�cup�rer une branche remote qui n'existe pas en local 
<pre>
La situation est alors la suivante: vous avez des branches distantes que vous souhaitez rapatrier en local. 
Il suffit de connecter, ou track, cette branche remote � une branche locale
</pre>

```
1. premiere solution
$ git checkout --track -b <local branch> <remote>/<tracked branch>

* Exemple:
$ git checkout --track -b dev origin/dev

2. deuxieme solution
$ git fetch origin ==> recuperer le pointeur de la branche distante
$ git checkout -b dev origin/dev ==> reconstuire la branche localement : dev
```

## FUSION - merge
<pre>
Fusion pour int�grer des travaux aux historiques divergeants.
Cette commande r�alise une fusion � trois branches entre les deux derniers instantan�s (snaphots)
de chaque branche et l'anc�tre le plus r�cent, cr�ant un nouvel instantan� (et un commit).
</pre>

# Fusionner deux branches : int�grer les donn�es de la branche v2.0 dans master
==> se positionner dans master
>$ git merge v2.0

## REBASER (Rebasing)


## SUPPRIMER UNE BRANCHE
<pre>
> $ git branch -d the_local_branch

> $ git push origin :the_remote_branch

> $ git push origin --delete the_remote_branch
</pre>

## Commande utile
<pre>
# filter les branches de la liste suivant que vous les avez : 

1- fusionn�es avec la branche courante
$ git branch --merged

2- pas encore fusionn�es avec la branche courante
$ git branch --no-merged

# lister les derniers 'commit' sur chaque branche
$ git branch -v 
</pre>