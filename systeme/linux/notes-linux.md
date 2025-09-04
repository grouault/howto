## notes-linux

[retour](./index-linux.md)


## GNU/Linux

Linux: Linus Torvald a développé le noyau
GNU: Richard stallman a développé un tas de système qui gravite autour du noyau

Unix/Linux
- unix : version antérieur à Linux 
- linux : est une version commerciale

### Linux vs Windows
- code source ouvert à la communauté
- linux : pas de support constructeur mais c'est la communauté qui développe les pilotes/drivers.
- pas toujours les drivers pour faire fonctionner le matériel

- OS: logiciel (ensemble de logiciels)
	- qui pilote les dispositifs matériels 
	- qui reçoit des instructions de l'utilisateurs ou autre logiciels (applications)
	- sert d'interface entre le matériel et les applications et les utilisateurs

### Distribution Linux:
	- hardware <==> kernel Linux <==> applicatifs / GNU 
	- ensemble de logicielles qui fonctionnent entre eux
	- logicielles qui arrivent par défaut mais qui arrivent par défaut

* redhat: distribution payante (CentOS => dérivé et gratuite)
* ubuntu (debian): distribution gratuite (permet de faire ce que fait redhat mais sans support)
* fedora

### Shell:
- Interaction avec le système à l'aide de commande.

Prompt:
~ : répertoire personnel de l'utilisateur identifié dans le terminal au niveau du prompt
$ : utilisateur normal 
\#: admin


Virtualisation
* faire fonctionner plusieurs systèmes sur une seul machine (serveur) physique.


## Système de fichiers:

### etc
* /etc ==> fichier de configuration
cat /etc/hostname => nom de la machine


## Commande: 

### pwd
> pwd : affiche le chemin d'accès au fichier

### cat
> cat: permet d'afficher le contenu d'un fichier
> cat -n /ect/passwd : permet d'afficher le numéro de ligne

### man
* shift + g : aller à la fin
* g: aller au début
* espace: passer de page en page

man -k keyword: 
* permet de rechercher dans les commandes man,
  celle qui ont le mot keyword dans leur descriptif
  
### grep

### ls
ls [aRtlh]
a: fichier caché
R: affiche le contenu du répertoire (Récursif)
t: fichiers triés
l: sous forme de liste
h: taille en ko ou mo plutôt que octet

## Manipulation de fichier/répertoire
```sh
$ touch # permet de créer un fichier
$ mkdir # ajouter un répertoire
$ rmdir # supprimer un répertoire vide
$ rm -Rf # supprimer un dossier avec ce qu'il contient
$ cp # copier des fichiers
$ cp -R # copier un répertoire
```
## alias / bashrc

## nano
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

```bash
$ locate name_file #donne l'ensemble des fichiers avec le chemin des fichiers
$ sudo updatedb # met à jour la base
```
## Find
* find cherche un élément 
* permet faire des recherches très spécifiques en ciblant les noms, 
	les extensions, les types de fichiers, etc..
* il faut indiquer un endroit de recheche
* find n'utilise pas de base de données


### find -name
```sh
$ find /home/jordan fichier1
# chercher un nouvel élément par son nom
$ find -name "fichier1" 
$ find /tmp/exercices/ -name arabica.cafe
# rechercher uniquement les dossiers situés dans le répertoire /var/log
$  find /var/log -type d 
# chercher tous les fichiers d'un répertoire
$ find /tmp/exercices/cafes -type f 
```

### find -user
```bash
# * permet de cibler, dans notre recherche, les fichiers et dossiers appartenant un utilisateur particulier
$ find /tmp/exercices/livres/ -user root -type f
```
### find -empty
```bash
# permet de cibler, dans notre recherche, les fichiers et dossiers qui sont vides
$ find /etc/network -type d -empty
```

### find regex
```bash
# rechercher un ficher avec une extendion
$ find exercices/ -regex  .*.file
```

## Utilisateurs
Chaque utilisateur se voit attribuer un numéro utilisateur et un groupe.
### id - uid - gid 
```bash
alexandre@N058176:/tmp$ id
uid=1002(alexandre) gid=1002(alexandre) groups=1002(alexandre)
```

Attribution des uid: 
0 -> 99 : compte historique linux
100 -> 999: application tel que apache...
1000 -> 4999: compte utilistateur
5000 -> ? :

### /etc/passwd
contient les comptes utilisateurs de la machine
```bash
jordan@N058176:/tmp$ cat -n /etc/passwd
     1  root:x:0:0:root:/root:/bin/bash
     2  daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
     3  bin:x:2:2:bin:/bin:/usr/sbin/nologin
     4  sys:x:3:3:sys:/dev:/usr/sbin/nologin
     5  sync:x:4:65534:sync:/bin:/bin/sync
     6  games:x:5:60:games:/usr/games:/usr/sbin/nologin
     7  man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
     8  lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
     9  mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
    10  news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
    11  uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
    12  proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
    13  www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
    14  backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
    15  list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
    16  irc:x:39:39:ircd:/run/ircd:/usr/sbin/nologin
    17  gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
    18  nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
    19  systemd-network:x:100:102:systemd Network Management,,,:/run/systemd:/usr/sbin/nologin
    20  systemd-resolve:x:101:103:systemd Resolver,,,:/run/systemd:/usr/sbin/nologin
    21  messagebus:x:102:105::/nonexistent:/usr/sbin/nologin
    22  systemd-timesync:x:103:106:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
    23  syslog:x:104:111::/home/syslog:/usr/sbin/nologin
    24  _apt:x:105:65534::/nonexistent:/usr/sbin/nologin
    25  uuidd:x:106:112::/run/uuidd:/usr/sbin/nologin
    26  tcpdump:x:107:113::/nonexistent:/usr/sbin/nologin
    27  grouault:x:1000:1000:,,,:/home/grouault:/bin/bash
    28  jordan:x:1001:1001:,,,:/home/jordan:/bin/bash
```

