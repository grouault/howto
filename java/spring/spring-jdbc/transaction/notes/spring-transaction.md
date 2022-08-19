## spring-transaction

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

## urls

https://stackoverflow.com/questions/2007097/unexpectedrollbackexception-a-full-scenario-analysis
