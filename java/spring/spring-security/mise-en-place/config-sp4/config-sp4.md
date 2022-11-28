## Architecture - mise en place

[retour](../../index-sp-security.md)

## web.xml

Dans un contexte J2ee deux choses à faire à minima:

- WEB.xml ajouter un listener pour que le fichiers Spring soient chargés dans le context J2ee

```
  <!-- Chargement du Spring -->
  <context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath*:spring/*-context.xml</param-value>
  </context-param>

  <listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
  </listener>

  <!-- Spring Security -->
  <filter>
  	<filter-name>springSecurityFilterChain</filter-name>
  	<filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
  </filter>

  <!-- // toutes les urls -->
  <filter-mapping>
  	<filter-name>springSecurityFilterChain</filter-name>
  	<url-pattern>/*</url-pattern>
  </filter-mapping>
```

## spring-security-context.xml

- Réaliser un fichier de configuration dédié au Spring-Security

### authentication-manager

Permet de définir des providers

#### authentication-provider

Permet de définir les objets qui vont fournir les informations d'authenfication

### http

#### \* intercept-url

Permet de dire le/les ressources à sécuriser en fonction d'un ou plusieurs rôles

#### \* http-basic

#### \* form-login

#### \* form-logout

#### \* access-denied-handler

#### \* csrf
