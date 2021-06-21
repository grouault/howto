## Décomposition

[structure](../structure.md)

### Principe
<pre>
Cette partie traite de la communication entre les composants.
Angular permet de décomposer l'application en différents composants.
Les composants peuvent alors interagir entre eux et communiquer.
Pour cela, différentes options sont possibles :
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
	* exécuter une opération qui se trouve dans composant parent
	* envoyer un message/ un évnènement vers le composant parent
		* sortie @output : pour envoyer l'évenement on utiliser un objet de type EventEmitter
		* @ouput: cela veut dire que le composant a une sortie
			* chaque fois que l'on fait eventEmitter.emit() ; le composant emet l'évènement sur sa sortie.
	* le composant parent récupère l'évènement et exécuter l'opération
</pre>

##### EventEmitter
<pre>
Le Output peut être typé ou pas:
@Output() productEventEmitter: EventEmitter<ActionEvent> = new EventEmitter();	
@Output() productEventEmitter: EventEmitter<any> = new EventEmitter();	
	
au niveau de la déclaration du composant :
	* le composant Enfant est déclaré dans le composant Parent
	* l'évènement est transmis au parent et déclenche une action associée
	
	<i>code</i> :
	... app-product-nav-bar (productEventEmitter)="onActionEvent($event)" ...

</pre>

##### Event
<pre>
L'event correspond à la donnée qui est transmise quand l'ActionEmitter est déclenché.
Quand l'évènement est déclenché l'event est transmis au parent sous forme de paramètre dans la fonction parente.

L'event peut se définir de la manière suivante : 
* créer une interface qui définit l'event avec 2 attributs
	* type:<ProductActionType> : un enumérateur pour savoir le type d'event (add / update / ...)
	* payload:<any>
</pre>

### Sub/Pub avec Subject


* service dans lequel on va gérer la communication entre les composants : EventDriverService

    * permet de faire la communication entre les composants d'une application à travers un objet,
        - il faut créer un subject ( équivalent à un broker )
        - qui a un état (ActionEvent), à un moment donné il contient un ActionEvent
    * permet de centraliser le state
        - state = ActionEvent

    - Subject (rxjs) : programmation réactive :
    - utilisation du design pattern Observable
    - Dans le Subject, on va publier des évènements de type ActionEvent
    - Sur le subject, on va créer un Observable
    - une fois publié dans le subject, tous les composants de l'application qui veulent écouter un event particulier,
      n'ont qu'à faire qu'un subscribe vers l'observable

1- injecter le service dans le composant dans lequel on souhaite écouter
2- dans la méthode ngOnInit() : dès que le composant démarre, appel au service d'écoute.
    * dés que tu démarres, écoute moi ce qu'il se passe sur ce broker
    * attent les actionEvent
    * qd il les reçoit, il les traite

3- il est possible de faire des subscribe sur plusieurs subjects
    - séparé les opérations d'écriture et de lecture
    - il faut créer des subjets sur deux types d'évènements différents

TODO : à redispatcher
* Faire un observable qui dispactchent les actions
* action qui va être intercepté par le composant à l'écoute de cette action pour exécuter le traitement qu'il faut

* service dans lequel on créé un subject
* dans le subject on utilise un observable
* chaque composant peut faire des subscribe vers l'observable
* chaque composant contient un evènement qui se produit sur chaque composant ==> ???
* il suffit de faire un publish, plublier un message, une action
* quand une action est publiée, le composant va recevoir, le composant peut alors exécuter une action

==> Publier un evènement sur un observable
==> Composant font un subscribe que l'observable ==> cela signifie qu'ils écoutent l'évènement


