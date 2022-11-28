## Prise en charge des exceptions

[retour](./index-spring-jdbc.md)

### API JDBC

<pre>
* API JDBC lance une exception vérifiée java.sql.SQLException 
  ==> qui doit être intercepté.
</pre>

### API Hibernate

<pre>
* API lance des exceptions du type HibernateException
</pre>

### API JPA

<pre>
* API lance des exceptions du type PersistenceException
</pre>

### Spring et les exceptions

<pre>
Quand ont utilise Spring, il y a un wrapping des exceptions par Spring.
Spring renvoie alors une exception de type DataAccessExcepion.
C'est une exception du type Runtime.

Question : Sur quelle couche se fait le wrapping ?
Au niveau du Repository et de l'annotation @Repository.
</pre>

### Spring JDBC

<pre>
* Les exceptions lancées par Spring-Jdbc sont des sous-classes de DataAccessException : 
  - exception de type RuntimeException qu'il n'est pas obligatoire d'intercepter
  - classe racine de toutes les exceptions dans le module Spring

* les classes du framework interceptent l'exception SQLException à notre place et l'enveloppe
  dans une des sous classes de DataAccessException qu'il n'est pas obligatoire d'intercepter.
 
* Comment Spring-JDBC peut-il savoir quelle execption concrète peu de la hiérarchie DataAccessException
  peut-être lancée ?
    * il examine les propriétésde l'exception SQLException :
      - errorCode
      - sqlState   

* Ces propriétés sont accessibles depuis l'exception Spring:

    try {

      ...
      
    } catch (DataAccessException e) {
      SQLException sqle = (sQLException) e.getCause();
      log.info(sqle.getErrorCode());
      log.info(sqle.getSQLState())
    }

*  Dans les méthodes des DAOs, il est inutile :
- d'entourer le code avec un bloc try/catch
- de déclarer le lancement d'une exception dans les signatures

* Question : comment gérer les exceptionx aux niveaux des DAOs? Services?
</pre>

### Rollback

<pre>
Un rollback est déclenché qaund une exception est déclenchée.
Néanmoins, dans les cas suivants, on n'a pas d'excetion :

- les checked exceptions
- certaines exceptions runtime de persistence:
  > NoResultException
  > NonUniqueResultException
  > LockTimeOutException
  > QueryTimeOutException
- les exceptions délcarées dnans NoRollBackFor

</pre>

### Gestion des exceptions dans les transactions
