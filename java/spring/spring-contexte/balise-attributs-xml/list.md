# list,set,vector ...

[retour](./configuration-xml.md)

## gestion des collections : &lt;list /&gt; &lt;value&gt;

adresses : liste de champs de type String

     <!--
     property name="adresses": simple string -->
     <property name="adresses">
       <list>
         <value>1 rue du midi</value>
         <value>é rue de Paris</value>
       </list>
     </property>

## gestion des collections : &lt;list /&gt; &lt;bean&gt;

adresses : liste de bean de type Adresse
==> construction des objets directement dans la liste

    <!-- property name="adresses" -->
    <property name="adresses">
      <list value-type="fr.exagone.beans.Adresse">
        <bean class="fr.exagone.beans.Adresse">
          <constructor-arg index="0" value="78000" />
          <constructor-arg index="1" value="18 rue de la Reine" />
          <constructor-arg index="2" value="Versailles" />
          <constructor-arg index="3" value="France" />
         </bean>
      </list>
    </property>

adresses : liste de bean de type Adresse

- construction des objets directement dans la liste
- utilistation d'un constructeur

    <!-- property name="adresses" -->
    <property name="adresses">
    <bean class="java.util.ArrayList">
      <constructor-arg>
        <list value-type="fr.exagone.beans.Adresse">
          <bean class="fr.exagone.beans.Adresse">
             <constructor-arg index="0" value="78000" />
       <constructor-arg index="1" value="18 rue de la Reine" />
       <constructor-arg index="2" value="Versailles" />
       <constructor-arg index="3" value="France" />
         </bean>
        </list>
      </constructor-arg>
     </bean>
    </property>

## gestion des collections : &lt;list /&gt; &lt;ref&gt;

adresses : liste de bean de type Adresse
==> la liste référence des beans déjà existant

    <!-- par référence -->
    <bean id="adresses" class="java.util.Vector">
      <list>
        <ref bean="adresse1" />
    	<ref bean="adresse2" />
    	<ref bean="adresse3" />
      </list>
    </bean>

## gestion des collections : &lt;list /&gt; &lt;constructor&gt;

adresses : liste de bean de type Adresse
==> la liste référence des beans déjà existant
<!-- par référence -->
<bean id="client3" class="fr.exagone.beans.Client">
<property name="nom" value="Vanavermat" />
<property name="prenom" value="Greg" />
<property name="age" value="29" />
<property name="adresses">
<bean class="java.util.Vector">
<constructor-arg>
<list value-type="fr.exagone.beans.Adresse">
<bean class="fr.exagone.beans.Adresse">
<constructor-arg index="0" value="35000" />
<constructor-arg index="1" value="18 rue de Fougères" />
<constructor-arg index="2" value="Rennes" />
<constructor-arg index="3" value="France" />
</bean>
</list>
</constructor-arg>
</bean>
</property>
</bean>
