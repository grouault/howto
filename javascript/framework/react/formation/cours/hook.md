# Hook

[home](../../index-react.md)

## Principe

<pre>
Les hooks sont un excellent moyen d’accéder aux méthodes d’état et
 de cycle de vie de React à partir d’un composant fonctionnel.
</pre>

## Cycle de vie

<a href="https://blog.logrocket.com/guide-to-react-useeffect-hook/" target="_blank">lifecyle</a>

### DOM Virtuel

<pre>
Le pouvoir de React réside dans son processus de <b>réconciliation</b> robuste. 
Lorsque nous utilisons JSX pour créer ou mettre à jour des composants, 
React crée son propre <b>DOM virtuel</b> qui est une représentation mémoire
de l'interface utilisateur.

Il compare ce DOM virtuel au DOM réel dans le navigateur, calculant 
le moins de changements nécessaires pour mettre à jour le DOM réel 
pour correspondre au DOM virtuel.
React change juste la partie qui a besoin d'être mise à jour. 
</pre>

### RENDER : Dom Virtuel et State

<pre>
* Mise à jour du state
* Pour modifier le DOM, on passe par le State
* Le state met à jour le DOM Virtuel qui met à jour le DOM

<b>Important </b>: 
Différence entre <b>réinterpréter</b> et <b>réafficher</b> dans le DOM
* la réinterprétation n'est pas problèmatique pour REACT 
  - elle ne coûte pas chère.
* l'affichage du DOM coûte plus chère

REACT peut donc <b>interpréter</b> moulte fois le code, il ne <b>réaffiche</b> que 
les élements HTMLs qui ont été modifiés.  

<b> Attention </b>, dans la méthode RENDER, à chaque rerendu : : 
- Pour un objet de style présent, recréation d'un objet mis en mémoire 
- Pour une arrow function, nouvelle référence mise en mémoire   
</pre>

### collections d'éléments

<pre>
Parfois, nous utilisons <b>plusieurs instances</b> du même composant au même endroit. 
Comme les multiples instances d’un composant 'TodoItem' dans un composant 'TodoList'. 
Lorsque cela se produit, les <b>clés uniques</b> sont très importantes, car elles permettent 
à React de différencier ces composants similaires, et de cibler ceux qui peuvent 
avoir besoin d’être mis à jour individuellement, au lieu de les ré-afficher tous.
</pre>

## useState

### principe

<pre>
* le state stocke les données <b>dynamiques</b> liées aux composants.
* le changement d'une données du state engendre la mise à jour 
  du composant (<b>méthode render</b>) et donc la mise à jour du dom.
* le state met à jour le DOM virtuel qui met à jour le DOM réel.
</pre>

### Previous state

<a href="https://fr.reactjs.org/docs/hooks-reference.html#functional-updates" target="_blank">Functional updates</a>

<pre>
Quand la mise à jour du state tient compte de la valeur précédente,
il faut passer par une fonction.

<b>exemple: 1</b>
<i>
function Counter({initialCount}) {
  const [count, setCount] = useState(initialCount);
  return (
    <>
      Count: {count}
      <button onClick={() => setCount(initialCount)}>Reset</button>
      <button onClick={() => setCount(prevCount => prevCount - 1)}>-</button>
      <button onClick={() => setCount(prevCount => prevCount + 1)}>+</button>
    </>
  );
}
</i>

<b>exmple 2</b> 
<i>
  const addToast = useCallback(content => {
    setToasts(toasts => [
      ...toasts,
      { id: id++, content }
    ]);
  }, [setToasts]);
</i>

