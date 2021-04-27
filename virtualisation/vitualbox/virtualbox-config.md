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
Ou est install� docker-host / docker-engine sur la VM?

## Cr�ation d'adaptateur
* pour cr�er une nouvelle carte r�seau virtuelle.

## Configuration R�seau 

### connexion � Internet en NAT
Aucune configuration n'est � faire pour faire cela
> test connexion internet
$ ping google.com
En NAT, c'est VB qui attribue une adresse IP dynamique � la machine virtuelle
Addresse IP qui est fournit par d�faut � la machine : 10.0.2.15
$ ip a
inet 10.0.2.15/24 brc
Avec cet IP, la machine peut se connecter � internet car VB va faire la translation d'adresse (pour tous les paquets envoy�s) de fa�on � utiliser la carte ethernet physique de la machine.

### Tester les applications en dehors de la machine virtuelle
* En NAT, il y a un pb. Ce n'est pas configur� par d�faut.

### configuration Acces-Pont
* machine virtuelle va utiliser la m�me interface r�seau que la machine physique
* exactement comme s'il s'agit d'une vraie machine physique
* on peut pinger d'une machine � l'autre
* par contre pas d'internet

### configuration R�seau Priv�
Configuration avec plusieurs interface
* interface 1 : NAT pour avoir acc�s Internet
* interface 2 : R�seau priv� h�t� pour permettre � la VM de contacter l'ext�rieur
	* cr�ation d'un r�seau priv� sur la machine virtuelle mais connect� � la machine h�te
	* pour un r�seau priv�, il faut pr�ciser l'adaptateur � utiliser : carte r�seau
		* carte pour pouvoir acc�der au r�seau
	* pour cela, il est possible de cr�er un adaptateur
	
## SSH : connection serveur � distance
```
* sur la version Desktop, il faut installer OpenSsh
* sudo apt-get install openssh-server
* sur la version Server, OpenSsh est d�j� install�
```

## Installation de docker

* il faut s'assurer de la version de Linux

```
> Permet de voir la version de l'OS install�
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

* Installation � partir d'un script qui fait l'installation et mise � jour de Docker.

```
> T�l�charger le script
$ curl -fsSL https://get.docker.com -o get-docker.sh
> installer curl si besoin
$ sudo apt-get install curl
> Ex�cuter le script
$ sudo sh get-docker.sh
```
	
* checker l'installation
	```
	$ docker version
	```


## T�l�charger des images pour tester



* t�l�charger image sur DockerHub : whalesay
	* application simple qui permet d'afficher un message
````
$ docker run docker/whalesay cowsay exagone
````	


		
## conteneurs / images
* image : c'est un fichier qui contient l'ensemble des �l�ments permettant de packager une application.
* conteneur : instance d'une image	
		* avec la m�me images, on peut cr�er plusieurs instances/conteneurs
		* chaque conteneur � un identifiant unique qui le diff�re de l'autre
* stokage : 
	* images : gourmand en espace disque
	* conteneur : ne prend pas beaucoup de place
		* c'est une instance
		* ce sont de fichiers tr�s l�gers
		
## installation nginx et mapping de port
* installation : sudo docker run -d nginx
* Quand docker est install�, il cr�� sa propre interface r�seau		
* docker-engine cr�e une carte-r�seau, une interface qui lui est propre avec son adresse ip :172.17.0.1
* le server web nginx est d�marr� dans le conteneur sur le port 80
	* ce port 80 ne peut �tre utilis� que dans le conteneur, c'est � dire par une application qui se trouve dans le conteneur
		et qui appelle le serveur web avec l'adredse locale IP_CONTENEUR et sur le port 80 : 172.17.0.1:80
	* si je suis sur la machine h�te, impossible d'acc�der. Pourquoi?
		* 192.168.56.101:80 : acc�s machine virtuelle sur le port 80
		* parce que je suis sur une machine (machine virtuelle) en dehors du conteneur et je veux acc�der au port 80,
			alors que le port 80 est utilis� pour acc�der � l'application � l'int�rieur du conteneur
		* pour pouvoir acc�der au serveur web en dehors du conteneur, il faudrait mapper les ports.
		* pour acc�dder � un service de l'ext�rieur � un service d�ploy� � l'int�rieur du conteneur, il faudrait
			qu'au d�marrage du conteneur, sp�cifier � docker le mapping entre les ports expos�s en interne avec les ports externes.
		
		
### mapping de port		
* au d�marrage, on a besoin de mapper le port 80 avec un autre port accessible de l'exterieur
* $ sudo docker run -d -p 8082:80 nginx
	* nginx dans le conteneur d�marre sur le port 80 ; on le mappe sur le port 8082
	* quand on est en dehors du conteneur, on peut y acc�der en acc�dant � ce num�ro de port : 8082.
	* 192.168.56.101 repr�sente l'adresse IP de la machine virtuelle qui d�ploie docker Host
	* Acc�s � ngInx de l'exterieur via la machine virtuelle : http://192.168.56.101:8082/
* on peut d�marrer plusieurs containers nginx qui en interne utilise le port 80
	* chacun des containers devra voir son port 80 mapper sur un port distinct de la VM.
	* int�ressant pour tester des applications en versions diff�rentes ou une nouvelle et ancienne version applicative
	
## docker et OS
* $ sudo docker run ubuntu
* Que se passe-t-il?
	* l'image est t�l�charg� et tent� de l'ex�cuter mais va s'arr�ter automatiquement.
	* docker n'est pas fait pour contenir un OS. Il est fait pour envelopper des applications.
	* tous les conteneurs docker ont besoin d'utiliser le noyau Linux comme host
	* toutes les images docker vont se baser sur cette image. 
	* C'est l'image de base qui permet au conteneur d'acc�der au noyau. Il a besoin de g�rer les processus.
		* pour cr�er un espace processus pour le containeur.
	
## container mysql

### commande installation

#### g�n�rique

```
* $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
````

