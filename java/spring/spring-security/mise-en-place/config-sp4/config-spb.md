##

[retour](../../index-sp-security.md)

### Configuration par défaut

#### basique

<pre>
* Par défaut, avec la dépendances spring-security, <b>spb utilise la configuration basique</b>
<a href="https://www.baeldung.com/spring-boot-security-autoconfiguration" target="_blank">custom</a>

* Authentification qui ne sert presque à rien
* login : user
* password: celui générer dans la console

</pre>

#### désactivation

##### Spring-Boot 1

<pre>
application.properties
security.basic.enabled=false
</pre>

##### Spring Boot 2

<pre>

* application.properties
##Spring-Security : désactivation de la configuration par Défaut
##spring.autoconfigure.exclude[0]=org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration

* annotation
@EnableAutoConfiguration(exclude = {
    org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class
})
</pre>

### WebSecurityConfigurerAdapter

<pre>
1- Créer une classe de configuration: <b>SecurityConfig</b> qui étend <b>WebSecurityConfigurerAdapter</b>

2- Ajouter <b>annotations</b>: 
- @Configuration 
- @EnableWebSecurity
	
3- Redéfinir deux méthodes suivantes:
</pre>

#### AuthenticationManagerBuilder

##### définition

<pre>
<i> protected void <b>configure(AuthenticationManagerBuilder auth)</b> throws Exception</i>

	* permet de faire la configuration pour l'authentification
		* indiquer à Spring-Security comment il va chercher les utilisateurs et les roles
</pre>

##### In-Memory

```
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.inMemoryAuthentication()
            .withUser("admin").password("{noop}1234").roles("ADMIN", "USER")
            .and()
            .withUser("user").password("{noop}1234").roles("USER");
    }
```

##### Jdbc

#### HttpSecurity

##### définition

<pre>
<i> protected void <b>configure(HttpSecurity http)</b> throws Exception </i>
	* définir routes et les droits d'accès
		* definir quel 'route' nécessite d'être identifié avec quel utilisateur
	* permet d'ajouter des filtres
</pre>

##### configuration

###### default

```
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.formLogin();
        // desactivation csrf - active par défaut.
        http.csrf().disable();
        // toutes les ressources necessitent une authentification
        http.authorizeRequests().anyRequest().authenticated();
    }
```
