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

### Composants Spring-Security

#### SecurityContextHolder
```
* l� o� est stock� le contexte de s�curit� applicatif pour la session en cours 
* utilisation d'un ThreadLocal pour stocker ce contexte qui est donc toujours disponible dans le m�me fil d'ex�cution.
* Spring-Security nettoie le thread quand la requ�te est trait�e et termin�e
```

#### SecurityContext

##### d�finition

```
* context de s�curit� de l'application
* c'est l'objet qui est gard� dans le thread-local storage
* inclus les infos de l'utilisteur (Authentication)
```

##### r�cup�ration

```
SecurityContext context = SecurityContextHolder.getContext();
```

#### Authentication / Principal

##### d�finition

```
* objet qui repr�sente le principal
* il permet de stocker les informations:
	* principal (getPrincipal())
	* authorities du principal (getAuthorities())
```

##### r�cup�ration

```
Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
if (principal instanceof UserDetails) {
	String username = ((UserDetails)principal).getUserName();
}
```

#### GrantedAutority
```
* refl�te les permissions au niveau application accord�es � un principal
* ROLE_ADMINISTRATOR | ROLE_SUPERVISOR
* les r�les sont configur�es pour les autorisation web, les m�thodes et les objets m�tiers (domaine).
* Les objets GrantedAuthority sont charg�es habituellement par le UserDetailService
```

#### UserDetails

##### d�finition

```
* objet qui doit permettre de fournir les informations n�c�ssaires pour construire l'objet Authentication.
* L'impl�mentation peut �tre celle de Spring (org.springframework.security.core.userdetails.User)
* L'impl�mentation peut �tre propre suivant les besoins. En g�n�ral, on stocke le user sp�cifique (UserDao) de l'application.
```

##### impl�mentation propre

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

##### d�finition
```
* classe permettant de cr�er un objet UserDetail pour stocker les informations de contexte de l'utilisteur.
* la recherche se fait sur le param�tre 'username' pour chercher ses infos de context (donn�es r�cup�r�es en base par exemple) 
	* les informations � r�cup�rer pour construire le UserDetail : username, crediential, authorities
* doit impl�menter la m�thode 
* retourne un objet qui impl�mente UserDetail (ex: org.springframework.security.core.userdetails.User)
	- return new User(appUser.getUserName(), appUser.getPassword(), authorities);
```

##### Impl�mentation en m�moire 

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

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		 
		 // utilisateur en m�moire.
		 // {noop} : corrige erreur : there is no PasswordEncoder mapped for the id 'null'
		 auth.inMemoryAuthentication()
		 	.withUser("admin").password("{noop}1234").roles("ADMIN","USER")
		 	.and()
		 	.withUser("user").password("{noop}1234").roles("USER");
	
	 }
	 
	 @Override
	 protected void configure(HttpSecurity http) throws Exception {

		 // application stateless : d�sactivation
		 http.csrf().disable();
		 http.formLogin();
		 http.authorizeRequests().anyRequest().authenticated();
		 
	 }
	
}
```

##### Impl�mentation JDBC

```
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		 
		 // JDBC
		 auth.jdbcAuthentication()
		 	.usersByUsernameQuery("") // requete SQL pour recuperer User � partir du username.
		 	.authoritiesByUsernameQuery("") // requete SQL pour recuperer les roles utilisateurs
	
	 }
