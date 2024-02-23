## Commande de base

[retour](../docker.md)

###  diverses

<a href="https://docs.docker.com/engine/reference/commandline/docker/" target="_blank">docker commandes</a>

#### <a href="https://docs.docker.com/engine/reference/commandline/version/" target="_blank">docker version</a>
<pre>
	* voir la version client et serveur de Docker.
	* permet de vérifier le bon fonctionnement de docker

</pre>

#### <a href="https://docs.docker.com/engine/reference/commandline/info/" target="_blank">docker info</a>
<pre>
* Détail sur le docker-engine
- nombre de conteneurs actuellement en fonctonnement
- nombre d'images stockées dans Docker
</pre>

### images

#### docker images
<pre>
* $ docker images
	* permet de voir les images installées dans le docker-host
	* chaque image présente à un identifiant unique au niveau du docker-host: [IMAGE ID]
	* le tag indique la version : par défaut, 'latest'
</pre>

#### docker image ls
<pre>
* voir la liste des images
</pre>

#### docker image history < NAME/ID >
<pre>
* $ docker image history <i> << nom_image >> </i>
	* montrer les différentes couches de modifications qui ont été appliquées à l'image Docker
</pre>

#### docker image inspect < NAME/ID >
<pre>
* $ docker image inspect <i> << nom_image >> </i>
	* retourne au format JSON les métadonnées correspondantes à l'image inspectée
	- ports exposés
	- id de l'image
	- variables d'environnement
	- commande lancée au démarrage du conteneur
</pre>

#### docker rmi
<pre>
* $ docker rmi <i> << nom_image >> </i>
	* permet de supprimer une image du host docker.
	* pour ce faire, il faut s'assurer de stopper et supprimer d'abord tous les conteneurs instanci�s de cette image
</pre>

#### docker pull image
<pre>
* $ docker pull image
	* docker-pull: permet de t�l�charger l'image et de la mettre dans le repository local de docker (docker-engine)
	* docker-run: v�rifie si pr�sent dans le repository local de docker
		* Si oui, il l'instancie et l'ex�cute
		* si non, il lancer le t�l�chargement de l'image (pull + run)
</pre>

#### docker image build -t < IMAGE_NAME >:< TAG > .
<pre>
$ docker image build -t demo-web-spb .

	* permet de constuire une image à partir d'un dockerfile
	* -t : donner un nom à l'image (taguée l'image)
	* . : specifier le dossier ou se trouver le fichier Dockerfile
</pre>

#### docker image tag
<pre>
λ docker image tag < SOURCE_IMAGE>:< TAG > < TARGET_IMAGE>:< TAG >

	* permet de créer une image à partir d'une autre image

	TAG: correspond à un pointeur vers un commit spécifique sur une image
	Le TAG "latest" correspond au tag par défaut si aucun n'est spécifié

</pre>

#### docker image push
<pre>
λ docker image push < IMAGE_NAME >

	* UPLOAD les modifications des couches de l'image vers Docker Hub
		par défaut (on peu changer lde dépôt de destination)

</pre>

#### docker login
<pre>
λ docker login

* permet de s'authentifier auprès de Docker Hub ou autre dépot
* on peut observer le fichier créé: cat .docker/config.json
</pre>

#### docker logout
<pre>
λ docker logout

* permet de supprimer le fichier d'autentification créer à 
	partir de la commande docker login.
</pre>

### reseau

#### DNS
<pre>
Protocole pour la résolution d'adresse IP
* résolution de nom directe: nom de domaine ==> IP
* résoluiton de nom inverse: IP ==> nom de domaine

<b>Important</b>:
Sur docker, le DNS qui permet au conteneur de communiquer entre eux par le nom,
n'est dipsonible que sur les nouveaux réseaux.
Il n'est pas disponible sur les réseaux existant (Bridge notamment).
Un ping ne marchera pas.

Tous les <b>nouveaux</b> réseaux sont automatiquement rattachés au démon DNS de docker.
</pre>

#### DHCP / IPv4
<pre>
* Serveur DHCP : box internet par exemple
	- permet d'attribuer une adresse IPv4 à une machine dès lors que cette
		cette dernière est connecté via wifi ou cable RJ45 à la box.

* Service qui permet d'attribuer une adresse IPv4 privée au conteneur
- adresses IPV4 publiques : adresse qu'on loue à l'opérateur internet
- adresses IPV4 privées ne font pas parties du routage sur Internet:
  Leur plage est la suivante :
	- 10.0.0.0 => 10.255.255.255
	- 172.16.0.0 => 172.31.255.255
	- 192.168.0.0 => 192.168.255.255
