
# Injectable

[structure](structure.md)

## définition
Il s'agit d'une annotation que l'on positionne sur un composant : service ou autre pour indiquer 
que la classe devient une entité injectable sous la forme d'un singleton ou non.

## @Injectable({providedIn:"root"})
<pre>
* pour dire que l'on peut l'injecter
* providedIn : pour indiquer qu'il est disponible dans le root de l'application
	* sinon il faut de déclarer dans <b>app.module</b>
	* indique que le service est <b>disponible</b> au niveau de toute <b>l'application</b>
</pre>

## Component / constructor
Dans le constructeur, on peut mettre en paramètre les injectables.
L'injectable est alors créé et devient disponible dans le composant ; une proprieté du nom de l'injectable est alors créé automiquement.

## Import
@angular/core
