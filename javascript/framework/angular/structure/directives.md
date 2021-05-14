# directives
Le mécanisme d'expression (binding) n'est pas suffisant pour construire une application fonctionelle et dynamiqu
Les directives agissent sur la vue en fonction de 
- de variables
- de valeur
- de conditions 
qui viennent du composant, du serveur...
Suivant leur comportement, les directives agissent sur le code html : rendre visible ou non un élément, afficher des listes... 

Les directives les plus courantes: ngIf, ngFor, ngStyle, ngModel, ngClass
# ngIf
Conditionner l'affichage d'un élément.
<div *ngIf="display">Hello world</div>

# ngModel
[(NgModel)] lier un element html à une variable en mémoire

# ngFor
<li *ngFor="let item of list">{{item}}</li>

# ngStyle

# ngClass

########
# Form
########
# Select
<select name="profile" ngModel>
<option [ngValue]="null"></option>
</select>
name: permet de récupérer la valeur sélectionné à la validation du fomulaire
==> let userProfile: Profile = form.controls['profile'].value;
ngModel: permet d'enregistrer l'élément avec ngFrom (ou un binding two way)
ngValue : Permet de définir la valeur des options

