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

### création

#### Driver JDBC

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

#### dataSource

##### principe

<pre>
* interface javax.sql.DataSource est définie par les spécifications de JDBC qui représente une "source de données".
* Cette source de données est en fait une simple fabrique de connexion vers la source de données physique.
</pre>

##### implémentations

<pre>
  * basiques : implémentations qui produisent des instance de Connection normales,
      telles que l'on pourrait les obtenir avec DriverManager

      * DriverManagerDataSource ==> Spring : ouvre une nouvelle connexion à chaque demande

  * Pool de connexions : ces implémentations produisent des instances qui appartiennent à un Pool
      * BasicDataSource => Apache DBCP
</pre>

##### Exemple

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

## Transaction JDBC

### Validation automatique

<pre>
* Lorsque la mise à jour d'une base de données se fait avec JDBC, chaque requête SQL est par défaut
  validée immédiatement
</pre>

### Validation par transaction

#### principe

<pre>
JDBC prend en charge une stratégie élémentaire de gestion des transactions qui consiste à invoquer
explicitement les méthodes commit() et rollback() sur une connexion.
Pour gérer les transactions, il faut désactiver le mode autoCommit à partir de la connection.

Inconvénient : ce code est porpre à JDBC.

Spring propose donc un ensemble d'outils transactionnels indépendants de la technologie :
* gestionnaire de transaction
* template de transaction
* la gestion des transactions par déclaration
</pre>

#### code

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
