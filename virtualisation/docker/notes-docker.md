## Docker

### Menu
* [installation](installation-docker.md)

###
Questions : 
* o� sont stock�es les images docker physiquement ?


## Images a conna�tre

#### alpine

```
$ sudo docker run --rm alpine ping 8.8.8.8
```	

```
* image linux r�duite
* contient l'essentiel pour ex�cuter les scripts ou cmd sur shell
* -- rm le conteneur est d�truit en fin de traitement
```

#### mysql

#### commande installation

##### g�n�rique

```
* $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
````

##### exemple

######  minimal
```	
* $	docker run --name my2 -e MYSQL_ROOT_PASSWORD=root -d mysql
	* --name : nom du conteneur
	* mysql: r�f�rence l'image
````

###### avec volume
```	
* $	docker run -v /opt/datas/mysql:/var/lib/mysql --name my2 -e MYSQL_ROOT_PASSWORD=root -d mysql
	* --name : nom du conteneur
	* mysql: r�f�rence l'image
````


### docker-engine
???

### docker-host
???	
	
### conteneurs / images

#### image : 
```	
* c'est un fichier qui contient l'ensemble des �l�ments permettant de packager une application.
* elles sont stock�es dans le docker-engine	
```
	
#### image : succession de couches

```
* $ sudo docker run ubuntu
* Que se passe-t-il?
	* l'image est t�l�charg� et tent� de l'ex�cuter mais va s'arr�ter automatiquement.
	* docker n'est pas fait pour contenir un OS. Il est fait pour envelopper des applications.
	* tous les conteneurs docker ont besoin d'utiliser le noyau Linux comme host
	* toutes les images docker vont se baser sur cette image. 
	* C'est l'image de base qui permet au conteneur d'acc�der au noyau. Il a besoin de g�rer les processus.
		* pour cr�er un espace processus pour le conteneur.
		
* docker utiliser la notion de couche pour t�l�charger les images
	* l'image de base est ubuntu pour chaque appliation t�l�charg�e
	* mais docker n'est pas fait pour faire tourner un OS 
	* donc cette couche seule ne fonctionne pas
	* une image est une succession de couches qui permettent de d�marrer une application
```	
	
	

#### conteneur 

##### instance d'une image
	* avec la m�me images, on peut cr�er plusieurs instances/conteneurs
	* chaque conteneur � un identifiant unique qui le diff�re de l'autre
	
##### d�fintion
	* il faut consid�rer le conteneur comme l'instance d'une application
	* cette application est li�e � une image
	* l'id�e est de cr�er une image custom, o� son li�s :
		* fichier de configuration
		* varaibles d'environnement
		* fichiers de donn�es
		*...
	* ainsi, l'image contient une configuation de base et pour utiliser l'application,
		il suffit d'ex�cuter le conteneur.

#### stokage : 
	* images : gourmand en espace disque
	* conteneur : ne prend pas beaucoup de place
		* c'est une instance
		* ce sont de fichiers tr�s l�gers

### mapping de port
		
#### installation nginx et mapping de port

```
* installation : sudo docker run -d nginx
* Quand docker est install�, il cr�� sa propre interface r�seau		
* docker-engine cr�e une carte-r�seau, une interface qui est propre au conteneur avec son adresse ip :172.17.0.1
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
```		
		
#### mapping de port	

```	
* au d�marrage, on a besoin de mapper le port 80 avec un autre port accessible de l'exterieur
* $ sudo docker run -d -p 8082:80 nginx
	* nginx dans le conteneur d�marre sur le port 80 ; on le mappe sur le port 8082
	* quand on est en dehors du conteneur, on peut y acc�der en acc�dant � ce num�ro de port : 8082.
	* 192.168.56.101 repr�sente l'adresse IP de la machine virtuelle qui d�ploie docker Host
	* Acc�s � ngInx de l'exterieur via la machine virtuelle : http://192.168.56.101:8082/
* on peut d�marrer plusieurs containers nginx qui en interne utilise le port 80
	* chacun des containers devra voir son port 80 mapper sur un port distinct de la VM.
	* int�ressant pour tester des applications en versions diff�rentes ou une nouvelle et ancienne version applicative
```


#### mapping de volume
	
![volume](16-commande-volume.PNG)	

	
### Commande de base

####  diverses
```
* $ docker version
	* voir la version de docker

* $ cat /etc/*relesase*
	* Permet de voir la version de l'OS install�

* $ sudo shutdown -h 0
	* Arr�ter la machine
```

#### images

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
	* -d : Ex�cuter une application en arri�re plan 
		* Exemple: $ sudo docker run -d nginx
		* sous form de deamon (ex: serveur avec num�ro de port)
		* comme service de fond
	* --name : nom du coneneur
		* Exemple : $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag

* $ docker run image:tag
	* Pour sp�cifier la version
		* Exemple: docker run redis:4.0
		
* $ docker run --rm image
	* permet de supprimer le conteneur, une fois celui-ci termin� et lib�r�r de la taille sur le disque.
	* bien pour les conteneurs utilis� pour tr�s peu de temps, juste pour accomplir quelque chose
		* comme compil� une application
		* faire des tess
		* lancer une commande de base
	
```

#### conteneur

```
* $ docker ps
	* permet de lister les conteneurs qui sont en cours d'ex�ution
	* chaque conteneur cr�� dispose d'une identifiant unique et d'un nom de conteneur

* $ docker ps -a
	* permet de lister tous les conteneurs avec leurs statuts (Up, Exited, Created)
		
* $ docker stop << containerID or Container Name>>
	* permet de stopper un conteneur demarrer ou en cours de d�marrage.
	* sp�cifier le nom nom ou 4 premiers caract�re de l'identifiant  

* $ docker restart << containerID or Container Name >>

* $ docker rm << containerID or Container Name>>
	* permet de supprimer un container de fa�on permanente.  

* $ sudo docker logs -t mysql3
	* consulter les logs quand un probl�me sur le conteneur est constat�

* $ sudo docker exec << containerID or Container Name >> << fonction >>
	* exemple : docker exec -it my2 mysql --password
		* demande d'ex�cuter le client mysql dans le conteneur my2
	* option -it : 
		* mode interactif : execution le conateneur en donnant la possibilit� de rentrer en interaction avec l'utilisateur
		* terminal : 
			* on utilise le terminal utilis� sur vm comme console d'interaction avec le container.
			* commse si on attachait la console au conteneur.
		* sans cette option, le conteneur d�marre, mais on ne peut voir aucun message
	* exec (explication)
		* une fois l'image t�l�charg�, une instance (un conteneur) est cr��e.
		* le conteneur d�marre alors MySql
		* Question : comment communiquer avec mysql une fois le conteneur mis en place ?
		* MySql : client et Serveur MySql.
			* on veut ex�cuter le client MySql dans le conteneur
			* on veut entrer en interaction avec le conteneur
			* on va utiliser 'exec' pour rentrer dans le contexte du conteneur et ex�cuter une commande
			* c'est comme si on allait dans le r�pertoire myqsl/bin et qu'on lan�ait le client mysql
			
* $ sudo docker attach << containerID or Container Name >>
	* comment attacher une console � un conteneur
	* util pour aller voir ce qui se passe dans un conteneur d�marr� avec l'option -d
	
* $ sudo docker inspect << containerID or Container Name >>
	* permet d'avoir plus de d�tail sur le container au format JSon
	
```