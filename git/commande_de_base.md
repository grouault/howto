# Configuration GIT
Fichier de configuration global : user_folder/.gitconfig
git config --help
git config -h

# Fichier de configuration de git
$ git config --global user.name "grouault"
$ git config --global user.email "gildasrouault@gmail.com"
$ git config --global core.editor vim

# proxy
git config --global http.proxy 10.3.64.101:8080
==> Parfois il faut ajouter le mot de passe : http://login:passwd@ip_adresse:port
git config --global --unset http.proxy
git config --global --unset https.proxy
git config --global http.proxy https://login:passwd@10.3.64.101:8080
git config --global https.proxy https://login:passwd@10.3.64.101:8080

# Principe
Etat: pour un fichier suivi par GIT, le fichier peut être dans 3 états
- Validé / Modifié / Indexé
Pour pouvoir être committé, un fichier doit êtré dans l'état 'indexé'.
Indexation : nouvelle signature/nouveau hash // signe le fichier pour le versionnement et en faire une nouvelle version

# initilisation d'un dépôt GIT
git init ==> initialise un dépôt GIT sur la branche Master
git init monNouveauProjet

# status : git status
renseigne sur le statut du dépot actuel

# Indexation : git add
Git fait appel à un système par état pour gérer ses fichiers.
add: indexer à la main tous les fichiers qui ont été créés ou modifiés
Il est de la responsabilité du développeur d'inclure :
- les fichiers à versionner 
- les fichiers modifiés 
$ git status
$ git add [mon_fichier]
$ git add . ==> index tous les fichiers modifiés
$ git add -p ==> index de manière interactive

# Commit : git commit
Commit : action de prendre le répertoire de travail et d'en faire une copie carbonne qu'on appelera 'version/révision'
Une fois indexé, un fichier peut-être committé.
Cela créer une version/révision (hash) sur le dépôt local (réferentiel local)
$ git commit ==> commit les fichiers indexés.
$ git commit -m "[Commentaire]"
$ git commit -am "[Commentaire]" ==> indexe les fichiers modifiés(a) et fait un commit

# historiser : un fichier / une revision
$ git checkout ==> remplace un fichier par sa révision à un instant t
Permet de consulter un fichier, mais ne permet pas de le modifier

# Récupérer un fichier un fichier supprimer localement
$ git checkout -f
==> the deletes files should be back.
==> CAUTION : commint uncommitted files

# HEAD
Version de tête de la brance en cours de visualisation.
La version de tête pointe sur le dernier commit.
Les changements réalisés et les changements réalisés ajoutés à l'index ne font pas partir de la version Head.

# git log et HEAD
$ git log --oneline --decorate  #make sure there is a ref besides HEAD branch, or lose it

# Retour arrière sur un fichier ajouté à l'index au préalable et surlequel on a fait d'autres modifs.
# on voit le fichier tel que présent sur l'index. Les dernières modifications sont effacées
# git checkout : dernier le la pile ; le dernier de la pile n'est pas forcément le head mais l'index...
git checkout [filename]

# Retour arrière sur un fichier ajouté à l'index ==> se repoistionner sur la version de tête.
git checkout HEAD [filename]

# Retour arrière sur un fichier committé.
$ git reset ==> annule l'effet du 'git add' précédent

Annuler un commit :
$ git reset --soft 9e5e64a ; le commit est annulé mais pas les données
==> Fichie remis à l'index

To move head-branch to previous commit:
$ get reset --hard ==> écrase les modifications faite depuis le dernier commit
$ git reset --hard 9e5e64a      #move Head-branch to specified commit

==> 
https://alexgirard.com/git-book/intermediaire/repair-reset-checkout-revert/

# Ignorer : .gitignore
- racine du dépot
- quel fichier / pattern fichier à ignorer
Créer le fichier et ajouter le fichier au dépôt.
git rm --cached [nom_fichier] ==> retirer du suivi de version le fichier
git rm -r --cached salsa-core/target ==> recursif

# Nettoyer espace de travail
--> effacer les fichiers qui ne font pas parti du referentiel / fichier non indexé par Git
$ git clean -n ==> ce que Git propose en suppression
$ git clean -df ==> supprimer dossier et fichier
--> effacer les fichiers qui font parti du .gitignore 
$ git clean -xn
$ git clean -xdf

# show origin
git remote show origin
