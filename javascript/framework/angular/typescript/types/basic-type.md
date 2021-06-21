## String

## Boolean
public error: Boolean = false;

## Array
public films: Array<Object> = new Array<Object>();

## Valeur par défaut
<pre>
formGroup?:FormGroup;
	* ? : pas obligé d'affecter une valeur par défaut.
	* l'objet peut ne pas avoir de valeur
	
<i>note</i> : il faut alors utiliser l'objet comme suit:
<b>formGroup?.value</b> : affichage de la valeur si l'objet possède une valeur	
	
formGroup?:FormGroup | null = null;
	* l'objet peut être null
</pre>

## 
<pre>
{{addProductFormGroup?.value|json}}
	* afficher la valeur de l'objet dans le html au format json
</pre>