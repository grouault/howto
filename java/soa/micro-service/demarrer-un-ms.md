## Microservice [How-to-dev]

[home](../index-soa.md)

#### 1- Spring Boot librairie

Les librairies maven 0 installer :

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
<pre>
Spring Data et JPA pour faciliter le mapping objet/Relationnel

	- Base de donn2es H2
	- Entity JPA
	- ProduitRepository : utilisation de l'implémentation SpringData basé sur JPA (JpaRepository)
	- JPA est une implémentation : utilisation de l'implémentation Hibernate
</pre>

##### 2.2 entity

> Créer l'entité JPA avec Lombok, annotation JPA

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

> Repository Spring Data : création d'une interface qui hérite de JpaRepository 
	(mapping objet-relationnel se fait à ce nivau là)

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

#### 3- Couche Service

##### DTO
<pre>
Les entités JPA sont des objets lourds.
Ils sont surveillés par le framework en mémoire.
Ce sont donc des objets qui consomment de la ressource et on a pas
intérêt à ce qu'il se trouve au niveau de la couche web.

DTO; objet plus léger adapté à la partie UI :
- supprimer les attributs inutiles
- les relations
- les annotations
</pre>


#### 4- Couche Web

##### 4.1- RestController

    * Création d'une classe ProduitRestService avec l'annotation @RestController
    * Injection des dépendance sur le repository
    * Création des méthodes REST

##### 4.2- Spring Data Rest

    * Toutes les méthodes accessibles via JpaRepository sont accessibles via RESTfull via un WebService
    * Le WS permet d'accéder aux fonctionnalités exposées par l'interface JpaRepository.

#### 5 Configuration

#### 5.1 application.properties

> La configuration se fait dans le fichier de configuration application.properties

```
spring.datasource.url=jdbc:h2:mem:testDB
server.port=8082
```

#### 5.2 annotation config

> Pour instancier certains composants aux démarrage de l'application si nécessaire

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

#### 6 Application

> Un WebService est une application qui doit booter rapidement.

##### 6.1 Créer et lancer l'application

```
	* Créer une classe application qui contient la méthode main

	* SpringBoot fournit une Classe, une application @SpringBootApplication dans lequel on a le code:
		SpringApplication.run( ... )

	* Spring démarre alors l'application :
		- scanne les classes pour détecter les annotations
		- lit le fichier de properties pour configurer le ms
		- essaie de démarrer en un minimum de temps
```

##### 6.2 Exemple

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
