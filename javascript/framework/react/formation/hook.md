# Hook

[home](../index-react.md)

## Principe

<pre>
Les hooks sont un excellent moyen d’accéder aux méthodes d’état et
 de cycle de vie de React à partir d’un composant fonctionnel.
</pre>

## useState

### principe

<pre>
* le state stocke les données <b>dynamiques</b> liées aux composants.
* le changement d'une données du state engendre la mise à jour 
  du composant (<b>méthode render</b>) et donc la mise à jour du dom.
* le state met à jour le DOM virtuel qui met à jour le DOM réel.
</pre>

## useEffect

### principe

<pre>
Le Hook useEffect est une fonction (effet) qui s’exécute
* après le rendu 
* et chaque fois que le DOM est mis à jour
</pre>

### child vs parent

<pre>
L’utilisation du hook d'effet se comporte de manière similaire aux méthodes 
de cycle de vie de la classe.
* composant DidMount, 
* composant DidUpdate 
* et composant WillUnmount combinés.
 
Un comportement à noter est que le rappel de l’enfant est déclenché avant le rappel du parent.
Disons que vous devez déclencher un paiement automatiquement. 
Ce code est écrit dans la composante enfant qui s’exécute après le rendu, 
mais les détails réels (montant total, escompte, etc.) requis pour le paiement 
sont récupérés dans l’effet de la composante mère. Dans ce cas, 
comme le paiement est déclenché avant de définir les détails requis, il ne sera pas réussi.
Gardez cela à l’esprit et structurez votre code en conséquence.
</pre>

### tableau de dépendances

### Pas de dépendances

<pre>
Le hook accepte un second argument, connu sous le nom de tableau de dépendance, 
pour contrôler quand le callback devrait se lancer.
Effets d’exécution sur chaque mise à jour DOM
<b>Attention</b>
Ne pas passer dans un tableau de dépendances exécutera le callback 
sur chaque mise à jour DOM.
</pre>

### tableau vide et rendu initial

<pre>
* Effets d’exécution sur le rendu initial
Passer un tableau vide exécute les effets seulement après le rendu initial. 
A ce moment l’état est mis à jour avec ses valeurs initiales. 
Les autres mises à jour dans le DOM n’appellent pas cet effet.
Ceci est similaire aux méthodes de cycle de vie 
* componentDidMount 
* componentWillUnmount (sur retour).

<b>important</b>
C’est là que tous les écouteurs et abonnements requis pour votre page est ajouté.
</pre>

### effets sur des propiétés qui changent

<pre>
Supposons que vous devez chercher des données (détails du produit) en fonction du produit
qui intéresse un utilisateur. Le produit sélectionné a un ID de produit, par exemple.
Nous devons lancer le callback chaque fois que le productId change
et pas seulement sur le rendu initial ou sur chaque mise à jour DOM.

Ceci a essentiellement répliqué la méthode de cycle de vie componentDidUpdate.
Nous pouvons également passer plusieurs valeurs au tableau de dépendance.
</pre>

### Passé un objet dans le tableau de dépendance

<pre>
Maintenant, que se passe-t-il si votre callback dépend d’un objet. 
Nos effets s’exécuteraient-ils avec succès si vous faisiez cela ? :

const [obj, setObj] = useState({'a' : 1}) 
useEffect(() => {
    //do something on `obj` change
}, [obj] );

La réponse est non, car les objets sont des types de référence. 
Toute modification d'une propriété de l’objet passerait inaperçue par le tableau de dépendance 
car seule la référence est vérifiée mais pas les valeurs à l’intérieur.

Solution :
JSON.stringify l'objet

const [objStringified, setObj] = useState(JSON.stringify({'a' : 1}))
useEffect(() => {
    //do something on `objStringified` change 
    // use JSON.parse to access a property of the object 
}, [objStringified])

</pre>

### Gérer les dépendances dans les fonctions

<pre>
Supposons que vous voulez décomposer le code en plus petites fonctions 
et l’appeler de l’effet, comme ci-dessous :

<i>
function MyComponent({ data}) {

  function doSomething() {
    console.log(data);  
  }

  useEffect(() => {
    doSomething();
  }, []); // we call the function which is dependent on the prop but not included in the dependency array
}
</i>

Cela ne nous donnerait pas le comportement attendu 
- doSomething dépend de données qui ne sont pas incluses dans le tableau useEffect. 
Toute mise à jour des données ne déclenchera pas notre callback.

C’est pourquoi React recommande que nous ayons la fonction dans le useEffect 
car il est plus facile de tracer les dépendances.

Mais que faire si vous voulez écrire des fonctions réutilisables? 
Ou le transmettre à partir d’un composant parent?

Lorsque vous voulez passer une fonction en tant que prop à son composant enfant, vous devez ajouter 
la fonction au tableau de dépendance dans l’effet du composant enfant. 
Mais chaque fois que quelque chose change dans parent, de nouvelles instances de ces fonctions 
sont créées et notre callback est lancé. C’est inefficace.

useCallback vient à la rescousse.
Similaire à useEffect, useCallback accepte un callback et un tableau de dépendances. 
Il retournera une version memoized du callback qui ne change son identité que si l’une des dépendances a changé, 
en veillant à ne pas créer une nouvelle instance de la fonction à chaque fois que le parent re-rend.
</pre>

## useRef

### principe

