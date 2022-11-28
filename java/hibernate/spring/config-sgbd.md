[home](../index.md)

## Configuration hibernate

<pre>
- géré dans un fichier de configuration avec la création des beans
- TODO: à détailler.
</pre>

### Pom.xml

#### principe

<pre>
- ajouté la persistence dans le pom.xml
- ajouté la dépendance hibernate
    - la version est tiréé par Spring-Boot
- ajouté la dépendance spring ORM
- gestion des transactions et de la persistence avec Spring
</pre>

#### code

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

#### hibernate-jpamodelgen

<pre>
* pour l'api criteria, on génère des constantes basé sur le modèle
  plutôt que de saisir le nom des attributs des classes en dur dans les requêtes
* au build, les fichiers sont générés et mis dans les sources de l'application et 
  dans le fichier generated-source
</pre>

```
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-compiler-plugin</artifactId>
  <configuration>
    <annotationProcessorPaths>
      <annotationProcessorPath>
        <groupId>org.hibernate</groupId>
        <artifactId>hibernate-jpamodelgen</artifactId>
        <version>5.6.10.Final</version>
      </annotationProcessorPath>
    </annotationProcessorPaths>
  </configuration>
</plugin>
```

### configurer les Entity avec leur Repository respectif

<pre>
- entity : entité de base = objet de persistence
- Repository: permet d'accèdér à la base de données
</pre>

## Configuration Spring classique

### persistence.config

<pre>
- création du package config dans le folder des tests unitaires
- création du fichier PersistenceConfig:
  - définit le contexte de persistence
    - orm utilisé
    - la base de donnée utilisée
    - les entité à mettre dans le contexte de persistence
</pre>

<a href="../../spring/spring-data/hibernate/persistance-config.java" target="_blanck">persistence-config</a>

### config entityManagerFactory

```
    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        // pemet de generer le contexte de persistence
        LocalContainerEntityManagerFactoryBean em = new LocalContainerEntityManagerFactoryBean();
        em.setDataSource(dataSource());
        em.setPackagesToScan(new String[] { "com.hibernate4all.tutorial.domain", "com.hibernate4all.tutorial.converter" });
        // basé sur hibernate
        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        vendorAdapter.setShowSql(true);
        vendorAdapter.setGenerateDdl(true);
        em.setJpaVendorAdapter(vendorAdapter);
        em.setJpaProperties(additionalProperties());
        return em;
    }
```

### config hibernate

<pre>
  private Properties additionalProperties() {
      Properties properties = new Properties();
      // au lancement du test : hibernate tente de faire un drop de la structure
      // tables, en fonction des entités déclarées
      properties.setProperty("hibernate.hbm2ddl.auto", "none");
      properties.setProperty("hibernate.dialect", "org.hibernate.dialect.PostgreSQLDialect");
      properties.setProperty("hibernate.format_sql", "true");
      properties.setProperty("hibernate.cache.use_second_level_cache", "true");
      properties.setProperty("hibernate.cache.use_query_cache", "true");
      // dire a hibernate comment il doit fabriquer le cache
      properties.setProperty("hibernate.cache.region.factory_class","org.hibernate.cache.ehcache.EhCacheRegionFactory");
      return properties;
  }
</pre>

### config dataSource

<a href="https://www.baeldung.com/spring-testing-separate-data-source" target="_blank">config-datasource</a>

```
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl(dataBaseUrl);
        dataSource.setUsername("postgres");
        dataSource.setPassword("admin");
        return dataSource;
        // création d'un pool de connexion
        /*
        DataSourceBuilder<?> dataSourceBuilder = DataSourceBuilder.create();
        dataSourceBuilder.driverClassName("org.postgresql.Driver").url(dataBaseUrl).username("postgres").password("admin");
        return dataSourceBuilder.build();
        */
    }
```

### config transactionManager

```
    @Bean
    public PlatformTransactionManager transactionManager() {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(entityManagerFactory().getObject());

        return transactionManager;
    }
```

## Configuration Spring-Boot

<a href="../../spring/spring-data/spring-data-principe.md" target="_blank">config.spring-boot</a>

### datasource

