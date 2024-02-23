# Connection

[retour](../index-spring-jdbc.md)

## Principe

<pre>
* Comparer la base de données à une chambre forte qui contient plusieurs portes
* Pour accéder à la base, il faut passer par une de ces portes
* Comme c'est une chambre forte, les portes sont blindées et difficilement accessibles.

<b>Important</b>:
* Une connexion à la base à un coût :
    * il faut ouvrir une socket (la porte) 
    * il faut s'authentifier 
</pre>

## Pool de connexion

<pre>
* c'est qqchose qui va préouvrir les portes afin de pouvoir à rentrer
  sans avoir à ouvrir / refermer les portes à chaque fois

* un pool de connexion maintient ses connexions

* on peut les réutiliser au besoin

* indispensable en production :
    * gain de performances
    * contrôler les connexions de l'appli à la base de données
        * nombre de connexion dans le pool
        * timeout, lifetime...
</pre>

## driver JDBC

<pre>
Pour réaliser une connection JDBC, il faut utiliser un driver JDBC;

Un driver est une implémentation des interfaces pour un SGBDR donné.

Pour obtenir une connexion, il faut:

1- le chargement de la classe du driver par la JVM
  Note : La méthode Driver.registerDriver() contient un initialiseur static qui permet de signaler 
    la classe comme driver JDBC au niveau de la JVM.
  Ce chargement permmet alors l'établissement d'une connexion.

2- Récupération de la Connexion

<b>Important :</b>
On met le driver au scope Runtime pour MySQL.
On n'utilise pas directement les classes du driver dans le code.
<a href="../../spring-boot/spb-utils.md#config-par-base" target="_blank">driver</a>
</pre>

```
Class.forName("com.mysql.jdbc.Driver")
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/test","login","mdp")
```

## DataSource

### Principe

<pre>
* interface javax.sql.DataSource est définie par les spécifications de JDBC qui représente une "source de données".
* Cette source de données est en fait une simple fabrique de connexion vers la source de données physique.
* il en existe différentes implémetation avec des usages bien déterminés (test, production...)
* il est facile de passer de l'une à l'autre car elles implémentent toutes cette même interface.
</pre>

### Implementations

<pre>
* basique : 
    implémentation qui produisent des instance de Connection normales,
    telles que l'on pourrait les obtenir avec DriverManager

* DriverManagerDataSource ==> Spring : ouvre une nouvelle connexion à chaque demande

* Pool de connexions : 
  implémentation qui produit des instances de connection qui appartiennent à un Pool
  BasicDataSource => Apache DBCP
</pre>

#### Java

```
    MysqlDataSource dataSource = new MysqlDataSource();
    dataSource.setUser("root");
    // dataSource.setPassword("password");
    dataSource.setServerName("localhost");
    dataSource.setPort(3306);
    dataSource.setDatabaseName("mabdd");

    try {
      Connection connection = dataSource.getConnection();

      // utilisation de la connexion

      connection.close();
    } catch (SQLException e) {

      e.printStackTrace();
    }
```

#### spring

<pre>
 <b>DriverManagerDataSource</b>
    une nouvelle connexion est ouverte à chaque requête
    
 <b>SingleConnectionDataSource</b> :
    maintient une connection réutilisée à chaque requête.
    pas adapaté en environnement multithread.
</pre>

##### xml

```
    <bean id="dataSource" destroy-method="close" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
        <property name="driverClassName" value="${db.driver}" />
        <property name="url" value="${db.url}" />
        <property name="username" value="${db.login}" />
        <property name="password" value="${db.password}" />
    </bean>

```

##### java-config
```
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl(dataBaseUrl);
        dataSource.setUsername("postgres");
        dataSource.setPassword("admin");
        return dataSource;
    }

    ou

	@Bean
	public DataSource getDataSource(){
        DataSourceBuilder<?> dataSourceBuilder = DataSourceBuilder.create();
        dataSourceBuilder.driverClassName("org.postgresql.Driver").url(dataBaseUrl).username("postgres").password("admin");
        return dataSourceBuilder.build();
	
	}
```

#### spring-boot

##### principe

<pre>
Pour obtenir une connexion, il faut au minimum la librairie
spring-jdbc que l'on peut obtenir avec les dépendances:
- JDBC API
- Spring Data JPA
- Spring Data JDBC

La dépendance ajoutée dans le pom est la suivante;
spring-boot-starter-jdbc


</pre>

#### pool de Connexion

##### principe

