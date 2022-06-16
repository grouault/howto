# HIBERNATE - Mapping - Annotations

[home](../index.md)

# Annotation
<pre>
* la place des annotations est importantes
    * sur les attributs (FieldAccess)
    * sur les getters (GetterAccess)
* hibernate regarde ces annotations pour mapper les attributs en base
    FieldAccess: hibernate regarde sur les attributs
    GetterAcess: hibernate regarde sur les getters
* Bonne pratique : mettre les annotations sur les attributs
</pre>

### mapping implicit
<pre>
* sans annoation sur les attributs, hibernate regarde les attributs pour les mapper en base
* tout ce qui est implicit peut être configuré
</pre>


## @Entity
<pre>
* annotation JPA: indique une classe à persister
</pre>

## @Id
### Note
<pre>
* la place des annotations est importantes
    * sur les attributs (FieldAccess)
    * sur les getters (GetterAccess)
* hibernate regarde ces annotations pour mapper les attributs en base
    FieldAccess: hibernate regarde sur les attributs
    GetterAcess: hibernate regarde sur les getters
* Bonne pratique : mettre les annotations sur les attributs
    @ID sur le champ ID plutôt que sur GETID()
    Sinon chaque mapping qui commence par un "get" entraine un mapping
    sur la base de données
</pre>

### @GeneratedValue
<pre>
* représente la façon dont l'id est généré
* il faut Sequence si possible car c'est la plus performante
</pre>

#### SEQUENCE
<pre>
SEQUENCE : 
    * utilise une séquence en base de données
    * la séquence est décorrélée de la table
    * L'appel à la séquence est atomique et hors transaction
    * Si la transaction échoue et déclenche le rollback, la valeur de la séquence aura augmenté
</pre>

#### IDENTITY
<pre>
IDENTITY : 
    * Similaire à la séquence : mécanisme de génération est associé à la table
        et pas disponible sur toutes les bases
    * à utiliser sur MYSQL qui n'a pas le mécanisme de séquence
</pre>

#### TABLE
<pre>
TABLE : 
    * Très peu utilisé
    * Hibenate va créer une table pour la génération de l'id
</pre>

#### AUTO
<pre>
AUTO : 
    * Hibernate choisit en fonction de la base de données
</pre>

#### @Transient
<pre>
* pour ne pas mapper un attribut
</pre>

## Enum and Converter

### @Enumerated
<pre>
    // Code 
    @Enumerated(EnumType.STRING)
    private Certification certification;
</pre>

### Converter

####  Définition
<pre>
* pour mapper un type non standard
* la conversion s'implémente dans les deux sens
* <b>Attention</b> : si un converter est mis en place sur un attribut de type énumération
    l'annotation @Enumerated n'a plus lieu d'être
* le but du converter est de convertir la valeur stockée en base dans une énumération
</pre>

* Exemple d'énumération, candidate à un converter:
<pre>
    TOUT_PUBLIC(1, "Tout public"),
    INTERDIT_MOINS_12(2, "Interdit au moins de 12 ans"),
    INTERDIT_MOINS_16(3, "Interdit au moins de 16 ans"),
    INTERDIT_MOINS_18(4, "Interdit au moins de 18 ans");

    private Integer key;
    private String description;
</pre>

#### Exemple
```
// autoApply=true indique que, dès qu'une entité du domaine a un attribut Certification
// hibernate applique le converter
@Converter(autoApply = true)
public class CertificationAttributeConverter implements AttributeConverter<Certification, Integer> {

    @Override
    public Integer convertToDatabaseColumn(Certification certification) {
        return certification != null ? certification.getKey(): null;
    }

    @Override
    public Certification convertToEntityAttribute(Integer dbData) {
        return Stream.of(Certification.values())
                     .filter(certif -> certif.getKey().equals(dbData))
                     .findFirst()
                     .orElse(null);
    }

}
```

#### Config
<pre>
* ajouter le converter au niveau du package to scan de l'entity manager
    
    em.setPackagesToScan("com.hibernate4all.tutorial.domain",
        "com.hibernate4all.tutorial.converter");
</pre>

### Bonne pratique
<pre>
* La bonne pratique, c'est d'avoir un entier stocké en base et dans le code, une
    énumération qui fait le lien entre les entiers et les valeurs de l'énumération
    ==> Converter
</pre>

## Equals / HashCode / toString
### Prealable
<pre>
* Un id fonctionnel est caractéristique
* il doit impérativement être non null, immuable et unique
</pre>
### Règle
<pre>
Règle 1:
* Quand une entité a un identifiant fonctionnel, il faut s'appuyer dessus
  pour implémenter les méthodes
* Il faut donc repérer les entités avec et sans id fonctionnel.
  C'est ce qui permet d'écrire les equals et hashcode

Règle 2:
* pas d'association dans equals et hashCode
* les entités associés ne doivent jamas faire partire de ces méthodes
</pre>
### Exemple avec un identifiant fonctionnel
* name est un identifiant fonctionnel
```
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Movie)) return false;
        Movie other = (Movie) o;
        return Objects.equals(this.getName(), other.getName());
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.getName());
    }
```

### Exemple sans identifiant fonctionnel
* equals : on se base sur l'id
* hash : on retourne une constante

