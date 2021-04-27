## VM Ubuntu
```
* login: grouault
* password:gildas1234
* ssh grouault@grouault-VirtualBox
```

## VM Ubuntu Server
```
* ssh grouault@ub-server
* login: grouault
* password: 1234
```

## VM Fedora Server
```
* root: grouault
* password: gildas1234
```

## installation
```
* installation local des VMs:
C:\Users\grouault\VirtualBox VMs


* installation des images
C:\Users\grouault\VirtualBox VMs\UbuntuServer\UbuntuServer.vdi
```

### hosts
```
Windows
C:\Windows\System32\drivers\etccvap
```

* Question : install-docker?
Ou est installé docker-host / docker-engine sur la VM?

## Création d'adaptateur
* pour créer une nouvelle carte réseau virtuelle.

## Configuration Réseau 

### connexion à Internet en NAT
Aucune configuration n'est à faire pour faire cela
> test connexion internet
$ ping google.com
En NAT, c'est VB qui attribue une adresse IP dynamique à la machine virtuelle
Addresse IP qui est fournit par défaut à la machine : 10.0.2.15
$ ip a
inet 10.0.2.15/24 brc
Avec cet IP, la machine peut se connecter à internet car VB va faire la translation d'adresse (pour tous les paquets envoyés) de façon à utiliser la carte ethernet physique de la machine.

### Tester les applications en dehors de la machine virtuelle
* En NAT, il y a un pb. Ce n'est pas configuré par défaut.

### configuration Acces-Pont
* machine virtuelle va utiliser la même interface réseau que la machine physique
* exactement comme s'il s'agit d'une vraie machine physique
* on peut pinger d'une machine à l'autre
* par contre pas d'internet

### configuration Réseau Privé
Configuration avec plusieurs interface
* interface 1 : NAT pour avoir accès Internet
* interface 2 : Réseau privé hôté pour permettre à la VM de contacter l'extérieur
	* création d'un réseau privé sur la machine virtuelle mais connecté à la machine hôte
	* pour un réseau privé, il faut préciser l'adaptateur à utiliser : carte réseau
		* carte pour pouvoir accèder au réseau
	* pour cela, il est possible de créer un adaptateur
	
## SSH : connection serveur à distance
```
* sur la version Desktop, il faut installer OpenSsh
* sudo apt-get install openssh-server
* sur la version Server, OpenSsh est déjà installé
```

## Installation de docker

* il faut s'assurer de la version de Linux

```
> Permet de voir la version de l'OS installé
$ cat /etc/*relesase*
```

* Url pour checker les version de linux pour installer Docker.

```
https://docs.docker.com/engine/install/
```

* Uninstal old versions
	* Older versions of Docker were called: docker, docker.io or docker-engine
```
$ apt-get remove docker docker-engine docker.io containerd runc
```

* Installation à partir d'un script qui fait l'installation et mise à jour de Docker.

```
> Télécharger le script
$ curl -fsSL https://get.docker.com -o get-docker.sh
> installer curl si besoin
$ sudo apt-get install curl
> Exécuter le script
$ sudo sh get-docker.sh
```
	
* checker l'installation
	```
	$ docker version
	```


## Télécharger des images pour tester



* télécharger image sur DockerHub : whalesay
	* application simple qui permet d'afficher un message
````
$ docker run docker/whalesay cowsay exagone
````	


		
## conteneurs / images
* image : c'est un fichier qui contient l'ensemble des éléments permettant de packager une application.
* conteneur : instance d'une image	
		* avec la même images, on peut créer plusieurs instances/conteneurs
		* chaque conteneur à un identifiant unique qui le diffère de l'autre
* stokage : 
	* images : gourmand en espace disque
	* conteneur : ne prend pas beaucoup de place
		* c'est une instance
		* ce sont de fichiers très légers
		
## installation nginx et mapping de port
* installation : sudo docker run -d nginx
* Quand docker est installé, il créé sa propre interface réseau		
* docker-engine crée une carte-réseau, une interface qui lui est propre avec son adresse ip :172.17.0.1
* le server web nginx est démarré dans le conteneur sur le port 80
	* ce port 80 ne peut être utilisé que dans le conteneur, c'est à dire par une application qui se trouve dans le conteneur
		et qui appelle le serveur web avec l'adredse locale IP_CONTENEUR et sur le port 80 : 172.17.0.1:80
	* si je suis sur la machine hôte, impossible d'accèder. Pourquoi?
		* 192.168.56.101:80 : accès machine virtuelle sur le port 80
		* parce que je suis sur une machine (machine virtuelle) en dehors du conteneur et je veux accéder au port 80,
			alors que le port 80 est utilisé pour accéder à l'application à l'intérieur du conteneur
		* pour pouvoir accèder au serveur web en dehors du conteneur, il faudrait mapper les ports.
		* pour accèdder à un service de l'extérieur à un service déployé à l'intérieur du conteneur, il faudrait
			qu'au démarrage du conteneur, spécifier à docker le mapping entre les ports exposés en interne avec les ports externes.
		
		
