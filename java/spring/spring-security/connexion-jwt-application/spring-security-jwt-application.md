## Application Spring-Security et JWT
- application qui permet de g�rer des t�ches
- acc�s via API REST s�curis� d'une mani�re stateless, par Spring-Security en utilisant JWT

## Projet-Spring-Boot

### d�pendances

```
* spring-boot-starter-data-jpa : mapping objet relationnel
* spring-boot-starter-data-rest : mettre en place facilement API Rest (@RepositoryRestResource)
	* finalement non utilis�
* spring-boot-starter-security : spring security
* spring-boot-starter-web: on cr�er une application web
* io.jsonwebtoken : impl�mentation de jwt (d�pendances manuelles)
```

### d�pendance classique

```
* spring-boot-devtools : red�marrage serveur
* org.projectlombok :
* spring-boot-starter-test : test unitaire
* spring-security-tests : test unitaire de s�curit�
```

## Processus d'autentification : deux filtres � mettre en place

### Filtre pour faire l'authentification

* Ce filtre impl�mente deux m�thodes:
	* attemptAuthentication : pour fournir � Spring-Security les infos saisies par le user
	* successfulAuthentication: pour construire le token JWT
	
```
* JWT Authentication Filter :
* attemptAuthentication() : construit un objet Authentication pour Spring-Security
* checkPassword()
* successfulAuthentication() : construit le token JWT en cas d'authentifiation r�ussit
```

### Filtre pour v�rifier les autorisations li�es au token
```
* JWT Autorisation Filter :
* filtre qui s'ex�cute pour chaque requ�te (avant d'ex�cuter la requ�te pour avoir les r�sultats)
* v�rifie la validit� du token (token par valeur | on v�rifie la signature du token (contient tout ce qu'il faut pour l'exploiter dans son contexte))
* si ok, spring-security met � jour son contexte : setAuthentication(user)
* si ok, la requete est envoy� au dispatcher-servlet
```

### Register (cr�ation de compte)

* M�thode qui permet de cr�er un user
* Particularit� : cr�er le user/password mais ne pas retourner le password dans le flux JSon de retour.
* Pour cela, sur l'entity on utilise les annatotations suivantes:

```
	// serialisation : on ne veut pas de mot de passe
	@JsonIgnore
	public String getPassword() {
		return password;
	}

	// deserialisation � la cr�ation
	// on recup�re le mot de passe.
	@JsonSetter
	public void setPassword(String password) {
		this.password = password;
	}
``` 

## Mise en place s�curit� JWT

* plus besoin de formulaire d'authentification
* activer la s�curit� en mode stateless et d�sactiver la s�curit� bas� sur les sessions
	```
	http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
	```
	* on passe d'un syst�me d'authentification par r�f�rence � un syst�me d'auhtenification par valeur.



### Cr�ation des filtres

#### JWTAuthenticationFilter
* Fonction 
	* 1- faire l'authentification
	* 2- cr�er le token
* classe qui h�ride de la classe : UsernamePasswordAuthenticationFilter
	* c'est un filtre qui intervient sp�cialement dans les op�rations d'identification
	* c'est le filtre qui proc�de � l'autentification dans la m�thode :
		```
		public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
		```
	* IMPORTANT : Cette m�thode ne met pas dans le contexte Spring en session, les infos.
	* ce filtre a besoin de l'objet AuthenticationManager h�rit� de la classe WebSecurityConfigurerAdapter 
	
##### Override attemptAuthentication()

###### Pourquoi

```
* Par d�faut, ce filtre r�cup�re les informations de connection dans la request: 
	* via un request.getParameter("username")
	* via un request.getParameter("password")
	car par d�faut les donn�es sont envoy�es au format www-urlencoded [username=...&password=?]
* Or pour s'authentifier, on va utiliser username/password au format JSon ; la r�cup�ration par d�faut n'est donc plus adequat.
* Les donn�es au format JSon seront � r�cup�rer par le code : request.getInputStream().
* Pour enfin, passer par l'objet ObjectMapper(Jackson) pour d�serialiser dans un objet Java.
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
		
		// tentative d'authentification qui reste la m�me
		// par d�faut on se base sur le manager authenticationManager.
		return authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
	
	}
```

##### Override successfulAuthentication()

###### Pourquoi

* besoin de construire/g�n�rer le token JWT

```
* cette m�thode re�oit en param�tre le r�sultat de l'authentification
* permet de r�cup�rer les infos du user qui a �t� authentifi�
* construction du jwtToken :
	* on met les claims [sujet, expiration, authorities]
	* la signature en pr�cisant la m�thode de hash avec le secret utilis�
	* on compact le tout : met en base64Url
* met dans la r�ponse le token
```

###### Insertion des constantes ou en properties

* certaines valeurs doivent �tre stock� soit en properties (avec annotation values), soit en constantes
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
		
		
		// mise dans la r�ponse du JWT
		// Ajout du pr�fixe : Bearer + Token
		response.addHeader(SecurityConstants.HEADER_STRING, SecurityConstants.TOKEN_PREFIX + jwtToken);
		
	}
```

#### JWTAutorisationFilter 
* il s'agit de l'impl�mentation d'un nouveau filtre
* Fonction
	* filtre devant analyser le token et checker la bonne authentification
	* filtre appel� � chaque requ�te donc c'est un filtre qui doit se placer avant les autres
		* c'est le premier filtre qui doit intercepter les requ�tes
* classe qui h�ride de la classe : OncePerRequestFilter
	* filtre qui s'ex�cute � chaque requ�te
	* classe doFilterInternal � impl�menter

##### Fonctions

```
* r�cup�ration du token et v�rification que le token existe dans la requ�te
* si ko : on passe au filtre suivant
* si ok : on parse le token 
	* en precisant le secret et le pr�fixe (on doit le supprimer)
	* le parsing d�clenche la v�rification et provoque une exception si l'op�ration ne matche pas.
* si parsing ok
	* r�cup�ration des datas du token
	* mise � jour du contexte Spring pour que ce dernier soit au courant du user loggu� et de ses r�les
	* poursuite de la chaine des filtres
* REMARQUE : � la fin de la requ�te, le contexte est vid�.
		* comme la config. de la s�curit� est en mode Stateless, la session n'est pas mis � jour.
```
		
##### Exemple
```
	public class JWTAuthorisationFilter extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		

		// recuperation du token
		// check la bonne r�cup�ration
		String jwtToken = request.getHeader(SecurityConstants.HEADER_STRING);
		if (jwtToken == null || !jwtToken.startsWith(SecurityConstants.TOKEN_PREFIX)) {
			filterChain.doFilter(request, response); // on poursuit dans la chaine des filtres
			return; // on quitte la m�thode
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