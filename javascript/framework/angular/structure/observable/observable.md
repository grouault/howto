[structure](../structure.md)

# Programmation réactive
Problématique: gestion du temps de réponse.
Le navigateur ne met à diposition qu'un Thread à la fois et il faut pour l'utilisateur ne pas attendre que le serveur réponde.

## Promise
Le principe est le suivant:
- j'ai un traitement dans un coin ; il vit sa vie et me rappelle quand le traitement est terminé.
- mécanisme de requête / réponse avec un traitement long potentiel ==> Je prévois ce qui se passe et derrière je réponds.

## Observable
Un observable est un canal de communication ; comme si j'allumais la radio, des nouvelles tombent et on s'abonne à un mot clé.
Mécanisme d'écoute / évenementiel : se mettre à l'écoute d'un click ou interaction avec l'utilisateur ; 
Quand le serveur / utilisateur a quelque chose à me dire, j'effectue un traitement.
Le canal est ouvert le temps que le serveur réponde.

### Module 
import {Observable} from 'rxjs/Observable'


### Composant et observable
<pre>
* Le composant <b>consomme</b> l'observable et surveille l'observable
* Exemple : Fonction qui remonte un observable
	<i>fonction rehercherFilms(titre:String): Observable<Array<Film>> { ... }</i>
* On est bien sur un mécanisme asynchrone, je ne renvoie pas la valeur directement mais un observable qui est 
	capable de fournir un Array<Film> ou une erreur à la fin du traitement.
</pre>

#### Subscribe
<pre>
* Le <b>composant</b> se met à l'<b>écoute</b> du cancal de communication / <b>observable</b> 
* Le composant est inscrit au canal et réagit quand ce dernier répond
	* qd une valeur est ajoutée au canal add ou erreur ou autre
		le composant peut traiter l'information.
* Le composant surveille et attend que les données arrivent
</pre>

##### Syntaxe
<pre>
* La fonction prends un seul arguments
	* soit le <b>handler next</b>
	* soit un objet <b>observer</b> (voir en-dessous)
</pre>
<pre>
// subscribe avec un Observer
this.productService.getAllProducts()
  .<b>subscribe</b>({
	<b>next</b>: (data) => {
	  this.products= data;
	},
	<b>error</b>: err => {
	  this.erreur = error;
	  console.log(err),
	},
	<b>complete</b>: () => {
	  this.loading = false; // traitement termine
	}
  });
</pre>

##### Variable
<pre>
* une variable qui est affecté à un observable est généralement suffixé par un $
	<i><b>products$</b>:Observable<Product[]> | null = null</i>
</pre>

#### Subscribe (HTML)
<pre>
* possible de renvoyer au HTML, l'objet subscribe
* la souscription et le traitement fait avec se fait dans la partie HTML
* on surveille et on attend les données
</pre>

<pre>

</pre>

#### Pipe()
<pre>
</pre>

## Observer

### Principe
<pre>
* sert à expliquer ce qui se passe dans le canal de communication
* est en <b>paramètre</b> de l'objet <b>Observable</b>
	<i>return new Obervable(observer => { ... })</i>;
</pre>

### Paramètres
<pre>
* <b>complete</b> : je ferme le canal de communication ; j'ai dit tout ce que j'avais à dire.
* <b>next</b>: info est disponible, je peux la ventiler aux abonnés.
* <b>error</b>: définir une erreur
* <b>add</b> : ajouter des chose dans le canal.
* <b>remove</b>: enlever qqchose du canal
</pre>

### Autres
<pre>
On peut s'en servir comme buffer, file, evènement ou ventiler une seul info...
</pre>