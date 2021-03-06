## Spring-Security

### docs

#### Spring 3.0.1.x
https://docs.spring.io/spring-security/site/docs/3.1.x/reference/springsecurity-single.html#core-services-authentication-manager

#### Spring 3.0.2.RELEASE
https://docs.spring.io/spring-security/site/docs/3.2.0.RELEASE/reference/htmlsingle/#core-services-authentication-manager

#### Spring 4.0.4.RELEASE
https://docs.spring.io/spring-security/site/docs/4.0.4.RELEASE/reference/html/ns-config.html

#### Spring 4.2.10.RELEASE
https://www.docs4dev.com/docs/en/spring-security/4.2.10.RELEASE/reference/jc.html#jc-authentication-inmemory

#### Spring Security Kerberos
https://docs.spring.io/spring-security-kerberos/docs/current/reference/htmlsingle/

#### utils
https://www.baeldung.com/spring-security-multiple-entry-points
https://www.baeldung.com/spring-boot-security-autoconfiguration
https://docs.spring.io/spring-boot/docs/current/reference/html/appendix-application-properties.html#common-application-properties-actuator
https://mkyong.com/spring-boot/spring-rest-spring-security-example/
https://howtodoinjava.com/spring-boot2/security-rest-basic-auth-example/
https://stackoverflow.com/questions/8168119/spring-security-3-configuration-in-xml
https://www.baeldung.com/spring-security-authentication-with-a-database
https://www.baeldung.com/spring-security-multiple-auth-providers
https://stackoverflow.com/questions/18653294/how-to-correctly-encode-password-using-shapasswordencoder
https://stackoverflow.com/questions/24349219/spring-security-with-multiple-authentication-providers-usernamenotfoundexcepti

### Menu

[Protocole HTTP](protocole-http/protocole-http.md)

### Composants Spring-Security

#### SecurityContextHolder
```
* là où est stocké le contexte de sécurité applicatif pour la session en cours 
* utilisation d'un ThreadLocal pour stocker ce contexte qui est donc toujours disponible dans le même fil d'exécution.
* Spring-Security nettoie le thread quand la requête est traitée et terminée
```

#### SecurityContext

##### définition

```
* context de sécurité de l'application
* c'est l'objet qui est gardé dans le thread-local storage
* inclus les infos de l'utilisteur (Authentication)
```

##### récupération 

```
SecurityContext context = SecurityContextHolder.getContext();
```

#### Authentication / Principal

##### définition

```
* objet qui représente le principal
* il permet de stocker les informations:
	* principal (getPrincipal())
	* authorities du principal (getAuthorities())
```

##### récupération

```
Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
if (principal instanceof UserDetails) {
	String username = ((UserDetails)principal).getUserName();
}
```

#### GrantedAutority
```
* reflète les permissions au niveau application accordées à un principal
* ROLE_ADMINISTRATOR | ROLE_SUPERVISOR
* les rôles sont configurées pour les autorisation web, les méthodes et les objets métiers (domaine).
* Les objets GrantedAuthority sont chargées habituellement par le UserDetailService
```

#### UserDetails

##### définition

```
* objet qui doit permettre de fournir les informations nécéssaires pour construire l'objet Authentication.
* L'implémentation peut être celle de Spring (org.springframework.security.core.userdetails.User)
* L'implémentation peut être propre suivant les besoins. En général, on stocke le user spécifique (UserDao) de l'application.
```

##### implémentation propre

```
package fr.exagone.teamanage.security;

import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.userdetails.UserDetails;

import fr.exagone.teamanage.bean.User;
import fr.exagone.teamanage.bean.Role;

public class CSIUserDetails implements UserDetails {
	
	User user;
	
	public CSIUserDetails(User usr){
		if (usr==null){
			throw new IllegalArgumentException("Constructor Argument must not be null...");
		}
		this.user=usr;
	}
	
	public GrantedAuthority[] getAuthorities() {
		GrantedAuthority[] auths = new GrantedAuthority[user.getRoles().size()];
		int i=0;
		for (Role r : user.getRoles() ){
			GrantedAuthorityImpl auth = new GrantedAuthorityImpl(r.getCode());
			auths[i++]=auth;
		}
		return auths;
	}

	public String getPassword() {
		return null;
	}

	public String getUsername() {
		return user.getLogin();
	}

	public boolean isAccountNonExpired() {
		return false;
	}

	public boolean isAccountNonLocked() {
		return false;
	}

	public boolean isCredentialsNonExpired() {
		return false;
	}

	public boolean isEnabled() {
		return true;
	}
}
```


