# JDBC

[retour](./../index-spring-jdbc.md)

## doc

https://docs.spring.io/spring/docs/4.1.x/spring-framework-reference/html/jdbc.html#jdbc-JdbcTemplate-idioms

## Liens

- [jdbctemplate](./jdbctemplate.md)

## Définition

### jdbc

<pre>
définit un ensemble d'API standard (Bibliothèque d'interfaces et de classes)
  utilisé pour accéder à une base de donéees relationnelles de manière indépendante du fournisseur.
</pre>

### Programme JDBC

<pre>
* Un programme JDBC envoie des requêtes à un SGBDR et exploite les résultats en Java.
* Avec JDBC, il faut :
  * gérer les ressources (la connexion, transaction) 
  * traiter explicitement les exceptions
</pre>

### Problème

<pre>
* pour une opération JDBC, les tâches sont redondantes :
</pre>

#### opération de mise à jour

<pre>
Pour implémenter une opération JDBC de mise à jour :
1- obtenir une connexion avec la BD à partir de la source de données
2- créer un objet PrepareStatement à partir de la connexion
3- Lier les paramètres à l'objet PreparedStatement
4- Exécuter l'objet PreparedStatement
5- Gérer l'exception SQLException
6- Nettoyer l'objet de requête de connexion
</pre>

#### opération de consultation

<pre>
Pour implémenter une opération JDBC de consultation, il faut ajouter ces deux opérations :

1- obtenir une connexion avec la BD à partir de la source de données
2- créer un objet PrepareStatement à partir de la connexion
3- Lier les paramètres à l'objet PreparedStatement
4- Exécuter l'objet PreparedStatement
<b>
5- Parcourir l'ensemble de résultat obtenu
6- Extraire les données de l'ensemble de résultat
</b>
7- Gérer l'exception SQLException
8- Nettoyer l'objet de requête de connexion
</pre>

## connection

### récupération

#### à partir Driver JDBC

<pre>
Un driver est une implémentation des interfaces pour un SGBDR donné.

Pour obtenir une connexion, il faut:

1- le chargement de la classe du driver par la JVM
  Note : La méthode Driver.registerDriver() contient un initialiseur static qui permet de signaler 
    la classe comme driver JDBC au niveau de la JVM.
  Ce chargement permmet alors l'établissement d'une connexion.
2- Récupération de la Connexion

Soit le code: 
Class.forName("com.mysql.jdbc.Driver")
Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/test","login","mdp")

</pre>

#### à partir d'une dataSource

<pre>
* interface javax.sql.DataSource est définie par les spécifications de JDBC qui représente une "source de données".

* Cette source de données est en fait une simple fabrique de connexion vers la source de données physique.

* Implémentations :
  * basiques : ces implémentations produisent des instance de Connection normales,
      telles que l'on pourrait les obtenir avec DriverManager

      * DriverManagerDataSource ==> Spring : ouvre une nouvelle connexion à chaque demande

  * Pool de connexions : ces implémentations produisent des instances qui appartiennent à un Pool

      * BasicDataSource => Apache DBCP

</pre>

#### Exemple

```
<!-- Declaration de notre data source -->
<bean id="dataSource" destroy-method="close" class="org.apache.commons.dbcp2.BasicDataSource">
    <property name="driverClassName" value="${db.driver}" />
    <property name="url" value="${db.url}" />
    <property name="username" value="${db.login}" />
    <property name="password" value="${db.password}" />
    <property name="initialSize" value="2" />
    <property name="maxActive" value="5" />
</bean>
```

### Définition

<pre>
La classe java.sql.DriverManager fournit la méthode getConnexion().
Cette méthode renvoie un objet Connexion qui est utilisée pour effectuer les opérations sur la base.
Cette classe fournit par le driver implémente l'interface : java.sql.Connection
Principales méthodes :

- createStatement
- prepareStatement
- prepareCall
- setAutocommit / commit /rollback
- getMetaData
- close / isClosed
</pre>

#### prepareStatement

<pre>
Méthode qui précompilent une instruction SQL paramétrée.
Elle laisse au driver JDBC, le soin de transmettre les valeurs des objets au format requis par la base de données.
Peut être utilisé plusieurs fois / concurrence / multi-thread
</pre>

## Transaction

```
Connection conn = DriverManager.getConnection(BDD_URL, BDD_LOGIN, BDD_PWD);
try

  conn.setAutoCommit(false);

  // instruction transaction
  PreparedStatement ps = conn.prepareStatement(sql);
  ps = conn.prepareStatement(sql);
  ps.setTimestamp(1, vehicule.getDateImmatricuation());
  ps.setString(2, vehicule.getImmatriculation());
  ps.setString(3, vehicule.getCouleur());
  ps.setString(4, vehicule.getMarque());
  ps.setString(5, vehicule.getModele());
  ps.setInt(6, vehicule.getId());
  ps.executeUpdate();

  // validation de la transaction
  conn.commit();

} catch (SQLException ex) {

  // annulation connexion
  conn.rollback();

} finally {
  ps.close();
  conn.close();
}
conn.setAutoCommit(true);
```

## Exception

### Principe

#### API JDBC

<pre>
* API JDBC lance une exception vérifiée java.sql.SQLException 
  ==> qui doit être intercepté.
</pre>

#### Spring JDBC

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
