## Rest

### serveur d'application vs Spring IOC

### Les 5 r�gles e RESTful
* impl�ment les 5 rg�les REST

### WebService REST
C'est un objet qui est impl�ment� dans un langage de programmation.
1- Client REST: requ�te HTTP [xml | json] ==> accept:application/json
2- Jerset Servlet : la requ�te est trait�e par une servlet (JerseyServlet) et aiguill� vers le WebService.
3- Client REST : r�ponse HTTP (xml | json)

### J2EE
- est un ensemble de sp�cification (APIs)
- pour utiliser l'API, il faut choisir une impl�mentation
- L'impl�mentation de r�f�rence, c'est celle donn�e par Oracle.

### Spring [JAX-RS / JERSEY]
- Sp�cification (API) �crit dans la norme J2EE qui permet de cr�er et g�rer des WebService de type RESTful.
- Pour utiliser une API, il faut une impl�mentation
- **JERSEY** est l'impl�mentation de r�f�rence
- CXF et REstEasy sont deux autres impl�mentations

####  Principe JERSEY
> Jersey est une libairie � importer via maven par exemple.
> C'est une servlet � configurer dans le web.xml pour traiter les requ�tes REST.
* Jersey utilise Jackson pour faire le mapping objet | json
* Jersey utilise JaxB pour faire le mapping objet | xml

##### Utilisation avec Spring
> Ce n'est pas la disptatcher-servlet qui rentre en jeu. C'est une servlet � c�t� de Spring qui sera cr�er avec une utilisation conjointe de Spring.
> Il faut dire � Spring de d�ployer Jersey. Il n'y a pas beson d'utiliser le web.xml car Spring permet de le faire diff�remment, comme une classe de configuration.
> Deux servlets sont alors pr�sentes dans le code.
```
	@Bean
	public ResourceConfig resourceConfig() {
		ResourceConfig jerseyServlet = new ResourceConfig();
		// register : demarre Jersey en lui indiquant le WebService
		jerseyServlet.register(CompteRestJaxRSAPI.class);
		return jerseyServlet;
	}
```

- **Note**: Avec Spring, JaxRS ne sert � rien car Spring MVC avec RestController fait la m�me chose

#### annotation-Jersey
```
@Path: chemin d'acc�s au WebService et au m�thodes
@PathParam: parm�tre positionn� dans l'URL
@Produces: format que l'on va produire avec la m�thode
@GET: consulter
@POST: cr�er
@PUT: mise � jour
@DELETE: suppression
```

> Exemple d'impl�mentation
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
* int�gr� les d�pendances minimum
* int�gr� le plugin maven tomcat (mvn tomcat7:run)
* configur� Jersey (web.xml)
	- sp�cifi� le package que Jersey doit scanner
	- sp�cifi� l'aiguillage des requ�tes
	
### Spring [RestController]

### Spring [SpringDataRest]
#### Principe
Spring Data Rest a d�j� cr�er un WS G�n�rique qui marche pour n'importe quel enit� JPA bas� sur Spring-Data.