#### UserDetailsService

##### définition
<pre>
* classe permettant de <b>créer un objet UserDetail</b> pour stocker les informations de contexte de l'utilisteur.
	* ces informations de contexte servent de base pour l'auhentification
	* les valeurs saisies au moment de l'autentification (rest, interface utilisateur) sont comparées avec ces infos
		de contexte
	
* la recherche se fait sur le paramètre 'username' pour chercher ses infos de context (données récupérées en base par exemple) 
	* les informations à récupérer pour construire le UserDetail : username, credential, authorities

* doit implémenter la méthode :
	<i>public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException</i>

* retourne un objet qui implémente UserDetail (ex: org.springframework.security.core.userdetails.User)
	- return new User(appUser.getUserName(), appUser.getPassword(), authorities);
</pre>

##### PasswordEncoder
<pre>
* sert à <b>crypter</b> le mot de passe :
	* à la récupération, lors de la <b>création</b> initial de l'objet <b>Authentication</b>
	* au niveau de la comparaison, avec ce qui es récupérée par userDetailService
* cela signifie, que les infos stockées pour le pwd, le soit avec le passwordEncoder
</pre>

##### Implémentation
<pre>
* L'implementation se fait dans la méthode 

	<i> protected void configure(AuthenticationManagerBuilder auth) throws Exception </i>
	
* Le but est de retrouver les informations pour l'authentification quand un user se loggue.

* Les informations sont ainis récupérer et retourner dans un objet UserDetail de 3 façons :	
	* reconciliation en mémoire
	* réconciliation en base
	* réconciliation spécifique
</pre>	


###### Implémentation en mémoire 


```
package fr.exagone.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	// Dès qu'un bean de ce type est utilisé
	// il convient de l'utiliser dans la configuration d'enregisrement
	// car par defaut le manager d'auhtenfication l'utilisera pour l'authentification.
	@Bean
	public BCryptPasswordEncoder getBCryptPasswdEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		 
		 // utilisateur en mémoire.
		 // {noop} : corrige erreur : there is no PasswordEncoder mapped for the id 'null'
		 // A utiliser qd aucun encoder n'est definit
		 auth.inMemoryAuthentication()
		 	.withUser("admin").password("{noop}1234").roles("ADMIN","USER")
		 	.and()
		 	.withUser("user").password("{noop}1234").roles("USER");
			
		// avec BCryptEncoder
		// Dès qu'un encoder est définit, il faut l'utiliser
        auth.inMemoryAuthentication()
	        .withUser("admin").password(getBCryptPasswdEncoder().encode("1234")).roles("ADMIN","USER")
	        .and()
	        .withUser("user").password(getBCryptPasswdEncoder().encode("1234")).roles("USER");		
	
	 }
	 
	 @Override
	 protected void configure(HttpSecurity http) throws Exception {

		 // application stateless : désactivation
		 http.csrf().disable();
		 http.formLogin();
		 http.authorizeRequests().anyRequest().authenticated();
		 
	 }
	
}
```

###### Implémentation JDBC

```
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		 
		 // JDBC
		 auth.jdbcAuthentication()
		 	.usersByUsernameQuery("") // requete SQL pour recuperer User à partir du username.
		 	.authoritiesByUsernameQuery("") // requete SQL pour recuperer les roles utilisateurs
	
	 }
```

###### Implémentation propre ou spécifique

* Principe

```
* créer une classe qui implémente l'interface : UserDetailService
```

* Configuration

```
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		 
		// recuperation des utilisateur avec la couche de service : UserDetailService	
		// check-password
		auth
		// custo du service pour la récupération du user et de ses rôles.
			.userDetailsService(userDetailService) 
		// chargement pour UserDetail et vérification du password pour l'Authenfication manager	
			.passwordEncoder(getBCryptPasswdEncoder()); 
	
	 }
```

* Implementation de UserDetailService

```
package fr.exagone.service;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import fr.exagone.entities.AppUser;

@Service
public class UserDetailServiceImpl implements UserDetailsService {

	@Autowired
	private AccountService accountService;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		
		AppUser appUser = accountService.findUserByUserName(username);
		if (appUser == null) {
			throw new UsernameNotFoundException(username);
		}
		
		// chargement des rôles.
		Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		appUser.getRoles().forEach(r -> {
			authorities.add(new SimpleGrantedAuthority(r.getRoleName()));
		});
		
		return new User(appUser.getUserName(), appUser.getPassword(), authorities);
	
	}

}
```

