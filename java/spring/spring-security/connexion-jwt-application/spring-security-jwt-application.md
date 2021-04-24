## Application Spring-Security et JWT
- application qui permet de gérer des tâches
- accès via API REST sécurisé d'une manière stateless, par Spring-Security en utilisant JWT

## Projet-Spring-Boot

### dépendances

```
* spring-boot-starter-data-jpa : mapping objet relationnel
* spring-boot-starter-data-rest : mettre en place facilement API Rest (@RepositoryRestResource)
	* finalement non utilisé
* spring-boot-starter-security : spring security
* spring-boot-starter-web: on créer une application web
* io.jsonwebtoken : implémentation de jwt (dépendances manuelles)
```

### dépendance classique

```
* spring-boot-devtools : redémarrage serveur
* org.projectlombok :
* spring-boot-starter-test : test unitaire
* spring-security-tests : test unitaire de sécurité
```

## Processus d'autentification : deux filtres à mettre en place

### Filtre pour faire l'authentification

* Ce filtre implémente deux méthodes:
	* attemptAuthentication : pour fournir à Spring-Security les infos saisies par le user
	* successfulAuthentication: pour construire le token JWT
	
```
* JWT Authentication Filter :
* attemptAuthentication() : construit un objet Authentication pour Spring-Security
* checkPassword()
* successfulAuthentication() : construit le token JWT en cas d'authentifiation réussit
```

### Filtre pour vérifier les autorisations liées au token
```
* JWT Autorisation Filter :
* filtre qui s'exécute pour chaque requête (avant d'exécuter la requête pour avoir les résultats)
* vérifie la validité du token (token par valeur | on vérifie la signature du token (contient tout ce qu'il faut pour l'exploiter dans son contexte))
* si ok, spring-security met à jour son contexte : setAuthentication(user)
* si ok, la requete est envoyé au dispatcher-servlet
```

### Register (création de compte)

* Méthode qui permet de créer un user
* Particularité : créer le user/password mais ne pas retourner le password dans le flux JSon de retour.
* Pour cela, sur l'entity on utilise les annatotations suivantes:

```
	// serialisation : on ne veut pas de mot de passe
	@JsonIgnore
	public String getPassword() {
		return password;
	}

	// deserialisation à la création
	// on recupère le mot de passe.
	@JsonSetter
	public void setPassword(String password) {
		this.password = password;
	}
``` 

## Mise en place sécurité JWT

* plus besoin de formulaire d'authentification
* activer la sécurité en mode stateless et désactiver la sécurité basé sur les sessions
	```
	http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
	```
	* on passe d'un système d'authentification par référence à un système d'auhtenification par valeur.



### Création des filtres

#### JWTAuthenticationFilter
* Fonction 
	* 1- faire l'authentification
	* 2- créer le token
* classe qui héride de la classe : UsernamePasswordAuthenticationFilter
	* c'est un filtre qui intervient spécialement dans les opérations d'identification
	* c'est le filtre qui procède à l'autentification dans la méthode :
		```
		public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
		```
	* IMPORTANT : Cette méthode ne met pas dans le contexte Spring en session, les infos.
	* ce filtre a besoin de l'objet AuthenticationManager hérité de la classe WebSecurityConfigurerAdapter 
	
##### Override attemptAuthentication()

###### Pourquoi

```
* Par défaut, ce filtre récupère les informations de connection dans la request: 
	* via un request.getParameter("username")
	* via un request.getParameter("password")
	car par défaut les données sont envoyées au format www-urlencoded [username=...&password=?]
* Or pour s'authentifier, on va utiliser username/password au format JSon ; la récupération par défaut n'est donc plus adequat.
* Les données au format JSon seront à récupérer par le code : request.getInputStream().
* Pour enfin, passer par l'objet ObjectMapper(Jackson) pour déserialiser dans un objet Java.
```

###### Exemple

```
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {

		// recuperation des parametres d'authentification dans un objet JSon a deserialiser.
		AppUser user = null;
		try {
			user = new ObjectMapper().readValue(request.getInputStream(), AppUser.class);
		} catch (Exception e) {
			throw new RuntimeException(e); // pour que le user recoit qqchose
		}
		
		// tentative d'authentification qui reste la même
		// par défaut on se base sur le manager authenticationManager.
		return authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
	
	}
```

##### Override successfulAuthentication()

###### Pourquoi

* besoin de construire/générer le token JWT

