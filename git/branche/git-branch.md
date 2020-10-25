git branch
==========

## BRANCHE LOCAL 

# Créer une branche à partir du master sur le repo local
>$ git branch v2.0

# Passer sur une branch ==> je m'aligne sur la nouvelle branche
>$ git checkout v2.0

# Raccourci pour créer et se positionner sur la nouvelle branche
>$ git checkout v2.0 -b v2.1 

# Créer la branche sur le repo distant
>$ git push origin v2.O

# Fusionner deux branches : intégrer les données de la branche v2.0 dans master
==> se positionner dans master
>$ git merge v2.0

## BRANCHE REMOTE

# Informations sur les branches
>$ git remote show origin

# Récupérer une branche remote qui n'existe pas en local 
---
	
	La situation est alors la suivante: vous avez des branches distantes que vous souhaitez rapatrier en local. 
	Il suffit de connecter, ou track, cette branche remote à une branche locale

---

1. premiere solution
> $git checkout --track -b <local branch> <remote>/<tracked branch>

2. deuxieme solution
>$ git fetch origin ==> recuperer le pointeur de la branche distante
>$ git checkout -b dev origin/dev ==> reconstuire la branche localement : dev