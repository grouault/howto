# Spring-Boot [Boite à outils]

[retour](../index-spring.md)

## Configuration de l'application

<pre>
La configuration se fait dans le fichier de configuration application.properties
</pre>

```
server.port=8082
```

## Spring Boot librairie

<pre>
Les librairies maven à installer :
* Spring-web
* Spring Data Jpa (sql)
* H2 Database
* lombok
* SpringBootDevTools
</pre>

### SpringDevTools

<pre>
Cette dépendance est utile pour :
- prendre les modifications à chaud sans avoir besoin de redémmarer le serveur
- base de données H2: fournit une interface de connexion à la base.
</pre>

### Lombok

#### principe

<pre>
> Gestion des Getters/Setters, toString, constructeur
* lombok agit au niveau compilation. Au moment, où le code est compilé, 
lombok parcours les annotations pour ajouter les getters/setters.. dans le byte code.
</pre>

```
@Entity
@Data @AllArgsConstructor @NoArgsConstructor
public class Produit {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String name;
	private double price;
	private double quantity;

}
```

#### maven

```
<dependency>
	<groupId>org.projectlombok</groupId>
	<artifactId>lombok</artifactId>
	<optional>true</optional>
</dependency>

<plugin>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-maven-plugin</artifactId>
	<version>${project.parent.version}</version>
	<configuration>
		<excludes>
			<exclude>
				<groupId>org.projectlombok</groupId>
				<artifactId>lombok</artifactId>
			</exclude>
		</excludes>
	</configuration>
</plugin>
```

##### Eclipse:

###### lombok.jar

<pre>
- Principe:
- il faut donc paramatrer Eclipse pour qu'il compile le code souce avec lombok (Voir la doc)
- Le résultat est le suivant:
  - lombok.jar est ajouté au niveau du Eclipse
  - Le fichier .ini est mis à jour
</pre>

###### .ini

```
-javaagent:C:\Services\devs\java\eclipse\sts\spring-tool-suite-4-4.2.2.RELEASE-e4.11.0-win32.win32.x86_64\sts-4.2.2.RELEASE\lombok.jar
```

##### STS : Spring tool Suite

###### Erreur : Unable to install local cloud services

<pre>
- Erreur lors de l'installation de plugins
- Mettre à jour STS.ini

-Djdk.http.auth.tunneling.disabledSchemes=""
</pre>

## Base de données

<a href="../spring-data/spring-data.md" target="_blank">spring-data</a>

<a href="https://www.baeldung.com/spring-boot-data-sql-and-schema-sql" target="_blank">loading-data</a>

### principe

<pre>
Pour un démarrage rapide la configuration d'une couche de persistence via Jpa/Hibernate
peut se faire simplement.
Il faut utiliser H2

Spring Boot
* instancie une base en mémoire
* génère alors un schéma à partir des entités définit
  dans la couche de persistence.
* Pour alimenter les tables, il faut alors utilisé le fichier par défaut data.sql

Pour tout autre base, il faut :
- déclarer le driver dans le pom.xml
  Le driver permet de communiquer avec la base de données
- faire la conf. de la datasource dans application.properties

</pre>

### data.sql / schema.sql

#### principe

<pre>
<b>data.sql</b>:
S'il est définit, ce fichier est exécuté par Spring-Boot pour charger les données
en base.

<b>schema.sql</b>:
S'il est définit, ce fichier est exécuté par Spring-Boot pour créer les tables 
en base.
Il faut désactiver la conf. hibernate en utilisant ce mode sinon risque d'erreur.
</pre>

#### application.properties

<pre>
Par défaut, les scripts sont exécutées sur les bases intégrées
Pour les autres, il faut ajouter la clé suivante:

<b>spring.sql.init.mode=always</b>	

* automatic schema generation hibernate avec en parallèle
  le fichier data.sql et schema.sql
  1- creation shéma hibernate
  2- exécution de schema.sql pour les changements
  3- data.sql pour le chargement de données
<b>spring.jpa.defer-datasource-initialization=true</b>
</pre>

### Spring-annotation

#### @Sql

##### prinicipe

<pre>
- Permet d'initialiser et populer les schémas de tests
</pre>

##### Configuration

<pre>
<b>Sur la classe </b>: 