<b>exemple 3</b>
<i>
  const goPreviousSlide = () => {
    setSlideAnim((slideAnim) => {
      if (!slideAnim.inProgress) {
        setTimeout(() => {
          setSlideAnim({index: slideAnim.index > 1 ? slideAnim.index - 1 : 5, inProgress: false})
        }, 500);
        return {index: slideAnim.index > 1 ? slideAnim.index -1 : 5, inProgress: true}
      } else {
        return {...slideAnim}
      }
  }
</i>

</pre>

## useEffect

<a href="https://betterprogramming.pub/tips-for-using-reacts-useeffect-effectively-dfe6ae951421" target="_blank">Tips UseEffects</a>

<a href="https://blog.logrocket.com/guide-to-react-useeffect-hook/" target="_blank">Cycle de vie</a>

### principe

<pre>
Le Hook useEffect est une fonction (effet) qui s’exécute
* après le rendu à chaque mis à jour du DOM.

<b>attention</b> : suivant qu'il y ait ou non un tableau
de dépendance, le comportement d'exécution de l'effet sera
différent.
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

### principe

<pre>
Le hook s'exécute après le rendu.
Néammoins, avec un tableau de dépendance renseigné le callback
ne s'exécutera que sous-condition.
Le tableau de dépendance est donc très important quand au cycle 
de déclenchement de l'effet sur le composant.
</pre>

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
<i>
const [obj, setObj] = useState({'a' : 1}) 
useEffect(() => {
    //do something on `obj` change
}, [obj] );
</i>
La réponse est non, car les objets sont des types de référence. 
Toute modification d'une propriété de l’objet passerait inaperçue par le tableau de dépendance 
car seule la référence est vérifiée mais pas les valeurs à l’intérieur.

Solution :
JSON.stringify l'objet
<i>
const [objStringified, setObj] = useState(JSON.stringify({'a' : 1}))
useEffect(() => {
    //do something on `objStringified` change 
    // use JSON.parse to access a property of the object 
}, [objStringified])
</i>
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
  }, []); // we call the function which is dependent on the prop 
          but not included in the dependency array
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

## useCallback

### principe
<pre>
Dans un composant (parent), à chaque fois que le composant est rerendu,
toute fonction créé dans le composant se voit assignée d'une nouvelle empreinte
mémoire. Ce qui signifie que c'est une nouvelle fonction.

<b>Problème potentiel</b>:
1- si cette fonction est passé en parmètre via des props à un autre composant (enfant),
le composant est rerendu car la fonction a changé.
2- si cette fonction est utilisé dans un useEffect(), le useEffect() sera réinitialisé
également pour les mêmes raisons et ce n'est pas forcément ce que l'on veut. 
Effectivement, on ne veut peut être que ce useEffect() ne se déclenche qu'une seule fois.

<b>Solution</b>:
Il faut mémoiser la fonction.
* Il s'agit ici de stocker la fonction (callback) dans une variable via un <b>useCallback</b>.
* useCallback prend en premier paramètre votre fonction callback et en deuxième paramètre 
  une liste de dépendances similaires à ce qu’il peut y avoir pour un useEffect.
* Ce qui se passe en interne, c’est qu’un appel à useCallback va créer une fonction et 
  la retourner dans une variable.
* Lors d’un appel successif à useCallback, et si la liste des dépendances n’a pas changé 
  par rapport au précédent appel, la fonction ne sera pas recalculée et la même adresse 
  sera ainsi retournée.
  React a désormais un moyen de savoir si le callback calculé est une nouvelle valeur 
  ou non et ainsi 
    * déclencher un nouveau rendu si cela est nécessaire.
    * redéclencher le useEffect dans le composant enfant.
      Il convient dans ce cas de mettre en paramètre du useEffect, la fonctoin mémoisée.
  Dans la documentation, React conseille donc de passer en dépendance toute variables et 
  fonction utilisée dans le callback à l’exception évidemment des paramètres de la fonction.

<b>Note:</b>
* un composant dont l'état est modifié avec changement de valeur, 
  est rerendu ainsi que ses composant enfants.
* un composant dont l'état est modifié mais sans changer la valeur,
  est rerendu mais pas ses composants enfants.
* le rerendu des composants enfant n'impacte pas le dom, si pas de changements
  constatés au niveau de ces composants.
</pre>

## useRef

### useRef et variable
<pre>
On parle de variable qui pointe sur une ref.
Ref (Référence ) signifie ici le lien (couple) entre l'objet et les variables.
On modifie l'objet référencé => on ne change donc pas la référence
Modifier la ref ne provoque pas de rerender. 
C'est ce que l'on fait avec useRef().
Pour avoir un rerender, il faut une nouvelle référence.

Par contre, quand on fait un setState(value) ;  on change la référence.
La variable pointe sur un nouvel objet.
En fait, c'est une nouvelle référence qui est créé. Le state
pointe alors sur cette nouvelle référence. C'est ce qui provoque le rerender.

Une ref, c'est un state qui ne change jamais.

const ref = useRef(0);
const [state] = useState({current: 0});
ref.current = 1 ==> pas de rerender
state.current = 1 ==> pas de rerender

Quand se servir de useRef

**useRef** est parfait pour stocker des valeurs qui ne sont pas affichées dans la vue.
</pre>

### useRef et DOM

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
