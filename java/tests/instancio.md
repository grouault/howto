[retour](./test-index.md)

## Link
<a href="https://www.baeldung.com/java-test-data-instancio" target="_blank">baeldung<a>
<a href="https://github.com/eugenp/tutorials/blob/master/testing-modules/instancio/src/test/java/com/baeldung/instancio/basics/CreateStudentUnitTest.java" target="_blank">baeldung-github</a>
<a href="https://www.instancio.org/user-guide/#using-generate" target="_blank">doc</a>

### maven
```xml
<instancio.version>4.6.0</instancio.version>
<dependency>  
    <groupId>org.instancio</groupId>  
    <artifactId>instancio-junit</artifactId>  
    <version>${instancio.version}</version>  
    <scope>test</scope>  
</dependency>
```

### Principe
* `intancio` aide a généré des données de tests en créant des objets entièrement remplis.
* Son objectif est de rendre les tests unitaires plus concis et maintenables
en éliminant autant que possible la configuration manuelle des données

### création d'objet : instancio.create() / instancio.of()
Instancio utilise des valeurs par défaut raisonnables pour remplir les objets. Les objets générés ont :

* valeurs non nulles
* Chaînes non vides
* nombres positifs
* Collections non vides contenant quelques éléments

```java
// create POJO
Student student = Instancio.create(Student.class);

// collections and streams
List<Student> list = Instancio.ofList(Student.class).size(10).create(); 
Stream<Student> stream = Instancio.of(Student.class).stream().limit(10);
```

### personnalisé un objet

Lors de l’écriture de tests unitaires, nous avons souvent besoin de créer des objets 
dans différents états. 
L’état dépend généralement de la fonctionnalité testée :
* besoin d’un objet valide pour vérifier le chemin heureux 
* besoin d'un objet non valide pour vérifier les erreurs de validation.

Avec `Instancio`, nous pouvons :

* personnaliser les valeurs générées selon les besoins via les méthodes
`set()`, `supply()` et `generate()` 
* ignorer certains champs et classes en utilisant la méthode `ignore()`
* générer des valeurs nulles en utilisant la méthode `withNullable()`
* Spécifiez les implémentations pour les types abstraits en 
utilisant la méthode `subtype()`

#### selectors
Instancio utilise des sélecteurs pour spécifier les champs et les classes à personnaliser. 
Toutes les méthodes listées ci-dessus acceptent un sélecteur comme premier argument. 
Nous pouvons créer des sélecteurs en utilisant les méthodes statiques fournies 
par la classe `Select`.

Nous pouvons sélectionner un champ particulier en utilisant 
* une référence de méthode,
* le nom du champ 
* ou un prédicat en utilisant les méthodes suivantes :

``` java
Select.field(Address::getCity) Select.field(Address.class, "city") 
Select.fields().matching("c.*y").declaredIn(Address.class) // matches city, country 
Select.fields(field -> field.getDeclaredAnnotations().length > 0)

// On peut aussi sélectionner des types en spécifiant la classe 
// ou en utilisant un prédicat :
Select.all(Collection.class)
Select.types().of(Collection.class)
Select.types(klass -> klass.getPackage().getName().startsWith("com.example"))

```

#### set()
à utiliser pour mettre à jour des valeurs attendues (non random)
```java
Student student = Instancio.of(Student.class)
  .set(field(Phone::getCountryCode), "+49")
  .create();
```
* quand on a une liste, le set permet de mettre à jour tous les éléments
* permet de mettre à jour des objets immutables comme les records

#### supply()
La méthode supply() a deux variantes : 
* une pour assigner des valeurs non aléatoires à l’aide d’un fournisseur 
* une autre pour générer des valeurs aléatoires à l’aide d’un générateur.
```java
Student student = Instancio.of(Student.class)
  .supply(all(LocalDateTime.class), () -> LocalDateTime.now())
  .supply(field(Student::getDateOfBirth), random -> LocalDate.now().minusYears(18 + random.intRange(0, 60)))
  .create();
```

#### generate()
Avec la méthode `generate()`, nous pouvons personnaliser les valeurs via des générateurs
de données intégrés. 
Instancio fournit des générateurs pour les types Java les plus couramment utilisés. 
Cela inclut les chaînes, les types numériques, les collections, les tableaux, les dates...

Dans l’exemple suivant, la variable gen donne accès aux générateurs disponibles. 
Chacun d’eux fournit une API fluide pour personnaliser ses valeurs :
```java
Student student = Instancio.of(Student.class)
  .generate(field(Student::getEnrollmentYear), gen -> gen.temporal().year().past())
  .generate(field(ContactInfo::getEmail), gen -> gen.text().pattern("#a#a#a#a#a#a@example.com"))
  .create();
```

