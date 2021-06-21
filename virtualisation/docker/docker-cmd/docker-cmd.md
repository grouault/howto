## Commande de base

[retour](../docker.md)

###  diverses

#### docker version
<pre>
* $ docker version
	* voir la version de docker
</pre>

### images

#### docker images
<pre>
* $ docker images
	* permet de voir les images installés dans le docker-host
	* chaque image présente à un identifiant unique au niveau du docker-host: [IMAGE ID]
	* le tag indique la version : par défaut, 'latest'
</pre>

#### docker rmi
<pre>
* $ docker rmi <i> << nom_image >> </i>
	* permet de supprimer une image du host docker.
	* pour ce faire, il faut s'assurer de stopper et supprimer d'abord tous les conteneurs instanciés de cette image
</pre>

#### docker pull image
<pre>
* $ docker pull image
	* docker-pull: permet de télécharger l'image et de la mettre dans le repository local de docker (docker-engine)
	* docker-run: vérifie si présent dans le repository local de docker
		* Si oui, il l'instancie et l'exécute
		* si non, il lancer le téléchargement de l'image (pull + run)
</pre>

#### docker run image
<pre>
* $ docker run image
	* Fait un pull et exécute l'image
</pre>

#### docker run -d image
<pre>
* $ docker run -d image
	* -d : Exécuter une application en arrière plan 
		* Exemple: $ sudo docker run -d nginx
		* sous form de deamon (ex: serveur avec numéro de port)
		* comme service de fond
	* --name : nom du coneneur
		* Exemple : $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
</pre>

#### docker run image:tag
<pre>
* $ docker run image:tag
	* Pour spécifier la version
	* Exemple: docker run redis:4.0
</pre>

#### docker run --rm image
<pre>		
* $ docker run --rm image
	* permet de supprimer le conteneur, une fois celui-ci terminé et libérér de la taille sur le disque.
	* bien pour les conteneurs utilisé pour très peu de temps, juste pour accomplir quelque chose
		* comme compilé une application
		* faire des tess
		* lancer une commande de base
</pre>	

#### docker build
<pre>
* $ docker build -t demo-web-spb .
	* permet de constuire une image à partir d'un dockerfile
	* -t : donner un nom à l'image
	* . : specifier le dossier ou se trouver le fichier Dockerfile
</pre>

### conteneur

#### docker ps
<pre>
* $ docker ps
	* permet de lister les conteneurs qui sont en cours d'exéution
	* chaque conteneur créé dispose d'une identifiant unique et d'un nom de conteneur
</pre>

#### docker ps -a
<pre>
* $ docker ps -a
	* permet de lister tous les conteneurs avec leurs statuts (Up, Exited, Created)
</pre>

#### docker stop
<pre>		
* $ docker stop << containerID or Container Name>>
	* permet de stopper un conteneur demarrer ou en cours de démarrage.
	* spécifier le nom nom ou 4 premiers caractère de l'identifiant  
</pre>

#### docker restart
<pre>
* $ docker restart << containerID or Container Name >>
</pre>

#### docker rm
<pre>
* $ docker rm << containerID or Container Name>>
	* permet de supprimer un container de façon permanente.  
</pre>

#### docker logs
<pre>
* $ sudo docker logs -t mysql3
	* consulter les logs quand un problème sur le conteneur est constaté
</pre>

#### docker exec
<pre>
* <b>$ sudo docker exec << containerID or Container Name >> << fonction >></b>
</pre>
<pre>
* exec (explication)
	* une fois l'image téléchargé, une instance (un conteneur) est créée.
	* le conteneur démarre alors MySql
	* <i>Question</i> : <b>comment communiquer avec mysql une fois le conteneur mis en place ?</b>
	* MySql : client et Serveur MySql.
		* on veut <b>exécuter le client MySql dans le conteneur</b>
		* on veut entrer en interaction avec le conteneur
		* on va utiliser 'exec' pour rentrer dans le contexte du conteneur et exécuter une commande
		* c'est comme si on allait dans le répertoire myqsl/bin et qu'on lançait le client mysql

* <i>exemple</i> : <b>docker exec -it my2 mysql --password</b>
	* demande d'exécuter le client mysql dans le conteneur my2
	
