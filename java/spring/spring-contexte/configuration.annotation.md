# Configuration par annotation

[retour](./index.md)

- [liste des @annotations](./spring-configuration-annotation/index.md)

## principe
<pre>
Le règles à repecter peuvent être les suivantes:
* @Component: pour créer les composants applicatifs
* @Value: pour configurer les composants applicatifs à partir
  de @PropertyPlaceHolder
* @Configuration: pour créer des beans Spring qui nous permettent
  d'utiliser une fonctionnalité proposé par Spring.
</pre>

## Injection via les annotations

### @Autowired injection des dépendances

#### paramétrage

```
<context:annotation-config />
```

##### principe

<pre>
- configuration XML réduite au maximum
- Les beans doivent être explicitement déclarés dans les xmls
sans l'injection des composants enfants.
- toutes les propriétés ayant l'annotation @autowired sont injectés.
</pre>

##### @Autowired

<pre>
- L'annotation est embarquée dans le code source de la classe
- permet une injection dans la propriété sans passer par le setter
  (intervient au niveau du bytecode)
</pre>

### @Value injection des valeurs

##### paramétrage

```
<context:property-placeholder location="classpath: application.properties" />
```

##### principe

<pre>
* S'utilise pour injecter une valeur dans une propriété avec une clé de configuration
* la clé de configuration pointe sur une valeur stockée dans un fichier de propriété
</pre>

```
<bean id="adresse1" class="com.exo.beans.Adresse">
  <property name="rue" value="${addr1.rue}" />
  <property name="codePostal" value="${addr1.codePostal}" />
  <property name="ville" value="${addr1.ville}" />
  <property name="pays" value="${addr1.pays}" />
</bean>
```

## Stéréotype

### annotation à mettre sur les classes

<pre>
Il en existe 4 :
@Component
@Controller
@Service
@Repositroy
</pre>

### détection des stéréotype

#### principe

<pre>
Il s'agit ici de faire en sorte que Spring détecte les composants
qu'il doit créer sans que ces derniers ne soient créés dans le fichier
XML.
On soit alors dire à Spring les packages qu'il doit scanner.

Va alors se poser la question suivante :
Comment alors dire à Spring quelle implémentation il doit utiliser pour 
tel composant ?
On est là sur une gestion de problématique des conflits.
Les solutions seront alors diversee:

- Répartition des implémentation par packages
- Répartition par librairies
- Annoation: @Primary
- Autowiring byName
- @Profile ou @Conditional
</pre>

#### Scan à partir de fichier XML.

```
<!-- scan des stereotypes -->
<context:component-scan base-package="base.package" />

Cette balise peut-être démultiplié.
Il n'est pas conseillé de scanner le package racine mais au minimum,
scanner au niveau des types de composants:
<context:component-scan base-package="package.controller" />
<context:component-scan base-package="package.service" />
<context:component-scan base-package="package.repository " />
```

#### Scan à partir de fichier Java

##### Annotation: @ComponentScan

###### Principe
```
// stereotype
@ComponentScan("com.banque")
* récursivité sur le package et les sous-packages
```

##### Exemple

```

    @ComponentScan("com.banque")
    @EnableAspectJAutoProxy
    public final class Main {

        private static final Logger LOG = LogManager.getLogger();

        /**
        * Exemple de fonctionnement.
            *
        * @param args
        *            ne sert a rien
        */
        public static void main(String[] args) throws Exception {
            Main.LOG.info("-- Debut -- ");

            // Permet de démarrer Spring.
            // Permet de charger Spring : recherche d'annotation sur la classe Main.
            // Spring va rechercher les annotations.
            // context = zone de mémoire avec ses propres valeurs spring <==> context
            AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(Main.class);
```

## Chargement du context-spring

### Principe

<pre>
Les composants sont détectés au démarrage de l'application:
- indique la racine, les sous-package pour le scan
- les archives jars des dépendances sont prises en compte

Pour la détection des composants, plusieurs solutions :

- scan configuré à partir du XML: ClassPathXmlApplicationContext

- scan configuré à partir du Java: AnnotationConfigApplicationContext
    Le but est ici de se passer d'un fichier xml.
    On va lancer le scan à partir du code Java.
    La configuration se trouve alors dans les classes annotées :
    - par les stéréotypes
    - par java-config (@Configuration)

- combiné les deux modes: voir ci-après.
</pre>

### @ImportRessource: combiner les deux: annotation et xmls

<pre>
@Configuration
@ComponentScan("com.banque")
@ImportRessource("classpath: applicationContext.xml")
public final class Main {

    AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(Main.class, AppConfig.class);
    ...
}
</pre>

## Cycle de vie annotations :

<pre>
1- Détection des beans : Scan des stéréotypes
2- BeanFactoryPostProcessor
3- Instanciation des beans et injection des dépendances
4- BeanPostProcessor
</pre>
