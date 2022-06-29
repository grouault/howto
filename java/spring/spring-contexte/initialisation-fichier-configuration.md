# Schema Spring

[retour](./configuration.xml.md)

TODO

## [spring-4.2](https://docs.spring.io/spring/docs/4.2.x/spring-framework-reference/html/xsd-configuration.html)

Version minimal :

    <?xml version="1.0" encoding="UTF-8"?>
    <beans	xmlns="http://www.springframework.org/schema/beans"
    	    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

          <!-- Beans Contexte -->
          <beans>
        </beans>
    </beans>

Version avec activation annotation constext / tx / aspect

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

	<!-- scan des stereotypes -->
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
