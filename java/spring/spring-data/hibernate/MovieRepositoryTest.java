package com.hibernate4all.tutorial.repository;

import com.hibernate4all.tutorial.config.PersistenceConfig;
import com.hibernate4all.tutorial.domain.Award;
import com.hibernate4all.tutorial.domain.Certification;
import com.hibernate4all.tutorial.domain.Genre;
import com.hibernate4all.tutorial.domain.Movie;
import com.hibernate4all.tutorial.domain.MovieDetails;
import com.hibernate4all.tutorial.domain.Review;
import com.hibernate4all.tutorial.service.MovieService;
import java.time.Duration;
import java.time.Instant;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Table;
import javax.persistence.criteria.CriteriaBuilder;
import javax.transaction.Transactional;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.InstanceOfAssertFactories.INPUT_STREAM;
import org.hibernate.LazyInitializationException;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlConfig;
import org.springframework.test.context.junit.jupiter.SpringExtension;

// doit s'executer dans le contexte Spring
@ExtendWith(SpringExtension.class)
// donner les classes de config dont spring a besoin pour s'initialiser
@ContextConfiguration(classes= {PersistenceConfig.class})
// charger les données de test
@SqlConfig(dataSource = "dataSource", transactionManager = "transactionManager")
@Sql({"/datas/datas-test-postgre.sql"})
public class MovieRepositoryTest {

    private static final Logger LOGGER = LoggerFactory.getLogger(MovieRepository.class);

    @Autowired
    private MovieRepository repository;

    @Autowired
    private MovieService service;

    @Autowired
    private GenreRepository genreRepository;

    @PersistenceContext
    EntityManager entityManager;

    @Test
    public void addMovieDetails_casNominal(){
        MovieDetails details = new MovieDetails().setPlot("Intrique du film Memento très longue!");
        repository.addMovieDetails(details, -2L);
        assertThat(details.getId()).as("l'entité aurait dû être persistée").isNotNull();
    }

    @Test
    public void association_casNominal() {
        Movie movie = new Movie().setName("Fight Club")
                                 .setCertification(Certification.INTERDIT_MOINS_12)
                                 .setDescription("Le Fight Club n'existe pas");
        Review review1 = new Review().setAuthor("max").setContent("super film!");
        Review review2 = new Review().setAuthor("jp").setContent("au top!");
        movie.addReview(review1);
        movie.addReview(review2);
        repository.persist(movie);
    }

    @Test
    public void associationGet_fail(){
        Assertions.assertThrows(LazyInitializationException.class, () -> {
            Movie movie = repository.find(-1L);
            LOGGER.trace("chargement des reviews...");
            LOGGER.trace("nombre de movies  : " + movie.getReviews().size());
        });
    }

    @Test
    public void association_addAward() {
        Movie movie = new Movie()
                .setName("Fight Club")
                .setCertification(Certification.INTERDIT_MOINS_12)
                .setDescription("Le Fight Club n'existe pas");
        Award award = new Award().setName("Prix de la surprise").setDescription("Incredible").setYear(2011);
        movie.addAward(award);
        repository.persist(movie);
        assertThat(award.getId()).as("Award aurait du etre persister avec Movie").isNotNull();
    }

    @Test
    public void addReview_existingMovie() {
        Movie movie = repository.getReference(-1L);
        service.addReview(movie.getId(), new Review().setAuthor("Gildas").setContent("super"));
    }

    @Test
    public void merge_casimule() {
        Movie movie = new Movie();
        movie.setId(-1L);
        movie.setName("Inception 2");
        movie.setDescription("alter description");
        Review newReview = new Review();
        newReview.setAuthor("Gildas").setContent("Test unitaire Content");
        movie.addReview(newReview);
        Movie mergedMovie = repository.merge(movie);
        assertThat(movie.getName()).as("Le nom du film n'a pas changé").isEqualTo("Inception 2");
    }

