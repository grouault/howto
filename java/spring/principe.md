## Spring-principe

[retour](index-spring.md)

### Pourquoi?

<pre>
Spring permet:
* se structurer une application
* de développer par contrat et donc par fonctionnalité
* de ne pas créer de dépendance entre les objets intanciés.
</pre>

### Problématique

<pre>
Sans Spring, on développe l'application en étant centré  sur le besoin client.
- Le nommage des classes n'est souvant pas le bon
- les objets (contrôleur/service/repository) sont imbriqués et dépendants

Tout ajout de nouvelle fonctionnalité devient compliqué.
On <b>implémente successivement</b> les classes suivant le <b>besoin</b> des clients.
A terme, cela donne des pbs de nommage des composants et 
des combinatoires qui peuvent amener à des centaines de solutions
avec l'ajout successif des clients.

Exemple : 
un contrôleur par client pour un besoin spécifique

Configuration Défault
* contrôleurDefaut : saisie en mode console
* service : incrementation des factures incrémentale
* repository: in-memory

Configuration Michel
* controleurMichel : saisie en mode web
* service: incrémentation spécifique avec un préfixe
* repository: BDD

Configuration Chamboule Tout
* controleurChambouleTout: saisie douchette
* service: incrémentation
* repository: BDD ou File

Problématique:
* Il ne faut pas à avoir à modifier le code à chaque fois que 
la configuration change.
</pre>

### Programmation par contrat

<pre>
Pour éviter d'avoir une relation forte entre les composants à chaque nouveau besoin,
il convient d'utiliser la programmation par <b>interface</b> et/ou classe abstraite.

<b>interface</b>: desing pattern qui permet de relâcher les contraintes entre les composants.
Dans un composant, on ne doit plus faire de référence explicite à un composant donné.
On passe d'un <b>couplage fort</b> à un <b>couplage faible </b>.

L'interface: 
* définit comment le <b>composant du haut</b> communique avec le <b>composant du bas</b>.
* contractualise les méthodes du composant.
</pre>

### Injection de dépendances

<pre>
Pour casser le lien entre les composants on va utiliser au niveau des <b>composants du haut</b>:
* une référence à une interface pour faire le lien avec le <b>composant du bas</b>, 
via des propriétés du composant 
* mécanisme des setters qui permet de valoriser les propriétés de chaque composant à la volée,
suivant le besoin avec une implémentation ou une autre.
</pre>

### Inversion de contrôle.

#### Problématique

<pre>
Sans Spring on était concentré sur une configuration par client.
Avec Spring on se concentre sur une configuration par fonctonnalité.
* Pas de sens d'assicuer une classe à un client.
* Renommer les composants en faisant abstraction de qui en a besoin.

Au niveau de l'injection, 
* plutôt que de demander la configuration par client
* on demande une configuration par fonctionnalité
Type de controller ? console, web, ...
Type de service ? number, prefix, ...
Type de reposiotry ? memory, database, file, ...
</pre>

#### Principe

<pre>
Il s'agit d'inverser le fonctionnement de l'application.
Ce n'est pas les composants qui se chargent d'instancier leur composant associer.

C'est un bout de code ou un endroit centraliser du code: 
* qui se charge d'instancier les composants de l'architecture
* de mettre en relation ces composants grâce à l'injection de dépendances
</pre>

#### ioc et java

<pre>
* instancier les classes par java et la réflexion
* bout de code centraliser dans le main qui est en charge
de créer les composants et de les mettre en relation.
</pre>

### ioc et conteneur léger de Spring

<pre>
Ainsi quand le logiciel démarre, il soit savoir 
 - quoi instancier 
 - quii injecter dans les autres composants 
 dans le contexte du client

Le bout de code qui permet de faire cela en Spring c'est le <b>conteneur léger</b>.
Il permet de faire l'<b>inversion de contrôle</b> et de <b>garder en mémoire</b> 
tous les composants instanciés pendant toute la vie de l'application.

Ceci sous forme de graphe pour matérialiser les dépendances entre les composants.

<a target="_blank" href="./spring-contexte/index.md">instancier le conteneur léger</a>

</pre>
