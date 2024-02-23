## Rest

[home](../index-soa.md)

### serveur d'application vs Spring IOC

### Les 5 règles e RESTful

- implément les 5 rgèles REST

### WebService REST
<pre>
C'est un objet qui est implémenté dans un langage de programmation.
1- Client REST: requête HTTP [xml | json] ==> accept:application/json
2- Jerset Servlet : la requête est traitée par une servlet (JerseyServlet) et aiguillé vers le WebService.
3- Client REST : réponse HTTP (xml | json)
</pre>

### J2EE
<pre>
- est un ensemble de spécification (APIs)
- pour utiliser l'API, il faut choisir une implémentation
- L'implémentation de référence, c'est celle donnée par Oracle.
</pre>

### Spring [JAX-RS / JERSEY]
<pre>
- Spécification (API) écrit dans la norme J2EE qui permet de créer et gérer des WebService de type RESTful.
- Pour utiliser une API, il faut une implémentation
- <b>JERSEY</b> est l'implémentation de référence
- CXF et REstEasy sont deux autres implémentations
</pre>

#### Principe JERSEY
<pre>
> Jersey est une libairie à importer via maven par exemple.
> C'est une servlet à configurer dans le web.xml pour traiter les requêtes REST.

- Jersey utilise Jackson pour faire le mapping objet | json
- Jersey utilise JaxB pour faire le mapping objet | xml
</pre>

##### Utilisation avec Spring
<pre>
> Ce n'est pas la disptatcher-servlet qui rentre en jeu. 
C'est une servlet à côté de Spring qui sera créer avec une utilisation conjointe de Spring.
> Il faut dire à Spring de déployer Jersey. 
Il n'y a pas beson d'utiliser le web.xml car Spring permet de le faire différemment, 
comme une classe de configuration.
> Deux servlets sont alors présentes dans le code.
<b>Note</b>: Avec Spring, JaxRS ne sert à rien car Spring MVC avec RestController fait la même chose
</pre>

```
	@Bean
	public ResourceConfig resourceConfig() {
		ResourceConfig jerseyServlet = new ResourceConfig();
		// register : demarre Jersey en lui indiquant le WebService
		jerseyServlet.register(CompteRestJaxRSAPI.class);
		return jerseyServlet;
	}
```

#### annotation-Jersey

```
@Path: chemin d'accès au WebService et au méthodes
@PathParam: parmètre positionné dans l'URL
@Produces: format que l'on va produire avec la méthode
@GET: consulter
@POST: créer
@PUT: mise à jour
@DELETE: suppression
```

#### Exemple d'implémentation

```
@Component
@Path("/banque")
public class CompteRestJaxRSAPI {

	@Autowired
	private CompteRepository compteRepository;

	@Path("/comptes")
	@GET
	@Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
	public List<Compte> compteList() {
		return compteRepository.findAll();
	}

	@Path("/comptes/{id}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Compte getOne(@PathParam(value = "id") Long id) {
		return compteRepository.findById(id).get();
	}

	@Path("/comptes")
	@POST
	@Produces({MediaType.APPLICATION_JSON})
	public Compte save(Compte compte) {
		return compteRepository.save(compte);
	}

	@Path("/comptes/{id}")
	@PUT
	@Produces({MediaType.APPLICATION_JSON})
	public Compte update(Compte compte, @PathParam(value = "id") Long id) {
		compte.setId(id);
		return compteRepository.save(compte);
	}

	@Path("/comptes/{id}")
	@DELETE
	@Produces({MediaType.APPLICATION_JSON})
	public void delete(@PathParam(value = "id") Long id) {
		compteRepository.deleteById(id);
	}

}
```

#### Configuration : Projet Maven | Jersey

- intégré les dépendances minimum
- intégré le plugin maven tomcat (mvn tomcat7:run)
- configuré Jersey (web.xml)
  - spécifié le package que Jersey doit scanner
  - spécifié l'aiguillage des requêtes

### Spring [RestController]

### Spring [SpringDataRest]

#### Principe
<pre>
Spring Data Rest a déjà créer un WS Générique qui marche pour n'importe quel enité JPA basé sur Spring-Data.

Caractéristique Rest Spring Data:
- structure HATEOAS
  norme autodescriptif : lien entre les ressources (norme RESTFULL)
  si un produit appartient à une catégorie, on envoie le lien pour consulter la catégorie
</pre>

#### Configuration

##### dépendance
<pre>
Attention, avec cette dépendance, les services REST sont activés par défauts.
Pour les inactivés par défaut voir la configuration ci-après
</pre>
```
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-data-rest</artifactId>
</dependency>
```

##### application.properties
<pre>
# Exposes all public repository interfaces but considers @(Repository)RestResource\u2019s `exported flag.
spring.data.rest.detection-strategy=default

# Exposes all repositories independently of type visibility and annotations.
spring.data.rest.detection-strategy=all

# Only repositories annotated with @(Repository)RestResource are exposed, unless their exported flag is set to false.
spring.data.rest.detection-strategy=annotated

# Only public repositories annotated are exposed.
spring.data.rest.detection-strategy=visibility
</pre>

#### getAll
<pre>
Par défaut, spring data rest renvoie une page.
Ne renvoie pas tous les items mais page par page.
Consulter tous les produits, consulte avec la notion de pages
</pre>
```
"page": {
		"size": 20,
		"totalElements": 3,
		"totalPages": 1,
		"number": 0
}

Exemple d'appels: 
http://localhost:8089/products?page=0&size=2

```

#### tri
<pre>
Par défault le tri est pris en compte

Exemple:
http://localhost:8089/products?page=0&size=20&sort=price,desc
</pre>

#### ids
<pre>
Par défault les identifiants ne sont pas exposés
Pour exposer l'id:

	@Bean
	CommandLineRunner start(ProductRepository productRepository, RepositoryRestConfiguration configurationRest) {
		return args -> {
			configurationRest.exposeIdsFor(Product.class);
</pre>

#### Projections
<pre>
Par défault, tous les attributs sont exposés.
Pour afficher moins d'attributs il faut utiliser les projections.
</pre>
```
		// A mettre dans le même package que l'entity
    @Projection(name="mobile", types = Product.class)
    interface ProductProjectionMobile{
        String getName();
    }
```

#### Ajout de méthodes

<pre>
Les méthodes ajoutées dans le repository sont accessibles en rest
</pre>

##### Recherche par attribut
<pre>
* créer une méthode de recherche par nom par exemple
* paramétrage REST pour son accès
</pre>
```
    // recherche sur nom
    // http://localhost:8089/products/search/by-name?kw=HP
    // http://localhost:8089/products/search/by-name?kw=HP&projection=mobile&page=0&size=2
    @RestResource(path="/by-name")
    Page<Product> findByNameContains(@Param("kw")String name, Pageable pageable);

```

#### JSon
##### boucle infini
<pre>
Quand on a une relation bidirectionnel:
@JsonProperty(access=JSonProperty.access.writeOnly)

@JsonIgnor
</pre>