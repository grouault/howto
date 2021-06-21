## D�composition

[structure](../structure.md)

### Principe
<pre>
Cette partie traite de la communication entre les composants.
Angular permet de d�composer l'application en diff�rents composants.
Les composants peuvent alors interagir entre eux et communiquer.
Pour cela, diff�rentes options sont possibles :
1- @Input / @Output
2- EventSubjectService
3- Framework avec state : Redux 
</pre>


### @Input / @Output

#### @Input

#### @Output
<pre>

ProductNavBarComponent
* click sur le bouton
	* ex�cuter une op�ration qui se trouve dans composant parent
	* envoyer un message/ un �vn�nement vers le composant parent
		* sortie @output : pour envoyer l'�venement on utiliser un objet de type EventEmitter
		* @ouput: cela veut dire que le composant a une sortie
			* chaque fois que l'on fait eventEmitter.emit() ; le composant emet l'�v�nement sur sa sortie.
	* le composant parent r�cup�re l'�v�nement et ex�cuter l'op�ration
</pre>

##### EventEmitter
<pre>
Le Output peut �tre typ� ou pas:
@Output() productEventEmitter: EventEmitter<ActionEvent> = new EventEmitter();	
@Output() productEventEmitter: EventEmitter<any> = new EventEmitter();	
	
au niveau de la d�claration du composant :
	* le composant Enfant est d�clar� dans le composant Parent
	* l'�v�nement est transmis au parent et d�clenche une action associ�e
	
	<i>code</i> :
	... app-product-nav-bar (productEventEmitter)="onActionEvent($event)" ...

</pre>

##### Event
<pre>
L'event correspond � la donn�e qui est transmise quand l'ActionEmitter est d�clench�.
Quand l'�v�nement est d�clench� l'event est transmis au parent sous forme de param�tre dans la fonction parente.

L'event peut se d�finir de la mani�re suivante : 
* cr�er une interface qui d�finit l'event avec 2 attributs
	* type:<ProductActionType> : un enum�rateur pour savoir le type d'event (add / update / ...)
	* payload:<any>
</pre>

### Sub/Pub avec Subject


* service dans lequel on va g�rer la communication entre les composants : EventDriverService

    * permet de faire la communication entre les composants d'une application � travers un objet,
        - il faut cr�er un subject ( �quivalent � un broker )
        - qui a un �tat (ActionEvent), � un moment donn� il contient un ActionEvent
    * permet de centraliser le state
        - state = ActionEvent

    - Subject (rxjs) : programmation r�active :
    - utilisation du design pattern Observable
    - Dans le Subject, on va publier des �v�nements de type ActionEvent
    - Sur le subject, on va cr�er un Observable
    - une fois publi� dans le subject, tous les composants de l'application qui veulent �couter un event particulier,
      n'ont qu'� faire qu'un subscribe vers l'observable

1- injecter le service dans le composant dans lequel on souhaite �couter
2- dans la m�thode ngOnInit() : d�s que le composant d�marre, appel au service d'�coute.
    * d�s que tu d�marres, �coute moi ce qu'il se passe sur ce broker
    * attent les actionEvent
    * qd il les re�oit, il les traite

3- il est possible de faire des subscribe sur plusieurs subjects
    - s�par� les op�rations d'�criture et de lecture
    - il faut cr�er des subjets sur deux types d'�v�nements diff�rents

TODO : � redispatcher
* Faire un observable qui dispactchent les actions
* action qui va �tre intercept� par le composant � l'�coute de cette action pour ex�cuter le traitement qu'il faut

* service dans lequel on cr�� un subject
* dans le subject on utilise un observable
* chaque composant peut faire des subscribe vers l'observable
* chaque composant contient un ev�nement qui se produit sur chaque composant ==> ???
* il suffit de faire un publish, plublier un message, une action
* quand une action est publi�e, le composant va recevoir, le composant peut alors ex�cuter une action

==> Publier un ev�nement sur un observable
==> Composant font un subscribe que l'observable ==> cela signifie qu'ils �coutent l'�v�nement