<pre>
* une ref permet d'avoir une <b>référence</b> sur un élément du <b>DOM réel</b>.

* Si un composant react cible une élément du dom avec une ref, c'est qu'il
  n'a pas vocation a se mettre à jour quand cet élément du dom change de 
  valeur.
  Par contre, à instant t, il peut ponctuellement avoir besoin d'accéder
  à la valeur de cet élément. On utilise donc la ref, pour accéder à la 
  valeur de cet élément du Dom
  <b>Attention </b>:
  Par exemple, dans le cas de checkbox géré par ref dans un formulaire,
  la mise à jour d'un élément ciblé par une ref, met à jour directement le DOM réel.
  Le composant et le DOM virtuel ne sont pas mis à jour.
</pre>

### exemple -1

```
  // dom
  <input ref={inputPwd} type="password"
  <input ref={inputPwd} type="password"

  // javascript
  const inputPwd = useRef();
  const inputRepeatPwd = useRef();

  if (
    inputPwd.current.value.length < 6 ||
    inputRepeatPwd.current.value.length < 6
  ) {
    setMessageValidation("Longueur trop petite");
    return;
  }

```

### exemple-2

<pre>
<b>Attention</b>, dans cet exemple, tiré d'une modal,
quand la modal est close, le composant n'est pas forécment démonté,
mais disparaît qd même du dom.
Du coup, il faut nettoyer les refs sur le close car qd le composant
est réaffiché car qd il est réaffiché c'est un nouvel elément du dom
qui est inséré dans le tableau.
</pre>

```
  // dom
  <input ref={addInputs} type="password"
  <input ref={addInputs} type="password"

  const inputsPwd = useRef([]);
  const addInputs = (el) => {
    if (el && !inputsPwd.current.includes(el)) {
      inputsPwd.current.push(el);
    }
  };
```

## api Context

### principe

<pre>
Un contexte est un objet (zone mémoire) qui a voccation à stocker 
de la data qui doit être diffusé à d'autres composants.
Le contexte doit pouvoir être <b>exporté</b> pour pouvoir être utiliser 
via le hook useContext
</pre>

### Quand utiliser un contexte:

<pre>
* Un contexte est à utiliser pour gérer des données transverses:
- connexion utilisateur
- theme
* Pour partager des données entre composants qui n'ont pas de 
  hiérarchie.

</pre>

### Créer un contexte

```
export const LangContext = createContext({});
```

### provider

### Définition

<pre>
Le provider est un composant s'utilise sur le contexte et à vocation :
* à <b>alimenter</b> le contexte
* à <b>diffuser</b> le contexte au élément enfants

Dans sa définition, on utilise la propriété <b>provider</b> du contexte pour 
définir le composant.
La propriété <b>value</b> permet d'initialiser les valeurs du contexte.

Dans son utilisation, le provider vient encapsuler/wrapper les composants enfants.
Le provider va alors hydrater/fournir aux composants enfants les données du contexte.

Exemple: 
    < LangContext.Provider <b>value</b>={{ lang: lang, toggleLang: toggleLang }} >
      {props.children}
    < />
</pre>

#### provider et HOC

<pre>
En utilisant un simple provider, il est difficile d'agir dynamiquement sur le
contexte et de gérer toute la logique et les données que l'on veut gérer pour
nos composants.

On utilise alors un autre composant d'ordre supérieur (HOC). A l'image d'une 
fonction d'ordre supérieure qui peut utiliser une autre fonction callback ou 
en retourner une autre, le HOC retourne un composant.
Dans le corps de ce HOC, on peut créer une logique qu'on partegera au composant 
qu'on retourne, qui lui même partagera à tous les composants qu'il entoure.

Ce <b>provider</b> est un composant à part entière qui doit donc être exporter.
 
Une pratique courant est d'alimenter le contexte avec le state du composant.
Cela permet aux élément enfants d'agire sur le state du composant parent et
d'ainsi mettre à jour le contexte.
</pre>

#### exemple Provider HOC

<pre>
export const <b>LangContext</b> = createContext({});

const <b>LangContextProvider</b> = (props) => {
  const browserLang = navigator.language.slice(3);

  const [lang, setLang] = useState(browserLang);

  const authorizedLang = ["FR", "ES", "EN"];

  const toggleLang = (activeLang) => {
    authorizedLang.indexOf(activeLang) >= 0
      ? setLang(activeLang)
      : setLang("EN");
  };

  return (
    < LangContext.Provider <b>value</b>={{ lang: lang, toggleLang: toggleLang }} >
      {props.children}
    < />
  );
};
</pre>

##### utilisation provider

```
function App() {
  return (
    <LangContextProvider>
      <ToggleLang />
      <Contenu />
    </LangContextProvider>
  );
}
```

### useContext

#### principe

<pre>
Le hook useContext s'utilise sur les composants enfants pour pouvoir
récupérer les données de contexte.
Il faut donc aussi récupérer le contexte à utiliser.
Une fois le contexte récupéré, les données du contexte (simple data ou fonction) peuvent 
être alors utilisées dans le composant enfant.
</pre>

#### exemple

<pre>

// <b>récupération du contexte</b>
import { LangContext } from "../../context/LangContext";

// <b>composant enfant qui utilise le contexte</b>
export default function ToggleLang() {

  // récupération des données du contexte
  const { lang, toggleLang } = useContext(LangContext);

</pre>
