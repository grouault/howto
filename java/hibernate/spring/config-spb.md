[home](../index.md)

## Configuration hibernate

- géré dans un fichier de configuration avec la création des beans
- TODO: à détailler.

### Pom.xml

- ajouté la persistence dans le pom.xml

  - ajouté la dépendance hibernate
    - la version est tiréé par Spring-Boot
  - ajouté la dépendance spring ORM

    - gestion des transactions et de la persistence avec Spring

    ```
            <dependency>
                <groupId>org.hibernate</groupId>
                <artifactId>hibernate-core</artifactId>
            </dependency>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-orm</artifactId>
            </dependency>
    ```

### configuration d'une Entity avec son Repository

- entity :
  - entité de base = objet de persistence
- Repository:
  - permet d'accèdér à la base de données

### Configuration de l'accès à la base de données

- création du package config dans le folder des tests unitaires
- création du fichier PersistenceConfig:
  - définit le contexte de persistence
    - orm utilisé
    - la base de donnée utilisée
    - les entité à mettre dans le contexte de persistence

## jar vs war dans le pom.xml

```
https://devstory.net/11903/deployer-le-application-spring-boot-sur-tomcat-server
```

## open-session-in-view

- Attention avec Spring, la configuration par défaut est active.
- Il convient de désactiver cet anti-pattern dans le fichier
  application.properties:

```
spring.jpa.open-in-view=false
```

## Problèmes

- Au lancement de l'application, le tomcat ne se lancait pas.
  Solution : mettre en commentaire le scope provided

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
    <!--<scope>provided</scope>-->
</dependency>
```


## FlyWayDb

<pre>
Flywaydb permet de gérer les opérations liés à la base de données
* création et modification de la structure
* insertion / modification des données

On délègue à flywaydb cette tâche que l'on ne confie pas à hibernate.
On ne souhaite pas en effet recréer la structure et les données à chaque 
  nouveau déploiement. 

Ainsi la configuration sera la suivante 

</pre>

## Tests

### Configuration de la base de données
<pre>
* utilisation de Spring
  * via les profils
  * via les properties

* créer un fichier application.properties au niveau des tests
* il vient surcharger le fichier par défaut de l'application

* il faut ensuite injecter les valeurs des properties dans les fichiers de config.
* on a plus besoin de PersistenceConfigTest ==> ???
* Il faut donc appliquer la configuration suivante :
    
    properties.setProperty("hibernate.hbm2ddl.auto", "none");
    properties.setProperty("hibernate.dialect", "org.hibernate.dialect.PostgreSQLDialect");

</pre>

#### utilisation des logs

- création du fichier logback-test.xml dans le folder test/resources

#### chargé un jeu de tests

```
// charger les données de test
@SqlConfig(dataSource = "dataSourceH2", transactionManager = "transactionManager")
@Sql({"/datas/datas-test.sql"})
```

### analyse des logs de tests

#### avec le logger hibernate et transaction

```
# 1- Phase de LANCEMENT DU TEST

# au lancement du test : hibernate tente de faire un drop de la structure
# lié au paramétrage PersistenceConfig("hibernate.hbm2ddl.auto", "create-drop")
11:22:36 DEBUG o.hibernate.SQL.logStatement drop table if exists Movie CASCADE
11:22:36 DEBUG o.hibernate.SQL.logStatement drop sequence if exists hibernate_sequence

# création dans la base mémoire de la table et la séquence
11:22:36 DEBUG o.hibernate.SQL.logStatement create sequence hibernate_sequence start with 1 increment by 1
11:22:36 DEBUG o.hibernate.SQL.logStatement create table Movie (id bigint not null, name varchar(255), primary key (id))

# spring a créer une nouvelle transaction
11:37:03 DEBUG o.s.o.j.JpaTransactionManager.getTransaction Creating new transaction with name [com.hibernate4all.tutorial.repository.MovieRepository.persist]: PROPAGATION_REQUIRED,ISOLATION_DEFAULT

# spring a ouvert une session hibernate
11:37:03 TRACE o.h.i.SessionImpl.<init> Opened Session [c4b0fceb-f38e-473f-825f-d22160cdfceb] at timestamp: 1654681023225

