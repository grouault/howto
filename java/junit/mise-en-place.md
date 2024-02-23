
### Mise en place

[home](index-junit.md)

### Liens
<a href="https://blog.logrocket.com/implement-keycloak-authentication-react/">spring-boot-test</a>

<a href="https://reflectoring.io/spring-boot-test/" target="_blank">spring-boot</a>

<a href="https://www.baeldung.com/spring-boot-testing" target="_blank">spring-boot-baeldung</a>

### JUnit4

<a href="https://rpouiller.developpez.com/tutoriels/spring/tutoriel-tests-junit4-spring/#LII-A" target="_blank">Spring et JUnit-4</a>


### JUnit 5

#### maven
```
    <junit.jupiter.version>5.9.2</junit.jupiter.version>

    <!-- junit 5 -->
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-engine</artifactId>
      <version>${junit.jupiter.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-api</artifactId>
      <version>${junit.jupiter.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-params</artifactId>
      <version>${junit.jupiter.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.assertj</groupId>
      <artifactId>assertj-core</artifactId>
      <version>3.24.2</version>
      <scope>test</scope>
    </dependency>
```

#### SpringBoot

##### mise en place
```
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = BeanConfig.class)
public class StringTutoTest {
  ...
}

ou

@SpringBootTest
public class StringTutoTest {
  ...
}

```
##### @ExtendsWith
<pre>
Permet d'indiquer à JUnit 5 que le test se fait dans un contexte Spring
A partir de SpringBoot 2.1, elle est incluse dans les annotations
@SpringBootTest
@DataJpaTest
@WebMvcTest
</pre>
<a href="https://www.concretepage.com/spring-5/extendwith-springextension-spring-test" target="_blank">ExtendsWidth</a>
