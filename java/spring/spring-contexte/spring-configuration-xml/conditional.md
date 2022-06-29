## @Conditional

[retour](./index.md)

## lien

https://javapapers.com/spring/spring-conditional-annotation/

## Notes

Il sert à élaborer un type de vérification conditionnelle « If-Then-Else » pour l’enregistrement des beanss.

Spring Condition Interface

Il faut créer une classe qui implémente l'interface 'condition' fournit par Spring.
public interface Condition {
boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata);
}

Ensuite, la classe doit être utilisé avec l'annotation @Conditional pour vérifier la condition.
Si la condition est remplie, le bean est instancié.

Dans le cas suivant, la dataSource instancié dépent de la propriété database.name

Condition Dev

```
package com.javapapers.spring4.condition;

import org.springframework.context.annotation.Condition;
import org.springframework.context.annotation.ConditionContext;
import org.springframework.core.type.AnnotatedTypeMetadata;

public class ProdDataSourceCondition implements Condition {

	@Override
	public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
		String dbname = context.getEnvironment().getProperty("database.name");
		return dbname.equalsIgnoreCase("prod");
	}

}
```

Condition Prod

```
package com.javapapers.spring4.condition;

import org.springframework.context.annotation.Condition;
import org.springframework.context.annotation.ConditionContext;
import org.springframework.core.type.AnnotatedTypeMetadata;

public class DevDataSourceCondition implements Condition {

	@Override
	public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
		String dbname = context.getEnvironment().getProperty("database.name");
		return dbname.equalsIgnoreCase("dev");
	}

}
```

Fichier de configuration de Spring

```
@Configuration
public class EmployeeDataSourceConfig {


	  @Bean(name="dataSource")
	  @Conditional(value=DevDataSourceCondition.class)
	  public DataSource getDevDataSource() {
		  return new DevDatabaseUtil();
	  }

	  @Bean(name="dataSource")
	  @Conditional(ProdDataSourceCondition.class)
	  public DataSource getProdDataSource() {
		  return new ProductionDatabaseUtil();
	  }
}
```
