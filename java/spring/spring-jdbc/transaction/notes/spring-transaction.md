# spring-transaction

[retour](./../readme.md)

## définition

<pre>
Une transaction est une suite d'actions qui forme une seule unité de travail.
Les actions doivent toutes réussir ou n'avoir aucun effet.
La transaction peut alors être:
  * soit annulée pour revenir à l'état précédent
  * soit validée de manière permanente.

La gestion des transaction dans les applications permet de garantir:
- l'intégrité des données
- la cohérence des données

La gestion des transaction est une forme de préoccupations transverses.
</pre>

## Problématique

<pre>
* Le code transactionnel est un code standard répétitif (dans les méthodes)
* propre à la technologie d'implémentation (JDBC / Hibernate / JPA)

Spring propose un ensemble d'outils transactionnels indépendant de la technologie,
en particulier des gestionnaire de transactions
</pre>

## gestionnaire de transactions

### Principe

<pre>
En tant que framework d'application d'entreprises, Spring définit une couche
abstraite au dessus des différentes API de gestion des transactions.

Cette abstraction est permise grâce à un gestionnaire de transaction.
Il est en existe plusieurs implémentations pour les différentes API de gestion des transactions.

L'utilisation d'un gestionnaire permet d'être indépendant de la technologie et permette de gérer 
les tansaction
* par programmation grâce au template de transaction
* par déclaration :

<b>Note</b>:
* même si le mode par déclaration est moins souple, il permet de configuer de manière fine les transactions.
* Les attributs réconnus par Spring sont les suivants :
  * propagation
  * niveau d'isolation
  * règles d'annulation
  * temporisations
  * fonctionnement en lecture seule
</pre>

### PlatformTransactionManager

<pre>
Spring abstrait l'utilisation des transations avec PTM.
PlatformTransactionManager :
* est une interface générale pour tous les gestionnaire transactions Spring.
* encapsule un ensemble de méthodes indépendants de la technologie.
</pre>

### Implémentation

#### DataSourceTransactionManager

<pre>
pour une application qui accède à une seule source de données via JDBC
</pre>

#### JtaTransactionManager

<pre>
pour la gestion des transaction sur un serveur d'application
</pre>

#### HibernateTransactionManager

<pre>
gestionnaire adapté pour le framework Hibernate
</pre>

#### JpaTransactionManager

<pre>
gestionnaire adpaté pour l'utilisation de Jpa
</pre>

### Déclaration

<pre>
un gestionnaire de transaction se déclare comme un autre bean dans le conteneur
</pre>

```
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="dataSource" />
</bean>
```

## programmatic-transaction

### définition

<pre>
* le code de gestion des transactions est incorporé dans les méthodes métiers de manières à 
  contrôler la validation et l'annulation des transactions.

De manière générale :
* une transaction est validée lorsqu'une méthode se termine de manière normale
* une transaction est annulée lorsqu'une méthode lance un certains types d'exception

* Cette approche oblige à écrire du code de gestion supplémentaire pour chaque opération
  transactionnelle. 
* Un code transactionnel standard est ainsi reproduit pour chaucune des opérations.

* ATTENTION : dans ce mode, le code transactionnel est lié au code métier.
</pre>

- [API du gestionnaire de transaction](./spring-transaction-programmatic.md)
- [Transaction Template](./spring-tx-template.md)

## declarative-transaction

### définition

<pre>
* ce mode est à préféré à la gestion par programmation
* le code transactionnel n'est plus lié au code métier via des déclarations
* le framework Spring AOP sert de fondation à la gestion déclarative des transactions

Avantage : 
* activer plus facilement les transactions
* définir une politique transactionnelle cohérente

Inconvénient:
* moins souple car on ne peut contrôler la transaction à partir du code.
</pre>

- par déclaration avec Spring AOP
- par déclartion avec des greffons transactionnels
- par déclartion avec l'annotation @Transactionnal

[declarative-transaction](./spring-transaction-declarative.md)

### @Transactional

#### définition

<pre>
Cette annotation permet de déclarer une connexion.

Ce qui se passe au niveau du SGBD :
  * elle ne démarre pas immédiatement une transaction 
  * elle ouvre une connexion ou recupère une connection dans le pool
    suivant la configuration
  * désactive le mode auto-commit de la connection
  * démarre une transaction si besoin

Ce qui se passe au niveau application Spring / Hibernate:
 * Spring ouvre une session hibernate.
 * En même temps, il initialise une transaction qui n'est pas
   forcément répercuté au niveau de la base. Par contre, dèq qu'une opération
   mettant en jeu l'entityManager est réalisé, la transaction est créer au 
   niveau de la base.

Note:
  En parallèle, la méthode find fonctionne en autocommit:
  * créer une connexion
  * exécute la requête
  * ferme la connexion

<b> IMPORTANT </b>:
 * @Transactionnal prend une connexion au pool
 * avec Spring, il faut donc l'utiliser quand c'est nécessaire.

</pre>

#### proxy

<pre>
@Transactionnal fonctionne avec les proxies, il faut donc faire attention où sont 
positionnés les annotations
* les services doivent être injecté par Spring ; ils sont ainsi proxifiés par Spring.
* les services transactionnels doivent porter l'annotation.
</pre>

#### test
<pre>
<b>Important</b> :
Cette annotation sur une classe de test à l'effet inverse que dans une classe en production.
La transaction si elle va au bout finira par un <b>Rollback</b>.

Pourquoi:
Chaque méthode de tests donne lieu à une nouvelle instance de la classe de test ; en effet,
pour chaque test, les données doivent pouvoir être réinitialiser pour le prochain test.
Il convient de noter ici, que dans une classe de test, les tests se déroulent dans 
n'importe quel ordre.
Il ne faut pas de dépendance fonctionnelles entre les tests. Si les tests portent sur une 
BDD, il faut réinitialiser les valeurs en base, d'où le RollBack.
</pre>

## Configuration des tx

### Propagation

<pre>
REQUIRED:
  * par défaut
  * spring crée une tx s'il n'en trouve pas
SUPPORT:
  * prend la tx en cours si elle existe
  * sinon spring n'en créé pas
MANDATORY:
  * exception si pas de tx en cours
NEVER: 
  * s'il y a une tx, il y aura une exception
REQUIRED_NEW:
  * tx ou non, spring créé une nouvelle tx
</pre>

### Isolation

[niveau d'isolation](../notes/concurrence-acces.md#3-les-niveaux-disolation)

### readonly=true

<pre>
* empêche tout modification en base de données
  => déclenche une exception pour toute modification
* optimise mémoire et CPU en désactivant le système de dirty-checking
</pre>

## Exceptions et tx

[excption](../../exceptions.md)

## Concurrence d'accès.

[transaction - concurrence](../notes/concurrence-acces.md)

## urls

https://stackoverflow.com/questions/2007097/unexpectedrollbackexception-a-full-scenario-analysis