```
* cette méthode reçoit en paramètre le résultat de l'authentification
* permet de récupérer les infos du user qui a été authentifié
* construction du jwtToken :
	* on met les claims [sujet, expiration, authorities]
	* la signature en précisant la méthode de hash avec le secret utilisé
	* on compact le tout : met en base64Url
* met dans la réponse le token
```

###### Insertion des constantes ou en properties

* certaines valeurs doivent être stocké soit en properties (avec annotation values), soit en constantes
* Exemple

```
public static final long EXPIRATION_TIME = 864_000_000; // 10 days
public static final String SECRET = "secret";
public static final String TOKEN_PREFIX = "Bearer ";
public static final String HEADER_STRING = "Authorization";
```

###### Exemple
```
	@Override
	protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
			Authentication authResult) throws IOException, ServletException {
		
		// recuperation du principal
		User springUser = (User)authResult.getPrincipal();
		
		// construction du jwt.
		String jwtToken = Jwts.builder()
				.setSubject(springUser.getUsername())
				.setExpiration(new Date(System.currentTimeMillis()+ SecurityConstants.EXPIRATION_TIME))
				.signWith(SignatureAlgorithm.HS256, SecurityConstants.SECRET)
				.claim("roles", springUser.getAuthorities())
				.compact();
		
		
		// mise dans la réponse du JWT
		// Ajout du préfixe : Bearer + Token
		response.addHeader(SecurityConstants.HEADER_STRING, SecurityConstants.TOKEN_PREFIX + jwtToken);
		
	}
```

#### JWTAutorisationFilter 
* il s'agit de l'implémentation d'un nouveau filtre
* Fonction
	* filtre devant analyser le token et checker la bonne authentification
	* filtre appelé à chaque requête donc c'est un filtre qui doit se placer avant les autres
		* c'est le premier filtre qui doit intercepter les requêtes
* classe qui héride de la classe : OncePerRequestFilter
	* filtre qui s'exécute à chaque requête
	* classe doFilterInternal à implémenter

##### Fonctions

```
* récupération du token et vérification que le token existe dans la requête
* si ko : on passe au filtre suivant
* si ok : on parse le token 
	* en precisant le secret et le préfixe (on doit le supprimer)
	* le parsing déclenche la vérification et provoque une exception si l'opération ne matche pas.
* si parsing ok
	* récupération des datas du token
	* mise à jour du contexte Spring pour que ce dernier soit au courant du user loggué et de ses rôles
	* poursuite de la chaine des filtres
* REMARQUE : à la fin de la requête, le contexte est vidé.
		* comme la config. de la sécurité est en mode Stateless, la session n'est pas mis à jour.
```
		
##### Exemple
```
	public class JWTAuthorisationFilter extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		

		// recuperation du token
		// check la bonne récupération
		String jwtToken = request.getHeader(SecurityConstants.HEADER_STRING);
		if (jwtToken == null || !jwtToken.startsWith(SecurityConstants.TOKEN_PREFIX)) {
			filterChain.doFilter(request, response); // on poursuit dans la chaine des filtres
			return; // on quitte la méthode
		}
		
		// parsing du token avec verification du secret.
		// renvoie une exception : SignatureException si pb.
		// pris en compte dans ExceptionTranslationFilter en AccessDeniedException
		Claims claims = Jwts.parser()
					// precise le secret pour le parser
					.setSigningKey(SecurityConstants.SECRET)
					// parse les claims en suppriment le prefixe
					.parseClaimsJws(jwtToken.replace(SecurityConstants.TOKEN_PREFIX, ""))
					// recuperation des datas du token.
					.getBody();
		
		// recuperation des datas
		String username = claims.getSubject(); // user
		// recuperation des roles et conversion dans le format Spring : GrantedAutority
		ArrayList<Map<String, String>> roles = (ArrayList<Map<String, String>>)claims.get("roles");
		Collection<GrantedAuthority> authorities = new ArrayList<>();
		roles.forEach(r -> {
			authorities.add(new SimpleGrantedAuthority(r.get("authority")));
		});
		
		// creation d'un objet usernameAuthenticationToken
		// pour chargemennt dans Spring.
		UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(username, null, authorities);
		// on met le token dans le context Spring pour que Spring soit au courant du user et de ses roles.
		SecurityContextHolder.getContext().setAuthentication(authenticationToken);
		
		filterChain.doFilter(request, response);
		
	}

}
```