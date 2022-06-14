[home](../index-soa.md)

## Application Monolithique

- application d?velopp?e en un seul bloc (war, jar, ear, dll)
- d?ploy? sur un **serveur d'application** (conteneur web + framework d'inversion de contr?le)
- Principe d'**inversion de contr?le** : se concentrer sur les aspects fonctionnels pendant que le framework s'occupe des aspects techniques

### Architecture

- SGBD: relationnel | BigData (MongoDB, ES)
- L'application se compose de plusieurs couches:
  - **couche m?tier** : impl?mentation des sp?cifications fonctionnelles
  - **couche technique** : couche d'acc?s aux donn?es (Spring Data | JPA | Hibernate)
  - **couche Web** : Rendu c?t? serveur (Spring MVC - Html g?r? c?t? serveur (Moteur de template))
  - **couche Web** : Rendu c?t? client (Bas? sur les WebServices - Application Distribu?e)

### Syst?me Distribu?e

- application bas?e sur RMI, IOP : application distribu?e mais utilisant que du Java
- application bas?e sur Corba : application distribu?e mais multilanguage, multiplateforme (jusqu'aux ann?es 2000)
- application bas?e sur les WebService : plus simple, plus l?ger, plus facile ? mettre en place.
  - Communication synchrone
  - Communication asynchrone avec sp?cification JMS : ActiveMQ, Kafka, RabbitMQ,...

### Inconv?nient

- centralisation des besoins fonctionnels (m?me processus)
  - si une fonction bloque, toute l'application est bloqu?e
- r?alis?es dans une seule techno
  - toute le monde doit ?tre form? sur les technos
  - fonctionnalit? plus apte ? ?tre r?alis? avec certaines technos
- Modifications n?cessite :
  - tester les r?gressions (test unitaire | n?cessite de d?velopper les tests unitaires)
    - Si pas de tests unitaires, impossible de mesurer l'impact de l'?volution!
    - comment garantir qu'il n'y ai pas d'impact n?gatif sur les autres fonctionnalit?s.
  - red?ployer toute l'application
    - n?cessite une interruption de service
  - difficile ? faire ?voluer au niveau fonctionnel
    - id?al : fermer ? la modification, ouverte aux extensions
    - mais si le besoin fonctionnel change, c'est compliqu?
- Livraison en bloc:
  - le client doit attendre beaucoup de temps pour commencer ? voir les premi?res versions

## Approche Micro-Services

### Principe

> diviser pour mieux r?gner

- consiste ? d?couper l'application en plusieurs petites applications (petits services) ind?pendantes appel?es Micro-Service.
- l'id?e est de d?couper un grand probl?me en petites unit?s impl?ment?es sous forme de micro-services.
- un service est responsable d'une fonctionnalit?
- chaque ms peut ?tre d?velopp? independamment des autres (devs, tests, d?ploiement)
- chaque ms peut ?tre d?velopp? en utilisant une technologie diff?rente (tir? parti de chaque techno)
- chaque ms tourne dans un processus diff?rent
- la seule relation entre les diff?rentes ms est l'?change de donn?es effectu? ? travers les diff?rentes APIs qu'ils exposent
- lorsqu'on les combine, ces ms peuvent r?aliser des op?rations tr?s complexes

### Avantage

- les ms sont faiblement coupl?s puisque chaque ms st physiquement s?par? des autres
- ind?pendance relative entre les diff?renes ?quipes
- facilit? de tests et d?ploiement
- livraison continue
- Test Driver Developpement et m?thodes agiles
  - commencer par le test-unitaire: expression de besoin

### Comment f?d?rer les WebServices

- tr?s simples : SOAP, REST, ...
- orchestration : framework qui permet de g?r? les applications bas?s sur MS (Spring Cloud)

### Performances et mont?e en charge

- HPC: Hight Performance Computing - calcule de haute performance
- Minimiser l'utilisation et la consommation de ressources
- application monolithique :
  - la duplication de l'application entraine la duplication de toute l'application
  - d?marrer dans plusieurs machines (plusieurs instances de l'application) : donc des ressouces importantes (scalablity horizontale avec load balancing)
- application ms : seul une nouvelle instance du ms qui l'exige est cr?e pour pallier la mont?e en charge

### D?coupage et granularit?

- un ms <==> une fonctionnalit? : mais difficile ? r?aliser
- un ms <==> un module sinon

### Architecture

- un ms est une application compl?te :
  - couche m?tier (une fonctionnalit?) business-architecture
  - couche technique (composants qui permettent au ms de communiquer)
  - couche DAO (sa propre base de donn?es ou base de donn?es partag?es)
- Chaque ms est d?marr? dans une machine (machine virtuel dans le cloud)
- Pour en faire une seule application, on utilise un framework comme Spring Cloud qui offre un ensemble de ms technique (avec des impl?mentations existantes - NetFlix)

  1- service d'enregistrement -

  > annuaire (Eureka(netflix))

      * son r?le : enregistrer tous les ms de l'architecture
      * il va enregistrer 3 informations pour chaque ms :nom, adresseIp, port
      * quand un ms d?marre, la premi?re chose qui doit faire est de s'enregistrer/publier aupr?s de ce service

  2- Gateway : (zuul (netflix) | spring cloud gateway)

  > service proxy

      * Tous les clients|application quand ils envoient des requ?tes les envoie au gateway. Ils ne peuvent les envoyer directement aux ms.
      * les requ?tes sont envoy?es au gateway qui interroge le service d'enregistement pour obtenir l'adresse du ms et ainsi aiguille la requ?te vers le bon ms
      * joue le r?le de load-balancer, utilise un syst?me d'?quilibrage de charge pour aiguiller intelligemment vers le bon ms
      * combien d'instance de ms dois-je utiliser pour supporter la charge, on utilise un outils d'orchestration
      	(docker swarm | Kubernetes : utilise des conteneurs bas?s sur Docker)
      * Kubernetes surveille les ms:
      	- qd il y a un pb de mont?e en charge, d?marre un ms
      	- qd il y a un ms qui bloque, il l'arr?te
      	- qd il y a une maj, nvlle version, il garde l'ancienne version jusqu'? ce qu'il d?marre la nouvelle version
      * docker : permet de d?ployer un ms dans un conteneur et apr?s il faut orchestrer les conteneurs

  3- Configuration service

  > service qui permet de centraliser la configuration

      * centraliser la configuration de l'ensemble des ms
      * L'id?e, c'est que l'on ne configure pas un ms mais l'application.
      * S'il faut g?rer un fichier de config (application.properties) par ms, cela devient compliqu?
      * en g?n?ral les fichier de configuration sont d?pos?s dans un gestionnaire de version
      * quand le ms d?marre, il demande sa configuration au service de configuration qui le lui retourne en le r?cup?rant au niveau du gestionnaire de source
      * avantage : si la config change le service configuration est capable de lui donner l'information directement.
      * Le ms met ? jour sa configuration ? chaud (en m?moire) sans red?marrage

  4- Communication entre micro-service

  > brokers

      * ms, gateway envoie un message vers file d'attente, boite ? lettre
      * un ms fait un subscribe pour ?tre ? l'?coute de la file d'attente
      * d?s qu'un message arrive dans la bo?te, il est transf?r?s ? tous les ms qui ont souscrit ? la bo?te
      * IMPORTANT : Lors d'une modification ou ajout le gateway pousse des infos au broker.
      	Toutes les instances ds ms abonn?s peuvent alors mettre ? jour leur r?f?rentiel.

## Authentification

- **stateless**: ms d'authentification qui g?re, stocke les [users | r?les]
- chaque ms met en oeuvre Spring-Security : filtre configur?
- Quand une requ?te arrive sur le gateway, une identification se fait sur le ms d'autentification (ex: keycloak)
- un token (JWT: identity du user) est alors retourn? au gateway en cas d'authentification r?ussi.
- le token est renvoy? au client, stock? dans le local storage de l'application du navigateur
- qd le client envoie alors une requ?te, le token est envoy? au gateway qui dispatche la requ?tre vers le ms
- le filtre spring-security du ms, regarde le header 'Authorization', r?cup?re le token.
- La signataure du token est analys? avec un public | private key (expiration).
- Si valide, les r?les du user sont analys?s et en fonction des droits ex?cute ou non l'action
