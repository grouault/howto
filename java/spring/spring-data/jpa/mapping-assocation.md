# Mapping Association

[retour](../spring-data.md)

## many-to-one / one-to-many

### Mod�le de donn�es

![shema-entity-medecin](./img/mapping/0-schema-medecin.PNG)

### Sch�ma entity

![shema-entity-medecin](./img/mapping/1-schema-entite-medecin.PNG)

### association bidirectionnelle / unidirectionnelle

<pre>
* un patient patient peut avoir plusieurs rendez-vous
	* se traduit par une <b>Collection</b> de <i>RendezVous</i> au niveau de <i>Patient</i>
* un rendez vous est d�finit pour 1 patient
	* se traduit par une entit� <i>Patient</i> <b>unique</b> au niveau de d'un <i>RendezVous</i>
</pre>

#### association bidirectionnelle

<pre>
* A partir du <i>Patient</i>, je peux atteindre ses <i>RendezVous</i>
* A partir d'un <i>RendezVous</i>, je peux conna�tre <i>son Patient</i>
</pre>

#### association unidiretionnelle

<pre>
* Suivant le Sens, il n'est pas n�cessaire de d�clarer de r�f�rencer l'entit�.
* Exemple: Ci-apr�s, releation unidrectionnelle
	* dans <i>Patient</i>, je d�clare la la Collection de <i>RendezVous</i>
	* dans <i>RendezVous</i>, je n'ai pas beson de d�clarer la classe <i>Patient</i>
* Dans ce cas, une <b>table d'association</b> est cr��.
</pre>

![shema-entity-medecin](./img/mapping/2-association-unidrectionnelle.PNG)

### Base de donn�es

<pre>
* se d�finit par la cr�ation de deux tables
	* [PATIENT](id, ...)
	* [RENDEZ_VOUS] (id, ... , PATIENT_ID)
</pre>

#### cl�-�trang�re

<pre>
* <i>Note</i> : Dans le relationnel, il n'y pas la notion de bidirectionnel
* Dans une relation [1..*], la cl� primaire de la classe(1) devient cl� �trang�re au niveau de la classe o� il y a (*)
</pre>

### annotation jpa @ManyToOne / @OneToMany

<pre>
* <i>@ManyToOne</i> : <b>l'attribut</b> qui a cette annotation est une <b>colonne</b> en base qui est une <b>cl� �trang�re</b>
* <i>@oneToMany</i> : <b>l'attribut</b> est une <b>collection</b> est n'est donc pas mat�rialis� en base comme attribut
	* soit <b>avec</b> table d'association
	* soit <b>sans</b> table d'association : la <b>classe</b> o� figure cet attribut est <b>cl� �trang�re</b> dans la classe de collection
</pre>

#### JoinedColumn(name="PATIENT_ID")

<pre>
* permet de d�finir le <b>nom</b> de la <b>cl�-�trang�re</b>
* si non d�finit, sera attribu� par d�faut : <b>nom de l'attribut</b> dans la classe <b>plus suffixe '_ID'</b>
</pre>

#### mappedBy (@OneToMany)

<pre>
* permet d'indiquer que la <b>relation</b> est <b>bidirectionnelle</b>
* il faut l'indiquer � JPA : <b>@OneToMany(mappedBy = "patient")</b>
	* indique � JPA que la relation est d�j� mapp� dans la classe <i>RendezVous</i> via l'attribut <i>Patient</i>
		* se traduit par la cr�ation d'une <b>cl� �trang�re</b> dans la table <i>RendezVous</i>
	* indique � JPA que les deux relations @oneToMany et @ManyToOne, sont la m�me repr�sentation relationnelle
	* cela lui indique, que cela se traduit par la <b>m�me cl�-�trang�re</b>
*<b>IMPORTANT</b> : si la propri�t� est omise, une <b>table d'association</b> sera cr�e en base [PATIENT_RENDEZ_VOUS]
</pre>

#### fetch (LAZY | EAGER)

##### fetch=FetchType.LAZY

<pre>
* permet de dire � JPA/Hibernate, au chargement d'un objet <i>Patient</i>, a partir de la base de donn�es:
	* de <b>ne pas charger en m�moire</b> la liste des <i>RendezVous</i> de ce patient
	* les autes informations seront remont�es dans l'objet
* la <b>r�cup�ration</b> se fera au moment de l'appel du <b>getter</b>
	* c'est un chargement � la demande
	* au momemnt, o� l'on en a besoin
</pre>

##### fetch=FetchType.EAGER

<pre>
* les <b>valeurs</b> de la <b>collection</b> sont <b>remont�es directement</b> quand on charge le Patient
* <b>inconv�nient</b> : charg� en m�moire des donn�es qui ne sont pas utilis�es
* <i>note</i> : � un int�r�t dans certains cas :
	* gestion des r�les : charger les r�les de l'utilisateur quand on r�cup�re ses r�les
	* composition : voiture [moteur|roues|...]
*<b>IMPORTANT</b> : il faut initailiser la collection avec EAGER dans la d�claration
	* new ArrayList<Entity>;
</pre>

## one-to-one

<pre>
* idem oneToMany
* <b>association bidirectionnelle</b>
* il y a une cl� �trang�re qui sera plac�e dans l'une ou l'autre table
	* <b>mappedBy</b> => indique que la cl� �trang�re est d�j� mapp� dans l'autre classe 
</pre>

## many-to-many
