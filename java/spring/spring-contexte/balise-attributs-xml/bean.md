# bean

[retour](./configuration-xml.md)

## General

- id: identifiant de la configuration
- classe : type d'objet

Les objets fabriqués par Spring sont appelés : Spring bean

## &lt;property name="" value=""&gt;

La balise 'property' permet d'utiliser une fonction commençant par un set.

## &lt;property name="" ref=""&gt;

Permet de relier un autre objet

## &lt;constructor-arg name="" /&gt;

Permet de fournir des arguments aux constructeurs d'un objet

    <bean class="fr.exagone.beans.Adresse">
      <constructor-arg index="0" value="78000" />
      <constructor-arg index="1" value="18 rue de la Reine" />
      <constructor-arg index="2" value="Versailles" />
      <constructor-arg index="3" value="France" />
    </bean>

## scope: singleton et prototype

Par défaut, les beans sont des singletons.
Pour définir un prototype.

```
<bean id="client1" class="fr.exagone.beans.Client" scope="prototype" />
```

## Traitements posts-processeurs

### bean xml: init-method / destroy-method

    <bean id="client1" class="fr.exagone.beans.Client" init-method="initialiser" destroy-method="detruire">
      <property name="nom" value="lunz" />
      <property name="prenom" value="Axel" />
      <property name="age" value="28" />
      <property name="adresses" ref="adresses" />
    </bean>

### objet java

    public void initialiser() {
      Client.LOG.info("Dans mon Init du client");
      }

    public void detruire() {
    	  Client.LOG.info("Dans mon Destroy du client");
    }