    @Test
    public void merge_cassimule_with_transient() {
        Movie movie = new Movie();
        movie.setName("usual suspect").setDescription("Film incompréhensible.");
        movie.setCertification(Certification.INTERDIT_MOINS_12);
        Review review = new Review();
        review.setAuthor("Gildas").setContent("super film");
        movie.addReview(review);
        repository.merge(movie);
        assertThat(movie.getName()).as("le film n'a pas été créé").isEqualTo("usual suspect");
        assertThat(movie.getId()).as("L'id n'est pas null... alors qu'avec un merge sur transient").isNull();
    }

    @Test
    public void merge_casimule_without_update() {
        Movie movie = new Movie();
        movie.setId(-1L);
        movie.setName("Inception").setDescription("description init").setCertification(Certification.TOUT_PUBLIC);
        Movie mergedMovie = repository.merge(movie);
        assertThat(movie.getName()).as("Le nom du film n'a pas changé").isEqualTo("Inception");
    }

    @Test
    public void find_casNominal(){
        Movie memento = repository.find(-2L);
        assertThat(memento.getName()).as("mauvais film récupéré").isEqualTo("Memento");
        assertThat(memento.getCertification()).as("mauvaise certification").isEqualTo(Certification.INTERDIT_MOINS_16);
    }

    @Test
    public void find_byName(){
        List<Movie> movies = repository.findByName("Inception");
        assertThat(movies).hasSize(1);
        assertThat(movies.get(0).getName()).isEqualTo("Inception");
    }

    @Test
    public void find_withCertification(){
        List<Movie> result = repository.findWithCertification("<=", Certification.INTERDIT_MOINS_12);
        assertThat(result).hasSize(3);
    }

    @Test
    public void getMoviesWithReviews_casNominal(){
        List<Movie> movies = repository.getMoviesWithReview();
        assertThat(movies).as("il devrait y avoir 3 films récupérés").hasSize(3);
        Movie inception = movies.stream().filter(m -> m.getId().equals(-1L)).findFirst().get();
        assertThat(inception.getReviews()).as("les reviews n'ont pas été correctement récupérés.").hasSize(3);
    }

    @Test
    public void getMoviesWithAwardsAndReviews_casNominal(){
        List<Movie> movies = repository.getMoviesWithAwardsAndReviews();
        assertThat(movies).as("il devrait y avoir 3 films récupérés").hasSize(3);
        Movie inception = movies.stream().filter(m -> m.getId().equals(-1L)).findFirst().get();
        assertThat(inception.getReviews()).as("les reviews n'ont pas été correctement récupérés.").hasSize(2);
    }

    @Test
    public void getAll_casNominal(){
        List<Movie> movies = repository.getAll();
        assertThat(movies).as("l'ensemble des films n'a pas été récupéré.").hasSize(2);
    }

    @Test
    @Sql({"/datas/datas-test-n+1.sql"})
    public void getAllMovieDetails(){
        List<MovieDetails> movieDetails = repository.getAllMovieDetail();
        assertThat(movieDetails).as("le nombre de MovieDetails devrait être de 3").hasSize(3);
    }

    @Test
    // @Sql({"/datas/datas-test-bulk.sql"})
    public void getAllMovieBulk_casNominal(){
        Instant now = Instant.now();
        List<Movie> movies = repository.getAll();
        Duration duration = Duration.between(now, Instant.now());
        LOGGER.info("durée : {}", duration.toMillis() );
        assertThat(movies).as("Les movies n'ont pas été chargées correctement").hasSize(1000000);
    }

    @Test
    //@Sql({"/datas/datas-test-bulk.sql"})
    public void getAllMovieBulk_casPaging(){
        Instant now = Instant.now();
        List<Movie> movies = repository.getMoviesPager(100,50);
        Duration duration = Duration.between(now, Instant.now());
        LOGGER.info("durée : {}", duration.toMillis() );
        assertThat(movies).as("Les movies n'ont pas été chargées correctement").hasSize(50);
    }