### Authentification 

#### Authentification dans une application Web

<pre>
1- Visiter la HomePage et <b>cliquer sur un lien</b>

2- Une requête est envoyée au serveur et ce dernier décide si une <b>ressource protégée</b> a été demandée.

3- Comme vous n'êtes pas authentifié, le <b>serveur</b> envoie une réponse indiquant que vous devez vous authentifié:
	* soit un <b>code</b> de réponse <b>HTTP</b>
	* soit une <b>redirection</b> vers une <b>page</b> particulière

4- En fonction du mécanisme d'authentification, le <b>navigateur</b> :
	* <b>redirige</b> vers la <b>page</b> web pour remplir le formulaire
	* voit comment il <b>récupère</b> votre <b>identité</b> (basic authentifiation, cookie, x.509 certificat, ...)

5- Le navigateur envoie une réponse au seveur
	* une <b>requête HTTP POST</b> contenant les informations du formulaire d'authentification
	* un <b>header HTTP</b> contenant les éléments d'authentification

6- Le <b>serveur</b> juge si les infos d'<b>authentification</b> sont <b>valides</b> ou non.
	* si invalide, l'utilisateur est invité à recommencer
	* si ok, la prochaine étape s'exécute

7- La <b>requête originale</b> qui a déclenché le mécanisme d'authentification est <b>rejouée</b>
	* si les autorisations utilisateur sont suffisantes pour accéder à la ressource protégée, la ressource est présentée
	* sinon un ocde erreur de réponse HTTP 403 (forbidden) est envoyé
</pre>

#### Authentication Mechanism (Spring)

##### Principe

<pre>
* contexte : le navigateur envoie pour soumission les informations d'authentification:
	* http form post
	* http header

* définition : 
	* mécanisme qui est reponsable de collecter les informations d'authentification du user-agent (form-base-login and Basic Authentication)
	* une fois collectée, un objet <b>Authentication</b> basé sur la requête est construit et présenté à l'<b>AuthenticationManager</b>
	* le mécanisme 
		* jugera alors la requête <b>valide</b>
		* mettra l'objet Authentication dans le <b>SecurityContextHolder</b> 
		* rejouera la <b>requête originale</b> qui a déclenché l'authentification.

* Détail : dans le détail qui suit:
	* Les étapes 2 et 3 sont liées : l'<b>AuthenticationManager</b> a besoin du <b>UserDetailService</b>.
	* Par défaut, si le manager n'est pas redéfinit, celui-ci a besoin des infos de contexte de l'utisateur 
		pour procéder à l'authentification dans la chaine des filtres de Spring-Security.
	* Pour cela, il utilise les données de contexte chargée avec le service UserDetailService.
</pre>

##### Détail
<pre>
1- utilisateur se loggue avec un username et password
	* récupération username et password, stocké dans une instance de <b>UsernamePasswordAuthenticationToken</b>
	* retourne un objet <b>Authentication light</b> sans les Autorities
	
2- <b>obtention</b> des <b>informations de contexte</b> du user (rôle)
	* s'appuie sur <b>UserDetailService</b> pour récupérer les informations du user
	* implementation de la méthode loadUserByUsername
	* retourne un objet <b>UserDetail</b>
	
3- le système vérifie que le password est correct
	* le <b>token initial</b> est passé à une instance de <b>AuthenticationManager</b> pour authentification :	
	* C'est le manager qui procède à la vérification en <b>comparant</b> le <b>token</b> avec les informations de context <b>UserDetail</b>.
	* implémentation de la méthode: 
	
		<i>public Authentication authenticate(Authentication authentication) throws AuthenticationException</i>
		
	* si KO, on bloque l'authentification
	* sinon, l'AuthenticationManager retourne un objet <b>Authentication full</b>(UsernamePasswordAuthenticationToken)  
		complète (principal + grantedAuthority) construite à partir du UserDetail

4- Authentification réussit, l'objet <b>Authentication</b> est stockée dans le <b>SecurityContextHolder</b>
	* qui fait cette opération ? Spring Security Filter Chain par défaut.
	* l'Authentication instance est mise dans le contexte
	* le SecurityContextHolder contient alors un objet Authentication complet et accessible partour dans l'application.
</pre>

###### Algorithme