```

##### Impl�mentation propre ou sp�cifique

* Principe

```
* cr�er une classe qui impl�mente l'interface : UserDetailService
```

* Configuration

```
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		 
		// recuperation des utilisateur avec la couche de service : UserDetailService	
		// check-password
		auth
			.userDetailsService(userDetailService) // service pour la r�cup�ration du user et de ses r�les.
			.passwordEncoder(getBCryptPasswdEncoder()); // verification du password
	
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
		
		// chargement des r�les.
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
* Sc�nario dans une application web :
```
1- Visiter la HomePage et cliquer sur un lien
2- Une requ�te est envoy�e au serveur et ce dernier d�cide si une ressource prot�g�e a �t� demand�e.
3- Comme vous n'�tes pas authentifi�, le server envoie une r�ponse indiquant que vous devez vous authentifi�:
	* soit un code de r�ponse HTTP
	* soit une redirection vers une page particuli�re
4- En fonction du m�canisme d'authentification, le navigateur :
	* redirige vers la page web pour remplir le formulaire
	* voit comment il r�cup�re votre identit� (basic authentifiation, cookie, x.509 certificat, ...)
5- Le naviateur envoie une r�ponse au seveur
	* une requ�te HTTP POST contenant les informations du formulaire d'authentification
	* un header HTTP contenant les �l�ments d'authentification
6- Le serveur juge si les infos d'authentification sont valides ou non.
	* si invalide, l'utilisateur est invit� � recommencer
	* si ok, la prochaine �tape s'ex�cute
7- La requ�te originale qui a d�clench� le m�canisme d'authentification est rejou�e
	* si les autorisations utilisateur sont suffisantes pour acc�der � la ressource prot�g�e, la ressource est pr�sent�e
	* sinon un ocde erreur de r�ponse HTTP 403 (forbidden) est envoy�
```

#### Authentication Mechanism (Spring)

* Principe

```
* contexte : le navigateur envoie pour soumission les informations d'authentification:
	* http form post
	* http header
* d�finition : 
	* m�canisme qui est reponsable de collecter les informations d'authentification du user-agent (form-base-login and Basic Authentication)
	* une fois collect�e, un objet Authentication bas� sur la requ�te est construit et pr�sent� � l'AuthenticationManager
	* le m�canisme jugera alors la requ�te valide, mettra l'objet Authentication dans le SecurityContextHolder 
		et rejouera la requ�te qui a d�clench� l'authentification.
```

* D�tail
	* Les �tapes 2 et 3 sont li�es : l'AuthenticationManager a besoin du UserDetailService.
	* Par d�faut, si le manager n'est pas red�finit, celui-ci a besoin des infos de contexte de l'utisateur pour proc�der � l'authentification dans la chaine des filtres de Spring-Security.
	* Pour cela, il utilise les donn�es de contexte charg�e avec le service UserDetailService.

````
1- utilisateur se loggue avec un username et password
	* r�cup�ration username et password, stock� dans une instance de UsernamePasswordAuthenticationToken
	* retourne un objet Authentication light sans les Autorities
	
2- obtention des informations de contexte du user (r�le)
	* s'appuie sur UserDetailService pour r�cup�rer les informations du user
	* implementation de la m�thode loadUserByUsername
	* retourne un objet UserDetail
	
3- le syst�me v�rifie que le password est correct
	* le token initial est pass� � une instance de AuthenticationManager pour authentification :	
	* C'est le manager qui proc�de � la v�rification en comparant le token avec les informations de context UserDetail.
	* impl�mentation de la m�thode: 
		public Authentication authenticate(Authentication authentication) throws AuthenticationException
	* si KO, on bloque l'authentification
	* l'AuthenticationManager retourne une instance Authentication (UsernamePasswordAuthenticationToken) compl�te construite � partir du UserDetail

4- Authentification r�ussit, l'objet Authentication est stock�e dans le SecurityContextHolder
	* qui fait cette op�ration ? Spring Security Filter Chain par d�faut.
	* l'Authentication instance est mise dans le contexte
	* le SecurityContextHolder contient alors un objet Authentication complet et accessible partour dans l'application.
````

* Code d'authentification peut se voir comme cela: 
```
try {
	// step-1
	Authentication request = new UsernamePasswordAuthenticationToken(request.name, request.password);
	// step- 2-3
	Autheniction result = authenticationManager.authenticate(request);
	// step- 4
	SecurityContextHolder.getContext.setAuthentication(result);
} catch (AuthenticationException ex) {
	...
}
```

#### AuthenticationManager

```
* composant qui a en charge de faire l'authentification
* peut d�l�guer l'op�ration � un ou plusieurs providers
* impl�mente la m�thode authenticate()
```

```
* il faut sp�cifier quel type encodage/hachage on utiliser pour le passwordEncoder
	- cr�er une instanciation de BCryptPasswordEncoder
* suppose que le password est encod� par ailleurs dans la base de donn�es
```


