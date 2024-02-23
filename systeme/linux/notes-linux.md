## notes-linux

[retour](./index-linux.md)


GNU/Linux

Linux: Linus Torvald a développé le noyau
GNU: Richard stallman a développé un tas de système qui gravite autour du noyau

Unix/Linux
- unix : version antérieur à Linux 
- unix : est une version commerciale

Linux vs Windows
- code source ouvert à la communauté
- linux : pas de support constructeur mais c'est la communauté qui développe les pilotes/drivers.
- pas toujours les drivers pour faire fonctionner le matériel

- OS: logiciel (ensemble de logiciels)
	- qui pilote les dispositifs matériels 
	- qui reçoit des instructions de l'utilisateurs ou autre logiciels (applications)
	- sert d'interface entre le matériel et les applications et les utilisateurs

Distribution Linux:
	- hardwar <==> kernel Linux <==> applicatifs / GNU 
	- ensemble de logicielles qui fonctionnent entre eux
	- logicielles qui arrivent par défaut mais qui arrivent par défaut

* redhat: distribution payante (CentOS => dérivé et gratuite)
* ubuntu (debian): distribution gratuite (permet de faire ce que fait redhat mais sans support)
* fedora

Virtualisation
* faire fonctionner plusieurs systèmes sur une seul machine (serveur) physique.


Système de fichiers:
* /etc ==> fichier de configuration
cat /etc/hostname => nom de la machine

Shell:
- Interaction avec le système à l'aide de commande

Prompt:
~ : répertoire personel de l'utilisateur identifié dans le terminal au niveau du prompt
$ : utilisateur normal
# : utilisateur root

Commande: 

## pwd
> pwd : affiche le chemin d'accès au fichier

## cat
> cat: permet d'afficher le contenu d'un fichier
> cat -n /ect/passwd : permet d'afficher le numéro de ligne

man
* shift + g : aller à la fin
* g: aller au début
* espace: passer de page en page

man -k keyword: 
* permet de rechercher dans les commandes man,
  celle qui ont le mot keyword dans leur descriptif
  
grep

ls [aRtlh]
a: fichier caché
R: affiche le contenu du répertoire (Récursif)
t: fichiers triés
l: sous forme de liste
h: taille en ko ou mo plutôt que octet

Manipulation de fichier/répertoire
> touch: permet de créer un fichier
> mkdir: ajouter un répertoire
> rmdir: supprimer un répertoire vide
> rm -Rf: supprimer un dossier avec ce qu'il contient
> cp: copier des fichiers
> cp -R: copier un répertoire

alias / bashrc

"nano"
Raccourcis de l'éditeur "nano"
Ctrl + G : affiche l'aide de nano
Ctrl + K : coupe la ligne sur laquelle se situe le curseur et la place de le presse-papier
Ctrl + U : colle le contenu du presse-papier
Ctrl + C : affiche la position du curseur (numéro de ligne et numéro de colonne)
Ctrl + W : permet d'effectuer une recherche de texte dans le fichier
Ctrl + O : permet d'enregistrer les modifications effectuées sur le fichier
Ctrl + X : permet de quitter l'éditeur de texte nano

## locate
* localise un fichier
* se base sur une base de données des fichiers mis à jour toutes les 24h.

>locate name_file
* donne l'ensemble des fichiers avec le chemin des fichiers

>sudo updatedb
* met à jour la base

## Find
<pre>
* find cherche un élément 
* permet faire des recherches très spécifiques en ciblant les noms, 
	les extensions, les types de fichiers, etc..
* il faut indiquer un endroit de recheche
* find n'utilise pas de base de données
</pre>

<pre>
* chercher un nouvel élément
> find /home/jordan fichier1
> find /tmp/exercices/ -name arabica.cafe

* chercher un nouvel élément dont le nom est le suivant:
> find -name "fichier1"
</pre>

### find -type
<pre>
* rechercher uniquement les dossiers situés dans le répertoire /var/log: 
> find /var/log -type d

* chercher tous les fichiers d'un répertoire
> find /tmp/exercices/cafes -type f
</pre>

### find -user
<pre>
* permet de cibler, dans notre recherche, les fichiers et dossiers 
	appartenant à un utilisateur en particulier
</pre>

<pre>
> find /tmp/exercices/livres/ -user root -type f
</pre>

### find -empty
<pre>
* permet de cibler, dans notre recherche, les fichiers et dossiers qui sont vides
Exemple:
> find /etc/network -type d -empty
</pre>

## Droit utilisateurs

## Sortie standard

## Sortie d'erreur standard

## stats

## file