#### ignore()
Nous pouvons utiliser la méthode `ignore()` si nous ne voulons pas que certains 
champs ou classes soient remplis. 
Supposons que nous voulons tester la persistance d’une instance de Student 
dans la base de données. 
Dans ce cas, nous voulons générer un objet avec un identifiant null.

Nous pouvons y parvenir de la façon suivante :
```java
Student student = Instancio.of(Student.class)
  .ignore(field(Student::getId))
  .create();
```

#### withNullable()
Alors qu’Instancio est désireux de générer des objets entièrement peuplés, 
parfois ce n’est pas souhaitable. 
Par exemple, nous pouvons vouloir vérifier que notre code fonctionne correctement 
lorsque certains champs facultatifs sont nuls. 
Nous pouvons le faire en utilisant la méthode `withNullable()`. 
Comme son nom l’indique, Instancio génère soit une valeur réelle ou une valeur nulle au hasard.
```java
Student student = Instancio.of(Student.class)
  .withNullable(field(Student::getEmergencyContact))
  .withNullable(field(ContactInfo::getEmail))
  .create();
```
Avec l’approche traditionnelle de l’utilisation de données statiques, 
nous aurions besoin de créer des méthodes de test séparées pour 
les valeurs nulles et non nulles. 
Nous pourrions aussi utiliser des tests paramétrables, ce qui peut 
prendre beaucoup de temps, surtout s’il y a beaucoup de champs facultatifs. 
La génération d’objets, comme illustré ci-dessus, nous permet d’avoir une seule 
méthode de test qui vérifie différentes permutations d’entrées.


#### subtype()
La méthode `subtype()` nous permet de spécifier une implémentation pour 
un type abstrait ou une sous-classe pour un type concret. 
Prenons l’exemple suivant, où la classe ContactInfo déclare un champ List<Phon>
```java
Student student = Instancio.of(Student.class)
  .subtype(field(ContactInfo::getPhones), LinkedList.class)
  .create();
```
Sans spécifier explicitement le type de liste, Instancio utiliserait ArrayList comme implémentation 
par défaut. Nous pouvons remplacer ce comportement en spécifiant le sous-type.

### Models
Les objets créés à partir d’un modèle auront toutes les propriétés du modèle. 
Un modèle peut être créé en appelant la méthode toModel(), comme illustré
dans l’exemple suivant :
```java
Model<Student> studentModel = Instancio.of(Student.class)
  .generate(field(Student::getDateOfBirth), gen -> gen.temporal().localDate().past())
  .generate(field(Student::getEnrollmentYear), gen -> gen.temporal().year().past())
  .generate(field(ContactInfo::getEmail), gen -> gen.text().pattern("#a#a#a#a#a#a@example.com"))
  .generate(field(Phone::getCountryCode), gen -> gen.string().prefix("+").digits().maxLength(2))
  .toModel();
```
Le modèle étant défini, nous pouvons maintenant l’utiliser dans toutes nos
méthodes de test. 
Chaque méthode de test peut utiliser le modèle comme base et appliquer 
des personnalisations au besoin.

Supposons que nous testons une méthode qui exige un élève qui a suivi dix
cours et qui a obtenu le grade A ou B dans tous les cours. 
Nous pouvons utiliser le modèle défini ci-dessus et personnaliser le nombre 
de cours et les notes 

```java
@Test
void whenGivenGoodGrades_thenCreatedStudentShouldHaveExpectedGrades() {
    final int numOfCourses = 10;
    Student student = Instancio.of(studentModel)
      .generate(all(Grade.class), gen -> gen.oneOf(Grade.A, Grade.B))
      .generate(field(Student::getCourseGrades), gen -> gen.map().size(numOfCourses))
      .create();

    Map<Course, Grade> courseGrades = student.getCourseGrades();

    assertThat(courseGrades.values()).hasSize(numOfCourses)
      .containsAnyOf(Grade.A, Grade.B)
      .doesNotContain(Grade.C, Grade.D, Grade.F);
    
    // Remaining data is defined by the model:
    assertThat(student.getEnrollmentYear()).isLessThan(Year.now());
    assertThat(student.getContactInfo().getEmail()).matches("^[a-zA-Z0-9]+@example.com$");
    // ...

```
Nous pourrions également avoir un autre test qui exige un étudiant ayant
échoué à un cours. 
Pour ce faire, nous devons remplir le champ `Map<Course, Grade>` de l’élève
afin qu’il y ait un cours avec une note F. 
Encore une fois, Nous utilisons notre modèle d’étudiant comme base et écrasons les propriétés souhaités:
```java
@InstancioSource
@ParameterizedTest
void whenGivenFailingGrade_thenStudentShouldHaveAFailedCourse(Course failedCourse) {
    Student student = Instancio.of(studentModel)
      .generate(field(Student::getCourseGrades), gen -> gen.map().with(failedCourse, Grade.F))
      .create();

    Map<Course, Grade> courseGrades = student.getCourseGrades();
    assertThat(courseGrades).containsEntry(failedCourse, Grade.F);
}
```