    @Test
    //@Sql({"/datas/datas-test-bulk.sql"})
    public void getAllMovieBulk_casPagingWithReviews(){
        Instant now = Instant.now();
        List<Movie> movies = repository.getMoviesWithReviewsPager(100,50);
        Duration duration = Duration.between(now, Instant.now());
        LOGGER.info("durée : {}", duration.toMillis() );
        assertThat(movies).as("Les movies n'ont pas été chargées correctement").hasSize(50);
    }

    @Test
    public void getReference_casNominal(){
        Movie movie = repository.getReference(-2L);
        assertThat(movie.getId()).as("la référence n'a pas été correctement chargée").isEqualTo(-2L);
    }

    @Test
    public void getReference_fail(){
        Assertions.assertThrows(LazyInitializationException.class, () -> {
            Movie movie = repository.getReference(-2L);
            LOGGER.trace("movie name  : " + movie.getName());
            assertThat(movie.getId()).as("la référence n'a pas été correctement chargée").isEqualTo(-2L);
        });
    }

    @Test
    public void remove(){
        repository.remove(-1L);
        List<Movie> movies = repository.getAll();
        assertThat(movies).as("le film n'a pas été supprimé").hasSize(1);
    }

    @Test
    public void removeAndGetAll() {
        List<Movie> movies = service.removeAndGetAll(-1L);
        assertThat(movies).as("le film n'a pas été supprimé").hasSize(1);

    }

    @Test
    public void removeGenre() {
        Movie movie = repository.getReference(-1L);
            service.removeGenre(movie.getId(), new Genre("Action"));
    }

    @Test
    public void save_casNominal(){
        Movie movie = new Movie();
        movie.setName("Inception V2");
        movie.setCertification(Certification.INTERDIT_MOINS_12);
        repository.persist(movie);
        System.out.println("[save_CasNominal] - session contains movie : " + entityManager.contains(movie));
        System.out.println("fin de test");
    }

    @Test
    public void save_withGenres() {
        Movie movie = new Movie().setName("The Social Network");
        Genre bio = new Genre().setName("Biography");
        Genre drama = new Genre().setName("Drama");
        movie.addGenre(bio).addGenre(drama);
        repository.persist(movie);
        assertThat(bio.getId()).as("l'entité Genre aurait dû être persistée").isNotNull();
    }

    @Test
    public void save_withExistingGenres() {
        Movie movie = new Movie().setName("The Social Network");
        Genre bio = new Genre().setName("Biography");
        Genre drama = new Genre().setName("Drama");
        Genre action = new Genre().setName("Action");
        action.setId(-1L);
        movie.addGenre(bio).addGenre(drama).addGenre(action);
        repository.merge(movie);
        // Attention avec Merge
        // assertThat(bio.getId()).as("l'entité Genre aurait dû être persistée").isNotNull();
    }

    @Test
    public void testCacheSecondNiveauEntite(){
        Genre genre = genreRepository.findById(-1L);
        assertThat(genre).isNotNull();
        genre = genreRepository.findById(-1L);
        genre = genreRepository.findById(-1L);
    }

    @Test
    public void testCacheSecondNiveauRequete(){
        Genre genre = genreRepository.findById(-1L);
        List<Genre> genres = genreRepository.getAll();
        assertThat(genres).isNotEmpty();
        genre = genreRepository.findById(-1L);
        assertThat(genre).isNotNull();
        genres = genreRepository.getAll();
    }

    @Test
    public void testCacheSecondNiveauCollection(){
        repository.displayGenres(-1L);
        repository.displayGenres(-1L);
    }

    @Test
    public void testFlushOrder() {
        Assertions.assertThrows(DataIntegrityViolationException.class, () ->{
            Movie movie = service.removeThenAddMovie();
            assertThat(movie.getDescription()).as("le movie n'est pas le bon").contains("v2");
        });
    }
}
