### Configuration des tests

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

### 3 règles d'or

- toujours connaître l'état de la session/contexte de persistence
  - savoir si on est ou pas dans une session
- savoir si on est ou pas dans une transaction
- toujours se soucier du sql généré par hibernate

### session hibernate

- une session c'est quoi
- on peut le voir comme une map<classe+ID, entité>
- une entité géré par hibernate est dans la session/ dans la map
-

### les états JPAs

- orm : intermédiaire entre applis et la base de données
- contexte de persistence : ensemble des entités géréés par hibernate

#### transient

- entité non connu du contexte de persistence
- concerne les nouveaux objets (new)
- méthode :
  - persist(e): pour mettre l'entité dans le contexte de persistence

#### managed

- entité géré par hibernate
  - flush(): hibernate enverra les modifs vers la base de données
- méthode pour mettre l'entité dans l'état "managed"
  - persist(e)
  - find(e)
  - getReference()
  - getResultList()

#### removed

- remove(e): supprimé une entité qui est dans l'état managed
  - sur une entité connu du contexte de persistence
  - l'entité passe dans l'état Removed et hibernate envoie les suppressions au SGBD
    via la méthode flush()
- persist(e): on peut l'utiliser pour remettre l'entité dans la session dans l'état managed

#### detached

- une entité peut être retirée du contexte de persistence
  et dire à hibernate de ne plus gérer l'entité
- méthode pour retirer l'entité de la session :
  - detach(e)
  - clear()
  - close()
- merge(e) :
  - réattacher l'entité à la session
    - récupère l'entité en base
    - fait un update s'il y a un delta
  - si l'entité est nouvelle, cela revient à faire un persist()

### utilisation des logs

- création du fichier logback-test.xml dans le folder test/resources

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

#### chargé un jeu de tests

```
// charger les données de test
@SqlConfig(dataSource = "dataSourceH2", transactionManager = "transactionManager")
@Sql({"/datas/datas-test.sql"})
```

### Mauvaise pratiques

- Il ne faut jamais déterminé l'id de manière programmatique. C'est hibernate qui s'en occupe.
- On peut le faire pour tricher, pour simuler un merge.

## Définition

### EntityManager

- permet de déclencher des actions sur les entités
- ces actions permettent entre autre de changer l'état d'une entité

#### getReference() - proxy

### Session

### Transaction

#### @Transactional

- Spring va ouvrir une session avec la Transaction

### proxy / lazy loading

- un proxy est une référence vers une entité de la base qui n'est pas complètement chargée,
  mais chargeable à la demande si la session hibernate est encore ouverte.
- le lazy-loading ne peut donc se faire que pour des entités dans un état 'MANAGED'

### Flush

- force l'entity manager a envoyé ses modifications à la base de données
- en général, c'est une mauvaise pratique
- hibernate flush automatiquement à la fermeture de la session

### Dirty checking

- Fonctionnalité du contexte de persistence qui concerne les entités managed
- permet de faire la mise à jour des données et donc
  de répondre à la question suivante : comment fait-on un update avec hibernate ?
- Toute modification faite sur l'entité à l'état MANAGED sera enregistrée dans la session et
  propagée jusque dans la base de données.
- Quel est le principe :
  Hibernate maintient en plus de la session, un snaphot qui est une photographie des entités au
  chargement. Au flush, hibernate fait une comparaison entre les entités de la session et du
  snaphot. Toute entitié modifié sera mis à jour en base.
  Hibernate met alors à jour toute l'entité même si un seul champ a été modifié.

### Cache

#### cache de premier niveau

- si on demande des objets à Hibernate, hibernate va d'abord les chercher dans son cache
- utilité du cache de session:
  1- réduire le nombre de requête vers la BDD
  2- stocker les modifs et les envoyer en BDD au bon moment
- hibernate à la charge de renvoyer l'état à jour de l'entité
  - Sale = Dirty = modifié
  - C'est à hibernate de savoir qu'un objet est sale

### Hibernate et Event

- Hibernate fonctionne beaucoup par Event
- Utile pour trouver/surcharger certaines classes
