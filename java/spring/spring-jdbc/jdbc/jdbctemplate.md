# JdbcTemplate

[retour](./../index-spring-jdbc.md)

## url

[doc.spring](https://docs.spring.io/spring/docs/4.1.x/spring-framework-reference/html/jdbc.html#jdbc-JdbcTemplate-idioms)

## Gestion de la connexion:

- par rapport à un projet pur Jdbc, jdbctemplate gère la connexion.
- On supprime donc la méthode getConnexion
- Eviter de demander la connexion au JdbcTemplate

## Transaction

Plus de gestion des transactions explicit

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

## Dao

- Toutes les méthodes n'ont pas besoin de la connexion mais y accède via jdbctemplate
- Certaines méthodes prennent en paramètre la connexion (classe anonyme), mais sont appelées par des méthodes de jdbctemplate

```
PreparedStatementCreator psc = new PreparedStatementCreator() {
	@Override
	public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
		return AbstractDAO.this.buildStatementForInsert(pUneEntite, con);
	}
};
```

buildStatementForInsert

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

## RowMapper

Permet de mapper les résultats d'une requête sur une entité

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

## Select

- jdbctemplate.query( ... )

```
@Override
public T select(int pUneClef) throws ExceptionDao {

	T result = null;
	AbstractDAO.LOG.debug("select sur {} avec id={}", this.getClass(), String.valueOf(pUneClef));

	try {

		// request
		String request = "select " + this.getAllColumnNames() + " from " + this.getTableName() + " where "
				+ this.getPkName() + "=?;";
		// result
		result = this.getJdbcTemplate().queryForObject(request, this.getMapper(), pUneClef);

	} catch (EmptyResultDataAccessException e) {
		return result;
	} catch (Exception e) {
		throw new ExceptionDao(e);
	}

	return result;
}
```

- jdbc.queryObject(... )

## Insert (KeyHolder) / Update / Delete

- jdbctemplate.update( ... )

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