<pre>
* Code d'authentification peut se voir comme le pseudo-code qui suit: 
</pre>

```
try {
	// step-1
	Authentication request = new UsernamePasswordAuthenticationToken(request.name, request.password);
	// step- 2-3
	Authentication result = authenticationManager.authenticate(request);
	// step- 4
	SecurityContextHolder.getContext.setAuthentication(result);
} catch (AuthenticationException ex) {
	...
}
```

##### Filters
<pre>
Suivant le mode d'authentification, Spring met en jeu différents filtres pour l'authentification basique
C'est une chaine de filtre.
Suivant le mode d'accès, le bon filtre sera utilisé pour faire l'authentification
* <b>UsernamePasswordAuthenticationFilter </b>: filtre par défaut
	Les infos (credentials) sont récupérées dans la request.
* <b>BasicAuthenticationFilter </b>: filtre pour l'authentification basique
</pre>

#### UsernamePasswordAuthenticationFilter

<pre>
* Filtre qui la responsabilité de faire les opérations 1, 2 et 3 précédentes.
* la tentative de connexion est faite par : attemptAuthentication()
* la mise en session est faite par : AbstractAuthenticationProcessingFilter.successfulAuthentication()
	** Note **  : UsernamePasswordAuthenticationFilter hérite de AbstractAuthenticationProcessingFilter
* Le manager utilise par défaut, semble-t-il le provider suivant pour faire l'authentification.
</pre>

##### attemptAuthentication()

```
* Récupération username et password
	* Par défaut ces paramètres sont récupérées dans la request sous la forme suivante:
		* request.getParameter("username")
		* request.getParameter("password")
* s'appuie sur le manager 'authenticationManager' pour faire l'authentification.
```

##### successfulAuthentication()

```
* Par défaut, met dans la session et le context de Spring-Security l'objet Authentication.
```

#### AuthenticationManager

```
* composant qui a en charge de faire l'authentification
* peut déléguer l'opération à un ou plusieurs providers
* implémente la méthode authenticate()
```

```
* il faut spécifier quel type encodage/hachage on utiliser pour le passwordEncoder
	- créer une instanciation de BCryptPasswordEncoder
* suppose que le password est encodé par ailleurs dans la base de données
```


#### ExceptionTranslationFilter

* architecture

```
 package :org.springframework.security.web.access
 jar : spring-security-web.jar
```

* Principe

```
* Filtre qui a la responsabilité pour détecter tous les exceptions Spring-Security qui sont lancées :
	* toutes les exceptions de type AccessDeniedException et AuthenticationException lancées par la chaine des filtres sont traitées.
	* les autres type d'exception ne sont pas traitées dans cette classe mais remontées par ailleurs.
* ExceptionTranslationFilter offre ce service en fournissant un pont entre les exceptions java et les réponses HTTP :
	* retourner une erreur 403 (si les permissions ne sont pas suffisantes) : 
	* lancer une AuthenticationEntryPoint (si le principal n'est pas authentifié)
* Si une AuthenticationException est détectée le filtre lance l'AuthticationEntryPoint.
	* De telles exceptions sont lancées par un AbstractSecurityInterceptor, principal fournisseur de service d'autorisation.
	* Ces intercepteurs ne font que lancées des exceptions et ne connaissent rien sur HTTP et sur le processus d'authentification
* Si une AccessDeniedExceptin est détectée, le filtre détermine si le user est anonyme:
	* si oui, l'AuthenticationEntryPoint est lancé
	* si non, le filtre délègue au composant AccessDeniedHanlder (l'implémentation par défaut envoie un code error HTTP 403 - SC_FORBIDDEN)
```

##### CustomTranslationFilter
* Consiste à créer une un nouveau filtre permettant de réaliser des traitements spécifiques sur des Urls.
* Permet de créer un filtre supplémentaire à déclencher sur des urls à défnir.

###### urls
* https://stackoverflow.com/questions/37129611/spring-security-custom-exceptiontranslationfilter

###### Configuration de urls

* Chainage de filtre

```
<!-- OPCONN -->
<security:http pattern="/opc/**" auto-config="true" use-expressions="true">
	
	<security:intercept-url pattern="/opc/batch/login" access="isAnonymous()"  />
	<security:intercept-url pattern="/opc/batch/launch" access="isAnonymous()"  />
	
	<security:intercept-url pattern="/opc/batch/auth/**" access="hasAnyRole('ADMIN')"  />
	
	<!-- filtre pou l auhtentification basic -->
	<security:custom-filter ref="basicAuthenticationFilter" before="BASIC_AUTH_FILTER" />
	
	<!-- filtre pour la gestion des erreurs dans Spring-Security -->
	<security:custom-filter ref="opConnTranslationFilter" after="EXCEPTION_TRANSLATION_FILTER" />
   
</security:http>
```

