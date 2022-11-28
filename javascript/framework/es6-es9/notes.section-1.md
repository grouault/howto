[home](./es6-es9.md)

## Ecmascript

<pre>
* Ecmascript 6
Pas supporté par tous les navigateurs.

* Babel :
transforme du JS ES6 en JS basique.
</pre>

### Variable

<pre>
* <b>variable</b> = conteneur qui peut être modifié au cours du temps
* variable globale / variable local
* La portée globale permet de définir une variable disponible dans des blocs de niveaux inférieurs
* variable locale est disponible seulement dans le bloc de sa définition et dans ses blocs fils.
</pre>

### undefined vs null

<pre>
* undefined est un type
* null : assignement value pour un objet
</pre>

### let

<pre>
* permet de forcer le développeur à positionner la déclaration de variable au bon endroit dans un bloc.
* Evite d'avoir des variables à 'undefined' au niveau de l'exécution du code.
* Exemple: variable définit dans une boucle et utilisable en dehors !!
</pre>

```
    var age = 30;
    if (age < 18) {
        let message = 'ok';
    }
    console.log(message);
    ==> avec var : message = undefined
    ==> avec let : ReferrenceError : message is not defined
```

### const

<pre>
* c'est un conteneur qui ne peut pas changer de valeur.
</pre>

### HTML / Récupérer un sélecteur

document.querySelector('#id');
document.querySelector('.class');

## innerHtml vs textContent (exo2)

A la place du innerHtml,la propriété textContent, plus sécurirsée, peut-être utilisé.
divResultat.innerHtml = ' ... ';
divResultat.textContent = ' ... ';

## Template String (exo4)

- Utiliser backStick : ``
- espace javascript dans template : ${contenu}
- padStart / padEnd : à compléter pour obtenir un nombre de caractères prédéfini en y ajoutant une chaîne choisie
  Exemple :

```
    let nom = 'toto';
    let nom = nom.padStart(10,'-') ==> ------toto
```

## Boucle for...in / for...of (exo.6-7-8)

for...in : à privilégier sur les 'objets'
for...of : à utiliser sur tableau ou objet itérables ainsi que for / forEach

## Destructuring / Décomposition

<pre>
permet d'extraire des données d'un tableau ou d'un objet pour obtenir des variables réutilisables.

* Tableau :
  - extraction des valeurs dans des variables.
  - dans cette extraction, l'ordre est important / le nommage des variables ne l'est pas.
  - let [variable1, variable2] = monTableau;

* Objet
  - extraction des propriétés dans des variables de même noms.
  - dans cette extractions, le nommage des propriétés est important / l'ordre ne l'est pas.
  - permet de recupérer une, plusieurs ou toutes les propriétés d'un objet.
  - let {nom, age} = persos;
</pre>

## Opérateur Spread & Rest

<pre>
* Spread: 

    * utiliser pour créer des copies réelles 
        * de tableaux
        * d'objets

    * concaténation de tableau
    <i>
    exemple 1 :
        let tete = ['yeux','nez','bouche'];
        let basDuCorps = ['jambes', 'pieds'];
        let corps = ['bras', ...basDuCorps, 'main', ...tete];
    
    exemple 2 :
        let t1 = [1,2,3];
        let t2 = [4,5,6];
        let newTableau = [...t1,...t2];
  </i>
    * opérateur qui sert à séparer et récupérer des informations de tableaux et d'objets.
   <i> 
    exemple 3 :
        let t1 = [5,10,15,20]
        const [n1,n2,...reste] = t1        
    </i>

* REST : opérateur qui permet de récupérer (sous forme de tableau) un nombre illimité d'arguments passés en paramètre de fonction.
    <i>
    exemple 4 :
      function f(,w,x,y,z) {}
      function fTab(first, ...rest){}
      let args = [2,3,4];
      f(1, ...args, 5);
      fTab(1, {a:2}, 5);
    </i>
</pre>

## Tableaux

### from

<pre>
Array.from({length:5}).map( ... );
==> permet de créér un tableau avec chaque 
élément prenant la valeu <b>undefined</b>
</pre>

### includes

<pre>
permet de tester la present d'un elément dans le tableau
el : string ou objet
</pre>

```
  const addInputs = (el) => {
    if (el && !inputsPwd.current.includes(el)) {
      inputsPwd.current.push(el);
    }
  };
```

### map

#### principe

<pre>
- réalise une copie + une transformation
- retourn un nouvel objet
</pre>

#### exemple

```
  const officers = [
    { id: 20, name: 'Captain Piett' },
    { id: 24, name: 'General Veers' },
    { id: 56, name: 'Admiral Ozzel' },
    { id: 88, name: 'Commander Jerjerrod' },
  ];

  // What you need
  // [20, 24, 56, 88]
  const ids = officers.map((officer) => officer.id);
```

#### react

<b>key</b>: il faut une clé unique quand on manipule
une liste pour que React se retrouve dans les éléments.
Cette clé sert à savoir quel élément est impacté lors
d'un ajout, suppression ou modification.

</pre>

### findIndex

<pre>
prend une fonction de callback en paramètre
 remonte le premier élément trouvé par la condition remplit dans le callback.
</pre>

### find

<pre>
idem 'findIndex' mais remonte la valeur
</pre>

