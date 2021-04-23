## Spring-Boot  [Boîte à outils]

### SpringDevTools
Cette dépendance est utile pour :
* prendre les modifications à chaud sans avoir besoin de redémmarer le serveur
* base de données H2: fournit une interface de connexion à la base.

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
* Principe: lombok agit au niveau compilation. Au moment, où le code est compilé, lombok parcours les annotations pour ajouter les getters/setters.. dans le byte code.
* il faut donc paramatrer Eclipse pour qu'il compile le code souce avec lombok (Voir la doc)
* Le résultat est le suivant:
	* lombok.jar est ajouté au niveau du Eclipse
	* Le fichier .ini est mis à jour
	
```
-javaagent:C:\Services\devs\java\eclipse\sts\spring-tool-suite-4-4.2.2.RELEASE-e4.11.0-win32.win32.x86_64\sts-4.2.2.RELEASE\lombok.jar
```	

### STS : Spring tool Suite

#### Erreur : Unable to install local cloud services 
* Erreur lors de l'installation de plugins
* Mettre à jour STS.ini

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
		// H2: resoudre le problème des frames.
        http.headers().frameOptions().disable();
		 
	 }
```

### CommandLineRunner
* Permet d'exécuer des opérations au démarrage en utilisant une fonction qui retourne une expression Lambda(@Bean)
* interface qui permet de redéfinir la méthode run
* permet de faire des traitement qd l'application est lancé
* Une fois que l'application 'SpringApplication.run ( ... )' a démarré et que tout est chargé en memoire, Spring appelle la méthode run()

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