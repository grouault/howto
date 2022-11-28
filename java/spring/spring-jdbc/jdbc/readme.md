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

## Définition

### connection

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

[getConnexion](../../spring-jdbc/transaction/connexion.md#driver-jdbc)

### prepareStatement

<pre>
Méthode qui précompilent une instruction SQL paramétrée.
Elle laisse au driver JDBC, le soin de transmettre les valeurs des objets au format requis par la base de données.
Peut être utilisé plusieurs fois / concurrence / multi-thread
</pre>

## Transaction JDBC

### Validation automatique

<pre>
Lorsque la mise à jour d'une base de données se fait avec JDBC, chaque requête SQL 
est par défaut validée immédiatement
</pre>

### Validation par transaction

#### principe

<pre>
JDBC prend en charge une stratégie élémentaire de gestion des transactions qui consiste à invoquer
explicitement les méthodes commit() et rollback() sur une connexion.
Pour gérer les transactions, il faut désactiver le mode autoCommit à partir de la connection.

Inconvénient : ce code est porpre à JDBC.

Solution: il faut utiliser les solutions offertes par spring-transaction.

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
