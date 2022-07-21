## Configuration par annotation

[retour](./index.md)

### [liste des @annotations](./spring-configuration-annotation/index.md)

## Principe : Injection via les annotations

<pre>
- annotations embarquées dans le code source de la classe
- configuration XML réduite au maximum
</pre>

### Cycle de vie annotation:

<pre>
1- Détection des beans : Scan des annotations @Component
2- BeanFactoryPostProcessor
3- Instanciation des beans et injection des dépendances
4- BeanPostProcessor
</pre>

### Chargement du context-spring

### Principe

<pre>
Les composants sont détectés au démarrage de l'application:
- indique la racine, les sous-package pour le scan
- les archives jars des dépendances sont prises en compte

Pour la détection des composants, plusieurs solutions :
- scan configuré à partir du XML
- scan configuré à partir du Java


IMPORTANT : 
ComponentScan: indique les packages à inspecter pour charger les configurations
</pre>

#### Scan à partir de fichier XML.

```
<!-- scan des stereotypes -->
<context:component-scan base-package="base.package" />
```

#### Scan à partir de fichier Java

##### Annotation

```
// stereotype
@ComponentScan("com.banque")
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

### Faire cohabiter les différents styles de configuration

#### paramétrage dans le XML

```
<context:annotation-config />
```

#### explication

<pre>
- Il s'agit ici de déclarer les beans dans les xmls
- Pour leur utilisation, on peut utiliser les annotations
- permet l'exécution des annotations placés dans le code
- ATTENTION:
- Aucun scan des classes annotées
- Les beans doivent être explicitement déclarés dans les xmls
    ==> @component n'est plus nécessaire
</pre>
