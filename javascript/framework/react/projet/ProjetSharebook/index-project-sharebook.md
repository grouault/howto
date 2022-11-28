# Projet Sharebook

[retour](../../index-react.md)

## Archi

![archiback](./img/0-archi-backend.PNG)

## Spring

### spring-core

<pre>
* container spring initialiser au runtime (lancement de l'appication)
  ==> permet d'ajouter des comportements dynamiquement
* contient la config. de l'application
* on utilise une interface.
 * au niveau de la déclaration des beans dans la configuration 
 * au niveau des beans injectés dans les classes, 
    * mais c'est l'implémentation qui sera injecté: @autowired
</pre>

![archispring](./img/2-spring-core.PNG)

![restful](./img/4-RestFull.PNG)

### spring mvc

<a href="../../../../../java/spring/spring-mvc/rest-mvc.md" target="_blank">Rest-Mvc</a>

#### RestFul

<pre>
* approche RestFull : respecter au maximum l'approche REST
</pre>

#### @RestController

<pre>
Spring MVC fournit la notion de controleur, qui permet de donner 
des points d'entrée dans l'application pour se brancher aux services.
Contrôleur métier:
BookController: gestion des livres
UserController: gestion des utilisateurs et incscription
BorrowController: gestion des emprunts

Contrôleur technique
JwtController: gestion de la partie authentification
</pre>

#### BookController

![restful](./img/5-BookControleur.PNG)

#### UserController

![restful](./img/6-UserController.PNG)

#### BarrowController

![restful](./img/7-BorrowController.PNG)

## Modèle de données

![modeles](./img/8-modele-de-donnees.PNG)

### Spring data

#### modèle

![modeles](./img/9-modele-jpa.PNG)

#### pom.xml

```

```

## Front

### Ecran

![liste-ecran](./img/front/liste-ecran-0.PNG)

![liste-ecran](./img/front/list-ecran-1.PNG)

### React-Router

![img-router](./img/front/react-router-0.PNG)

### Hook

![hook](./img/front/hook.PNG)

### axios

![axios](./img/front/axios-promesse.PNG)