### filter

#### principe

<pre>
* sur un tableau permet de ne retenir que certains éléments du tableau
* permet donc de <b> supprimer </b> des éléments du tableau
* Si la fonction Rollback retourne 'true', l'élément courant est dans 
le tableau résultant.
</pre>

#### exemple

```
  pilots = [
    {
      id: 2,
      name: 'Wedge Antilles',
      faction: 'Rebels',
    },
    {
      id: 8,
      name: 'Ciena Ree',
      faction: 'Empire',
    },
    {
      id: 40,
      name: 'Iden Versio',
      faction: 'Empire',
    },
    {
      id: 66,
      name: 'Thane Kyrell',
      faction: 'Rebels',
    },
  ];

  const rebels = pilots.filter((p) => p.faction === 'Rebels');
  const empire = pilots.filter((p) => p.faction === 'Empire');
```

### entries

<pre>
s'applique sur objet itérable style 'tableau' mais pas un objet.
  Pour un tableau de valeur, permet de remonter l'index + valeur.
  s'utiliser avec for...of.
</pre>

### includes

<pre>
permet de trouver un élément dans un tableau (chaine de caractère)
</pre>

### push

<pre>
ajout un élément à la fin du tableau
</pre>

### pop

<pre>
supprime un élément à la fin du tableau
</pre>

### reduce

#### principe

<pre>
* générer une simple valeur à partir d'un tableau
* passe le résultat du callback (l’accumulateur) d’un élément de tableau à l’autre.
</pre>

#### exemple

```
  // pilote avec leurs nombre d'années d'expérience
  var pilots = [
    {
      id: 10,
      name: 'Poe Dameron',
      years: 14,
    },
    {
      id: 2,
      name: "Temmin 'Snap' Wexley",
      years: 30,
    },
    {
      id: 41,
      name: 'Tallissan Lintra',
      years: 16,
    },
    {
      id: 99,
      name: 'Ello Asty',
      years: 22,
    },
  ];

  // avoir le nombre total d'années d'experience
  const nbYearsTotal = pilots.reduce(
    (accumulator, p) => p.years + accumulator,
    0
  );
  console.log('nb years total = ', nbYearsTotal);

  // nombre d'années d'experience moyenne
  const average =
    pilots.reduce((accumulator, p) => p.years + accumulator, 0) / pilots.length;
  console.log('average = ', average);

  // pilote avec le plus d'experience
  const mostExperiencePilot = pilots.reduce(
    (oldest, p) => (p.years > (oldest.years || 0) ? p : oldest),
    {}
  );
```

### slice

<pre>
* réalise une copie
* supprimer ou ajouter un élément dans le tableau.
</pre>

## Paramètre par défaut de fonction

## Fonctions fléchées

Une fonction anonyme qui s'écrit sans le mot clef 'function' et qui utilise les flèche à la place.
ex : (x) => x \* 2;
La syntaxe dépend de deux facteurs : nombre de paramètres et nombre d'instructions de la fonction fléchées.
Intéressange pour la gestion de 'this' et 'super'.

## Fonctions de rappel

Permet de passer une fonction 2 en paramètre d'une autre fonction 1.
Fonction 2 exécuter au moment de l'appel de la fonction 1
Dans quel cadre une fonction de rappel est utilisée ?
Pour réaliser des traitements avant le lancement d'une autre fonction.

## Import && Export

Export: permet d'exporter des éléments d'un fichier qui sont ensuite utilisable d'en d'autre à l'aide d'un import.
Import : permet de récupérer des éléments d'un autre fichier.
Import Objet : import Object from './path.js'
Import Fonction : import {function1, function2} from './path.js'

## Closure

<pre>
* se souvient du contexte dans lequel l'appel a été fait
* peut être appelé dans n'importe quel contexte 
</pre>

```
// Exemple
var value = null;

// closure 1
setTimeout(() => {
  value = 'toto';
}, 1000);

// closure 1
setTimeout(() => {
  console.log('value 1 = ', value);
}, 2000);

console.log('value 2 = ', value);

// pas de closure
(function (value) {
  console.log('value 3 = ', value);
})();

```

## Object

### structure

```
// structure
const user = {
    firstName:'titi';
    surName: 'gogo'
}
```

### ajouter/modifier un attribut

```
user.lastName = 'toto';

// supprimer un attribut
delete user.firstName;
```

### Cloner un objet

```
// Object.assign
const objToClone = {a:1, b:2};
const monClone = Object.assign({}, objToClone, {c:3});

// spred operator
const objToClone = {a:1, b:2};
const monClone = {...objToClone, c:3, d:4};
```

### Objects

<pre>
* permet de manipuler un objet
</pre>

#### keys/ values

<pre>
const user = {
    firstName:'titi';
    surName: 'gogo'
}

const key = Object.keys(monObjet)[0];
key => 'firstName'

const value = Object.keys(monObjet)[0];
value = 'titi';

</pre>

#### entries

<pre>
const [key, value] = Object.entries(monObjet)[0];
key => 'firstName';
value = 'titi';
</pre>

## Prototype

```
var User = function User(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
};
User.prototype.getFullName = function () {
  return this.firstName + ' ' + this.lastName;
};
user = new User('titi', 'tutu');
console.log(user.getFullName());
```

## Classes