#### exemple

```	
	docker run --name my2 -e MYSQL_ROOT_PASSWORD=pwd -d mysql
````

### Process d'installation

## exec vs attach
* une fois l'image t�l�charg�, une instance (un conteneur) est cr��e.
* le conteneur d�marre alors MySql
* Question : comment communiquer avec mysql une fois le conteneur mis en place ?
* MySql : client et Serveur MySql.
	* on veut ex�cuter le client MySql dans le conteneur
	* on veut entrer en interaction avec le conteneur
	* on va utiliser 'exec' pour rentrer dans le contexte du conteneur et ex�cuter une commande
		* option -it : 
			* mode interactif : execution le conateneur en donnant la possibilit� de rentrer en interaction avec l'utilisateur
			* terminal : 
				* on utilise le terminal utilis� sur vm comme console d'interaction avec le container.
				* commse si on attachait la console au conteneur.
			* sans cette option, le conteneur d�marre, mais on ne peut voir aucun message
		* c'est comme si on allait dans le r�pertoire myqsl/bin et qu'on lan�ait le client mysql
		
* Commande
	* demande d'ex�cuter le client mysql dans le conteneur my2
	```	
	docker exec -it my2 mysql --password
	````	
	
## Commande de base

###  diverses
```
* $ docker version
	* voir la version de docker

* $ cat /etc/*relesase*
	* Permet de voir la version de l'OS install�

* $ sudo shutdown -h 0
	* Arr�ter la machine
```

### images

```
* $ docker images
	* permet de voir les images install�s dans le docker-host
	* chaque image pr�sente � un identifiant unique au niveau du docker-host: [IMAGE ID]
	* le tag indique la version : par d�faut, 'latest'

* $ docker rmi <<nom_image>>
	* permet de supprimer une image du host docker.
	* pour ce faire, il faut s'assurer de stopper et supprimer d'abord tous les conteneurs instanci�s de cette image

* $ docker pull image
	* docker-pull: permet de t�l�charger l'image et de la mettre dans le repository local de docker (docker-engine)
	* docker-run: v�rifie si pr�sent dans le repository local de docker
		* Si oui, il l'instancie et l'ex�cute
		* si non, il lancer le t�l�chargement de l'image (pull + run)

* $ docker run image
	* Fait un pull et ex�cute l'image

* $ docker run -d image
	* Exemple: $ sudo docker run -d nginx
	* Ex�cuter une application en arri�re plan 
		* sous form de deamon (ex: serveur avec num�ro de port)
		* comme service de fond

* $ docker run image:tag
	* Pour sp�cifier la version
		* Exemple: docker run redis:4.0
```

### conteneur

```
* $ docker ps
	* permet de lister les conteneurs qui sont en cours d'ex�ution
	* chaque conteneur cr�� dispose d'une identifiant unique et d'un nom de conteneur

* $ docker ps -a
	* permet de lister tous les conteneurs avec leurs statuts (Up, Exited, Created)
		
* $ docker stop << containerID or Container Name>>
	* permet de stopper un conteneur demarrer ou en cours de d�marrage.
	* sp�cifier le nom nom ou 4 premiers caract�re de l'identifiant  

* $ docker rm << containerID or Container Name>>
	* permet de supprimer un container de fa�on permanente.  

* $  sudo docker logs -t mysql3
	* consulter les logs quand un probl�me sur le conteneur est constat�
```	