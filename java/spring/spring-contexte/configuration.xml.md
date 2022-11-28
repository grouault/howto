### SPRING: configuration XML

[retour](./index.md)

#### Structure des fichiers xmls

##### exemple

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean class=""/>


</beans>
```

##### espace de nommage

<pre>
Le fichier de configuation de spring est constitué de différents espace de nommages

xmlns="http://www.springframework.org/schema/beans"

<b>xmlns</b>: espace de nommage par défaut
<b>http://www.springframework.org/schema/beans</b>: identifiant, pourrait être autre
    chose qu'une adresse mail
<b>xsi:schemaLocation</b>: 
    * reprend la clé 
    * référence vers un fichier spring-beans.xsd.

</pre>

##### fichier xsd

<pre>
Dans l'en-tête, on trouver le chemin xsd associé à l'identifiant de l'espace de nommage

xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd">

<b>xsd</b>: 
* explique la grammaire de l'espace de nommage
* l'ensemble des balises que l'on peut utiliser et comment elle fonctionne

Location: 
Le fichier xsd si situe dans la librairie associé.
Dans le répoertoire <b>META-INF</b>, se tourver le fichier <b>spring-schemas</b>
On retrouve alors la référence au fichier xsd associé à une valeur.
La valeur est le chemin physique (package) du fichier où se trouve le XSD.

Exemple :
Balise < Bean >, < Property > sont l'espace de nommage par défaut.
Exploité dans la librairie: spring-beans

</pre>

##### espace de nommage: spring-context

<pre>
<b>xmlns:context</b> : espace de nommage pour context

- ne se situe pas dans l'espace par défaut
- se situe dans l'espace de nommage : context
- espace de nommage : pour éviter les conflits de noms de balise
  Balise < context:annoation-config > est exploitée par la libraire spring-context

</pre>

#### Property: injection de dépendance

##### ref => id

<pre>
Permet de faire :
- l'injection de dépendance en utilisant l'attribut ref.
- cet attribut référence un autre l'id d'un autre bean
</pre>

##### value

<pre>
Permet d'affecter une valeur à une propriété.
La valeur que l'on affecte est une chaine de caractère.
Néanmoins dans le code java, c'est une propriété typé.
Spring convertit alors la valeur dans le type attendu.

Les valeurs qu'il est possible d'injecter:
* String
* java.lang.Character
* java.util.Properties
* java.util.Locale
* java.net.URL
* java.io.File
* java.lang.Class

Certains types ne peuvent être instanciés.
Exemple : date ==> comment convertir la chaine en date
On a besoin du formatter, du standard du pays...

</pre>

##### autowiring

<pre>
- permet d'injecter les dépendances automatiquement

byName:

- Impose que l'idenfiant du bean injecté a le même nom
  que la propriété du bean du composant du haut.

byType:

- c'est le type des composants qui est alors exploiter
- spring cherche s'il existe un composant de type compatible.
</pre>

#### version minimale avec exemple de beans

```
<?xml version="1.0" encoding="UTF-8"?>
<beans	xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

     <!-- Beans Contexte -->
    <beans>

        <bean id="fileMovieRepository" class="com.mycompany.dvdstore.repository.impl.FileMovieRepositoryImpl">
            <property name="file" value="c:\\tmp\\dvdstore\\dvdstore.csv" />
        </bean>

        <bean id="memoryMovieRepository" class="com.mycompany.dvdstore.repository.impl.
        MemoryMovieRepositoryImpl" />

        <bean id="movieService" class="com.mycompany.dvdstore.service.impl.DefaultMovieServiceImpl">
            <property name="movieRepository" ref="fileMovieRepository" />
        </bean>

        <bean class="com.mycompany.dvdstore.controller.MovieController">
            <property name="movieService" ref="movieService" />
        </bean>
    </beans>

</beans>
```

#### Version avec activation annotation constext / tx / aspect

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:context="http://www.springframework.org/schema/context"
        xmlns:tx="http://www.springframework.org/schema/tx"
        xmlns:aop="http://www.springframework.org/schema/aop"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
            http://www.springframework.org/schema/beans/spring-beans.xsd
            http://www.springframework.org/schema/context
            http://www.springframework.org/schema/context/spring-context.xsd
            http://www.springframework.org/schema/tx
            http://www.springframework.org/schema/tx/spring-tx.xsd
			http://www.springframework.org/schema/aop
			http://www.springframework.org/schema/aop/spring-aop.xsd">

            >

    <!-- annotation des dependances: @Autowired -->
    <context:annotation-config />

	<!-- scan des stereotypes: du coup prend en charge automatiquement @Autowired -->
	<context:component-scan base-package="base.package" />

 	<aop:aspectj-autoproxy />
	<bean id="logAspect" class="com.banque.aop.LogAspect"></bean>

</beans>

```

Version avec config

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:context="http://www.springframework.org/schema/context"
        xmlns:aop="http://www.springframework.org/schema/aop"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
            http://www.springframework.org/schema/beans/spring-beans.xsd
            http://www.springframework.org/schema/context
            http://www.springframework.org/schema/context/spring-context.xsd
			http://www.springframework.org/schema/aop
			http://www.springframework.org/schema/aop/spring-aop.xsd"
            >

	<!-- prise en compte de la config -->
	<context:component-scan base-package="com.banque.config" />

	<!-- application context provider -->
	<bean id="applicationContextProvider" class="com.banque.beans.providers.ApplicationContextProvider" />

</beans>
```

- <a href="https://docs.spring.io/spring/docs/4.2.x/spring-framework-reference/html/xsd-configuration.html">spring-4.2</a>

- [balises et attributs xml](./balise-attributs-xml/configuration-xml.md)

### Java : Chargement du context-spring

<pre>
Charger les fichiers de configurations de plusieurs manières:

    appContext = new ClassPathXmlApplicationContext("classpath:spring/mesBeans.xml",
    	"file:///data/config.xml","http://monserveur.com/config.xml");

- classpath: permet de charger une configuration dans un sous répertoire du répertoire local
- file: permet de charger un fichier dans c:\data\config.xml
- http: permet de charger un fichier depuis une URL
</pre>

#### Exemple de code

<pre>
    appContext = new ClassPathXmlApplicationContext("spring/mesBeans.xml");
    appContext = new ClassPathXmlApplicationContext("spring-ingredient.xml, spring-accessoires.xml");
    appContext = new ClassPathXmlApplicationContext("spring/spring-*.xml");
</pre>

<pre>
Code générique complet de chargement

    ClassPathXmlApplicationContext appContext = null;
    try{
        // Chargement du context Spring
        appContext = new ClassPathXmlApplicationContext("spring/mesBeans.xml");
    } catch (BeansException e) {
        Main.LOG.fatal("Erreur", e);
    	System.exit(-1);
    } finally {

        if (appContext != null) {
    	    appContext.close();
    	    }

    	// On peut aussi faire :
    	// appContext.registerShutdownHook();
    	// Juste apres la creation du context, de cette manière il sera
    	// detruit automatiquement à la fin du programme

    }
</pre>
