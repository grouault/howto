[home](../index.md)

## Problématique

<pre>
Pour qu'un framework ORM puisse enregistrer les objets dans une base de données, il doit
connaître les métadonnées de correspondance pour la classe d'entité

Chaque ORM dispose de ses proprés métadonnées.
JPA définit alors un ensemble d'annoations de persistance qui définit un format standard.
</pre>

## éléments de programmation fondamentaux pour différentes stratégies

| Concept   | JDBC         | Hibernate          | JPA                  | Spring                       |
| --------- | ------------ | ------------------ | -------------------- | ---------------------------- |
| Ressource | Connection   | Session            | EntityManager        | Session ou EntityManager     |
| Fabrique  | DataSource   | SessionFactory     | EntityManagerFactory | Fabrique Spring de Ressource |
| Exception | SQLException | HibernateException | PersistenceException | DataAccessException          |

## JPA, Hibernate et stratégies de correpondance

<pre>
3 stratégies pour la correspondance et la persistances des objets:
* API hibernate + correspondance XML (hbm)
* API hibernate + annotation JPA
* API JPA + annoation JPA
</pre>

### Persistance avec API Hibernate et fichier XML.

#### hibernate.cfg.xml

<pre>
* chaque application qui utilise hibernate a besoind d'un fichier global pour configurer certaines propriétés
  - propriétés de connexion, dialiect, emplacement des fichiers de correspondance
</pre>

#### hbm

<pre>
* créé un fichier de correpondance hbm.xml par classe entité
  hbm : hibernate metadata
* ces fichiers sont à référencer dans le fichier de configuration.
</pre>

#### initialisation fabrique

<pre>
Pour utiliser hibernate, il faut donc créer une fabrique de session.
Son rôle est de produire des sessions pour pouvoir enregistrer les objets.
Intanciation avec l'objet configuration qui se base sur le fichier de configuration
</pre>

##### Code

```
Configuration configuration = new Configuration().configure();
SessionFactory sessionFactory = configurtion.buildSessionFactory();
```

### Persistance avec API Hibernate et annoation JPA

<pre>
* plus de fichier hbm
* des classes annotées avec @Entity
* noms des classes à spécifier dans le fichier de configuration
</pre>

##### Code

```
Configuration configuration = new AnnotationConfiguration().configure();
SessionFactory sessionFactory = configurtion.buildSessionFactory();
```

### Persistance avec API JPA et annoation JPA

#### Principe

<pre>
* Outre les annotations, JPA définit un ensemble d'interfaces de programmation.
* Hibernate implément ces interfaces grâces au module HibernateEntityManager
* JPA doit donc se baser sur un moteur compatible (Hibernate ici)
</pre>

#### Persistence.xml

<pre>
* la configuration JPA se fait avec le fichier Persistence.xml
* se trouve dans le répertoire META-INF
* contient une ou plusieurs unités de persistence < persistence-unit >
</pre>

#### persistence-unit

<pre>
* une unité de persistance définit un ensemble de classes persistances et la manière
  dont leur persistance est assurée.
* chaque unité de persistance exige un nom unique
</pre>

#### module hibernate-entityManager

<pre>
* détecte automatiquement que les fichiers XMLs de correspondance et les annotations JPA
  sont des métadonnées de correspondance
* inutile de les préciser explicitement dans le fichier de configuration
</pre>

#### EntityManagerFactory

<pre>
Pour utiliser JPA, il faut donc créer une fabrique de gestionnaire d'entité.
Son rôle est de produire des gestionnaire d'entités pour pouvoir enregistrer les objets.
L'<b>entityManagerFactory</b> est un objet mémoire qui contient toute la conf. JPA
pour créer des <b>enityManager</b>.
</pre>

##### Code

```
EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("nom-persistance-unit");
EntityManager entityManager = entityManagerFactory.createEntityManager();
EntityTransaction tx = entityManger.getTransaction();
....
```

## Problématique

<pre>
Dans les implémentations précédentes pour hibernate et JPA :
* code standard que nous devons reproduire de multiple fois
* code qui ne diffère que sur quelques lignes
* chaque framework à sa propre API pour la gestion locale des transactions

* configuration de la fabrique au travers le l'API native (hibernate ou JPA)
* application ne bénéficie pas des fonctions d'accès aux données apportées par Spring
</pre>

### Solution

<pre>
* Déléguer à Spring la création des Factory

* Spring fournit plusieurs beans de fabrique pour pouvoir créer une fabrique de sessions hibernate
ou une fabrique de gestionnaires d'entités JPA sous forme d'un bean unique dans le conteneur.

* Ces fabriques peuvent alors être partagées par plusieurs beans grâce à l'injection de dépendance.
</pre>

### Fabrique de session dans Spring

<pre>
* LocalSessionFactoryBean : avec des fichiers xmls de correspondance
* AnnotationSessionFactoryBean : pour l'utilisation des annotations

<b>Note</b>: 
* le fichier hibernate.cfg.xml est supprimé
* les éléments sont transférés au Spring
</pre>

### Fabrique de gestionnaire d'entité dans Spring

<pre>
* LocalEntityManagerFactoryBean : se base sur le fichier persistence.xml
* LocalContainerEntityManagerFactoryBean:
    * permet d'assouplir le fichier persistence.xml
    * de transférer les élements de configuration au spring
    * seul reste les unité de persistances avec leur nom dans le fichier de configuration

</pre>
