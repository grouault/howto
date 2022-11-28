# Spring-Data - Principe

[retour](./spring-data.md)

## Définition

<pre>
* couche d'abstraction au dessus de JPA
* au démarrage, spring configure automatiquement la datasource avec JPA
    et mysql, par exemple (en fonction des dépendances mis dans le POM.xml)

* Avec JPA, pour les repository on a beaucoup de code qui se ressemble.
* ==> beaucoup d'interfaces qui se ressemblent (find, persist)
* Spring data créé une interface générique pour tous les repository.
* Spring data propose donc un mécanisme pour avoir le moins de code à maintenir
</pre>

## persistance

### principe

<pre>
Sans Spring-Data, on est obligé de faire la configuration
* de l'accès à la base de données
* de l'entity manager
* d'hibernate
* du transaction-manager

Spring-Data permet de s'affranchir de cette configuration.

Le fichier <b><a href="./hibernate/persistance-config.java" target="_blanck">persistence-config</a></b>
peut être remplacé par des propriétés du fichier application.properties

Du fichier PersistenceConfig, les <b>annotations</b> suivantes sont activées automatiquement
par Spring-Boot:
- @EnableTransactionManagement
- tout ce qu'est scan de paquets

</pre>

### Configuration

[config-hibernate](../../hibernate/spring/config-sgbd.md.md)

#### pom.xml

```
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
```

#### application.properties

##### DataSource

<pre>
spring.datasource.driver-class-name=org.postgresql.Driver
spring.datasource.url=jdbc:postgresql://localhost:5432/hibernate4all
spring.datasource.username=postgres
spring.datasource.password=admin
</pre>

##### Jpa / Hibernate

<pre>
spring.jpa.open-in-view=false
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.database=mysql
# pour un fournisseur autre qu'hibernate
spring.jpa.generate-ddl=false (enable or disable schema initialisation)
# pour le fournisseur hibernate
spring.jpa.hibernate.ddl-auto=none | validate | create | update | create-drop

</pre>

##### Tests

<pre>
Fichier JPA / Hibernate :
<b><a href="./hibernate/persistance-config.java" target="_blanck">MovieRepositoryTest</a></b>

en Spring-Data : On a plus besoin des annotations:
- @ContextConfiguration
- @SqlConfig
Mais on ajoute : <a>@SpringBootTest</a>

Fichier Spring-data
</pre>

### JpaRepository (Spring-Jpa)

#### principe

<pre>
* interface à associer à une entité JPA.
* peut être injecter par la suite
* spring se débrouille pour donner une implémentation qui convienne à notre interface
* L'implémentation fournit pas mal de méthode par défaut.

* Attention, il faut toujours veiller à voir quelle sont les requêtes générés derrière
</pre>

#### exemple

<pre>
public interface MedecinRepository extends JpaRepository<Medecin, Long> {
}
</pre>

#### implémentation

<pre>
* L'implémentation par défaut : SimpleJpaRepository
</pre>

#### exemple de méthodes

##### save

<pre>
* correspond à un persist si c'est une nouvelle entité
* sinon fait un merge
</pre>

#### ajout de requête simple

##### Par mot-clé: @Query et @Override

<pre>
L'ajout de nouvelle requête peut se faire de manière simple
en respectant la nomenclature de l'entité et de ses attributs
Il faut aussi utilisé les mots-clés définit par Spring-Boot
==> voir la doc

Il est aussi possible de faire un @override des méthodes par défaut
</pre>

<a href="https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#jpa.query-methods.query-creation" target="_blank">doc</a>

<a href="https://spring.io/blog/2022/05/02/ever-wanted-to-rewrite-a-query-in-spring-data-jpa" target="_blank">rewrite query</a>

###### Exemple

```
public interface MedecinRepository extends JpaRepository<Medecin, Long> {
    @Query
    Medecin findByNom(String nom);

    @Override
    @EntityGraph(attributePaths = {"movie"})
    List<MovieDetails> findAll();
}
```

#### requête complexe

##### principe

<pre>
Pour les requêtes complexes, il faut:
* créer une nouvelle interface et son implémentation
* faire hériter l'interface JpaRepository de cette nouvelle interface
==> il est alors possible d'écrire les requêtes que l'on souhaite

<b>IMPORTANT</b> : il faut respecter la règle de nommage.
Interface et Implementation ont le même nom.
L'implémentation a le suffixe <b>Impl</b>
</pre>

##### exemple

```
1- création d'une interface
public interface MovieDetailsRepositoryExtended {

    void addMovieDetails(MovieDetails movieDetails, Long idMovie);

    MovieDetails getMovieDetails(Long id);

}

2- implémentation
public class MovieDetailsRepositoryExtendedImpl implements MovieDetailsRepositoryExtended {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public void addMovieDetails(MovieDetails movieDetails, Long idMovie) {
        Movie movieRef = entityManager.getReference(Movie.class, idMovie);
        movieDetails.setMovie(movieRef);
        entityManager.persist(movieDetails);
    }


3- héritage de l'interface
public interface MovieDetailsRepository extends JpaRepository<MovieDetails, Long>, MovieDetailsRepositoryExtended {
}
```

## Pagination

### principe

<pre>
Pageable : interface qui permet de normaliser ce qui est pagination
PageRequest : implémentation de pageable

</pre>

### exemple 1

#### JPA

```
List<Movie> movies = entityManager.createQuery(" select m from Movie m order by m.name", Movie.class)
						.setFirstResult(start)
						.setMaxResults(maxResults)
						.getResultList();
```

#### spring data

```
Page<Movie> movies = repository.findAll(PageRequest.of(0,50, Sort.by("name")));
==> accéder aux proriétés du pageable
movies.getPageable().getPageSize()
==> accés direct
movies.getContent()
movies.getSize
```

### exemple 2

```
// recuperation par pagination
// on recupere la page 1 avec 2 elements par page
Page<Produit> produits = produitRepository.findAll(PageRequest.of(1, 2));
System.out.println(produits.getSize());
System.out.println(produits.getTotalElements());
System.out.println(produits.getTotalPages());

produits.getContent().forEach(p -> {
	System.out.println(p.toString());
});
```

## Recherche

#### findByDesignation

- find : select \* from Produit
- ByDesignation: where designation

```
public interface ProduitRepository extends JpaRepository<Produit, Long> {

	public List<Produit> findByDesignation();

}
```

#### findByDesignationContains

- contains : like %...%

```
	public interface ProduitRepository extends JpaRepository<Produit, Long> {

		public Page<Produit> findByDesignationContains(String mc, Pageable pageable);

	}
```

- Code appelant :

```
	// recuperation de tous Produits.
	Page<Produit> produits = produitRepository.findByDesignationContains("Imprimante", PageRequest.of(0, 2));
	produits.getContent().forEach(p -> {
		System.out.println(p.toString());
	});
```

#### Query

- Query hql

```
	/**
	 * recherche par designation et prix minimum
	 *
	 * @param mc
	 * @param prix
	 * @param pageable
	 * @return
	 */
	@Query("select p from Produit p where p.designation like :x and p.prix>:y")
	public Page<Produit> chercherParDesignationEtPrixMinimum(
			@Param("x")String mc, @Param("y") double prix, Pageable pageable);
```
