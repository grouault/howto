## Héritage

[retour](./configuration-xml.md)

### Héritage de configuration &lt;bean&gt;

    <!-- Declaration de notre configuration service parent -->
    <bean id="couleur" class="projet.voiture">
        <property name="poids" value="1300"></property>
        <property name="couleur" value="rouge"></property>
    </bean>

    <!-- Declaration de nos services et mise en place des liens avec les DAO -->
    <bean id="v" class="projet.voiture" parent="config.Voiture"></bean>
    <bean id="vJaune" class="projet.voiture" parent="config.Voiture">
        <property name="couleur" value="jaune"></property>
    </bean>

### Héritage de configuration abstract

[plus](https://github.com/grouault/spring-tutorial/tree/master/spring-contexte/en07.spring.xml)

1. Définition des propriétés dans le bean 'abstract'.
2. Récupération des propriétés dans les beans 'enfants'
   <!-- -->

      <!-- Declaration de notre configuration de DAO parent -->
      <bean id="abstractDao" class="com.banque.dao.impl.AbstractDAO" abstract="true">
        <property name="url" value="${bdd.url}"></property>
        <property name="driver" value="${bdd.driver}"></property>
        <property name="login" value="${bdd.login}"></property>
        <property name="pwd" value="${bdd.password}"></property>
      </bean>
      
      <!-- Declaration de nos DAO enfants -->
      <bean id="compteDAO" class="com.banque.dao.impl.CompteDAO" parent="abstractDao">
      </bean>
      <bean id="operationDAO" class="com.banque.dao.impl.OperationDAO" parent="abstractDao">
      </bean>
