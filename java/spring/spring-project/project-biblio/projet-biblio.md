## Projet Biblio

[home](../../index-spring.md)

### Projet Spring

#### Démarrage
<pre>
* JDK 11 en JAVA_HOME
* Mettre dans le ficher de configuration persistence-dev.properties:
  javax.persistence.jdbc.url=jdbc:h2:tcp://localhost:9290/~/biblio
* builder de war et le déployer dans le Tomcat9 avec le port 8086
* démarrer/arrêter le tomcat: 
  - startup.bat
  - shutdown.bat
* démarrer le base de données:
  - démarrer le serveur H2 via la classe H2Server.
  - les données sont peuplées avec le listener: BilbiothequeListener

</pre>

#### Struture

##### Configuration Spring: IOC + propertyPlaceHolder
<pre>
- soit via xml ou annotation ou fichier de configuration
</pre>

##### Configuration de la couche de persistance
<pre>
* JPA / Spring Data JPA

* Dépendances maven

* Configuration des entités persistantes: @Entity

* Configuration des repositories: 
  - composant : @Repository o
  - interface : JpaRepository

* Configuration de la data source et du provider JPA (Hibernate)
  pour les tests unitaires
  * propriétés de la couche de persistence: persistence.properties
  * un fichier /META-INF/persistence.Xml minimaliste 

* classe de configuration pour le test de la couche de persistence: SpringConfigTestRepository

* classe de tests unitaires des repositories

</pre>

##### Configuration de la couche métier
<pre>
*  L'interface métier Bibliothèque

* Propriétés de configuration via properties

* Impléméntation

* Profiles
    persistence-dev.properties
    persistence-prod.properties

* Classe de configuration couche métier et persistence

* Classe de test d'intégration des couches métiers te persistance

* Profile en ligne de commandes

</pre>

##### Configuration de la couche web (REST)

<pre>
* dépendances maven

* contôleurs REST

* classes de configuration de la couche web

* Test d'intégration de l'API Rest

* Configuration DispatcherServlet

* Mise en oeuvre via un client Angular
</pre>
