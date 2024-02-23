# properties

[retour](./index.md)

## XML

### PropertyPlaceholder

#### Principe

<pre>
Permet de charger le fichier de propriete au niveau du fichier xml
Les propriétés peuvent alors être interprétés dans le xml de configuration
Les propriiétés sont accessibles dans les classe java par @annotation
</pre>

#### en déclarant le beans

1- créez un fichier properties à la racine de votre répertoire spring

    ## Format : clef=valeur
    ## Information pour la premiere adresse
    addr1.codePostal=75000
    addr1.ville=Paris
    addr1.pays=France
    addr1.rue=14 rue de la gloire
    ## Information pour la seconde adresse
    ...

2- charger le fichier de properties via la classe Spring PropertyPlaceholderConfigurer

    <beans xmlns="http://www.springframework.org/schema/beans"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <!-- PROPERTIES -->
    <bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
        <property name="location" value="spring/adresses.properties"/>
    </bean>

     <!-- CLIENT 1 -->
    <bean id="adresse1" class="fr.exagone.beans.Adresse">
        <property name="rue" value="${addr1.rue}" />
        <property name="ville" value="${addr1.ville}"/>
        <property name="codePostal" value="${addr1.codePostal}" />
        <property name="pays" value="${addr1.pays}" />
    </bean>

    </beans>

#### balise xml : <context:property-placeholder />

Autre configuration : avec dans la déclartion xml, le spring-context :

```
xmlns:http://www.springframework.org/schema/context/spring-context.xsd

    <?xml version="1.0" encoding="UTF-8"?>
    <beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:context="http://www.springframework.org/schema/context"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
            http://www.springframework.org/schema/beans/spring-beans.xsd
            http://www.springframework.org/schema/context
            http://www.springframework.org/schema/context/spring-context.xsd">


    <context:property-placeholder location="classpath:database.properties"/>

    <bean id="dataSource" class="org.springframework.jdbc.datasource.SimpleDriverDataSource">
        <property name="url" value="${db.url}"></property>
        <property name="username" value="${db.username}"></property>
        <property name="password" value="${db.password}"></property>
    </bean>

    </beans>
```

##### @Value
<pre>
IMPORTANT :
@value : permet de récupérer une valeur chargée par un property-placeholder dans une classe java :

	@Value("${bdd.driver}")
	private String bddDriver;

</pre>

### PropertiesFactoryBean

#### Principe

<pre>
* Permet de récupérer les propriétés dans une classe Java
* A utiliser quand le module spring-context n’est pas disponible 
  - c’est-à-dire que l’on utilise l’API BeanFactory de Spring par opposition à ApplicationContext
  - on ne peut pas dans ce cas utiliser les annotations < context:component-scan ... >
  - mais on peut alors injecter le properties dans un bean définit en XML
</pre>

#### config xml

```
	<bean id="dataBaseProperties" class="org.springframework.beans.factory.config.PropertiesFactoryBean">
		<property name="location" value="spring/database.properties" />
	</bean>
```

#### code Java

```
Properties dataBaseConfig = appContext.getBean("dataBaseProperties", Properties.class);
Main.LOG.debug("bdd.driver = " + dataBaseConfig.getProperty("bdd.driver"));
Main.LOG.debug("bdd.url = " + dataBaseConfig.getProperty("bdd.url"));
```

## @annotation

### @Bean PropertySourcesPlaceholderConfigurer  et Resource
<pre>
Une Resource (pour Spring), c'est un chemin d'accès à un fichier.
Deux stratégies sont possibles:
* Stratégie: FileSystem
* Stratégie: ClassPath

Pour abstraire cela, on utilise une resource spring que l'on configure.
Ensuite, on utilise juste le property source créer et l'annotation <b>@Value</b>
</pre>

```
@Bean
public PropertySourcesPlaceholderConfigurer propertySources(){
    PropertySourcesPlaceholderConfigurer propertySource = new PropertySourcesPlaceholderConfigurer();
    propertySource.setLocation(new ClassPathResource("sandbox/sandbox.properties"));
    // propertySourceLocation(new FileSystemResource("..."))
    return propertySource;

}
```

### @PropertySource
<pre>
* pour charger le fichier de propriété au niveau d'une classe @Component.
* pour charger le fichier de propriété au niveau d'une classe @Configuration.

<b>@Value</b> : pour récupérer les valeurs du fichier de propriétés

Cette annotation se positionne
* sur les propriétés d'une classe
* sur les paramètres d'une méthode
  

Derrière cette annotation se cache un new PropertySourcePlaceHolderConfigurer.
On pourrait remplacer cette annotation par le code suivant :
<i>
@Bean
public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
    PropertySourcesPlaceholderConfigurer configurer = new PropertySourcesPlaceholderConfigurer();
    configurer.setLocation(new ClassPathResource("application.properties"));
    return configurer;
}
</i>
</pre>

Exemple:

    @PropertySource("classpath:spring/database.properties")
    public abstract class AbstractDAO<T extends IEntity> implements IDAO<T> {

        private static final Logger LOG = LogManager.getLogger();

        @Value("${bdd.driver}")
        private String driver;

        @Value("${bdd.url}")
        private String url;
        private String url;


        public void creerMehode (@Value String monParmetre) { ... }
        ...

    }
