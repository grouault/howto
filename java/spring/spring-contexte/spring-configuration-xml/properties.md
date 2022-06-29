# properties

[retour](./index.md)

## XML

#### Configuration des fichiers XML avec un fichier de properties

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

#### Configuration des fichiers XML avec un fichier de properties

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
