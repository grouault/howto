package com.hibernate4all.tutorial.repository;

import java.util.List;
import static org.assertj.core.api.Assertions.assertThat;

import com.hibernate4all.tutorial.config.PersistenceConfig;
import com.hibernate4all.tutorial.domain.Movie;
import java.sql.SQLException;
import org.h2.tools.Server;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlConfig;
import org.springframework.test.context.junit.jupiter.SpringExtension;

// doit s'executer dans le contexte Spring
@ExtendWith(SpringExtension.class)
// donner les classes de config dont spring a besoin pour s'initialiser
@ContextConfiguration(classes= {PersistenceConfig.class})
@SqlConfig(dataSource = "dataSourcePostGre", transactionManager = "transactionManager")
@Sql(scripts = "/datas/datas-test.sql")
public class MovieRepositoryTest {

    @Autowired
    public MovieRepository movieRepository;


    @BeforeAll
    public static void initTest() throws SQLException {
        Server.createWebServer("-web", "-webAllowOthers", "-webPort", "8082")
              .start();
    }

    @Test
    public void saveCasNominal() {
        Movie movie = new Movie();
        movie.setTitle("Django");
        movieRepository.save(movie);
    }

    @Test
    public void findCasNominal(){
        Movie movie = movieRepository.find(-1L);
        assertThat(movie.getTitle()).as("Le nom attendu est incorrect").isEqualTo("Inception");
    }

    @Test
    public void findAllCasNominal(){
        List<Movie> movies = movieRepository.getAll();
        assertThat(movies).as("La taille attendu est incorrecte").hasSize(2);
    }

}