</pre>

#### NAT
<pre>
Le NAT permet de faire la traduction d'adresse IPv4 privées en adresse IPV4 publiques

En général un réseau privé à des adresses en 192.168
C'est la box qui va NATé (lié) l'adresse privée v4 de l'ordinateur pour la 
traduire en adresse IPv4 publique louée auprès de l'opérateur.
La box fait office de routeur NAT

Le NAT permet de 
- convertir les adresses réseaux.
- limiter la consommation des adrsses IPv4 publiques car on
	plein d'équipement avec des adresses IPv4 privées qui peuvent se connecter
	avec la même adresse IPv4 publiques sur internet
- il fonctionne à la périphérie d'un réseau d'extrémité
	- soit via un firewall 
	- soit un routeur (principalement la box)
- le routeur de périphérie fait la traduction

</pre>

#### Docker-Engine
<pre>
Le docker engine dispose :
- d'un daemon/service DNS:
	- permet de faire de la résolution de nom et d'appeler les conteneurs
		par le nom
- d'un deomon/service DHCP:
	- permet d'attribuer une adresse IPv4 au conteneur
- d'un firewall virtuel effectuant du NAT

- Un conteneur dispose alors de sa propre IP.
- Quand on le démarrer on peut lui affecter un nom qui
	peut étre géré par le DNS de docker.
</pre>

#### réseau de docker
<pre>
Le réseau "bridge"
parfois appelé Docker0 correspond au réseau virtuel par défaut
qui est NATé derrière l'adresse IP de l'hôte.
==> permet de connecter le conteneur avec la machine physique

Le réseau "host"
correspond au réseau qui attache les conteneurs directement à l'hôte
(sans NAT) ce qui est franchement délétère au niveau de la sécurité
mais augmente les performances
attache le conteneur directement à la carte réseau

Le réseau "None"
Correspond au réseau qui enlève l'interface eth0 du conteneur et ne 
laisse que l'interface localhost d'existante

<b>IMPORTANT</b>
Les réseaux par défaut ne sont pas rattachés au DNS. 


Chaque réseau de DOCKER peut communiquer avec 
- l'adresse IP de la machine physique (ordinateur ou serveur)
	 grâce à un firewall virtuel effectuant du NAT
- le firewall virtuel fait du NAT entre l'adresse IP du conteneur 
		et l'adresse IP publique de la box
- tous les conteneurs situés sur le même réseau virtuel peuvent 
	- discuter entre eux 
		pas besoin de faire du publish (-p) pour faire communiquer entre eux
		les conteneurs
	- avec l'ordinateur aussi parce que le réseau bridge est 
		interconnecté avec la carte réseau de l'ordinateur
		<b>important</b>: ici il faut faire un publish pour que le conteneur
		soit accessble de l'exterieur
</pre>

#### Règle générique
<pre>
* un conteneur est instancié dans un réseau
* le réseau par défaut est le réseau bridge
* le docker engine à son propre réseau avec sa plage d'adresse
* le réseau bridge est un sous réseau du docker-engine
* tout nouveau réseau est un sous réseau du docker-engine
</pre>

#### création de nouveau réseau

#### Commandes

##### <a href="https://docs.docker.com/engine/reference/commandline/network_ls/" target="_blank">docker network ls</a>
<pre>
permet de lister les réseaux Docker qui existent
Par défaut ils sont au nombre de 3: Bridget, Host et None

λ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
a952d7e8f6d9        bridge              bridge              local
a2cd5a11094e        host                host                local
39b9d72696d0        none                null                local

</pre>

##### <a href="https://docs.docker.com/engine/reference/commandline/network_inspect/" target="_blank">docker network inspect NETWORK_NAME</a> 
<pre>
affiche les détails sur le réseau Docker indiqué et montre 
les conteneurs qui lui sont rattachés
</pre>

##### <a href="" target="_blank">docker network create NETWORK_NAME</a>
<pre>
λ docker network create network_test
	permet de créer un nouveau réseau auquel pourront s'attacher les containers
	le driver par défaut auquel sera attaché le nouveau réseau est le bridge
	qui permet simplement de pouvoir attacher un sous-réseau au nouveau réseau
	créé.
</pre>

##### docker container run --network
<pre>
λ docker container run --network network_test --name webserver4 nginx
	permet de démarrer un conteneur en le rattachant au réseau
</pre>

