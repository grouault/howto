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
* <b>FormGroup</b> : cr�ation d'un group de contr�le
	* � l'aide d'un <b>FormBuilder</b>
	* avec ajout les contr�les 
* dans le fichier html, on fait le binding des �l�ments
</pre>

#### Cr�ation

##### Mode op�ratoire
<pre>	
1- <b>FormGroup</b> : cr�ation d'une variable de classe
2- <b>FormBuilder</b> : � injecter dans le constructeur du composant
3- <b>ngOnInit</b> : construction du formGroup
	* sp�cification des contr�les sous forme de tableau dans un objet
	* tableau: valeur par d�faut et les validateurs	
</pre>
	
##### Code	
<pre>
  addProductFormGroup?:<b>FormGroup</b>;
  submitted:boolean = false;

  constructor(private fb:<b>FormBuilder</b>, private productsService:ProductsService) { }

  ngOnInit(): void {
    // cr�ation d'un groupe de contr�le
    this.addProductFormGroup=this.fb.group({
	  // <b>liste des contr�les</b>
      name: ["", Validators.required],
      price: [0, Validators.required],
      quantity: [0, Validators.required],
      selected: [true, Validators.required],
      available: [true, Validators.required]
    });
  }
</pre>	
	
#### Binding

##### D�finition
<pre>
* Le binding permet de lier l'<b>objet</b> de type <b>FormGroup</b> et le <b>formulaire HTML</b>
* Le binding permet de mettre � jour l'objet formGroup et le formulaire de la mani�re suivante :
	1- quand le formulaire est mis � jour, l'objet est mis � jour
	2- quand l'objet est mis � jour, le formulaire est mis � jour
 
* Le binding s'op�re dans le fichier html en utilisant les propri�t�s suivantes :
	* <b>[formGroup]</b> 
	* <b>formControlName</b>
	
	<i>Code
	... form <b>[formGroup]</b>="addProductFormGroup" ...
	... input <b>formControlName</b>="name" ..</i>

<i>Note</i> :
	<i>Code</i>
	
	<b>... *ngIf="addProductFormGroup" ...</b>
	
	* permet de n'afficher le formulaire que quand il est cr��.
	* rappel : le formulaire est construit dans le ngOnInit
</pre>

##### Code
```
<div class="container" *ngIf="addProductFormGroup">

	<form <b>[formGroup]="addProductFormGroup">
	<div class="form-group">
	  
	  <!-- contr�le Name -->
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

##### transmission des donn�es
<pre>
* � la validation, l'<b>objet de type FormGroup</b> est transmis.
	* les valeurs des contr�les transmises par le formulaire le sont par l'objet formGroup et le binding
* dans la <b>m�thode</b> de validation du <b>controleur</b>, il suffit de r�cup�rer simplement la <b>valeur</b> de l'<b>objet</b> formGroup
</pre>

##### Validation des donnn�es
<pre>
* pour la validation, il faut v�rifier que le formulaire est <b>valid</b>
	* if (this.addProductFormGroup?.<b>invalid</b>) return;
	* si non, le code qui suit n'est pas ex�cut�
</pre>

##### code
<pre>
<i>Note</i> :
this.addProductFormGroup?.value
	* si l'objet poss�de une valeur
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
* ajout de style <b>CSS</b> sur un <b>contr�le</b> du formulaire
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

	* affich� un div si une erreur intervient sur le contr�le
		* en utilisant la directive : <b>*ngIf</b> ... addProductFormGroup.controls.name.<b>errors</b> 
		
	* aliment� le div avec l'erreur li�e au contr�le
		* en utilsant au la directive : <b>*ngIf</b> ... addProductFormGroup.controls.name.errors.<b>required</b>
</pre>

###### code
```
<div *ngIf="submitted && addProductFormGroup.controls.name.errors" class="invalid-feedback">
	<div *ngIf="addProductFormGroup.controls.name.errors.required">Name is required</div>
</div>
```