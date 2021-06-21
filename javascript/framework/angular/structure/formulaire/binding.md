# binding

[structure](../structure.md)

## définition
- variable en mémoire
- mécanisme d'expression: {{ ... }}
Angular évalue l'expression : {{ 1+1 }}
Faire des test : {{ title === 'app' }}

But :
- exécution du javascript
- faire appel à des attributs
- faire des opérations, concaténation, commande javascript simple, vérification, tests...

## FormsModule
- Permet d'utiliser la directive NgModel
- à importer dans AppModule

## [(NgModel)] lier un element html à une variable en mémoire
<input type="text"  [(NgModel)]="saisie" />
Angular : met toi à l'écoute de que l'utilisateur met dans ce champs et met le résultat dans la variable saisie.
==> inspecter la valeur en permanence, écouter, pousser

==> Déclarer la variable dans le contrôleur pour influencer ce qui est affiché à l'écran

## event bindig syntax
Un évènement est associé à un sélecteur. L'évènement est associé à un traitement particulier qui est une méthode du composant.
Exemple:
Permet de lier l'évènement click à la méthode afficher().
<button (click)="afficher()">Afficher</button>

## class binding syntax
https://angular.io/guide/template-syntax#class-binding
Permet d'ajouter ou supprimer une classe CSS de l'attribut 'class' d'un élément HTML.
<!-- toggle the "special" class on/off with a property -->
<div [class.special]="isSpecial">The class binding is special</div>

<!-- binding to `class.special` trumps the class attribute -->
<div class="special"
     [class.special]="!isSpecial">This one is not so special</div>

## style binding syntax

