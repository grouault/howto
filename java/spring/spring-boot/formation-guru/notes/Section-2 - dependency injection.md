
SOLID Principle of OOP

## SpringContext


### Dependency Injection
* dépendance injecter par un autre objet : constructeur, getter, setter
* la classe n'est pas chargée de créer la dépendance ; la dépendance est injectée et récupérée dans le context Spring
* l'injection se fait au runtime (au moment de l'exécution du code <=> démarrage)
### Inversion de contrôle
* C'est l'environnement d'exécution ; le code de l'application est placé dans l'environnement d'exécution du cadre Spring. 
* Spring fournit un cadre qui va nous aider à construire l'application.
* On ne travaille pas directement avec le cadre lui même, les efforts sont concentrés sur le code de l'application.
### @SpringBootTest
Cette annotation permet de tester le contexte Spring.
```java
@SpringBootTest
// Indique au composant de créer un contexte Spring
```
## Injection de dépendance

note: voir le projet la branch spring-6-di
### di sans Spring
Sans Spring, il faut utiliser l'opérateur new pour créer explicitement les objets.
- par setter
```java
class SetterInjectedContollerTest {  
  
    SetterInjectedContoller setterInjectedContoller;  
  
    @BeforeEach  
    void setUp() {  
        setterInjectedContoller = new SetterInjectedContoller();  
        setterInjectedContoller.setGreetingService(new GreetingServiceImpl());  
    }  
  
    @Test  
    void sayGreeting() {  
        System.out.println(setterInjectedContoller.sayGreeting());  
    }  
}
```
- par constucteur
```java
class ConstructorInjectedControllerTest {  
  
    private ConstructorInjectedController constructorInjectedController;  
  
    @BeforeEach  
    void setUp() {  
        constructorInjectedController = new ConstructorInjectedController(new GreetingServiceImpl());  
    }  
  
    @Test  
    void sayGreeting() {  
        System.out.println(this.constructorInjectedController.sayGreeting());  
    }  
}
```
- par property non public 
```java
class PropertyInjectedControllerTest {  
  
    PropertyInjectedController propertyInjectedController;  
  
    @BeforeEach  
    void setUp() {  
        propertyInjectedController = new PropertyInjectedController();  
        propertyInjectedController.greetingService = new GreetingServiceImpl();  
    }  
  
    @Test  
    void sayGreeting() {  
        System.out.println(propertyInjectedController.sayGreeting());  
    }  
}
```
### di avec Spring
Avec Spring, on utilise le contexte pour récupérer les objets.
* par contrôleur
```java
@SpringBootTest  
class ConstructorInjectedControllerTest {  
  
    @Autowired  
    private ConstructorInjectedController constructorInjectedController;  
  
    @Test  
    void sayGreeting() {  
        System.out.println(this.constructorInjectedController.sayGreeting());  
    }  
}

// Dans le controller, un seul constructeur est présent, Spring saura injecter le composant

@Controller  
public class ConstructorInjectedController {  
    private final GreetingService greetingService;  
  
    public ConstructorInjectedController(GreetingService greetingService) {  
        this.greetingService = greetingService;  
    }  
  
    public String sayGreeting(){  
        return this.greetingService.sayGreeting();  
    }  
  
}
```

* par Setter
```java
@Controller  
public class SetterInjectedContoller {  
    private GreetingService greetingService;  
  
    @Autowired  
    public void setGreetingService(GreetingService greetingService) {  
        System.out.println("setter - GreetingService");  
        this.greetingService = greetingService;  
    }  
  
    public String sayGreeting(){  
        return this.greetingService.sayGreeting();  
    }  
  
}
```

### Primary Bean
Permet de choisir le bean à privilégier en injection quand plusieurs types de bean existent dans le contexte de Spring pour le même besoin.
Deux implémentations différentes pour la même interfaces ; les deux sont dans le contexte de sprint mais seule l'implémentation Primary est câblée  si aucun autre Qualifier n'est utilisé par ailleurs.
### Using Qualifier
Par défaut, s'il n'y a qu'un seul bean de définit dans le contexte, spring utilise un qualifier par défaut qui porte le nom de la classe commençant par une minuscule
```java

```
Utilisé pour qualifier précisément le bean exact à injecter:
```java
@Service  
@Qualifier("greetingServiceConstructorInjectedBean")  
public class GreetingServiceConstructorInjectedImpl implements  GreetingService{  
    @Override  
    public String sayGreeting() {  
        return "Say Greeting from GreetingServiceConstructorInjectedImpl";  
    }  
}


@Controller  
public class ConstructorInjectedController {  
    private final GreetingService greetingService;  
  
    public ConstructorInjectedController(@Qualifier("greetingServiceConstructorInjectedBean")GreetingService greetingService) {  
        this.greetingService = greetingService;  
    }  
  
    public String sayGreeting(){  
        return this.greetingService.sayGreeting();  
    }  
  
}
```

### Spring Profiles
Permet de déterminer de définir des beans qui auront des configurations différentes par environnement.
```java
@Service("envService")  
@Profile({"dev", "default"})  
public class EnvironnementServiceDevImpl implements EnvironnementService {  
    @Override  
    public String getDataSource() {  
        return "dataSource - DEV";  
    }  
}
```

#### ActiveProfile
définit le profile à activer.
##### application.properties
```java
spring.profiles.active=ES, prod
```

##### tests
```java
@SpringBootTest  
@ActiveProfiles("default")  
class EnvironnementControllerTest {  
  
    @Autowired  
    EnvironnementController environnementController;
```
#### Default Profile
* permet de déterminer un profil par défaut à utiliser quand aucun profil n'est spécifié au lancement de l'application
* ne semble pas fonctionner pour les test où l'activation d'un profil semble nécessaire.