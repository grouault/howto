# bean - lifcecycle - init et destroy - InitaliseBean - DisposableBean - BeanPostProcessor - ApplicationContext

[retour](./index.md)

Principe:
Spring: fabrication des spring-beans:

- Spring construit les singletons / prototype au chargement de la configurations XML ou scan des composants
- le framework assemble les pièces puis gèrent l'exécution

## prototype / singleton

- Singleton: chargé au démarrage de l'application, au chargement de la configuration.
- Prototype : ne sont chargés qu'à la demande et non au chargement de la configuration.

## lifecycle bean

[lifecyclebean](https://howtodoinjava.com/spring-core/spring-bean-life-cycle/)

![image](https://user-images.githubusercontent.com/20648687/77641152-de451d80-6f5b-11ea-932b-43b8c695f506.png)

## par configuration xml : init-method / destroy-method

xml

    <bean id="question-1" class="fr.exagone.beans.SimpleQuestion" scope="prototype"
        init-method="initialiser" destroy-method="detruire">
    <constructor-arg value="1"></constructor-arg>
    <constructor-arg value="What is java"></constructor-arg>
    <constructor-arg ref="reponse-1"></constructor-arg>
    </bean>

Java

    public void initialiser() {
        SimpleQuestion.LOG.info("[SimpleQuestion]: in Init method");
    }

    public void detruire() {
        SimpleQuestion.LOG.info("[SimpleQuestion]: in Detruire method");
    }

## par annotation :@PostConstruct / @PreDestroy

This post-processor includes support for the PostConstruct and PreDestroy annotations - as init annotation and destroy annotation, respectively - through inheriting from InitDestroyAnnotationBeanPostProcessor with pre-configured annotation types.

### Fichier de configuration spring : XML

```
    <!-- Indiquez à Spring que vous faites usage des annotations @PreDestroy et @PostConstruct -->
    <bean class="org.springframework.context.annotation.CommonAnnotationBeanPostProcessor" />
```

### Java:

```
    @PostConstruct
    public void initialize() {
        Adresse.LOG.info("init dans Adresse");
    }

    @PreDestroy
    public void destroy() {
        Adresse.LOG.info("destroy dans Adresse");
    }
```

## InitializingBean

L'interface permet à un bean d’effectuer des travaux d’initialisation après que toutes les propriétés nécessaires sur le bean ont été définies par le conteneur.

## DisposableBean

L'interface permet à un bean d’obtenir un callback lorsque le conteneur le contenant est détruit.

## singleton / prototype

Un bean ayant un scope prototype et une destroy-method (en annotation, déclaration XML ou implémentation d'interface) ne verra JAMAIS cette dernière appelée.
Tant que le prototype ne contient pas lui-même une référence à une autre ressource telle qu’une connexion à une base de données ou un objet de session, il sera ramasser par le garbage collector dès que toutes les références à l’objet auront été supprimées ou que l’objet sera hors de portée. Il n’est donc généralement pas nécessaire de détruire explicitement un bean de type prototype.

Cependant, dans le cas où une fuite de mémoire peut se produire comme décrit ci-dessus, les beans prototypes peuvent être détruits en créant un bean post-processeur, singleton dont la méthode de destruction appelle explicitement la méthode de destruction de vos beans prototypes. Parce que le post-processeur est lui-même de portée singleton, sa méthode de destruction sera invoqué par Spring.

## bean post-processor

Un post-processeur de beans permet de modifier sur mesure les nouvelles instances de beans créées par Spring Bean Factory. Si vous voulez implémenter une logique personnalisée après que le conteneur Spring ait fini d’instancier, de configurer et d’initialiser un bean, nous pouvons brancher une ou plusieurs implémentations de Beanpostprocessor.

Dans le cas de plusieurs instances Beanpostprocessor, nous pouvons contrôler l’ordre en définissant la propriété order ou implémenter l’interface Ordered.

A l'instanciation, spring cherche les composants qui sont des BeansPostProcessor, et exécute la méthode [afterPropertiesSet].
A la fermeture du contexte-spring, la méthode [destroy] est exécutée.

[Plus d'info](https://github.com/grouault/spring-tutorial/blob/master/spring-contexte/ex00.spring/README.md)

## ApplicationProvider

#### Context-global

Comment obtenir l’objet de contexte d’application de Spring avec les classes non gérées par le conteneur. Il n’est pas possible d’avoir toutes les classes en tant que classes gérées par le conteneur, dans ces classes vous devez obtenir l’objet de contexte d’application. Cela peut être réalisé en utilisant l’interface Applicationcontextaware.

- créer une classe qui implémente l'interface ; la méthode "setApplicationContext" permet de récupérer l'object applicationContext
- declarer un bean dans le fichier de configuration de spring ou metter l'annotation @Component sur la classe précedemment crée.
- dans la classe non gérée par Spring, appelé le contexte

Java:

     @Autowired
     ApplicationContextProvider appContext

     ou

     ApplicationContextProvider appContext = new ApplicationContextProvider();
     TestBean tb = appContext.getApplicactionContext().getBean("testBean", TestBean.class);

Note : quand on fait un new, spring a déjà instancier une instance signleton et la récupère dans le contexte.

#### Context-web

On peut utiliser: javax.servlet.ServletContext.
La classe voulant faire usage de l'application-context devra implémenter l'interface : ServletContextAware
`org.springframework.web.context.ServletContextAware`

```

```
