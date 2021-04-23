## Spring-Boot  [Bo�te � outils]

### SpringDevTools
Cette d�pendance est utile pour :
* prendre les modifications � chaud sans avoir besoin de red�mmarer le serveur
* base de donn�es H2: fournit une interface de connexion � la base.

### Lombok
> Gestion des Getters/Setters, toString, constructeur
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
##### Eclipse:
* Principe: lombok agit au niveau compilation. Au moment, o� le code est compil�, lombok parcours les annotations pour ajouter les getters/setters.. dans le byte code.
* il faut donc paramatrer Eclipse pour qu'il compile le code souce avec lombok (Voir la doc)
* Le r�sultat est le suivant:
	* lombok.jar est ajout� au niveau du Eclipse
	* Le fichier .ini est mis � jour
	
```
-javaagent:C:\Services\devs\java\eclipse\sts\spring-tool-suite-4-4.2.2.RELEASE-e4.11.0-win32.win32.x86_64\sts-4.2.2.RELEASE\lombok.jar
```	

### STS : Spring tool Suite

#### Erreur : Unable to install local cloud services 
* Erreur lors de l'installation de plugins
* Mettre � jour STS.ini

```
-Djdk.http.auth.tunneling.disabledSchemes=""
```	

### Configuration de l'application
> La configuration se fait dans le fichier de configuration application.properties

```
server.port=8082
```

### MySql

```
spring.datasource.username=root
spring.datasource.password=gildas
spring.datasource.url=jdbc:mysql://localhost:3306/test?useSSL=false
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.jpa.database=mysql
spring.jpa.generate-ddl=false
spring.jpa.hibernate.ddl-auto=validate
```

### H2: In Memory DataBase

#### Configuration

```
* application.properties
spring.datasource.url=jdbc:h2:mem:testDB
```

#### Erreur affichage navigateur

> H2 database console spring boot Load denied by X-Frame-Options
> Au niveau de l'affichage dans le navigateur, les frames ne peuvent s'afficher correctement

```
	 @Override
	 protected void configure(HttpSecurity http) throws Exception {
		// H2: resoudre le probl�me des frames.
        http.headers().frameOptions().disable();
		 
	 }
```

### CommandLineRunner
* Permet d'ex�cuer des op�rations au d�marrage en utilisant une fonction qui retourne une expression Lambda(@Bean)
* interface qui permet de red�finir la m�thode run
* permet de faire des traitement qd l'application est lanc�
* Une fois que l'application 'SpringApplication.run ( ... )' a d�marr� et que tout est charg� en memoire, Spring appelle la m�thode run()

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