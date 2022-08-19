## Spring transaction programmatic

[retour](./spring-transaction.md#programmatic-transaction)

### Besoin

<pre>
* avoir un contrôle précis sur la validation et l'annulation des transactions mais
sans vouloir accéder directement à l'API transactionnelles sous jacentes
</pre>

### Solution

<pre>
utilisé l'entité abstraite PTM est ses méthodes indépendantes de la technologie
La transaction est géré avec l'objet transactionManager configuré dans Spring.

TransactionDefinition: permet de définir les carctéristique de la transaction

TransactionStatus: permet de suivre l'état de la transaction
</pre>

```
        // parametrage de la transaction.
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try {

            // recuperation du prix du livre
            sql = "SELECT PRICE FROM BOOK WHERE ISBN = :isbn";
            parameters = new HashMap<>();
            parameters.put("isbn", isbn);
            int price = getNamedParameterJdbcTemplate().queryForObject(sql, parameters, Integer.class);

            // mise à jour du stock du livre.
            sql = "UPDATE BOOK_STOCK SET STOCK = STOCK - 1 WHERE ISBN = :isbn";
            getNamedParameterJdbcTemplate().update(sql, parameters);

            // ajustement du solde du compte.
            sql = "UPDATE ACCOUNT SET BALANCE = BALANCE - :price WHERE USERNAME = :username";
            parameters = new HashMap<>();
            parameters.put("price", price);
            parameters.put("username", username);
            getNamedParameterJdbcTemplate().update(sql, parameters);

            transactionManager.commit(status);

        } catch (DataAccessException ex) {
            transactionManager.rollback(status);
            throw ex;
        }
```
