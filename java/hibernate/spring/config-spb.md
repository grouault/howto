[home](../index.md)

## Configuration hibernate

- géré dans un fichier de configuration avec la création des beans
- TODO: à détailler.

## jar vs war dans le pom.xml

```
https://devstory.net/11903/deployer-le-application-spring-boot-sur-tomcat-server
```

## open-session-in-view

- Attention avec Spring, la configuration par défaut est active.
- Il convient de désactiver cet anti-pattern dans le fichier
  application.properties:

```
spring.jpa.open-in-view=false
```

## Problèmes

- Au lancement de l'application, le tomcat ne se lancait pas.
  Solution : mettre en commentaire le scope provided

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
    <!--<scope>provided</scope>-->
</dependency>
```
