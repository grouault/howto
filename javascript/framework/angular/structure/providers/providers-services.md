
[structure](../structure.md)
[home](../../angular.md)

## Provider
Pour angular, la notion de provider est associé à la notion de service.
Le service se concentre sur la partie métier.

## Convention de nommage d'un fichier provider
<pre>
mon-service.provider.ts
mon-service.service.ts
</pre>

## @Injectable({providedIn:"root"})
<pre>
* pour dire que l'on peut l'injecter
* providedIn : pour indiquer qu'il est disponible dans le root de l'application
	* sinon il faut de déclarer dans <b>app.module</b>
	* indique que le service est <b>disponible</b> au niveau de toute <b>l'application</b>
</pre>