###### Etendre la classe abstaite GenericFilterBean

* Création du bean Srping
```
<bean id="opConnTranslationFilter" class="fr.pomona.swet.web.security.opconn.OpConnTranslationFilter"/>
```

* Implémentation de la classe de filtre

```
import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.util.UrlUtils;
import org.springframework.web.filter.GenericFilterBean;

public class OpConnTranslationFilter extends GenericFilterBean {

    protected final Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        try {
        	
        	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            chain.doFilter(request, response);
        
        
        //} catch (IOException | ServletException e) {
        //    throw e;
        } catch (Exception e) {
        	
        	logger.error("Erreur dans le processus d'authentification : " + e.getMessage());
        	
            HttpServletRequest servletRequest = (HttpServletRequest) request;
            HttpServletResponse servletResponse = (HttpServletResponse) response;
            
            String currentUrl = UrlUtils.buildRequestUrl((HttpServletRequest) request);
            System.out.println("currentUrl = " + currentUrl);
            
            // String encodedRedirectURL = servletResponse.encodeRedirectURL(
            //         servletRequest.getContextPath() + "/opconn/access/denied");
            
            // servletResponse.sendRedirect("/swet/opconn/access/denied");
            
            // servletResponse.setStatus(HttpStatus.TEMPORARY_REDIRECT.value());
            // servletResponse.setHeader("Location", encodedRedirectURL);
            // servletResponse.sendRedirect(encodedRedirectURL);
            // chain.doFilter(servletRequest, servletResponse);
            
            
            servletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            servletResponse.getWriter().write("unauthorized");
            servletResponse.getWriter().flush();
            // servletResponse.sendError(HttpStatus.UNAUTHORIZED.value());
            return; 
                        
        }
    }

}
```










#### AuthenticationEntryPoint

* Principe

```
* AuthenticationEntryPoint est responsable du step-3 de l'authentification Web.
* Chaque application web à sa stratégie d'authentification qui est configurable dans Spring-Security.
```

## Configuration

### Configuration par défaut / Désactivation
<pre>
* Par défaut, avec la dépendances spring-security, <b>spb utilise la configuration basique</b>
* Authentification qui ne sert presque à rien
* Pour la désactiver avant de personnaliser la configuration de sécurité (https://www.baeldung.com/spring-boot-security-autoconfiguration):
</pre>


#### Spring-Boot 1
<pre>
* application.properties
security.basic.enabled=false
</pre>


#### Spring Boot 2
<pre>

* application.properties
##Spring-Security : désactivation de la configuration par Défaut
##spring.autoconfigure.exclude[0]=org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration

* annotation
@EnableAutoConfiguration(exclude = {
    org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class
})
</pre>

### Etablir une configuration de base : WebSecurityConfigurerAdapter

<pre>
1- Créer une classe de configuration: <b>SecurityConfig</b> qui étend <b>WebSecurityConfigurerAdapter</b>

2- Ajouter <b>annotations</b>: 
- @Configuration 
- @EnableWebSecurity
	
3- Redéfinir deux méthodes suivantes:

<i> protected void <b>configure(AuthenticationManagerBuilder auth)</b> throws Exception</i>

	* permet de faire la configuration pour l'authentification
		* indiquer à Spring-Security comment il va chercher les utilisateurs et les roles

<i> protected void <b>configure(HttpSecurity http)</b> throws Exception </i>
	* définir routes et les droits d'accès
		* definir quel 'route' nécessite d'être identifié avec quel utilisateur
	* définir les filtres
</pre>

## CSRF
* Attention, il faut le désactiver, sinon certaines actions sont impossibles, pour une authentificatin stateless (sans les sessions)
* Pour la partie back-end, API REST, (PUT | POST), il faut désactiver.
* Souvent la partie Front-End, est une autre techno.
* Il faut utiliser une parade au niveau du token JWT pour pallier ce problème.

```
* Quand Spring-Security est activé, par défaut CSRF est activé. 
* Si le jeton CSRF n'est pas transmis, cela empêche certaines actions
	* Exemple : 403: FORBIDDEN sur un appel REST en POST  
```








