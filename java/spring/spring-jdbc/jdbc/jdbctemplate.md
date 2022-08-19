# Prise en charge de JDBC par Spring : JdbcTemplate

[retour](./../index-spring-jdbc.md)

## url

[doc.spring](https://docs.spring.io/spring/docs/4.1.x/spring-framework-reference/html/jdbc.html#jdbc-JdbcTemplate-idioms)

## principe

<pre>
* La classe JdbcTemplate déclare plusieurs méthodes <b>query()</b> surchargées qui contrôlent le 
	déroulement global d'une interrogation.

* Il est possible d'utiliser comme pour les opération de mises à jour les interfaces
	* PreparedStatementCreator
	* PreparedStatementSetter

* Pour la phase d'extraction des données, plusieurs manières sont proposés.	

* par rapport à un projet pur Jdbc, jdbctemplate gère la connexion.
* On supprime donc la méthode getConnexion

* Transaction : Plus de gestion des transactions explicit

</pre>

## XML Config

```
<!-- properties -->
<context:property-placeholder location="classpath:spring/database.properties"/>

<!-- data-source -->
<bean id="dataSource" destroy-method="close" class="org.apache.commons.dbcp2.BasicDataSource">
  <property name="driverClassName" value="${db.driver}"/>
  <property name="url" value="${db.url}"/>
  <property name="username" value="${db.login}"/>
  <property name="password" value="${db.password}"/>
</bean>

<bean id="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate">
  <property name="dataSource" ref="dataSource"/>
</bean>
```

## Dao -

### principe

<pre>
* Le design pattern DAO a pour objectif général d'éviter de mélanger les logiques
* Ainsi son but est de séparer logique d'accès aux données
	* de la logique métier 
	* de la logique de présentation
* le pattern DAO recommande d'encapsuler l'accès aux données dans des modules indépendants
* les opérations suivantes d'accès aux données peuvent être rendu abstaites :
	* l'insertion
	* la mise à jour
	* la suppression
	* la recherche
* ces opérations sont à déclarer dans une interface de DAO afin de ne pas figer la 
	technologie d'implementation
</pre>

### Exception

<pre>
* Le rôle de l'interface est de rendre abstraites les opérations d'accès aux données
* elle ne doit pas dépendre d'une technologie d'implémentation

<b>IMPORTANT</b> 
* les méthodes de l'interface de doivent pas lancer d'exception SQLException, 
  qui sont liées à la technologie JDBC 

* une pratique courante est d'envelopper ce type d'exécution dans une exception 
  d'exécution (au runtime).
</pre>

### Gestion de la connection

<pre>
- La connexion est gérée par la classe JdbcTemplate
- Toutes les méthodes n'ont pas besoin de la connexion mais y accède via jdbctemplate
- Certaines méthodes prennent en paramètre la connexion (classe anonyme), mais sont appelées par des méthodes de jdbctemplate
</pre>

```
PreparedStatementCreator psc = new PreparedStatementCreator() {
	@Override
	public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
		return AbstractDAO.this.buildStatementForInsert(pUneEntite, con);
	}
};
```

```
@Override
protected PreparedStatement buildStatementForInsert(IOperationEntity pUneEntite, Connection connexion)
		throws SQLException {
	String request = "insert into " + this.getTableName() + " (libelle, montant, date, compteId) values (?,?,?,?);";
	PreparedStatement ps = connexion.prepareStatement(request, Statement.RETURN_GENERATED_KEYS);
	ps.setString(1, pUneEntite.getLibelle());
	ps.setDouble(2, pUneEntite.getMontant().doubleValue());
	ps.setTimestamp(3, pUneEntite.getDate());
	ps.setInt(4, pUneEntite.getCompteId().intValue());
	return ps;
}
```

### Sans Spring

<pre>
* il faut créer explicitement l'instance de JdbcTemplate en passant l'objet dataSource
</pre>

### Avec Spring

#### injection classique

<pre>
* la création d'une nouvelle instance de JdbcTemplate à chaque utilisation est peu efficace.
* la classe JdbcTemplate est conçue pour être sûr vis à vis des threads.
* il faut donc en créer une seule instance dans le conteneur et l'injecter au besoin.
</pre>

```
<!-- spring jdbc -->
<bean id="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate">
	<property name="dataSource" ref="dataSource" />
</bean>

<!-- DAO -->
<bean id="vehiculeDAO" class="com.exo.dao.impl.JdbcVehiculeDAO">
	<property name="jdbcTemplate" ref="jdbcTemplate" />
</bean>
```

#### JdbcDaoSupport - getJdbcTemplate

<pre>
* faire en sorte que les DAO étendent la classe JdbcDaoSupport
* plus besoin de créer un bean JdbcTemplate

<b>Important :</b>
* les daos peuvent alors utiliser la méthode : <b>getJdbcTemplate()</b>
</pre>

```
<!-- DAO -->
<bean id="vehiculeDAO" class="com.exo.dao.impl.JdbcVehiculeDAO">
	<property name="dataSource" ref="dataSource" />
</bean>
```

#### NamedParameterJdbcDaoSupport

<pre>
* faire hériter les DAO de cette classe pour avoir la fonctionnalité qui permet 
	d'utiliser des paramètres nommés dans un template JDBC
</pre>

## Insert

### Insert JDBC

<pre>
@Override
public void insert(Vehicule vehicule) {
	String sql = "INSERT INTO vehicule (date_immatriculation, immatriculation, couleur, marque, modele) " +
			"VALUES(?, ?, ?, ?, ?);";
	Connection conn = null;
	try {
		conn = ConnectionUtil.getInstance().etablirConnexion();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setTimestamp(1, vehicule.getDateImmatricuation());
		ps.setString(2, vehicule.getImmatriculation());
		ps.setString(3, vehicule.getCouleur());
		ps.setString(4, vehicule.getMarque());
		ps.setString(5, vehicule.getModele());
		ps.executeUpdate();
		ps.close();
	} catch (SQLException e) {
		throw new RuntimeException(e.getMessage());
	} finally {
		try {
			ConnectionUtil.getInstance().fermerConnexion();
		} catch (SQLException e){};
	}
}
</pre>

### insert PreparedStatementCreator()

<pre>
* avec création de requete (tache 2)
* avec liaison des paramètres (tache 3)

Avantage :
* solution où on a la main sur le PrepareStatement
* on peut intervenir avant son exécution
</pre>

```
JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
jdbcTemplate.update(new PreparedStatementCreator() {
	@Override
	public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
		String sql = "INSERT INTO vehicule (date_immatriculation, immatriculation, couleur, marque, modele) " +
				"VALUES(?, ?, ?, ?, ?);";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setTimestamp(1, vehicule.getDateImmatricuation());
		ps.setString(2, vehicule.getImmatriculation());
		ps.setString(3, vehicule.getCouleur());
		ps.setString(4, vehicule.getMarque());
		ps.setString(5, vehicule.getModele());
		return ps;
	}
});
```

### insert PreparedStatementSetter()

<pre>
* avec liaison des paramètres (tache 3)
* création d'un objet PreparedStatement automatique
</pre>

```
String sql = "INSERT INTO vehicule (date_immatriculation, immatriculation, couleur, marque, modele) " +
	"VALUES(?, ?, ?, ?, ?);";

JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
jdbcTemplate.update(sql, new PreparedStatementSetter() {
	@Override
	public void setValues(PreparedStatement ps) throws SQLException {
		ps.setTimestamp(1, vehicule.getDateImmatricuation());
		ps.setString(2, vehicule.getImmatriculation());
		ps.setString(3, vehicule.getCouleur());
		ps.setString(4, vehicule.getMarque());
		ps.setString(5, vehicule.getModele());
	}
});
```

### insert avec paramètre

<pre>
* C'est la solution la plus simple
* aucune tâche à faire
	==> A privilégier
</pre>

```
String sql = "INSERT INTO vehicule (date_immatriculation, immatriculation, couleur, marque, modele) " +
		"VALUES(?, ?, ?, ?, ?);";
JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
jdbcTemplate.update(sql, new Object[]{
	vehicule.getDateImmatricuation(),
	vehicule.getImmatriculation(),
	vehicule.getCouleur(),
	vehicule.getMarque(),
	vehicule.getModele()
});
```

### Insert (KeyHolder) / Update / Delete

<pre>
- jdbctemplate.update( ... )
</pre>

```
@Override
public T insert(final T pUneEntite) throws ExceptionDao {
	if (pUneEntite == null) {
		return null;
	}
	AbstractDAO.LOG.debug("Insert {}", pUneEntite.getClass());
	try {

		// on passe par un prepare statement creator.
		PreparedStatementCreator psc = new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				return AbstractDAO.this.buildStatementForInsert(pUneEntite, con);
			}
		};

		// recuperation de l'identifiant.
		KeyHolder kh = new GeneratedKeyHolder();
		this.getJdbcTemplate().update(psc, kh);
		pUneEntite.setId(Integer.valueOf(kh.getKey().intValue()));

	} catch (Exception e) {
		throw new ExceptionDao(e);
	}
	return pUneEntite;
}
```

### Insert avec paramètres nommés

```
@Override
public void insertWithParameter(Vehicule vehicule) {
	String sql = "INSERT INTO vehicule (id, date_immatriculation, immatriculation, couleur, marque, modele) " +
			"VALUES(:id, :dateImmatriculation, :immatriculation, :couleur, :marque, :modele);";
	SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(vehicule);
	getNamedParameterJdbcTemplate().update(sql, parameterSource);
}
```

## update

### update JDBC

```
String sql = "update vehicule " +
		"set date_immatriculation=?, immatriculation=?, couleur=?, marque=?, modele=? " +
		"where id = ?";
Connection conn = null;
PreparedStatement ps = null;
try {
	conn = dataSource.getConnection();
	ps = conn.prepareStatement(sql);
	ps.setTimestamp(1, vehicule.getDateImmatricuation());
	ps.setString(2, vehicule.getImmatriculation());
	ps.setString(3, vehicule.getCouleur());
	ps.setString(4, vehicule.getMarque());
	ps.setString(5, vehicule.getModele());
	ps.setInt(6, vehicule.getId());
	ps.executeUpdate();
} catch (SQLException ex) {
	throw new RuntimeException(ex.getMessage());
} finally {
	try{
		if (ps != null)
			ps.close();
		if (!conn.isClosed()) {
			conn.close();
		};
	}catch (SQLException ex){}
}
```

### update Spring-JDBC

```
jdbcTemplate.update(sql, new Object[]{
		vehicule.getDateImmatricuation(), vehicule.getImmatriculation(),
		vehicule.getCouleur(), vehicule.getMarque(), vehicule.getModele(), vehicule.getId()
});
```

### update avec paramètres nommés

```
public Vehicule update(Vehicule vehicule) {
	String sql = "update vehicule " +
			"set date_immatriculation=:dateImmatriculation, immatriculation=:immatriculation, " +
			"couleur=:couleur, marque=:marque, modele=:modele " +
			"where id = :id";

	Map<String, Object> parameters = new HashMap<String, Object>();
	parameters.put("dateImmatriculation", vehicule.getDateImmatriculation());
	parameters.put("immatriculation", vehicule.getImmatriculation());
	parameters.put("couleur", vehicule.getCouleur());
	parameters.put("marque", vehicule.getMarque());
	parameters.put("modele", vehicule.getModele());
	parameters.put("id", vehicule.getId());

	getNamedParameterJdbcTemplate().update(sql, parameters);

	return vehicule;
}
```

## delete

### delete JDBC

```
Connection conn = null;
PreparedStatement ps = null;
try {
	conn = dataSource.getConnection();
	ps = conn.prepareStatement(sql);
	ps.setInt(1, vehicule.getId());
	ps.execute();
} catch (SQLException ex) {
	LOG.error(ex.getMessage());
	throw new RuntimeException(ex.getMessage());
} finally {
	try {
		if (ps != null) {
			ps.close();
		}
		if (!conn.isClosed())
			conn.close();
	} catch(SQLException ex){}
}
```

### delete Spring-JDBC

```
String sql = "DELETE FROM vehicule where id = ?";
JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
jdbcTemplate.update(sql, new Object[]{ vehicule.getId() });
```

## Mettre à jour en série

### batchUpdate

<pre>
* permet de faire de l'insertion en masse
	- appelée la méthode insert à chaque fois est coûteuse, car la requête est compilée à chaque fois.

* la méthode template batchUpdate(sql, BatchPreparedStatementSetter);
	- la requête est exécutée plusieurs fois mais compilée une fois
	- si le piloe est compatible JDBC 2.0, cette méthode utilise automatiquement
		la fonctionnalité de mise à jour automatique.
</pre>

```
public void insertBatch(List<Vehicule> vehicules) {
	String sql = "INSERT INTO vehicule (date_immatriculation, immatriculation, couleur, marque, modele) " +
			"VALUES(?, ?, ?, ?, ?);";

	jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

		@Override
		public void setValues(PreparedStatement ps, int i) throws SQLException {
			Vehicule vehicule = vehicules.get(i);
			ps.setTimestamp(1, vehicule.getDateImmatricuation());
			ps.setString(2, vehicule.getImmatriculation());
			ps.setString(3, vehicule.getCouleur());
			ps.setString(4, vehicule.getMarque());
			ps.setString(5, vehicule.getModele());
		}

		@Override
		public int getBatchSize() {
			return vehicules.size();
		}

	});
}
```

## Select

### jdbc

```
Vehicule vehicule = null;
try {
	conn = dataSource.getConnection();
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1,id);
	ResultSet rs = ps.executeQuery();
	if (rs != null && rs.next()) {
		vehicule = new Vehicule();
		vehicule.setId(rs.getInt("id"));
		vehicule.setDateImmatricuation(rs.getTimestamp("date_immatriculation"));
		vehicule.setImmatriculation(rs.getString("immatriculation"));
		vehicule.setCouleur(rs.getString("couleur"));
		vehicule.setMarque(rs.getString("marque"));
		vehicule.setModele(rs.getString("modele"));
	}
} catch (SQLException ex) {
	throw new RuntimeException();
} finally {
	try {
		if (!conn.isClosed())
			conn.close();
	} catch (SQLException ex) {}
}
return vehicule;
```

### spring-jdbc

#### RowCallBackHandler

##### Principe

<pre>
* principale interface permettant de traiter la ligne courante de l'ensemble du résultat
* méthode query parcourt le contenu de l'ensemble du résultat à notre place et invoque
	l'interface pour chaque ligne
* les paramètres sont passés sous forme de tableau d'objets
</pre>

#### RowMapper

##### Principe

<pre>
* permet d'extraire les données par correspondance de lignes
* son rôle : créer une correspondance entre une seule ligne de l'ensemble du résultat
	et un objet personnalisé
* elle est plus générale que l'interface RawCallBackHandler
* pour sa réutilisation, l'implémenter sous forme de classe plutôt
	que sous forme de classe interne
* dans la méthode mapRow():
	* construction de l'objet qui représente une ligne et qui sera retourné
</pre>

##### Exemple

```
public class OperationJdbcMapper implements RowMapper<IOperationEntity> {

	@Override
	public IOperationEntity mapRow(ResultSet rs, int rowNum) throws SQLException {

		IOperationEntity result = new OperationEntity();
		result.setId(Integer.valueOf(rs.getInt("id")));
		result.setLibelle(rs.getString("libelle"));
		double vm = rs.getDouble("montant");
		// Le montant etait-il null ?
		boolean mnull = rs.wasNull();
		if (!mnull) {
			result.setMontant(Double.valueOf(vm));
		} else {
			result.setMontant(null);
		}
		result.setDate(rs.getTimestamp("date"));
		result.setCompteId(Integer.valueOf(rs.getInt("compteId")));
		return result;

	}

}
```

### Requete avec une seule ligne

#### query

##### RowCallBackHandler

```
@Override
public Vehicule findById_withRowCallBackHandler(int id) {
	String sql = "Select * from Vehicule where id = ?";
	final Vehicule vehicule = new Vehicule();
	getJdbcTemplate().query(sql, new RowCallbackHandler() {
		@Override
		public void processRow(ResultSet rs) throws SQLException {
			vehicule.setId(rs.getInt("id"));
			vehicule.setDateImmatricuation(rs.getTimestamp("date_immatriculation"));
			vehicule.setImmatriculation(rs.getString("immatriculation"));
			vehicule.setCouleur(rs.getString("couleur"));
			vehicule.setMarque(rs.getString("marque"));
			vehicule.setModele(rs.getString("modele"));
		}
	}, id);
	return vehicule;
}
```

#### queryForObject

##### RowMapper

<pre>
* renvoie une exception : <b>EmptyResultDataAccessException</b>
	si aucun enregistrement trouvé en base
</pre>

```
@Override
public Vehicule findById_withRowMapper(int id) {
	String sql = "Select * from Vehicule where id = ?";
	Vehicule vehicule = (Vehicule) getJdbcTemplate().queryForObject(sql, new VehiculeRowMapper(), id);
	return vehicule;
}
```

### Requete avec plusieurs lignes

#### queryForList

<pre>
* permet de demander plusieurs lignes
* retourne une liste de tables d'assocation:
	List< Map < String, Ojbect > > 
	==> 
	[
	{id:..., modele:..., marque:...},
	{id:..., modele:..., marque:...}
	...
	]
* doit être transformer en List d'objets
</pre>

```
String sql = "Select * from Vehicule";

List<Vehicule> vehicules = new ArrayList<Vehicule>();
JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);

if (rows != null && !rows.isEmpty()) {
	for (Map<String, Object> row : rows) {
		Vehicule vehicule = new Vehicule();
		vehicule.setId((Integer) row.get("id"));
		vehicule.setDateImmatricuation(new Timestamp(((Date) row.get("date_immatriculation")).getTime()));
		vehicule.setImmatriculation((String)row.get("immatriculation"));
		vehicule.setCouleur((String)row.get("couleur"));
		vehicule.setMarque((String)row.get("marque"));
		vehicule.setModele((String)row.get("modele"));
		vehicules.add(vehicule);
	}
}

return vehicules;
```

#### query

##### RowCallBackHandler

```
String sql = "Select * from Vehicule where marque = ?";

List<Vehicule> vehicules = new ArrayList<>();

JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
jdbcTemplate.query(sql, new Object[]{marque}, new RowCallbackHandler() {

	@Override
	public void processRow(ResultSet rs) throws SQLException {
		Vehicule vehicule = new Vehicule();
		vehicule.setId(rs.getInt("id"));
		vehicule.setDateImmatricuation(rs.getTimestamp("date_immatriculation"));
		vehicule.setImmatriculation(rs.getString("immatriculation"));
		vehicule.setCouleur(rs.getString("couleur"));
		vehicule.setMarque(rs.getString("marque"));
		vehicule.setModele(rs.getString("modele"));
		vehicules.add(vehicule);
	}

});
return vehicules;
```

##### RowMapper

###### sans paramètre

```
String sql = "Select * from Vehicule";
JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
List<Vehicule> vehicules = jdbcTemplate.query(sql, new VehiculeRowMapper());
```

###### avec paramètre

```
String sql = "Select * from Vehicule where marque = ?";
JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
List<Vehicule> vehicules = jdbcTemplate.query(sql, new Object[]{marque}, new VehiculeRowMapper());
return vehicules;
```

### Requete avec une seule valeur

#### queryForObject

```
String sql = "Select couleur from Vehicule where id=?";
JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
String color = jdbcTemplate.queryForObject(sql, new Object[]{id}, String.class);
return color;
```

```
String sql = "Select count(*) from Vehicule";
JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
int count = jdbcTemplate.queryForObject(sql, Integer.class);
return count;
```
