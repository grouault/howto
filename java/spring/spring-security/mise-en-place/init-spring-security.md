# Spring security

##

## [retour](../index-sp-security.md)

Doc:
http://static.springsource.org/spring-security/site/docs/3.0.x/reference/core-services.html#core-services-dao-provider
https://javaetmoi.developpez.com/tutoriels/spring/configurez-spring-java/#LVI
// CAS
https://www.baeldung.com/spring-security-cas-sso
https://apereo.github.io/cas/5.1.x/planning/Architecture.html

- Principe:

---

User et Rôle:
Un utilisateur a une user et mot de passe.
Un utilisateur se voit assoicié un ou plusieurs rôles.
<security:user-service>
<security:user name="gilou" password="gilou" authorities="ROLE_FORMATEUR,ROLE_ADMIN" />
</security:user-service>
Accéder à une page/interdire l'accès à une page:
Les règles d'accès aux pages de l'application à l'aide de l'élément intercept-url.
Il s'agit simplement d'associer un pattern d'URL à un ou plusieurs rôles (séparation avec une virgule).
A noter que les patterns d'URL sont traités dans l'ordre de déclaration :
si /\*\* était déclaré en premier, les autres patterns ne seraient pas vérifiés.

<security:http>
<security:intercept-url pattern="/editerproduit.do" access="ROLE_ADMIN"/>
<security:intercept-url pattern="/\*\*" access="ROLE_USER"/>
<security:http-basic/>
</security:http>
Configuration d'une page de login personnalisée:

---

Configuration spring:
<security:intercept-url pattern="/jsp/login/login.jsp" filters="none" />
<security:form-login
login-page="/jsp/login/login.jsp"
authentication-failure-url="/jsp/login/login.jsp?login_error=1"
/>
formulaire:

<form method="post" action="<%=request.getContextPath()%>/j_spring_security_check">
  Identifiant  :<input name="j_username" value="" type="text" /><br/>
  Mot de passe :<input name="j_password" type="password" />
  <input value="Valider" type="submit" />
</form>	
	
Page de logout:
---------------	
<security:logout logout-url="/logout.do" logout-success-url="/jsp/login.jsp" invalidate-session="true"/>
	
Page accès non autorisée:
-------------------------
Quand un utilisateur authentifié tente d'accéder à une ressource non-autorisée, Spring Security renvoie par défaut une erreur HTTP 403. 
A la place, on peut demander l'affichage d'une page d'erreur personnalisée à l'aide de l'attribut access-denied-page :	
<security:http access-denied-page="/denied.do">
--> mettre en place le paramètrage normale de la vue avec le view.properties.
--> denied.do : mainController.

- configuration spring:

---

- configuration de la base de données:

---

- configuration de la page de login

---

- configuration de la page de logout

---

- taglib:

---