* option -it : 
	* i: mode interactif : execution le conateneur en donnant la possibilité de rentrer en interaction avec l'utilisateur
	* t: terminal : 
		* on utilise le terminal utilisé sur vm comme console d'interaction avec le container.
		* commse si on attachait la console au conteneur.
	* sans cette option, le conteneur démarre, mais on ne peut voir aucun message

</pre>
	
#### docker attach	
<pre>	
* <b>$ sudo docker attach << containerID or Container Name >></b>
	* comment attacher une console à un conteneur
	* util pour aller voir ce qui se passe dans un conteneur démarré avec l'option -d
</pre>

##### exemple
<pre>
* on démarre en tâche de font alpine avec un ping
* on attache la console pour voir ce qui se passe
</pre>
<pre>
grouault@ub-server:~$ <b>sudo docker run --rm -d alpine ping 8.8.8.8</b>
[sudo] password for grouault:
98353d78c415f367573da5dc8c3ff6bb4a4d2a8c05d3d893c1f029f446062cf7
grouault@ub-server:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND          CREATED          STATUS         PORTS     NAMES
98353d78c415   alpine    "ping 8.8.8.8"   10 seconds ago   Up 8 seconds             inspiring_meitner
grouault@ub-server:~$ <b>sudo docker attach 9835</b>
64 bytes from 8.8.8.8: seq=127 ttl=117 time=5.341 ms
64 bytes from 8.8.8.8: seq=128 ttl=117 time=7.021 ms
64 bytes from 8.8.8.8: seq=129 ttl=117 time=5.779 ms
</pre>

#### docker inspect
<pre>
* <b>$ sudo docker inspect << containerID or Container Name >></b>
* permet d'avoir plus de détail sur le container au format JSon
</pre>

### Mongo

#### Création conteneur
<pre>
> docker run -d --name mongodb -p 27017:27017 mongo
> docker logs mongodb
> docker inspect mongodb
</pre>

#### Suppression conteneur
<pre>
* Suppression conteneur en forcant l'arret et suppression du volume
> docker rm -fv mongodb
</pre>

#### Avec Volume
<pre>
> docker run -d --name mongodb -p 27017:27017 mongo
> docker run -d --name mongodb -p 27017:27017 -v c:/docker/datas/mongo/base-test:/data/db mongo
> docker exec -it mongodb /bin/sh
==> Ne fonctionne pas
> docker volume create --name=mongodata
> docker run -d --name mongodb -p 27017:27017 -v mongodata:/data/db mongo
</pre>

### MYSQL

##### générique
<pre>
* <b>$ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag</b>
</pre>

#####  minimal
<pre>
* <b>$ docker run --name my2 -e MYSQL_ROOT_PASSWORD=root -d mysql</b>
	* --name : nom du conteneur
	* mysql: référence l'image
</pre>

##### avec volume
<pre>
* <b>$ docker run -v /opt/datas/mysql:/var/lib/mysql --name my2 -e MYSQL_ROOT_PASSWORD=root -d mysql</b>
	* --name : nom du conteneur
	* mysql: référence l'image
</pre>

##### execution du client mysql
<pre>
> <b>docker exec -it my2 mysql --password</b>
</pre>

##### execution commande sans lancer le conteneur
<pre>
> <b>docker exec -it my2 /bin/sh</b>
</pre>

##### mapping port
<pre>
> <b>docker run -e MYSQL_ROOT_PASSWORD=root -p 11800:3306 mysql</b>
</pre>

##### mapping port avec version 5.7.27
> docker run -e MYSQL_ROOT_PASSWORD=root -p 11800:3306 mysql:5.7.27
</pre>

### Alpine

#### principe
<pre>
* image linux réduite
* contient l'essentiel pour <b>exécuter les scripts</b> ou <b>cmd sur shell</b>
</pre>

<pre>
$ <b>sudo docker run --rm alpine ping 8.8.8.8</b>
	* -- rm le conteneur est détruit en fin de traitement
</pre>

#### Volume : conteneur Linux / Alpine
<pre>
# consulter le fichier datas via Alpine
	* on ouvre le conteneur sur le shell avec interaction
	* on inspecte le folder data préalablement mapper
> <b>docker run -it -v /datas:/data alpine /bin/sh</b>
</pre>

<pre>
# lancer un conteneur et executer la commande
	* sans interaction
> <b>docker run -v /datas:/data alpine ls /data</b>
</pre>

