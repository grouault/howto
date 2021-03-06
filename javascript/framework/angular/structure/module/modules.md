
[structure](../structure.md)
[home](../../angular.md)

# Module
<pre>
Module au sens Angular : regroupement de différents composants, services, filters qui forment un ensemble cohérent.
Partir d'application
Exemple : gérer l'utilisateur ==> isoler dans un module
</pre>

## AppModule
<pre>
- boostraper l'application - initialisation de l'application
- Module d'initialisation des composants de l'application
- main.ts: permet de boostraper le module et d'initialiser les composants de l'application
- <b>app.module.ts</b> : les modules sont à déclarer dans cette partie
</pre>

## FormsModule
<pre>
- permet de créer et gérer les formulaires de l'application
- Permet d'utiliser la directive NgModel
- à importer dans AppModule: FormsModule
- à importer dans le composant : import {FormsModule} from '@angular/forms';
</pre>

## HttpModule
<pre>
* Permet d'utiliser la couche HttpClient, et d'envoyer les requêtes http.

* cmd : <i>import {HttpClientModule} from '@angular/common/http'</i>
</pre>

## RouterModule
[router-module](router-modules/router-modules.md)
<pre>
Mécanisme de traitement des routes
route : associé un composant à un path
Question : où faire l'injection des composants?
==> on peut vouloir garder un header / footer constant
==> <router-outlet> : router d'angular, c'est à cet endroit que tu injectes le composant qui nous intérèsse.
</pre>