##### <a href="https://docs.docker.com/engine/reference/commandline/network_connect/" target="_blank">docker network connect NETWORK_NAME</a>
<pre>
λ docker network connect network_test nginx_server
	permet d'attacher un container à un nouveau réseau
		mais n'enlève pas l'attachement au réseau précédent
</pre>

##### <a href="https://docs.docker.com/engine/reference/commandline/network_disconnect/" target="_blank">docker network disconnect NETWORK_NAME</a>
<pre>
λ docker network disconnect network_test nginx_server
	permet de détacher dynamiquement la carte réseau d'un conteneur
</pre>

### conteneur

#### docker container
<pre>
commande pour les containers
</pre>

##### <a href="https://docs.docker.com/engine/reference/commandline/run/" target="_blank"> docker container run</a>
<pre>
* démarre un <b>nouveau</b> container
</pre>

<pre>
$ docker container run --publish 80:80 nginx

	<b>publish</b>: expose le port 80 de la machine hôte et redirige tout le rafic
	à l'application exécutée dans le conteneur sur on port 80

$ docker container run --publish 80:80  --detach nginx
	detach permet d'exécuter le démarrage du container en arrière plan

$ docker container run --publish 80:80  --detach --name nginx_webserver nginx	
</pre>

###### docker container run -d < IMAGE_NAME >
<pre>
$ docker run -d image

	* -d : Exécuter une application en arrière plan 
		* Exemple: $ docker container run -d nginx
		* sous form de deamon (ex: serveur avec numéro de port)
		* comme service de fond

	* --name : nom du conteneur
		* Exemple : $ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
</pre>

###### docker container run < IMAGE_NAME >:< TAG >
<pre>
$ docker run image:tag

	* Pour spécifier la version
	* Exemple: docker image run redis:4.0
</pre>

###### docker container run --rm < IMAGE_NAME >
<pre>		
$ docker run --rm image

* permet de supprimer le conteneur, une fois celui-ci terminé et libérer de la taille sur le disque.
	* bien pour les conteneurs utilisé pour très peu de temps, juste pour accomplir quelque chose
		* comme compilé une application
		* faire des tess
		* lancer une commande de base
</pre>	


##### docker container ls
<pre>
$ docker ls
* permet de lister les conteneur en cours d'exécution

$ docker container ls -a 
tous les conteneurs, y compris ceux arrêtés
</pre>

##### docker container start < NAME/ID >
<pre>
$ docker container start nginx_webserver
	permet de démarrer un conteneur existant
</pre>

##### docker container stop < NAME/ID >
<pre>
$ docker container stop nginx_webserver
	permet d'arrêter un conteneur
</pre>

##### docker container rm < NAME/ID >
<pre>
$ docker container rm nginx_webserver 
	permet d'arrêter un conteneur

$ docker container rm nom_conteneur1 nom_conteneur_2
	permet de supprimer plusieurs conteneurs

$ docker container rm -f < Name/ID >	
	permet de supprimer définitivement un conteneur
	arrêtre et supprimer le conteneur
	-f: force
</pre>

##### docker container logs < NAME/ID >
<pre>
$ docker container logs nginx_webserver
	permet d'afficher les logs du conteneur

$ docker container logs --tail=10 -f nginx_server2	
</pre>

##### docker container top < NAME/ID >
<pre>
$ docker container logs nginx_webserver
	permet d'afficher le processus en cours d'exécution sur du conteneur
</pre>

##### <a href="https://docs.docker.com/engine/reference/commandline/container_inspect/" target="_blank">docker container inspect NAME|ID</a>
<pre>
$ docker container inspect nginx_webserver
	donne les informations au format json sur le conteneur

<a href="https://docs.docker.com/config/formatting/#template-functions" target="blank"><b>Format</b></a>

$ docker container inspect --format '{{.NetworkSettings.IPAddress }}' < NAME/ID >
	Permet de n'afficher que la ligne correspondante à l'adresse IP du conteneur
</pre>

##### docker container stats < NAME/ID >
<pre>
$ docker container stats nginx_webserver
	statistiques concernant l'utilisation RAM CPU
</pre>

##### docker container run -it bash
<pre>
$ docker container start -it --name nginx_server --publish 8089:80 nginx bash
	-t: simuler un vrai terminal (comme en SSH)
	-i: mode interactif pour garder la session ouverte et recevoir l'output
		des commandes que l'on tape
	-bash: donne un terminal existant à l'interieur du conteneur afin de 
		pouvoir y exécuter des commandes interprétables

==> conteneur lancé avec la commande bash
si on arrête le bash, le conteneur s'arrête.
</pre>

