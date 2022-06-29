## Configuration par annotation

[retour](./index.md)

Principe : Injection via les annotations

- annotations embarquées dans le code source de la classe
- configuration XML réduite au maximum

### [liste des @annotations](https://github.com/grouault/spring-tutorial/blob/master/spring-contexte/notes/spring-configuration-annotation/index.md)

### Cycle de vie annotation:

```
1- Détection des beans : Scan des annotations @Component
2- BeanFactoryPostProcessor
3- Instanciation des beans et injection des dépendances
4- BeanPostProcessor
```

### Chargement du context-spring

Les composants sont détectés au démarrage de l'application:

- indique la racine, les sous-package sont scannés
- les archives jars des dépendances sont prises en compte

Charger les fichiers de configurations de plusieurs manières:

XML:

```
<!-- scan des stereotypes -->
<context:component-scan base-package="base.package" />

<!-- aspect -->
<aop:aspectj-autoproxy />
```

Java:

```
// stereotype
@ComponentScan("com.banque")

// aspect
@EnableAspectJAutoProxy
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

- @ComponentScan: indique les packages à inspecter pour charger les configurations

### Faire cohabiter les différents styles de configuration

Usage de

```
<context:annotation-config />
```

- execution de toutes les annotations
- scan des classes annotées mais les beans doivent être explicitement déclarés
- @component n'est plus nécessaire
