Qu'est ce que Git ?
VCS: Version Control System gestionnaire de versions 
SCM: Source Control Management (système de gestion de contrôle du code source)
	==> Git : permet de stocker, gérer et collaborer
Distributed: modification locale et disponible sur un serveur central (duplication des dépôts)
	différent de centralisé

## Maitriser les termes Git

Dépôt: c'est le répository
Commit (hash - shaone) : c'est la photo, un instantané
branche : univers indépendant du tronc commun
	Toute formation de branche se base à partir d'un commit
Pointeur (raccourci)
HEAD:
	* tête de lecture ; c'est une constante
	* pointe vers le dernier commit de la branche sur laquelle vous travailez
REMOTE: pointe vers un dépôt GIT distant

workflow Git

git show HEAD
git loggraph
git commit -a  -m 'mon commentaire'

Annulé en staging
staging => unstaging
> git restore --staged <file>
unstaging => etat initial dernier commit
> git restore <file>

ou
> git reset HEAD <file>
> git checkout -- <file>

Log:
> git log --online
> git log --author=""
> git log --grep="hello-world.py
> git log --help

Afficher un commit - compare avec celui d'avant
> git show ou  git log -p
> git show 5838394

alias
https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases
https://borntocode.fr/git-alias-etre-un-bon-developpeur-faineant/
https://mjk.space/git-aliases-i-cant-live-without/

## git diff et git diff --staged
### comparer les états
```cmd
git diff: compare wd avec le tampon ou le dernier commit
git diff --staged : compare le tampon avec le dernier commit

λ git diff --staged --color-words
```
### comparer deux commits
```cmd
git diff entre deux commits
> git diff hashold hashnew
```

### comparer deux branches
```cmd
$ git diff <branch-t1> <branche-t2> --color-words
	compare les deux branches
$ git diff master test-span --color-words index.html
	 compare un fichier entre deux branches
```

## branche
### naviguer entre les branches
```cmd
> git checkout <mabranche> ou <num commit>
	se déplacer sur une branche ou un commit (état détaché)
> git checkout HEAD^
	 se déplacer sur le commit précédent
> git checkout HEAD~2
	se déplacer de deux commits en arrière
 ```
### créer une branche
```cmd
> git branch <mabranche>
> git checkout -b <mabranche>
	créer la branche et s'y déplacer
```

### renommer la branche courante
```cmd
> git branch -M main
```

### lister les branches
```cmd
> git branch
> git branch --all
	permet de lister les branches non visibles (en remote)
```

### git merge
```cmd
// j'ai fait des devs sur b1
// je merge depuis une branche vers la mienne.
// je suis sur une branche <main>, je veux merger b1
git merge <b1>
```

**commit de merge** : a lieu si l'historique est différent sur les deux branches
**fast-forward**: si l'historique du main n'a pas été altéré par rapport à b1

### git rebase
```cmd
// j'ai fait des devs sur b1
// je rebase vers une branche cible <main>
//  je me place sur la branche <b1> (qui va recevoir) et qui va aller vers la branche <main> 
git rebase <main>
```

## Faire du ménage

### modifier le dernier commit
```
> git commit --amend
```

### sortir un fichier du suivi de version
```cmd
git rm --cached <filename>
```

### Supprimer un fichier commité
> git rm <file>
==> comme git add place le fichier en staging


## Réécrire l'historique - ménage
https://git-scm.com/book/fr/v2/Utilitaires-Git-R%C3%A9%C3%A9crire-l%E2%80%99historique

## Remote

### créer un repository
```cmd
> git remote add origin <url-origine>
> git remote add origin https://github.com/grouault/git-test-eb.git
> git branch -M main // renommer la branche
> git push -u origin main // upstream
```

### récupérer l'url d'un repo
```
> git remote get-url origin
```
