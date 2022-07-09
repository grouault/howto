# properties

[retour](./index.md)

## XML

### PropertyPlaceholder

#### Principe

<pre>
Permet de charger le fichier de propriete au niveau du fichier xml
Les propriétés peuvent alors être interprétés dans le xml de configuration

A utiliser quand
- module spring-context n’est pas disponible (c’est-à-dire que l’on utilise l’API BeanFactory de Spring par opposition à ApplicationContext

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

#### balise : <context:property-placeholder />

Autre configuration : avec dans la déclartion xml, le spring-context :
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

Note:
@value : permet de récupérer une valeur chargée par un property-placeholder.

### PropertiesFactoryBean

#### Principe

<pre>
Permet de récupérer les propriétés dans une classe Java
</pre>

#### config xml

```
	<bean id="dataBaseProperties" class="org.springframework.beans.factory.config.PropertiesFactoryBean">
		<property name="location" value="spring/database.properties" />
	</bean>
```

### code Java

```
Properties dataBaseConfig = appContext.getBean("dataBaseProperties", Properties.class);
Main.LOG.debug("bdd.driver = " + dataBaseConfig.getProperty("bdd.driver"));
Main.LOG.debug("bdd.url = " + dataBaseConfig.getProperty("bdd.url"));
```

## @annotation

- @PropertySource
- @Value:

Exemple:

    @PropertySource("classpath:spring/database.properties")
    public abstract class AbstractDAO<T extends IEntity> implements IDAO<T> {

        private static final Logger LOG = LogManager.getLogger();

        @Value("${bdd.driver}")
        private String driver;

        @Value("${bdd.url}")
        private String url;
        private String url;

        ...

    }