@ExtendWith(SpringExtension.class)
@SpringBootTest
@Sql({"/datas/datas-test-postgre.sql"})
public class MovieServiceTest {

<b>Sur la méthode</b>
@Test
@Sql({"/import_senior_employees.sql"})
public void testLoadDataForTestCase() {
    assertEquals(5, employeeRepository.findAll().size());
}

</pre>

#### @SqlConfig

##### principe

<pre>
permet de configurer la manière de parser et d'exécuter les scripts SQL
</pre>

<pre>
<b>Sur la classe </b>: 
@SqlConfig(dataSource = "dataSourceH2", transactionManager = "transactionManager")
@Sql({"/datas/datas-test.sql"})
public class MovieRepositoryTest {ql"})
public class MovieServiceTest {

<b>Sur la méthode</b>
@Test
@Sql(scripts = {"/import_senior_employees.sql"}, 
  config = @SqlConfig(encoding = "utf-8", transactionMode = TransactionMode.ISOLATED))
public void testLoadDataForTestCase() {
    assertEquals(5, employeeRepository.findAll().size());
}

</pre>

### Config par base

#### H2: In Memory DataBase

<pre>
Base de données en mémoire
</pre>

##### pom.xml

```
<dependency>
	<groupId>com.h2database</groupId>
	<artifactId>h2</artifactId>
	<scope>runtime</scope>
</dependency>
```

##### application.properties

```
spring.datasource.url=jdbc:h2:mem:testDB
spring.h2.console.enabled=true
server.port=8086
```

##### console
<pre>
Pour accéder à la console, au niveau du <b>jar</b>:
tools => console
</pre>

##### Erreur affichage navigateur

<pre>
H2 database console spring boot Load denied by X-Frame-Options
Au niveau de l'affichage dans le navigateur, les frames ne peuvent s'afficher correctement
</pre>

```
@Override
protected void configure(HttpSecurity http) throws Exception {
// H2: resoudre le problème des frames.
http.headers().frameOptions().disable();

}
```

#### MySql

##### pom.xml

```
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-jdbc</artifactId>
	</dependency>

	<dependency>
		<groupId>com.mysql</groupId>
		<artifactId>mysql-connector-j</artifactId>
		<scope>runtime</scope>
	</dependency>

```

##### config. spb

```
spring.datasource.username=root
spring.datasource.password=gildas
spring.datasource.url=jdbc:mysql://localhost:3306/test?useSSL=false
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
```

#### PostGre

##### pom.xml

```
<dependency>
	<groupId>org.postgresql</groupId>
	<artifactId>postgresql</artifactId>
	<scope>runtime</scope>
</dependency>
```

##### config. spb

```
spring.datasource.driver-class-name=org.postgresql.Driver
spring.datasource.url=jdbc:postgresql://localhost:5432/hibernate4all
spring.datasource.username=postgres
spring.datasource.password=admin
```

## CommandLineRunner

<pre>
- Permet d'exécuter des opérations au démarrage en utilisant une fonction qui retourne une expression Lambda(@Bean)
- interface qui permet de redéfinir la méthode run
- permet de faire des traitement qd l'application est lancé
- Une fois que l'application 'SpringApplication.run ( ... )' a démarré et que tout est chargé en memoire, Spring appelle la méthode run()
</pre>

### interface

```
@SpringBootApplication
public class MyCatalogueApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(MyCatalogueApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		System.out.println(" **** ");
	}

}
```

### @Bean

<pre>
C'est mieux que d'implémenter l'interface.
Pkoi ? Car on peut injecter les Repos que l'on veut dans les paramètres
Automatiquement, spring fait l'injection des dépendances.
Plus besoin de les déclarer en attribut avec Autowired
- permet de créer un bean CommandLineRunner
- l'objet retourner exécuter dans la méthode start, le code retourné.
</pre>

```
	@Bean
	CommandLineRunner start(IHospitalService hospitalService, PatientRepository patientRepository,
			MedecinRepository medecinRepository, RendezVousRepository rendezVousRepository){
		return args -> {
			...
		};
	}
```

## test

<pre>
Ajouté l'annotation : 
@SpringBootTest
</pre>

## logs

<a href="https://www.baeldung.com/sql-logging-spring-boot" target="_blank">sql logging</a>

## maven

### spring-boot-maven-plugin

<pre>
- permet de lancer le projet via maven
- sinon faire java project.jar dans le Target
</pre>