<a href="https://howtodoinjava.com/spring-boot2/datasource-configuration/" target="_blank">config-datasource-spb</a>

## Configuration spécifique Spring-Boot

### jar vs war dans le pom.xml

```
https://devstory.net/11903/deployer-le-application-spring-boot-sur-tomcat-server
```

### open-session-in-view

<pre>
  - Attention avec Spring, la configuration par défaut est active.
  - Il convient de désactiver cet anti-pattern dans le fichier
    application.properties:

  <b>spring.jpa.open-in-view=false</b>
</pre>

### Problèmes

<pre>
Au lancement de l'application, le tomcat ne se lancait pas.
Solution : mettre en commentaire le scope provided
</pre>

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
    <!--<scope>provided</scope>-->
</dependency>
```

## FlyWayDb

### principe

<pre>
Flywaydb permet de gérer les opérations liés à la base de données
* création et modification de la structure
* insertion / modification des données

On délègue à flywaydb cette tâche que l'on ne confie pas à hibernate.
On ne souhaite pas en effet recréer la structure et les données à chaque
  nouveau déploiement.
</pre>

### pom.xml

```
<!-- db.management -->
<dependency>
  <groupId>org.flywaydb</groupId>
  <artifactId>flyway-core</artifactId>
</dependency>

<!-- sans spring boot -->
<dependency>
  <groupId>org.flywaydb</groupId>
  <artifactId>flyway-core</artifactId>
  <version>8.4.4</version>
</dependency>

```

### configuration

#### folder db.migration

<pre>
* dans le répertoires <b>resources</b>, il faut créer le 
répertoire db.migration.
* mettre dans ce folder, tous les fichiers à migrer en 
respectant la nomenclature suivante :
- V1.0__CreateShema.sql
</pre>

#### config.spb

<pre>
Par défaut, la configuration est active et la migration
des scripts s'opèrent au lancement de l'application.
Elle est également active pour les tests unitaires.
Ci-après, les clés de configuration si besoin.
Pour les tests, voir ci-après
</pre>

```
# config flyway
spring.flyway.enabled=true
spring.flyway.encoding=UTF-8
spring.flyway.locations=classpath:db/migration
spring.flyway.outOfOrder=false
spring.flyway.baselineOnMigrate=true
```

#### config maven

<pre>
Sans spring, on peut installer le plugin suivant
et utiliser maven pour lancer la migration des scripts

<b>goal maven</b>: flyway:migrate
</pre>

#### pom.xml

```
      <plugin>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-maven-plugin</artifactId>
        <version>8.0.0</version>
        <configuration>
          <url>jdbc:mysql://localhost:3306/banquetest?useUnicode=true&amp;useJDBCCompliantTimezoneShift=true&amp;useLegacyDatetimeCode=false&amp;serverTimezone=UTC</url>
          <user>root</user>
          <password>gildas</password>
          <locations>
            <location>filesystem:src/main/resources/db/migration</location>
          </locations>
        </configuration>
        <dependencies>
          <dependency>
            <groupId>net.sourceforge.jtds</groupId>
            <artifactId>jtds</artifactId>
            <version>1.2.7</version>
            <scope>runtime</scope>
          </dependency>
        </dependencies>
        <executions>
          <execution>
            <id>integration-test-database-setup</id>
            <phase>pre-integration-test</phase>
            <goals>
              <goal>clean</goal>
              <goal>migrate</goal>
            </goals>
            <configuration>
              <url>jdbc:mysql://localhost:3306/banquetest?useUnicode=true&amp;useJDBCCompliantTimezoneShift=true&amp;useLegacyDatetimeCode=false&amp;serverTimezone=UTC</url>
              <user>root</user>
              <password>gildas</password>
              <locations>
                <location>filesystem:src/main/resources/db/migration</location>
              </locations>
            </configuration>
          </execution>
        </executions>
      </plugin>
```

## Tests

<pre>
<a href="../../spring/spring-boot/spb-utils.md#sql" target="_blank">@Sql et @SqlConfig</a>
<a href="https://www.baeldung.com/spring-testing-separate-data-source" target="\_blank">spb-tests</a>
</pre>

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
