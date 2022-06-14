## Microservice [How-to-dev]

[home](../index-soa.md)

#### 1- Spring Boot librairie

Les librairies maven � installer :

```
	* Spring-web
	* Spring Data Jpa (sql)
	* RestRepositories (spring data rest)
	* H2 Database
	* lombok
	* SpringBootDevTools
```

#### 2 Couche DAO

##### 2.1 Composant de couche DAO

    - Base de donn�es H2
    - Entity JPA
    - ProduitRepository : utilisation de l'impl�mentation SpringData bas� sur JPA (JpaRepository)
    - JPA est une impl�mentation : utilisation de l'impl�mentation Hibernate

##### 2.2 entity

> Cr�er l'entit� JPA avec Lombok, annotation JPA

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

##### 2.2 reposoitory

> Repository Spring Data : cr�ation d'une interface qui h�rit� de JpaRepository (mapping objet-relationnel se fait � ce nivau l�)

- RestController

```
public interface ProduitRepository extends JpaRepository<Produit, Long> {
}
```

- Spring Data Rest

```
@RepositoryRestResource
public interface ProduitRepository extends JpaRepository<Produit, Long> {
	@RestResource(path="/byName")
	Page<Produit> findByNameContains(@Param("kw") String name, Pageable pageable);
}
```

#### 3- Couche Web

##### 3.1- RestController

    * Cr�ation d'une classe ProduitRestService avec l'annotation @RestController
    * Injection des d�pendance sur le repository
    * Cr�ation des m�thodes REST

##### 3.2- Spring Data Rest

    * Toutes les m�thodes accessibles via JpaRepository sont accessibles via RESTfull via un WebService
    * Le WS permet d'acc�der aux fonctionnalit�s expos�es par l'interface JpaRepository.

#### 4 Configuration

#### 4.1 application.properties

> La configuration se fait dans le fichier de configuration application.properties

```
spring.datasource.url=jdbc:h2:mem:testDB
server.port=8082
```

#### 4.2 annotation config

> Pour instancier certains composants aux d�marrage de l'application si n�cessaire

```
@Configuration
public class MyConfig {

	/**
	 * RestController
	 * - Pour convertir en flux XML avec RestController, il faut instancier un converter xml
	 *
	 * @return
	 */
	@Bean
	public HttpMessageConverter<Object> createXmlHttpMessageConverter(){
	    final MarshallingHttpMessageConverter xmlConverter = new MarshallingHttpMessageConverter();
	    final XStreamMarshaller xstreamMarshaller = new XStreamMarshaller();
	    xstreamMarshaller.setAutodetectAnnotations(true);
	    xmlConverter.setMarshaller(xstreamMarshaller);
	    xmlConverter.setUnmarshaller(xstreamMarshaller);
	    return xmlConverter;
	}



}
```

#### 5 Application

> Un WebService est une application qui doit booter rapidement.

##### 5.1 Cr�er et lancer l'application

```
	* Cr�er une classe application qui contient la m�thode main

	* SpringBoot fournit une Classe, une application @SpringBootApplication dans lequel on a le code:
		SpringApplication.run( ... )

	* Spring d�marre alors l'application :
		- scanne les classes pour d�tecter les annotations
		- lit le fichier de properties pour configurer le ms
		- essaie de d�marrer en un minimum de temps
```

##### 5.2 Exemple

```
@SpringBootApplication
public class MsBanqueApplication {

	public static void main(String[] args) {
		SpringApplication.run(MsBanqueApplication.class, args);
	}

	@Bean
	CommandLineRunner start(CompteRepository compteRepository,
			RepositoryRestConfiguration restConfig,
			ClientRepository clientRepository) {

		return args -> {

			restConfig.exposeIdsFor(Compte.class);

			// ajout repository
			Client c1 = clientRepository.save(new Client(null, "Hassan",null));
			Client c2 = clientRepository.save(new Client(null, "Mohamed",null));

			// ajout compte.
			compteRepository.save(new Compte(null, Math.random()*9000, new Date(), TypeCompte.EPARGNE, c1));
			compteRepository.save(new Compte(null, Math.random()*8000, new Date(), TypeCompte.COURANT, c1));
			compteRepository.save(new Compte(null, Math.random()*7000, new Date(), TypeCompte.EPARGNE, c2));

			compteRepository.findAll().forEach(c -> {
				System.out.println(c.getSolde());
			});

		};
	}

}
```