### /etc/shadow
* contient les mots de passe.
* contient les éléments pour la politique de sécurité.
```bash
grouault@N058176:/tmp$ sudo cat -n /etc/shadow
     1  root:*:19290:0:99999:7:::
     2  daemon:*:19290:0:99999:7:::
     3  bin:*:19290:0:99999:7:::
     4  sys:*:19290:0:99999:7:::
     5  sync:*:19290:0:99999:7:::
     6  games:*:19290:0:99999:7:::
     7  man:*:19290:0:99999:7:::
     8  lp:*:19290:0:99999:7:::
     9  mail:*:19290:0:99999:7:::
    10  news:*:19290:0:99999:7:::
    11  uucp:*:19290:0:99999:7:::
    12  proxy:*:19290:0:99999:7:::
    13  www-data:*:19290:0:99999:7:::
    14  backup:*:19290:0:99999:7:::
    15  list:*:19290:0:99999:7:::
    16  irc:*:19290:0:99999:7:::
    17  gnats:*:19290:0:99999:7:::
    18  nobody:*:19290:0:99999:7:::
    19  systemd-network:*:19290:0:99999:7:::
    20  systemd-resolve:*:19290:0:99999:7:::
    21  messagebus:*:19290:0:99999:7:::
    22  systemd-timesync:*:19290:0:99999:7:::
    23  syslog:*:19290:0:99999:7:::
    24  _apt:*:19290:0:99999:7:::
    25  uuidd:*:19290:0:99999:7:::
    26  tcpdump:*:19290:0:99999:7:::
    27  grouault:$y$j9T$RWwIXQQkhPURaG0DV5eMn0$7aOcv4t0pYDJo2NLibVZGhfhb6TIew6d6pB98p2W1c.:19870:0:99999:7:::
```

### Droits utilisateurs
Ils permettent de déterminer les actions qu'un utilisateur à le droit de faire.
Quand un utilisateur est créer, il dispose pour son compte /home/utilisateur de l'ensemble des droits (r/w/x).
L'utilisateur root dispose de tous les privilèges sur la machine et peu importe le compte utilisateur.
```bash
# role utilisateur
u: # utilisateur du compte connecté
g: # group
o: # other
a: # all

# droits
r: # lecture du fichier / répertoire
w: # ecriture du fichier / réperteoire
x: # exécution quand fichier / si répertoire, droit de le traverser
```
### chmod
permet de modifier les droits sur tous les types d'utilisateurs
```bash
$ chmod u+x # donner les droits d'exécution à l'utilisateur
$ chmod a+r # donner les droits de lecture à tous
```
### création
Pour créer un compte utilisateur il faut les droits root. 
Cela créer un compte /home/nom_utilisateur et met à jour les fichiers /etc/passwd et /etc/shadow.
``` bash
jordan@N058176:/tmp$ sudo adduser alexandre
[sudo] password for jordan:
Adding user `alexandre' ...
Adding new group `alexandre' (1002) ...
Adding new user `alexandre' (1002) with group `alexandre' ...
Creating home directory `/home/alexandre' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for alexandre
Enter the new value, or press ENTER for the default
        Full Name []:
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] Y
```
### suppression
* il faut être sudoers
* il faut utiliser l'option --remove-home pour supprimer le répertoire /home/nom_utilisateur
```bash
grouault@N058176:/tmp$ sudo deluser --remove-home jordan
Looking for files to backup/remove ...
Removing files ...
Removing user `jordan' ...
Warning: group `jordan' has no more members.
Done.
```

## Sortie standard
La sortie standard est par défaut brancher sur l'écran. Le résultat des commandes exécuter dans le Shell sorte sur l'écran.
Il est néanmoins possible de rediriger la sortie standard vers un fichier.

```bash
# écrase le fichier s'il existe ou écrasement du fichier
$ ls -lrt > test_file.txt 

# ajoute des éléments à la fin du fichier
$ ls -lrt >> test_file.txt
```


## Sortie d'erreur standard
La sortie d'erreur standard s'affiche par défaut sur l'écran. Elle est configurable sur le canal 2.
Ainsi, il est possible de rediriger la sortie d'erreur vers une autre sortie.

```bash
# écrase le fichier s'il existe ou écrasement du fichier
$ ls -lrt 2> error.file 

# ajoute des éléments à la fin du fichier
$ ls -lrt 2>> error.file
```
## groups
Chaque user se voit à sa création associé un groupe du même nom ave le même gid que le groupe id.
``` bash
$ tail -n 1 /etc/passwd
grouault:x:1000:1000:,,,:/home/grouault:/bin/bash
```
### /etc/group
permet de lister les groupes
```bash
$ tail -n 2 /etc/group
grouault:x:1000:
docker:x:999:grouault
```

### groups
permet de lister les groupes d'un utilisateur
```bash
$ groups grouault root
grouault : grouault adm dialout cdrom floppy sudo audio dip video plugdev netdev docker
root : root
```

### création: addgroup
```bash
$ sudo addgroup linux
[sudo] password for grouault:
Adding group `linux' (GID 1001) ...
Done.
```

### suppression delgroup
```bash
$ sudo delgroup linux
Removing group `linux' ...
Done.
```

### modification: usermod
```bash
# permet de changer/réinitialiser le groupe utilisateur
$ sudo usermod -g linux alexandre

# permet d'ajouter le groupe utilisateur
$ sudo usermod -G linux alexandre

```
## stats

## file