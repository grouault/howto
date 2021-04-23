## Application Monolithique
- application développée en un seul bloc (war, jar, ear, dll)
- déployé sur un **serveur d'application** (conteneur web + framework d'inversion de contrôle)
- Principe d'**inversion de contrôle** : se concentrer sur les aspects fonctionnels pendant que le framework s'occupe des aspects techniques

### Architecture
- SGBD: relationnel | BigData (MongoDB, ES)
- L'application se compose de plusieurs couches:
	* **couche métier** : implémentation des spécifications fonctionnelles
	* **couche technique** : couche d'accès aux données (Spring Data | JPA | Hibernate)
	* **couche Web** : Rendu côté serveur (Spring MVC - Html géré côté serveur (Moteur de template))
	* **couche Web** : Rendu côté client (Basé sur les WebServices - Application Distribuée)

### Système Distribuée
* application basée sur RMI, IOP : application distribuée mais utilisant que du Java
* application basée sur Corba : application distribuée mais multilanguage, multiplateforme (jusqu'aux années 2000)
* application basée sur les WebService : plus simple, plus léger, plus facile à mettre en place.
	- Communication synchrone 
	- Communication asynchrone avec spécification JMS : ActiveMQ, Kafka, RabbitMQ,...

### Inconvénient
* centralisation des besoins fonctionnels (même processus)
	- si une fonction bloque, toute l'application est bloquée
* réalisées dans une seule techno 
	- toute le monde doit être formé sur les technos
	- fonctionnalité plus apte à être réalisé avec certaines technos
* Modifications nécessite :
	- tester les régressions (test unitaire | nécessite de développer les tests unitaires)
		* Si pas de tests unitaires, impossible de mesurer l'impact de l'évolution!
		* comment garantir qu'il n'y ai pas d'impact négatif sur les autres fonctionnalités.
	- redéployer toute l'application
		* nécessite une interruption de service
	- difficile à faire évoluer au niveau fonctionnel
		* idéal : fermer à la modification, ouverte aux extensions
		* mais si le besoin fonctionnel change, c'est compliqué
* Livraison en bloc:
	- le client doit attendre beaucoup de temps pour commencer à voir les premières versions

## Approche Micro-Services

### Principe
> diviser pour mieux régner

- consiste à découper l'application en plusieurs petites applications (petits services) indépendantes appelées Micro-Service.
- l'idée est de découper un grand problème en petites unités implémentées sous forme de micro-services.
- un service est responsable d'une fonctionnalité
- chaque ms peut être développé independamment des autres (devs, tests, déploiement)
- chaque ms peut être développé en utilisant une technologie différente (tiré parti de chaque techno)
- chaque ms tourne dans un processus différent
- la seule relation entre les différentes ms est l'échange de données effectué à travers les différentes APIs qu'ils exposent
- lorsqu'on les combine, ces ms peuvent réaliser des opérations très complexes

### Avantage
* les ms sont faiblement couplés puisque chaque ms st physiquement séparé des autres
* indépendance relative entre les différenes équipes
* facilité de tests et déploiement
* livraison continue
* Test Driver Developpement et méthodes agiles
	- commencer par le test-unitaire: expression de besoin

### Comment fédérer les WebServices
* très simples : SOAP, REST, ...
* orchestration : framework qui permet de géré les applications basés sur MS (Spring Cloud)

### Performances et montée en charge
* HPC: Hight Performance Computing - calcule de haute performance
* Minimiser l'utilisation et la consommation de ressources
* application monolithique : 
	- la duplication de l'application entraine la duplication de toute l'application 
	- démarrer dans plusieurs machines (plusieurs instances de l'application) : donc des ressouces importantes (scalablity horizontale avec load balancing)
* application ms : seul une nouvelle instance du ms qui l'exige est crée pour pallier la montée en charge	
	
### Découpage et granularité
* un ms <==> une fonctionnalité : mais difficile à réaliser
* un ms <==> un module sinon

### Architecture
* un ms est une application complète : 
	- couche métier (une fonctionnalité) business-architecture 
	- couche technique (composants qui permettent au ms de communiquer)
	- couche DAO (sa propre base de données ou base de données partagées)
	
* Chaque ms est démarré dans une machine (machine virtuel dans le cloud)
* Pour en faire une seule application, on utilise un framework comme Spring Cloud qui offre un ensemble de ms technique (avec des implémentations existantes - NetFlix)

	1- service d'enregistrement - 
	
	> annuaire (Eureka(netflix))
	
		* son rôle : enregistrer tous les ms de l'architecture
		* il va enregistrer 3 informations pour chaque ms :nom, adresseIp, port
		* quand un ms démarre, la première chose qui doit faire est de s'enregistrer/publier auprès de ce service
	
	2- Gateway : (zuul (netflix) | spring cloud gateway)
	
	> service proxy
	
		* Tous les clients|application quand ils envoient des requêtes les envoie au gateway. Ils ne peuvent les envoyer directement aux ms.
		* les requêtes sont envoyées au gateway qui interroge le service d'enregistement pour obtenir l'adresse du ms et ainsi aiguille la requête vers le bon ms
		* joue le rôle de load-balancer, utilise un système d'équilibrage de charge pour aiguiller intelligemment vers le bon ms
		* combien d'instance de ms dois-je utiliser pour supporter la charge, on utilise un outils d'orchestration 
			(docker swarm | Kubernetes : utilise des conteneurs basés sur Docker)
		* Kubernetes surveille les ms:
			- qd il y a un pb de montée en charge, démarre un ms
			- qd il y a un ms qui bloque, il l'arrête
			- qd il y a une maj, nvlle version, il garde l'ancienne version jusqu'à ce qu'il démarre la nouvelle version
		* docker : permet de déployer un ms dans un conteneur et après il faut orchestrer les conteneurs
	
	3- Configuration service

	> service qui permet de centraliser la configuration
		
		* centraliser la configuration de l'ensemble des ms
		* L'idée, c'est que l'on ne configure pas un ms mais l'application. 
		* S'il faut gérer un fichier de config (application.properties) par ms, cela devient compliqué
		* en général les fichier de configuration sont déposés dans un gestionnaire de version
		* quand le ms démarre, il demande sa configuration au service de configuration qui le lui retourne en le récupérant au niveau du gestionnaire de source
		* avantage : si la config change le service configuration est capable de lui donner l'information directement. 
		* Le ms met à jour sa configuration à chaud (en mémoire) sans redémarrage
	
	4- Communication entre micro-service

	> brokers
	
		* ms, gateway envoie un message vers file d'attente, boite à lettre
		* un ms fait un subscribe pour être à l'écoute de la file d'attente
		* dès qu'un message arrive dans la boîte, il est transférés à tous les ms qui ont souscrit à la boîte
		* IMPORTANT : Lors d'une modification ou ajout le gateway pousse des infos au broker. 
			Toutes les instances ds ms abonnés peuvent alors mettre à jour leur référentiel.
		
## Authentification

- **stateless**: ms d'authentification qui gère, stocke les [users | rôles] 
- chaque ms met en oeuvre Spring-Security : filtre configuré 
- Quand une requête arrive sur le gateway, une identification se fait sur le ms d'autentification (ex: keycloak)
- un token (JWT: identity du user) est alors retourné au gateway en cas d'authentification réussi. 
- le token est renvoyé au client, stocké dans le local storage de l'application du navigateur
- qd le client envoie alors une requête, le token est envoyé au gateway qui dispatche la requêtre vers le ms
- le filtre spring-security du ms, regarde le header 'Authorization', récupère le token. 
- La signataure du token est analysé avec un public | private key (expiration). 
- Si valide, les rôles du user sont analysés et en fonction des droits exécute ou non l'action


