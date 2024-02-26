[home](../index.md)

## Mise en place des logs : LOGBACK.xml

<pre>
<a href="https://logback.qos.ch/manual/introduction.html" target="_blank">logback-doc</a>

<a href="https://mvnrepository.com/artifact/ch.qos.logback/logback-classic/1.4.6" target="_blank">mvn-repository</a>
</pre>

### Configuration
<pre>
Par défaut, spring-boot utilise logback
spring-boot-starter => spring-boot-starter-loggin ==> logback / slf4j

Créer un fichier :

<b>logback.xml</b> dans le répertoire : java/ressources

<b>logback-test.xml</b> dans le répertoire : test/ressources

</pre>

#### logger
<pre>

    * quels sont les instructions SQLs envoyés à la base
    < logger name="org.hibernate.SQL" level="DEBUG"/ >

    * observer la gestion des transactions : ouverture / fermeture
    < logger name="org.springframework.orm.jpa.JpaTransactionManager" level="DEBUG" />

    * SessionImpl : implementation de la session dans les sources hibernate
    * observer la gestion des sessions ouverture / fermeture
    < logger name="org.hibernate.internal.SessionImpl" level="TRACE" / >

    * besoin d'afficher les valeurs des "?"
    < logger name="org.hibernate.type.descriptor.sql.BasicBinder" level="TRACE" / >

	* ==> avec le nouveau package org.hibernate.orm
	<!-- besoin d'afficher les valeus des "?" -->  
	<logger name="org.hibernate.orm.jdbc.bind" level="TRACE" />

</pre>

### logback.xml

- Voici l'exemple de configuration d'un fichier de logs

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <appender name="STDOUT"
              class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>
                %d{HH:mm:ss} %highlight(%-5level) %logger{15}.%M %msg%n
            </pattern>
        </encoder>
    </appender>

    <!-- observer les instructions envoyes a la base de donnees -->
    <logger name="org.hibernate.SQL" level="DEBUG"/>

    <!-- besoin d'afficher les valeus des "?" -->
    <logger name="org.hibernate.type.descriptor.sql.BasicBinder" level="TRACE" />

    <!-- logger les classes specifiques -->
    <!-- logger name="com.hibernate4all.tutorial.repository.MovieRepository" level="TRACE"/ -->

    <!-- observer la gestion des transactions : ouverture / fermeture -->
    <!-- logger name="org.springframework.orm.jpa.JpaTransactionManager" level="DEBUG" /-->
    <!--
        SessionImpl : implementation de la session dans les sources hibernate
        observer la gestion des sessions ouverture / fermeture
    -->
    <logger name="org.hibernate.internal.SessionImpl" level="TRACE" />

    <!-- mecanisme de flux par defaut
        explication du dirty-checking
    -->
    <logger name="org.hibernate.event.internal.DefaultFlushEntityEventListener" level="TRACE"/>

    <root level="info">
        <appender-ref ref="STDOUT" />
    </root>

</configuration>
```

### analyse des logs de tests

#### persist

##### persist avec analyse de logs
<pre>
<b>1- Initialisation du contexte de persistance</b>
* au lancement du test : hibernate tente de faire un drop de la structure et essaie de la recréer.
* création dans la base mémoire de la table et la séquence
* spring a créer une nouvelle transaction
* spring a ouvert une session hibernate
* spring associe l'entity-manager (ou Session) avec la transaction

<b>2- phase de persistence </b>
* <b>appel à la séquence</b> pour obtenir l'id
  pkoi: dans la session: < class + id > en clé.
    Il faut donc récupérer l'identifiant.
    Si Hibernate ne récupère pas l'id ; il ne peut mettre l'entité dans la session.
    L'appel à la séquence se situe hors transaction
* Cela met l'entité dans la Session
* L'insert en base se fait pas forcèment au même moment.
* L'insert se fait quand hibernate le décide.
  Ici c'est au moment du commit.
</pre>


```
# 1- Phase de LANCEMENT DU TEST

# au lancement du test : hibernate tente de faire un drop de la structure et essaie de la recréer.
# lié au paramétrage PersistenceConfig("hibernate.hbm2ddl.auto", "create-drop")
11:22:36 DEBUG o.hibernate.SQL.logStatement drop table if exists Movie CASCADE
11:22:36 DEBUG o.hibernate.SQL.logStatement drop sequence if exists hibernate_sequence

# création dans la base mémoire de la table et la séquence
# pkoi séquence : id => basée sur la séquence
11:22:36 DEBUG o.hibernate.SQL.logStatement create sequence hibernate_sequence start with 1 increment by 1
11:22:36 DEBUG o.hibernate.SQL.logStatement create table Movie (id bigint not null, name varchar(255), primary key (id))

# spring a créer une nouvelle transaction
11:37:03 DEBUG o.s.o.j.JpaTransactionManager.getTransaction Creating new transaction with name [com.hibernate4all.tutorial.repository.MovieRepository.persist]: PROPAGATION_REQUIRED,ISOLATION_DEFAULT

# spring a ouvert une session hibernate
11:37:03 TRACE o.h.i.SessionImpl.<init> Opened Session [c4b0fceb-f38e-473f-825f-d22160cdfceb] at timestamp: 1654681023225

# trace JPA: spring associe l'entity-manager (ou Session) avec la transaction
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

# suppresion de la structure (on est en create-drop)
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