#### ExceptionTranslationFilter

* architecture

```
 package :org.springframework.security.web.access
 jar : spring-security-web.jar
```

* Principe

```
* Filtre qui a la responsabilit� pour d�tecter tous les exceptions Spring-Security qui sont lanc�es :
	* toutes les exceptions de type AccessDeniedException et AuthenticationException lanc�es par la chaine des filtres sont trait�es.
	* les autres type d'exception ne sont pas trait�es dans cette classe mais remont�es par ailleurs.
* ExceptionTranslationFilter offre ce service en fournissant un pont entre les exceptions java et les r�ponses HTTP :
	* retourner une erreur 403 (si les permissions ne sont pas suffisantes) : 
	* lancer une AuthenticationEntryPoint (si le principal n'est pas authentifi�)
* Si une AuthenticationException est d�tect�e le filtre lance l'AuthticationEntryPoint.
	* De telles exceptions sont lanc�es par un AbstractSecurityInterceptor, principal fournisseur de service d'autorisation.
	* Ces intercepteurs ne font que lanc�es des exceptions et ne connaissent rien sur HTTP et sur le processus d'authentification
* Si une AccessDeniedExceptin est d�tect�e, le filtre d�termine si le user est anonyme:
	* si oui, l'AuthenticationEntryPoint est lanc�
	* si non, le filtre d�l�gue au composant AccessDeniedHanlder (l'impl�mentation par d�faut envoie un code error HTTP 403 - SC_FORBIDDEN)
```

##### CustomTranslationFilter
* Consiste � cr�er une un nouveau filtre permettant de r�aliser des traitements sp�cifiques sur des Urls.
* Permet de cr�er un filtre suppl�mentaire � d�clencher sur des urls � d�fnir.

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

* Cr�ation du bean Srping
```
<bean id="opConnTranslationFilter" class="fr.pomona.swet.web.security.opconn.OpConnTranslationFilter"/>
```

* Impl�mentation de la classe de filtre

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
* Chaque application web � sa strat�gie d'authentification qui est configurable dans Spring-Security.
```

## Configuration

### Configuration par d�faut / D�sactivation
* Par d�faut, avec la d�pendances spring-security, spb utilise la configuration basique
* Authentification qui ne sert presque � rien
* Pour la d�sactiver avant de personnaliser la configuration de s�curit� (https://www.baeldung.com/spring-boot-security-autoconfiguration):

1- Spring-Boot 1
```
* application.properties
security.basic.enabled=false
```

2- Spring Boot 2
```
* application.properties
##Spring-Security : d�sactivation de la configuration par D�faut
##spring.autoconfigure.exclude[0]=org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration

* annotation
@EnableAutoConfiguration(exclude = {
    org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class
})
```

### Etablir une configuration de base : WebSecurityConfigurerAdapter

```
* Cr�er une classe de configuration: SecurityConfig qui �tend WebSecurityConfigurerAdapter

* Ajouter annotations: 
	- @Configuration 
	- @EnableWebSecurity
	
* Red�finir deux m�thodes suivantes:

	** protected void configure(AuthenticationManagerBuilder auth) throws Exception
	- indiquer � Spring-Security comment il va chercher les utilisateurs et les roles
	
	** protected void configure(HttpSecurity http) throws Exception
	- d�finir les droits d'acc�s, les 'roots'
	- d�finir les filtres
	
```

## CSRF
* Attention, il faut le d�sactiver, sinon certaines actions sont impossibles, pour une authentificatin stateless (sans les sessions)
* Pour la partie back-end, API REST, (PUT | POST), il faut d�sactiver.
* Souvent la partie Front-End, est une autre techno.
* Il faut utiliser une parade au niveau du token JWT pour pallier ce probl�me.

```
* Quand Spring-Security est activ�, par d�faut CSRF est activ�. 
* Si le jeton CSRF n'est pas transmis, cela emp�che certaines actions
	* Exemple : 403: FORBIDDEN sur un appel REST en POST  
```








