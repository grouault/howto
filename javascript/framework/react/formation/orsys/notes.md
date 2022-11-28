## Infos

[retour](../../index-react.md)

g.rouault@groupe-pomona.fr/Formation2022
gildasrouault@groupe-pomona.fr

## Questions

- Implémentation des règles métiers...
- Promise : résultat dans un cache
  Question : comment est vidé ce cache?

## Notes

- 2009: Moteur V8 : rapport de 1 à 1000 en terme d'exécution.
- CDN : applis que l'on met en cache
  le code js généré est statique et plus dynamique généré par le back
- shadow naming: nom identique entre méthodes internes et externes
- dynamiquement typé vs faiblement typé
<pre>
    // le type est détérminé dynamiquement
    var a = 1;
    console.log(typeof(a));
    // faiblement typé
    a = "toto"; 
</pre>

## copie ou référence

<pre>
var a = 1;
var b = a; // Passage par copie

/*
b = 42;
console.log(a); // 1
console.log(b); // 42
*/

var c = {a: 1, b: 2};
var d = c; // Passage par référence
d.a = 42;
console.log(c.a); // 42
console.log(d.a); // 42
</pre>

## Closure

<pre>
* comme si on avait un cache en interne
  la fonction se souvient du contexte d'appel
</pre>

## Event-Loop

<pre>
* Thread principal 
* le thread principal délègue à l'event-loop qui gère la liste des évènements.
* les events sont mis dans une liste  FIFO et traité par ordre d'arriver
* garantit le traitement synchrone des évènements
* Moteur V8 : Stack + Heap + Queue
</pre>

## Contexte et Fonctions

<pre>
* on ne peut pas accéder au contexte d'une fonction interne via l'extérieur.
</pre>

## This

En JavaScript, le mot-clé this représente l'appelant et non pas le déclarant

<pre>
constructor(firstname) {
this._firstname = firstname;
}
sayMyName() {
// SOLUTION 1
var that = this;
setTimeout(function() {
that._sayName();
}, 1000);

// SOLUTION 2
setTimeout(function(context) {
context._sayName();
}, 1000, this)

// SOLUTION 3
setTimeout(function() {
this._sayName();
}.bind(this), 1000);

// SOLUTION 4
setTimeout(() => {
this._sayName();
}, 1000);
}
_sayName() {
    console.log("Bonjour, je m'appelle " + this._firstname);
}

const joe = new User('Joe');
joe.sayMyName();
</pre>

## Destructuring

<pre>
REST = Réuni les éléments
... ??? (...params) => [1,2,3,4]
</pre>
<pre>
const [a, b,, d, [f, g]] = [1, 2, 3, 4, [5, 6]];
console.log(f, g); // 5 6
</pre>

## Componsant

<pre>
    * Réseau de composants
    * Route pour savoir par qui sont appelés les composants
        * Route et non hiérarchie de composants.
        * différents de AngularJS
    * SMART
        * petit mais avec intelligence : ALGO + DATAs
        * moins on en a, plus le code est réutilisable
    * DUMB
        * composant débile qui fait de l'AFFICHAGE
        * composant plus feuillu
</pre>

## Interface

<pre>
    * interface pour typer les props
</pre>

## RENDER : Dom Virtuel et State

<pre>
* Mise à jour du state
* Pour modifier le DOM, on passe par le State
* Le state met à jour le DOM Virtuel qui met à jour le DOM
* Important : Différence entre réinterpréter et réafficher dans le DOM
    * la réinterprétation n'est pas problèmatique pour REACT 
      - elle ne coûte pas chère.
    * l'affichage du DOM coûte plus chère
    REACT peut donc interpréter moulte fois le code, il ne réaffiche que 
        les élements HTMLs qui ont été modifiés  

*<b> Attention </b>, dans la méthode RENDER, à chaque rerendu : : 
    - Pour un objet de style présent, recréation d'un objet mis en mémoire 
    - Pour une arrow function, nouvelle référence mise en mémoire   
</pre>

### uuid

<pre>
Le pouvoir de React réside dans son processus de réconciliation robuste. 

Lorsque nous utilisons JSX pour créer ou mettre à jour des composants, 
React crée son propre DOM virtuel. 
Il compare ce DOM virtuel au DOM réel dans le navigateur, calculant 
le moins de changements nécessaires pour mettre à jour le DOM réel 
pour correspondre au DOM virtuel. 

Parfois, nous utilisons plusieurs instances du même composant au même endroit. 
Comme les multiples instances d’un composant 'TodoItem' dans un composant 'TodoList'. 
Lorsque cela se produit, les clés uniques sont très importantes, car elles permettent 
à React de différencier ces composants similaires, et de cibler ceux qui peuvent 
avoir besoin d’être mis à jour individuellement, au lieu de les ré-afficher tous.
</pre>

## Autres

<pre>
    * ne pas mettre index dans les listes.
</pre>