### mapping de port		
* au démarrage, on a besoin de mapper le port 80 avec un autre port accessible de l'exterieur
* $ sudo docker run -d -p 8082:80 nginx
	* nginx dans le conteneur démarre sur le port 80 ; on le mappe sur le port 8082
	* quand on est en dehors du conteneur, on peut y accéder en accédant à ce numéro de port : 8082.
	* 192.168.56.101 représente l'adresse IP de la machine virtuelle qui déploie docker Host
	* Accès à ngInx de l'exterieur via la machine virtuelle : http://192.168.56.101:8082/
* on peut démarrer plusieurs containers nginx qui en interne utilise le port 80
	* chacun des containers devra voir son port 80 mapper sur un port distinct de la VM.
	* intéressant pour tester des applications en versions différentes ou une nouvelle et ancienne version applicative
	
## docker et OS
* $ sudo docker run ubuntu
* Que se passe-t-il?
	* l'image est téléchargé et tenté de l'exécuter mais va s'arrêter automatiquement.
	* docker n'est pas fait pour contenir un OS. Il est fait pour envelopper des applications.
	* tous les conteneurs docker ont besoin d'utiliser le noyau Linux comme host
	* toutes les images docker vont se baser sur cette image. 
	* C'est l'image de base qui permet au conteneur d'accéder au noyau. Il a besoin de gérer les processus.
		* pour créer un espace processus pour le containeur.
	
## container mysql

### commande installation

#### générique

```
* $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
````

#### exemple

```	
	docker run --name my2 -e MYSQL_ROOT_PASSWORD=pwd -d mysql
````

### Process d'installation

## exec vs attach
* une fois l'image téléchargé, une instance (un conteneur) est créée.
* le conteneur démarre alors MySql
* Question : comment communiquer avec mysql une fois le conteneur mis en place ?
* MySql : client et Serveur MySql.
	* on veut exécuter le client MySql dans le conteneur
	* on veut entrer en interaction avec le conteneur
	* on va utiliser 'exec' pour rentrer dans le contexte du conteneur et exécuter une commande
		* option -it : 
			* mode interactif : execution le conateneur en donnant la possibilité de rentrer en interaction avec l'utilisateur
			* terminal : 
				* on utilise le terminal utilisé sur vm comme console d'interaction avec le container.
				* commse si on attachait la console au conteneur.
			* sans cette option, le conteneur démarre, mais on ne peut voir aucun message
		* c'est comme si on allait dans le répertoire myqsl/bin et qu'on lançait le client mysql
		
* Commande
	* demande d'exécuter le client mysql dans le conteneur my2
	```	
	docker exec -it my2 mysql --password
	````	
	
## Commande de base

###  diverses
```
* $ docker version
	* voir la version de docker

* $ cat /etc/*relesase*
	* Permet de voir la version de l'OS installé

* $ sudo shutdown -h 0
	* Arrêter la machine
```

### images

```
* $ docker images
	* permet de voir les images installés dans le docker-host
	* chaque image présente à un identifiant unique au niveau du docker-host: [IMAGE ID]
	* le tag indique la version : par défaut, 'latest'

* $ docker rmi <<nom_image>>
	* permet de supprimer une image du host docker.
	* pour ce faire, il faut s'assurer de stopper et supprimer d'abord tous les conteneurs instanciés de cette image

* $ docker pull image
	* docker-pull: permet de télécharger l'image et de la mettre dans le repository local de docker (docker-engine)
	* docker-run: vérifie si présent dans le repository local de docker
		* Si oui, il l'instancie et l'exécute
		* si non, il lancer le téléchargement de l'image (pull + run)

* $ docker run image
	* Fait un pull et exécute l'image

* $ docker run -d image
	* Exemple: $ sudo docker run -d nginx
	* Exécuter une application en arrière plan 
		* sous form de deamon (ex: serveur avec numéro de port)
		* comme service de fond

* $ docker run image:tag
	* Pour spécifier la version
		* Exemple: docker run redis:4.0
```

### conteneur

```
* $ docker ps
	* permet de lister les conteneurs qui sont en cours d'exéution
	* chaque conteneur créé dispose d'une identifiant unique et d'un nom de conteneur

* $ docker ps -a
	* permet de lister tous les conteneurs avec leurs statuts (Up, Exited, Created)
		
* $ docker stop << containerID or Container Name>>
	* permet de stopper un conteneur demarrer ou en cours de démarrage.
	* spécifier le nom nom ou 4 premiers caractère de l'identifiant  

* $ docker rm << containerID or Container Name>>
	* permet de supprimer un container de façon permanente.  

* $  sudo docker logs -t mysql3
	* consulter les logs quand un problème sur le conteneur est constaté
```	