[home](../index.md)

## Configuration Spring/Hibernate classique

### Principe
<pre>
1- Ajouter les dépendanes nécessaire dans le pom.xml
2- Créer un fichier de configuration dans lequel il faut 
   configurer les beans de persistence
</pre>

### Pom.xml

#### Hibernate-Core

<pre>
- permet de créer le contexte de persistence
- usine à Session 
</pre>

#### Spring-ORM
</pre>
- gestion des transactions et de la persistence avec Spring
- permet de mettre en place le contexte de persistence:
	- couche JPA / DataSource / Transaction

import org.springframework.jdbc.datasource.DriverManagerDataSource;  
import org.springframework.orm.jpa.JpaTransactionManager;  
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;  
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;  
import org.springframework.transaction.PlatformTransactionManager;  
import org.springframework.transaction.annotation.EnableTransactionManagement;
</pre>

#### code

```
<dependency>
    <groupId>org.hibernate</groupId>
    <artifactId>hibernate-core</artifactId>
</dependency>

<!-- attention nouveau repo pour hibernate -->
dependency>  
	<groupId>org.hibernate.orm</groupId>  
	<artifactId>hibernate-core</artifactId>  
</dependency>
	
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-orm</artifactId>
</dependency>
```

#### spring-boot-stater-JPA
<pre>
- starter qui permet de tirer les dépendances 
  nécessaires à la persistence
- par défaut, utiliser l'implémentation Hibernate
</pre>


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

</pre>

### Entity
<pre>
* <b>objet de persistence</b> qui materialise une donnée stockée en base
* objet qui s'implémente avec les annotation JPAs
* getter/setter
* equals/hashcode

<a href="../notes/mapping.md#entity" target="_blank">entity-mapping</a>
</pre>

### Repository
<pre>
* <b>composant Spring</b> spécialisé dans l'accès à la base de données
* un repository est associé à une "Entity" en général
* il permet d'effectuer les <b>actions associées</b> à l'entité.
</pre>

### persistence.config

#### principe
<pre>
- permet de configurer le <b>contexte de persistence</b> 
- on va configuer la fabrique d'EnityManager/Session
  <b>EntityManagerFactoryBean<B>
  => nécessite de configurer:
  * l'accès à la base de données : <b>dataSource</b>
  * référence aux <b>Entity</b> que devra géré le contexte de persistence
  * l'implementation <b>JpaVendor</b>
  * mise en place d'un gestionnaire de transaction
</pre>

#### Exemple-h2
<pre>
<a href="./config/PersistenceConfig-with-h2.java" target="_blank">persistence-config-h2</a>
<a href="../../spring/spring-boot/spb-utils.md#base-de-données" target="_blank">spb-h2</a>
</pre>

#### Mise en place
<pre>
- création du package config dans le folder des tests unitaires
- création du fichier PersistenceConfig qui contient la classe de même nom:

  <i>
  @Configuration
  @EnableTransactionManagement
  @ComponentScan(basePackages = {"com.hibernate4all.tutorial"})
  @PropertySource("classpath:application.properties")
  public class PersistenceConfig {
    ...
  }
  </i>

<b>@EnableTransactionManagement</b>: prendre en compte les transactions dans JPA
</pre>

<a href="./config/PersistenceConfig.java" target="_blanck">persistence-config</a>

#### config entityManagerFactory

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

#### config hibernate

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

#### config dataSource

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

#### config transactionManager

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

## hibernate-maven-enhance-plugin
<pre>
* plugin qui permet d'optimiser l'utilisation d'hibernate.
Attention à la version.
Certaines fonctions anciennes ne fonctionnent pas ou sont bugguées
</pre>
```
  <plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
  </plugin>
  <plugin>
    <groupId>org.hibernate.orm.tooling</groupId>
    <artifactId>hibernate-enhance-maven-plugin</artifactId>
    <version>5.6.15.Final</version>
    <executions>
      <execution>
        <configuration>
          <enableLazyInitialization>false</enableLazyInitialization>
          <enableDirtyTracking>true</enableDirtyTracking>
          <enableAssociationManagement>false</enableAssociationManagement>
          <enableExtendedEnhancement>false</enableExtendedEnhancement>
        </configuration>
        <goals>
          <goal>enhance</goal>
        </goals>
      </execution>
    </executions>
  </plugin>
````

## Tests

### Classe de Test
<pre>
Faire une classe de test s'exécutant dans un contexte Spring

<a href="./tests/MovieRepositoryTest.java" target="_blank">MovieRepositoryTest</a>


</pre>

### h2-test
<pre>
Pour inspecter la base de données pendant les tests :
* ajouter le code suivant
* jouer le test en mode debug.
* http://localhost:8082

<a href="./tests/MovieRepositoryTest-h2" target="_blank">MovieRepositoryTestH2</a>
</pre>
```
    @BeforeAll
    public static void initTest() throws SQLException {
        Server.createWebServer("-web", "-webAllowOthers", "-webPort", "8082")
              .start();
    }
```

### Charger un jeu de tests

```
// charger les données de test
@SqlConfig(dataSource = "dataSourceH2", transactionManager = "transactionManager")
@Sql({"/datas/datas-test.sql"})
```

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

