## aspect

[retour](./index.md)

### Note:

Un aspect est une fonctionnalité qui va venir se greffer sur un proxy.

Comment créer un Aspect?

1. il faut créer une classe avec l'annotation @Aspect
2. la classe doit être déclaré comme un composant Spring soit par annotation, soit dans un fichier xml

L'aspect peut aller sur différent proxy
Danger : ce n'est pas l'aspect qui crée le proxy par contre l'aspect vient enrichir le proxy

### configuration XML

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

	<!-- prise en compte des aspects sur les composants. -->
	<aop:aspectj-autoproxy/>

	<!-- scan des composants. -->
	<context:component-scan base-package="com.banque" />


</beans>
```

### configuration par annotation

Sur la classe main

```
// indique les répertoires ou rechercher les annotations.
@ComponentScan("com.banque")
@EnableAspectJAutoProxy
public final class Main {
```
