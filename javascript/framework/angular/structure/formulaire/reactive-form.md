# Reactive Forms

[structure](../structure.md)

## Mise en place

### module
<pre>
module: ReactiveFormsModule
</pre>

### FormGroup

#### Principe
<pre>
* <b>FormGroup</b> : création d'un group de contrôle
	* à l'aide d'un <b>FormBuilder</b>
	* avec ajout les contrôles 
* dans le fichier html, on fait le binding des éléments
</pre>

#### Création

##### Mode opératoire
<pre>	
1- <b>FormGroup</b> : création d'une variable de classe
2- <b>FormBuilder</b> : à injecter dans le constructeur du composant
3- <b>ngOnInit</b> : construction du formGroup
	* spécification des contrôles sous forme de tableau dans un objet
	* tableau: valeur par défaut et les validateurs	
</pre>
	
##### Code	
<pre>
  addProductFormGroup?:<b>FormGroup</b>;
  submitted:boolean = false;

  constructor(private fb:<b>FormBuilder</b>, private productsService:ProductsService) { }

  ngOnInit(): void {
    // création d'un groupe de contrôle
    this.addProductFormGroup=this.fb.group({
	  // <b>liste des contrôles</b>
      name: ["", Validators.required],
      price: [0, Validators.required],
      quantity: [0, Validators.required],
      selected: [true, Validators.required],
      available: [true, Validators.required]
    });
  }
</pre>	
	
#### Binding

##### Définition
<pre>
* Le binding permet de lier l'<b>objet</b> de type <b>FormGroup</b> et le <b>formulaire HTML</b>
* Le binding permet de mettre à jour l'objet formGroup et le formulaire de la manière suivante :
	1- quand le formulaire est mis à jour, l'objet est mis à jour
	2- quand l'objet est mis à jour, le formulaire est mis à jour
 
* Le binding s'opère dans le fichier html en utilisant les propriétés suivantes :
	* <b>[formGroup]</b> 
	* <b>formControlName</b>
	
	<i>Code
	... form <b>[formGroup]</b>="addProductFormGroup" ...
	... input <b>formControlName</b>="name" ..</i>

<i>Note</i> :
	<i>Code</i>
	
	<b>... *ngIf="addProductFormGroup" ...</b>
	
	* permet de n'afficher le formulaire que quand il est créé.
	* rappel : le formulaire est construit dans le ngOnInit
</pre>

##### Code
```
<div class="container" *ngIf="addProductFormGroup">

	<form <b>[formGroup]="addProductFormGroup">
	<div class="form-group">
	  
	  <!-- contrôle Name -->
	  <label>Name</label>
	  <input type="text" class="form-control" formControlName="name"
		[ngClass]="{'is-invalid':submitted && addProductFormGroup.controls.name.errors}">
	  
	  <!-- affichage message erreurs-->
	  <div *ngIf="submitted && addProductFormGroup.controls.name.errors" class="invalid-feedback">
		<div *ngIf="addProductFormGroup.controls.name.errors.required">Name is required</div>
	  </div>
	</div>

...

</form>
```

#### Validation du formulaire

##### transmission des données
<pre>
* à la validation, l'<b>objet de type FormGroup</b> est transmis.
	* les valeurs des contrôles transmises par le formulaire le sont par l'objet formGroup et le binding
* dans la <b>méthode</b> de validation du <b>controleur</b>, il suffit de récupérer simplement la <b>valeur</b> de l'<b>objet</b> formGroup
</pre>

##### Validation des donnnées
<pre>
* pour la validation, il faut vérifier que le formulaire est <b>valid</b>
	* if (this.addProductFormGroup?.<b>invalid</b>) return;
	* si non, le code qui suit n'est pas exécuté
</pre>

##### code
<pre>
<i>Note</i> :
this.addProductFormGroup?.value
	* si l'objet possède une valeur
</pre>

<pre>
onSaveProduct() {
	this.submitted = true;
	// <b>check si le form est valid</b>
	if (<b>this.addProductFormGroup?.invalid</b>) return;
	
	// appel du service de sauvegarde
	this.productsService
	  .save(this.addProductFormGroup?.value)
	  .subscribe(data => {
		console.log("success saving product");
	  });
}
</pre>

#### validators
##### css

###### principe
<pre>
* ajout de style <b>CSS</b> sur un <b>contrôle</b> du formulaire
* utilisation de la directive : <b>[ngClass]</b>	
</pre>

###### code
<pre>
<i>Exemple</i> : ajout de la classe 'is-invalid'
<i>Code 
input ... <b>[ngClass]</b>="{'is-invalid':submitted && addProductFormGroup.controls.name.errors}">
</i>
</pre>


##### messages

###### principe
<pre>
* affichage du message d'erreur en fonction du type de validators
* on peut avoir plusieurs validators, sur un attribut

<i>Exemple</i>

	* affiché un div si une erreur intervient sur le contrôle
		* en utilisant la directive : <b>*ngIf</b> ... addProductFormGroup.controls.name.<b>errors</b> 
		
	* alimenté le div avec l'erreur liée au contrôle
		* en utilsant au la directive : <b>*ngIf</b> ... addProductFormGroup.controls.name.errors.<b>required</b>
</pre>

###### code
```
<div *ngIf="submitted && addProductFormGroup.controls.name.errors" class="invalid-feedback">
	<div *ngIf="addProductFormGroup.controls.name.errors.required">Name is required</div>
</div>
```