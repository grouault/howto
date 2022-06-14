[home](../index.md)

## logback.xml

- Voici l'exemple de configuration d'un fichier de logs

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <appender name="STDOUT"
              class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>
                %d{HH:mm:ss} %highlight(%-5level) %logger{15}.%M %msg%n
            </pattern>
        </encoder>
    </appender>

    <!-- observer les instructions envoyes a la base de donnees -->
    <logger name="org.hibernate.SQL" level="DEBUG"/>

    <!-- besoin d'afficher les valeus des "?" -->
    <logger name="org.hibernate.type.descriptor.sql.BasicBinder" level="TRACE" />

    <!-- logger les classes specifiques -->
    <!-- logger name="com.hibernate4all.tutorial.repository.MovieRepository" level="TRACE"/ -->

    <!-- observer la gestion des transactions : ouverture / fermeture -->
    <!-- logger name="org.springframework.orm.jpa.JpaTransactionManager" level="DEBUG" /-->
    <!--
        SessionImpl : implementation de la session dans les sources hibernate
        observer la gestion des sessions ouverture / fermeture
    -->
    <logger name="org.hibernate.internal.SessionImpl" level="TRACE" />

    <!-- mecanisme de flux par defaut
        explication du dirty-checking
    -->
    <logger name="org.hibernate.event.internal.DefaultFlushEntityEventListener" level="TRACE"/>

    <root level="info">
        <appender-ref ref="STDOUT" />
    </root>

</configuration>
```