```
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Movie)) return false;
        Movie other = (Movie) o;
        if (this.getId() == null && other.getId() == null) {
            return Objects.equals(this.getName(), other.getName()) &&
                    Objects.equals(this.getDescription(), other.getDescription()) &&
                    Objects.equals(this.getCertification(), other.getCertification());
        }
        return this.getId() != null && Objects.equals(this.getId(), other.getId());
    }

        @Override
    public int hashCode() {
        return Objects.hash(31);
    }

    @Override
    public String toString() {
        return "Movie{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", certification=" + certification +
                '}';
    }

```

## Association
### Théorie
<pre>
* les associations hibernate reflète les associations de la base

* une association entre deux tables est matérialisé par une <b>clé etrangère</b> entre deux tables

* la clé étrangère est une colonne qui référence la clé primaire de l'autre table

* <b>important</b> : la chose à savoir, c'est laquelle des deux tables référence l'autre,
    laquelle des deux possèdent la clé étrangère
</pre>

### Exemple
<pre>
* un Movie peut avoir plusieurs Review
</pre>

Exemple Schéma 1 faux:
* si la clé étrangère est dans Movie, il est impossible de renseigner plusieurs Review

![schema](../img/modele-theorie-ko.png)

Exemple Schéma 2 ok:
* les 2 lignes dans Review vont référencées la clé dans Movie

![schema](../img/modele-theorie-ok.png)


### @ManyToOne and @OneToMany

#### Association bidirectionnelle

<pre>
* Association qui permet de faire la navigation dans les 2 sens
* accèder aux Review depuis Movie
* accèder aux Movie depuis Review

Attention : dans notre exemple
* seul le sens Review -> Movie est matérialisée
* le sens Movie -> Review ne l'est pas

<b>Important</b> : dans une relation bidirectionnelle @OneToMany/@ManyToOne,
la clé étrangère se trouve sur l'attribut annoté @ManyToOne.
L'entité ayant cet attribut est l'entité <b>propriétaire</b> de la relation
</pre>

#### Mapping 
<pre>
* côté de l'asso avec clé

    <b>@ManyToOne</b>(fetch = FetchType.LAZY)
    @JoinColumn(name="movie_id")
    private Movie movie;

* côté de l'asso sans clé

    // Dans Review, l'attribut Movie correspond à la clé étrangère
    // Qd on sauvegarde un movie, ca va sauvegarder les reviews de ce Movie
    <b>@OneToMany</b>(mappedBy = "movie", cascade = CascadeType.ALL, orphanRemoval = true)
    private List< Review > reviews;

</pre>

##### @JoinColumn
<pre>
* Cette annotation indique la clé étrangère
* Si non renseigné, mapping implicit qui sera déduit par convention (Entité Associée_ID)
</pre>

##### Fetch
<pre>
* permet d'indiquer le type de récupération des associations
* Attention au FetchType par défaut
* Hibernate s'aligne maintenant avec JPA: 
    * Eager sur @ManyToOne
    * Lazy sur @OneToMany
    Question ?? : Quiz
    Par défaut dans JPA, toute association est en EAGER.
</pre>

##### cascade
<pre>
* on propage les actions effectuées sur l'entité vers l'association (Ex: Persist, Delete)
</pre>

##### orphanRemoval
<pre>
* true : évite les orphelins
    * par exemple si on fait review.setMovie(null)
    * si hibernate voit une entité Review non associé à une entité Movie, il supprime l'entité Review
</pre>

##### mappedBy
<pre>
* indique le côté de l'assocation qui contient la clé étrangère et donc ou est fait 
    le mapping de l'association
</pre>

#### règle de la bidirection
<pre>
* <b>Attention</b> : la bidirection implique du code en plus
* Il faut redéfinir les méthodes d'ajout et de suppression
* Il est important de passer par ces méthodes
</pre>

##### Exemple de Test
```
@Test
public void association_casNominal() {
    Movie movie = new Movie().setName("Fight Club")
                    .setCertification(Certification.INTERDIT_MOINS_12)
                    .setDescription("Le Fight Club n'existe pas");
    Review review1 = new Review().setAuthor("max").setContent("super film!");
    Review review2 = new Review().setAuthor("jp").setContent("au top!");
    movie.getReviews().add(review1);
    movie.getReviews().add(review2);
    repository.persist(movie);
    }
```
<pre>
<b>Analyse:</b> 
Dans ce test les Reviews sont créés <b>sans valeur pour MOVIE_ID</b>.

Pourquoi?
C'est Review qui est <b>propriétaire</b> de la relation.
C'est le Movie renseigné dans Review qui fait foi.

A aucun moment, on a fait un review.setMovie( ... )
<b>Solution</b> : Il faut donc penser à renseigner les deux côtés de l'associations
</pre>

##### Solution
* Réécriture des méthodes de suppression et d'ajout

```
    public Movie addReview(Review review) {
        if (review != null) {
            this.reviews.add(review);
            review.setMovie(this);
        }
        return this;
    }

    public Movie remmoveReview(Review review) {
        if (review != null) {
            this.reviews.remove(review);
            review.setMovie(null);
        }
        return this;
    }
```

* Protéger la méthodes getReviews() pour qu'elle ne soit pas utiliser pour faire un 
  ajout de Review.
  
```  
    public List<Review> getReviews() {
        return Collections.unmodifiableList(reviews);
    }

    ==> Permet d'empêcher la modification de la liste
    movie.getReviews.add(...) : va déclencher une RuntimeException.
```