# trace JPA: association de l'entity-manager avec la transaction
11:37:03 DEBUG o.s.o.j.JpaTransactionManager.doBegin Opened new EntityManager [SessionImpl(463985450PersistenceContext[entityKeys=[], collectionKeys=[]];ActionQueue[insertions=ExecutableList{size=0} updates=ExecutableList{size=0} deletions=ExecutableList{size=0} orphanRemovals=ExecutableList{size=0} collectionCreations=ExecutableList{size=0} collectionRemovals=ExecutableList{size=0} collectionUpdates=ExecutableList{size=0} collectionQueuedOps=ExecutableList{size=0} unresolvedInsertDependencies=null])] for JPA transaction
11:37:03 DEBUG o.s.o.j.JpaTransactionManager.doBegin Exposing JPA transaction as JDBC [org.springframework.orm.jpa.vendor.HibernateJpaDialect$HibernateConnectionHandle@39ead1b7]

# 2- Phase où movie est dans un état transient et on va le persister
# repository.persist(movie)
# appel à la séquence pour obtenir l'id
11:45:25 DEBUG o.hibernate.SQL.logStatement call next value for hibernate_sequence

11:48:18 DEBUG o.s.o.j.JpaTransactionManager.processCommit Initiating transaction commit
11:48:18 DEBUG o.s.o.j.JpaTransactionManager.doCommit Committing JPA transaction on EntityManager [SessionImpl(463985450PersistenceContext[entityKeys=[EntityKey[com.hibernate4all.tutorial.domain.Movie#1]], collectionKeys=[]];ActionQueue[insertions=ExecutableList{size=1} updates=ExecutableList{size=0} deletions=ExecutableList{size=0} orphanRemovals=ExecutableList{size=0} collectionCreations=ExecutableList{size=0} collectionRemovals=ExecutableList{size=0} collectionUpdates=ExecutableList{size=0} collectionQueuedOps=ExecutableList{size=0} unresolvedInsertDependencies=null])]
11:48:18 TRACE o.h.i.SessionImpl.beforeTransactionCompletion SessionImpl#beforeTransactionCompletion()
11:48:18 TRACE o.h.i.SessionImpl.managedFlush Automatically flushing session
# insertion en base de l'entité
11:48:18 DEBUG o.hibernate.SQL.logStatement insert into Movie (name, id) values (?, ?)
# transaction en succès - l'entité est en base
# Attention : hibernate a mis l'entité dans la session
# hibernate se synchronisse avec la base quand il le souhaite (au flush ou en fin de transaction)
11:48:18 TRACE o.h.i.SessionImpl.afterTransactionCompletion SessionImpl#afterTransactionCompletion(successful=true, delayed=false)
# arrêt de la transaction
11:48:18 DEBUG o.s.o.j.JpaTransactionManager.doCleanupAfterCompletion Closing JPA EntityManager [SessionImpl(463985450PersistenceContext[entityKeys=[EntityKey[com.hibernate4all.tutorial.domain.Movie#1]], collectionKeys=[]];ActionQueue[insertions=ExecutableList{size=0} updates=ExecutableList{size=0} deletions=ExecutableList{size=0} orphanRemovals=ExecutableList{size=0} collectionCreations=ExecutableList{size=0} collectionRemovals=ExecutableList{size=0} collectionUpdates=ExecutableList{size=0} collectionQueuedOps=ExecutableList{size=0} unresolvedInsertDependencies=null])] after transaction
# fermeture de la session hibernate
11:48:18 TRACE o.h.i.SessionImpl.closeWithoutOpenChecks Closing session [c4b0fceb-f38e-473f-825f-d22160cdfceb]
# suppresion de la structure
11:57:56 DEBUG o.hibernate.SQL.logStatement drop table if exists Movie CASCADE
11:57:56 DEBUG o.hibernate.SQL.logStatement drop sequence if exists hibernate_sequence
```

#### avec le logger : basic-binder

```
11:57:55 DEBUG o.hibernate.SQL.logStatement drop table if exists Movie CASCADE
11:57:55 DEBUG o.hibernate.SQL.logStatement drop sequence if exists hibernate_sequence
11:57:55 DEBUG o.hibernate.SQL.logStatement create sequence hibernate_sequence start with 1 increment by 1
11:57:55 DEBUG o.hibernate.SQL.logStatement create table Movie (id bigint not null, name varchar(255), primary key (id))
11:57:56 DEBUG o.hibernate.SQL.logStatement call next value for hibernate_sequence
11:57:56 DEBUG o.hibernate.SQL.logStatement insert into Movie (name, id) values (?, ?)
11:57:56 TRACE o.h.t.d.s.BasicBinder.bind binding parameter [1] as [VARCHAR] - [Inception]
11:57:56 TRACE o.h.t.d.s.BasicBinder.bind binding parameter [2] as [BIGINT] - [1]
11:57:56 DEBUG o.hibernate.SQL.logStatement drop table if exists Movie CASCADE
11:57:56 DEBUG o.hibernate.SQL.logStatement drop sequence if exists hibernate_sequence
```
