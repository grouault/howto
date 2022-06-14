## Rest

### serveur d'application vs Spring IOC

### Les 5 règles e RESTful
* implément les 5 rgèles REST

### WebService REST
C'est un objet qui est implémenté dans un langage de programmation.
1- Client REST: requête HTTP [xml | json] ==> accept:application/json
2- Jerset Servlet : la requête est traitée par une servlet (JerseyServlet) et aiguillé vers le WebService.
3- Client REST : réponse HTTP (xml | json)

### J2EE
- est un ensemble de spécification (APIs)
- pour utiliser l'API, il faut choisir une implémentation
- L'implémentation de référence, c'est celle donnée par Oracle.

### Spring [JAX-RS / JERSEY]
- Spécification (API) écrit dans la norme J2EE qui permet de créer et gérer des WebService de type RESTful.
- Pour utiliser une API, il faut une implémentation
- **JERSEY** est l'implémentation de référence
- CXF et REstEasy sont deux autres implémentations

####  Principe JERSEY
> Jersey est une libairie à importer via maven par exemple.
> C'est une servlet à configurer dans le web.xml pour traiter les requêtes REST.
* Jersey utilise Jackson pour faire le mapping objet | json
* Jersey utilise JaxB pour faire le mapping objet | xml

##### Utilisation avec Spring
> Ce n'est pas la disptatcher-servlet qui rentre en jeu. C'est une servlet à côté de Spring qui sera créer avec une utilisation conjointe de Spring.
> Il faut dire à Spring de déployer Jersey. Il n'y a pas beson d'utiliser le web.xml car Spring permet de le faire différemment, comme une classe de configuration.
> Deux servlets sont alors présentes dans le code.
```
	@Bean
	public ResourceConfig resourceConfig() {
		ResourceConfig jerseyServlet = new ResourceConfig();
		// register : demarre Jersey en lui indiquant le WebService
		jerseyServlet.register(CompteRestJaxRSAPI.class);
		return jerseyServlet;
	}
```

- **Note**: Avec Spring, JaxRS ne sert à rien car Spring MVC avec RestController fait la même chose

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

> Exemple d'implémentation
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
* intégré les dépendances minimum
* intégré le plugin maven tomcat (mvn tomcat7:run)
* configuré Jersey (web.xml)
	- spécifié le package que Jersey doit scanner
	- spécifié l'aiguillage des requêtes
	
### Spring [RestController]

### Spring [SpringDataRest]
#### Principe
Spring Data Rest a déjà créer un WS Générique qui marche pour n'importe quel enité JPA basé sur Spring-Data.