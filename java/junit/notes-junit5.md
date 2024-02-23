### JUNIT-5

[home](index-junit.md)

### @BeforeEach, @AfterEach

<pre>
s'exécute avant et après chaque test définit sur la page
</pre>

### @BeforeAll, @AfterAll

<pre>
pour exécuter une opération coûteuse avant chaque test, il est 
préférable d'utiliser cette annotation.
exécuter une seule fois avant de d'éxécuter tous les tests.
</pre>

### @BeforeTransaction, @AfterTransaction
<pre>
* Après chaque méthode de tests.
</pre>


### @Test
<pre>
* permet de réaliser un cas de test
<i>
    @Test
    public void findCasNominal(){
        Movie movie = movieRepository.find(-1L);
        assertThat(movie.getTitle()).as("Le nom attendu est incorrect").isEqualTo("Inception");
    }
</i>
</pre>

### Assertion (Junit)

#### AssertEquals

<pre>
import static org.junit.jupiter.api.Assertions.assertEquals;
</pre>

#### AssertThrows

<pre>
import static org.junit.jupiter.api.Assertions.assertThrows;
</pre>

```
    @Test
    public void getReference_fail(){
        assertThrows(LazyInitializationException.class, () -> {
            Movie movie = movieRepository.getReference(-1L);
            LOGGER.info("movie - title = " + movie.getTitle());
        });
    }
```

### Assertions (AssertJ)

#### AssertThat

##### import static
<pre>
import static org.assertj.core.api.Assertions.assertThat;
</pre>

##### isEqualTo
<pre>
<i>Movie movie = movieRepository.find(-1L);
assertThat(movie.getTitle()).as("Le nom attendu est incorrect").<b>isEqualTo</b>("Inception");
</i></pre>

##### hasSize
<pre>
<i>List<Movie> movies = movieRepository.getAll();
assertThat(movies).as("La taille attendu est incorrecte").hasSize(2);</i>
</pre>
