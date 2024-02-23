
## Programmation impérative
attendre impérativement de recevoir une donnée pour faire autre chose
Modéle Multi-Thead - IO bloquante
==> Thread est bloqué pour plusieurs raisons : latence du réseau, IO bloquante

## Programmation réactive
Single Thread - IO Non bloquante
* Reactor Event Loop qui traite plusieurs requête en même temps.
* Gère les requêtes / réponses
* Thread qui boucle
* A condition d'utiliser des IO non bloquantes:
	* en attendant que les données sont envoyées ou récupérées, je fais autre chose

Mais utilisé plusieurs thread pour utiliser les ressources de l'ordinateur (workers threads).
==> dépend du nombre de CPU du serveur
Modèle de programmation
* pour écrire du code asynchrone, non bloquante et fonctionnel
* basé sur des évènements en utilisant une séquence d'observable :

Les flux de données sont des flux pilotés par les évènements / messages
Pour chaque requête, le thread loop émet des évènements et utilise les workers threads.
Les workers threads traitent les requêtes de manière non bloquantes en utilisant le principe d'event loop.
Exemple (appel base de données):
Quand une requête arrive sur le serveur, le serveur attribut un thread pour traiter la requête.
Le thread lance la requête auprès de la BDD et il retourne dans le pool. Le thread est libéré et pas bloqué en attente de la BDD. Il peut traiter une autre requête.
Quand la BDD renvoie les données, elles vont arrivées comme un message, elles vont être prises en charge par un thread, pas forcément le même thread, qui traite les données pour les renvoyées à l'utilisateur.
Si plusieurs données à renvoyer, plusieurs messages et potentiellement plusieurs threads utilisés pour renvoyer la donnée.

Ce que je comprends :
Les évenement sont bidirectionnels. Le thread principal emet des évènements, consommés par les workers threads qui a leurs tour emettent des évènements pour le thread principal...

Attendtion : avec JDBC, accès à la base utiliser une E/S bloquante et bloque le thread.
Tout doit être réactif.

Pour faire de la programmation réactive, on a besoin de la programmation fonctionnelle et des lambdas.

Dans ce modèle, plus d'impact lié à la latence, dû aux I/O non bloquante.

Spring 5 : Reactive Streams | Notion de Streaming
* implémentation de Spring pour la programmation réactive
Echange de données entre un Publisher et Subscriber :
Publisher: émet des données
Subscriber: recoit des donnés
Le subscriber s'abonne au Publisher

![img](./img/publisher-consumer.png)

Méthode bloquante:
* block()
* subscribe()

Traitement asynchrone qui permet de traiter de manière asynchrone la donnée:
map()


Back Pressure : il n'y a pas de données envoyées tant que le subscriber n'en demande pas.
Une sorte de négociation de protocole entre le P et le S pour que les deux fonctionnent à la même vitesse.
Publisher règle la vitesse de transmission en fonctoin du subscriber.
Les données arrivent au fur et à mesure que le subscriber les demande.
Dans le cas d'un Flux, le subscriber dit je veux 10, puis encore 10...

L'échange entre Publisher et Subscriber se termine par un des evenement: Error | Complete.
L'échange se termine:
* soit par un évènement de type Complete
* soit par un évènement de type Error s'il y a un pb

Reactor API : définit deux type de streams / Publisher :
Flux<T> : Publisher qui correspond à un échange de 1 à plusieurs éléments.
	* équivalent de List en programmation réactive...
	* équivalent à un observable en RxJs
	
Mono<T> : Publisher qui correspond de 0 à 1 élément
	* équivalent à une Promesse en RxJs
	* au maximum un élément échangé

Principe: Subscribe (Promesse/Observable)
Dés que j'ai le résultat, je vous l'envoie
* Programmation asynchrone, non bloquante, 
	on a reçu la promesse qui est un publisher 
* Quand on recoit la promesse, on fait un subscribe
	* on peut faire autre chose
	* dés que les données sont disponibles, on les recoit (où?)
	* la reception des données déclenchent un évènement
	* avec l'évènement on prend l'information

Spring WebFlux:
* Permet de faire de la programmation réactive en utilisant les annotations
de Spring MVC ==> Sauf que les méthodes retournent Flux<T> et Mono<T>

Réactive WebClient :
* API qui permet d'accéder à d'autres Service Distants (REST) mais de manière réactive

Note: 
Un publisher peut être partager pour plusieurs requêtes.