<pre>
Comment va-t-on obtenir une connexion à la base?
On exploite une datasource, avec un pool de connexion, instancier par Spring.
Une seule instance de datasource comme il se doit pour toute l'application

Il faut dire à Spring comment instancier la datasource
<b>Spring :</b>
- fichier xml
- java-config via un bean de configuration
    <i>
	@Bean
	public DataSource getDataSource(){
        DataSourceBuilder<?> dataSourceBuilder = DataSourceBuilder.create();
        dataSourceBuilder.driverClassName("org.postgresql.Driver").url(dataBaseUrl).username("postgres").password("admin");
        return dataSourceBuilder.build();
	
	}
    </i>

<b>SpringBoot :</b>
L'Autoconfiguration permet de paramètrer une datasource par défault
Spring-Boot: permet de faire cela nativement.
Spring dispose déjà un bean de configuration capable d'instancier une datasource
sur la base de propriétés se trouvant dans le fichier application.properties

* permet de se passer du fichier java.config quand on a une seule classe de configuration.

<a href="../../spring-boot/spb-utils.md#base-de-données" target="_blank">Spring-Boot</a>

Exemple:
<i>
spring.datasource.url=jdbc:mysql://localhost:3306/dvdstore?useSSL=false
spring.datasource.username=dvdstore
spring.datasource.password=1234
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
</i>

Par défaut, Spring-boot tire le pool de connexion HikariCP
Tiré automatiquement par le starter spring-boot-starter-jdbc

</pre>

##### Apache DBCP

<pre>
* accepte les même proporiétés de connexion que DriverManagerDataSource
  mais permet de configurer un pool.
</pre>

- pom.xml

```
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-dbcp2</artifactId>
    <version>${version.dbcp2}</version>
</dependency>
```

- config Spring

```
<!-- Declaration de notre data source -->
<bean id="dataSource" destroy-method="close" class="org.apache.commons.dbcp2.BasicDataSource">
    <property name="driverClassName" value="${db.driver}" />
    <property name="url" value="${db.url}" />
    <property name="username" value="${db.login}" />
    <property name="password" value="${db.password}" />
    <property name="initialSize" value="2" />
    <property name="maxActive" value="5" />
</bean>
```

##### HikariCP

- pom.xml

```
    <dependency>
        <groupId>com.zaxxer</groupId>
        <artifactId>HikariCP</artifactId>
    </dependency>
```

- config

<pre>
* org.springframework.boot.jdbc.DateSourceBuilder
  ==> sait détecter le mode de configuration du Pool Hikari et autres...
</pre>

```
    @Bean
    public DataSource dataSource() {
        // création d'un pool de connexion
        DataSourceBuilder<?> dataSourceBuilder = DataSourceBuilder.create();
        dataSourceBuilder.driverClassName("org.postgresql.Driver").url(dataBaseUrl).username("postgres").password("admin");
        return dataSourceBuilder.build();
    }
```

## Pratique

### dbeaver

<pre>
* se connecter avec dbeaver
* dbeaver crée une connection à chaque onglet
* par defaut, dbeaver affiche deux connexions
    * Main 
    * Metadata
</pre>

### state:

<pre>
<b>active</b>
    * celle qui a la main dans dbeaver

<b>idle</b>
    * en attente, aucune activité en cours
    * la porte est ouverte

<b>idle in transaction</b>
    * transaction en cours

</pre>

### transaction

#### autocommit

<pre>
Par défaut le mode actif est le mode autocommit.
On entre dans la chambre forte et on en ressort tout de suite.
Il n'y a pas de transaction.
Toute instruction est envoyée de manière unitaire et définitive à la BDD.
</pre>

#### manuel

<pre>
* rentré dans la chambre forte
* faire plusieurs opérations
* en sortir
</pre>

## MySql

```
show status like 'Conn%';

SHOW VARIABLES WHERE Variable_name = 'port';

show full processlist

select * from INFORMATION_SCHEMA.PROCESSLIST where db = 'entreprise';

select * from information_schema.INNODB_TRX it

--
-- voir les connexion et les transactions associées
--
SELECT p.id, p.`USER`,p.DB,p.STATE,p.INFO,it.trx_state, it.trx_isolation_level
from information_schema.PROCESSLIST p
	left join information_schema.INNODB_TRX it on it.trx_mysql_thread_id  = p.id
where p.DB ='entreprise'

```

## PostGre

```
SELECT pid,
	usename AS username,
	datname AS database,
	client_addr AS client_address,
	client_port,
	application_name,
	state,
	backend_start,
	state_change
FROM pg_stat_activity
WHERE datname ='hibernate4all-test'
```