Dans cet exemple, nous avons utilisé la méthode du générateur de map 
avec (clé, valeur) pour ajouter l’entrée attendue dans la carte générée.

Veuillez noter que cette méthode de test est un `@ParameterizedTest`. 
Lorsque `@InstancioSource` est utilisé avec un test paramétré, 
Instancio fournit automatiquement des objets remplis qui sont spécifiés 
comme arguments de méthode. 
Nous pouvons spécifier autant d’arguments que nécessaire.


### Instancio Junit Extension

#### reproduction en cas d'erreur
Une préoccupation commune concernant l’utilisation de données aléatoires est
qu’un test peut échouer en raison d’un ensemble de données particulier qui a
été généré. 
La défaillance peut être due à une erreur dans le code d’installation ou un bug
dans le code de production. 
Indépendamment de la cause, Instancio génère des données entièrement
reproductibles et l’utilisation d’`InstancioExtension` facilite la reproduction des
tests échoués.

Pour illustrer cela avec un exemple, nous allons inscrire notre étudiant dans un
nouveau cours. 
Cependant, notre `EnrollmentService` fait une exception si un étudiant a au
moins un cours avec une note de F. 
Par conséquent, le test suivant peut soit passer ou échouer, selon les grades qui
ont été générés :
```java
@ExtendWith(InstancioExtension.class)
class ReproducingFailedTest {

    EnrollmentService enrollmentService = new EnrollmentService();

    @Test
    void whenGivenNoFailingGrades_thenShouldEnrollStudentInCourse() {
        Course course = Instancio.create(Course.class);
        Student student = Instancio.create(Student.class);

        boolean isEnrolled = enrollmentService.enrollStudent(student, course);

        assertThat(isEnrolled).isTrue();
    }
}
```
Si le test échoue, un message d’erreur indiquant le nom de la méthode et la
valeur initiale est affiché, par exemple :
```log
_timestamp = 2023-01-24T13:50:12.436704221, Instancio = Test method ‘enrollStudent’ failed with seed: 1234_
```

En utilisant la valeur de graine signalée, nous pouvons reproduire l’échec en
plaçant l’annotation @Seed(1234) sur la méthode de test. 
Cela entraînera la production des données déjà produites, 
ce qui aura le même résultat :

```java
@Seed(1234)
@Test
void whenGivenNoFailingGrades_thenShouldEnrollStudentInCourse() {
    // test code unchanged
}
```
 Dans cet exemple, l’échec a été causé par une erreur dans la configuration 
 des données. 
 Par conséquent, nous pouvons simplement exclure la catégorie F de la
  génération afin de fixer notre test :
```java
Student student = Instancio.of(Student.class) 
.generate(all(Grade.class), gen -> gen.enumOf(Grade.class).excluding(Grade.F)) 
.create();
```
Le service d’inscription est testé avec succès par rapport à toutes les notes
valides, et nous avons atteint cet objectif en utilisant une seule méthode de test.

Nous pouvons appliquer exactement le même flux de travail pour gérer un 
échec de test causé par du code de production.

#### @WithSettings
Une autre fonctionnalité de l’extension est l’injection des paramètres à l’aide de 
l’annotation `@WithSettings`. 
Par exemple, par défaut, Instancio ne génère pas de collections vides.
Cependant, il se peut que des scénarios de test nécessitent des collections
vides.
Nous pouvons utiliser des paramètres personnalisés pour remplacer le 
comportement par défaut comme suit :

```java
@ExtendWith(InstancioExtension.class)
class CustomSettingsTest {

    @WithSettings
    private static final Settings settings = Settings.create()
      .set(Keys.COLLECTION_MIN_SIZE, 0)
      .set(Keys.COLLECTION_MAX_SIZE, 3)
      .lock();

    @Test
    void whenGivenInjectedSettings_shouldUseCustomSettings() {
        ContactInfo info = Instancio.create(ContactInfo.class);

        List<Phone> phones = info.getPhones();
        assertThat(phones).hasSizeBetween(0, 3);
    }
}
```
Les paramètres injectés seront appliqués à tous les objets créés dans cette
classe de test. 
Bien que non requis, nous appelons également la méthode lock() pour rendre
l’instance Settings immuable. 
Cela garantit qu’aucune méthode de test ne modifiera par inadvertance les
paramètres partagés.