##### docker container exec -it
<pre>
$ docker container exec -it nginx_server bash
	 exécute la commande bash en mode interactif à l'interieur du conteneur
	 sur alpine, bash n'est pas disponible, utiliser sh
</pre>

##### <a href="https://docs.docker.com/engine/reference/commandline/container_port/" target="_blank">docker container port</a>
<pre>
permet de savoir à quel port de la machine le conteneur est lié
</pre>

#### docker ps
<pre>
* $ docker ps
	* permet de lister les conteneurs qui sont en cours d'ex�ution
	* chaque conteneur cr�� dispose d'une identifiant unique et d'un nom de conteneur
</pre>

#### docker ps -a
<pre>
* $ docker ps -a
	* permet de lister tous les conteneurs avec leurs statuts (Up, Exited, Created)
</pre>

#### docker stop
<pre>		
* $ docker stop << containerID or Container Name>>
	* permet de stopper un conteneur demarrer ou en cours de d�marrage.
	* sp�cifier le nom nom ou 4 premiers caract�re de l'identifiant  
</pre>

#### docker restart
<pre>
* $ docker restart << containerID or Container Name >>
</pre>

#### docker rm
<pre>
* $ docker rm << containerID or Container Name>>
	* permet de supprimer un container de fa�on permanente.  
</pre>

#### docker logs
<pre>
* $ sudo docker logs -t mysql3
	* consulter les logs quand un probl�me sur le conteneur est constat�
</pre>

#### docker exec
<pre>
* <b>$ sudo docker exec << containerID or Container Name >> << fonction >></b>
</pre>
<pre>
* exec (explication)
	* une fois l'image t�l�charg�, une instance (un conteneur) est cr��e.
	* le conteneur d�marre alors MySql
	* <i>Question</i> : <b>comment communiquer avec mysql une fois le conteneur mis en place ?</b>
	* MySql : client et Serveur MySql.
		* on veut <b>ex�cuter le client MySql dans le conteneur</b>
		* on veut entrer en interaction avec le conteneur
		* on va utiliser 'exec' pour rentrer dans le contexte du conteneur et ex�cuter une commande
		* c'est comme si on allait dans le r�pertoire myqsl/bin et qu'on lan�ait le client mysql

* <i>exemple</i> : <b>docker exec -it my2 mysql --password</b>
	* demande d'ex�cuter le client mysql dans le conteneur my2
	
* option -it : 
	* i: mode interactif : execution le conateneur en donnant la possibilit� de rentrer en interaction avec l'utilisateur
	* t: terminal : 
		* on utilise le terminal utilis� sur vm comme console d'interaction avec le container.
		* commse si on attachait la console au conteneur.
	* sans cette option, le conteneur d�marre, mais on ne peut voir aucun message

</pre>
	
#### docker attach	
<pre>	
* <b>$ sudo docker attach << containerID or Container Name >></b>
	* comment attacher une console � un conteneur
	* util pour aller voir ce qui se passe dans un conteneur d�marr� avec l'option -d
</pre>

##### exemple
<pre>
* on d�marre en t�che de font alpine avec un ping
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
* permet d'avoir plus de d�tail sur le container au format JSon
</pre>

### Mongo

#### Cr�ation conteneur
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

##### g�n�rique
<pre>
* <b>$ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag</b>
</pre>

#####  minimal
<pre>
* <b>$ docker run --name my2 -e MYSQL_ROOT_PASSWORD=root -d mysql</b>
	* --name : nom du conteneur
	* mysql: r�f�rence l'image
</pre>

##### avec volume
<pre>
* <b>$ docker run -v /opt/datas/mysql:/var/lib/mysql --name my2 -e MYSQL_ROOT_PASSWORD=root -d mysql</b>
	* --name : nom du conteneur
	* mysql: r�f�rence l'image
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
* image linux r�duite
* contient l'essentiel pour <b>ex�cuter les scripts</b> ou <b>cmd sur shell</b>
</pre>

<pre>
$ <b>sudo docker run --rm alpine ping 8.8.8.8</b>
	* -- rm le conteneur est d�truit en fin de traitement
</pre>

#### Volume : conteneur Linux / Alpine
<pre>
# consulter le fichier datas via Alpine
	* on ouvre le conteneur sur le shell avec interaction
	* on inspecte le folder data pr�alablement mapper
> <b>docker run -it -v /datas:/data alpine /bin/sh</b>
</pre>

<pre>
# lancer un conteneur et executer la commande
	* sans interaction
> <b>docker run -v /datas:/data alpine ls /data</b>
</pre>

