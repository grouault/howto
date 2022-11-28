## BlockChain

<pre>
* Web décentralisé
* la donnée est stockée partout
</pre>

## GraphQL - ServerSideRendering

<pre>
* aujourd'hui: Route prédéfini avec Back Associé
* Avec GraphQL : Front décide de ce qui lui est renvoyé
* Front: fait la liste des courses et le back lui renvoit
</pre>

## Hoisting - Hissage

<pre>
* déclarer les variables en haut du code
* déclencher par var
</pre>
<pre>
function() {
        var foo;<-   
    if (!foo) {  |
        var foo = 10;
        ==> foo = 10;
    }
    console.log('test');
}
</pre>

## undefined vs null

<pre>
* Pkoi garder les 2
* Si on enlève undefined, on fait tomber 99% du web
</pre>

## séparateur ou ||

<pre>
* renvoie la première valeur true ou renseigné ou la dernière si aucune ne correspond
</pre>

## Notes

<pre>
* En JSX, pour éviter d'avoir à recharger un component, on peut le cacher : Hidden
</pre>

## Component

<pre>
* réutilisabilité
* fonctionnalité : separation of concept
</pre>

## Hook

<pre>
* simplifier l'utilisation de la donnée
* rendre plus logique la lecture du code
* maintenabilité
    * tout est au même endroit avec les hooks
    * rassembler les hooks par thème : faire des hooks custos.
* réutilisabilité
    * avec les hooks, de nombreuses choses peuvent être extraite des composants
</pre>

## Hook : useEffect

<pre>
* useEffect : développement par fonctionnalité
    ==> componentDidMount
    ==> componentWillUpdate
</pre>

## CustomHook / Composition API / Custom API

<pre>
* sortir du code commun à plusieurs composants
* avoir des features réutilisables
* fonction sans paramètre
* permet de sortirles éléments que l'on veut exporter
* plus besoin d'être dans le composant
* hook peut déclarer des éléments réactifs
* les propriétés réactives sont alors exportées du hook
    pour être utilisable par le composant
</pre>

## Mixins

<pre>
* ajouter des fonctionalités aux composants Stateless et Statefull
* ne fonctionne pas sur les composants fonctionnels
* remplacé par hook / context / customHook
* https://fr.reactjs.org/blog/2016/07/13/mixins-considered-harmful.html
</pre>

## Module et Export

<pre>
* tout fichier exporter est transformé en module et mis en mémoire vive
* si le fichier est modifié, il l'est en mémoire
* on récupère alors la donnée modifié dans le composants
</pre>
<pre>
* peut être intéressant pour charger un fichier de données
* partager une donnée dans l'application
</pre>
<pre>
/* Objet vide pour stocker les datas */
export default const {
    userDataHooks: {}
}
/* 
App 
Dans App, on remplit l'objet vide avec un customHooks
Charmgement des données dans l'objet vide
*/
import globalDatas from './global'
globalDatas.userDataHooks = useUsers();

/* 
Fichier 
Dans le fichier, on récupère les données
*/
import globalDatas from './global'
const {users, loadingUsers} = globalDatas.userDataHooks;
</pre>

## Children

## HOC

<pre>
* optimiser la réutilisabilité
* renvoi un autre composant
</pre>

## Rooting

### Définition des routes

```
import {BrowserRooter as Rooter, Routes, Route} from 'react-router-dom'
<Routes>
    <Route path="/" element={ <homePage />}></Route>
    <Route path="/login" element={ <loginPage />}></Route>
</Routes>
```

### Navigation

```
    <nav>
        <ul>
            <link><link to="/home">Accueil</link></li>
            <link><link to="/login">Login</link></li>
        </ul>
    </nav>
```

### Routes imbriquées

<pre>
* Définir des routes imbriquées dans un composant
* Les routes doivent être défini au niveau du router global
    et dans le compsant...
* Dans le composant, mettre le composant <Outlet /> pour voir 
    apparaître les routes enfants
</pre>

```
    Parent.jsx
        Child1.jsx
        Child2.jsw
    <Outlet />
```

### Paramètres des routes

### Exemple

<pre>
* Exemple : /ma-route/:monParam
* Implementation : /ma-route/123
</pre>

### Récupération des paramètres

<pre>
* hook useParams : renvoie un objet avec les variables déclaré dans la route
* hook useLocation : récupèrer toute la route
</pre>

### LAZY-LOADING

<pre>
* chargé simplement les pages que l'on veut
* SUSPSENSE : comportement par défaut quand la page se charge
</pre>

## Formulaire contrôlé

<pre>
* passage par le state
* permet de contrôler les inputs en live
* notifier à chaque changement de l'input
</pre>

## Formulaire non contrôlé

<pre>
* refs : dès qu'il y a le moindre chargement, le parasite se met à jour
* récupération des datas via l'id
    * document.querySelector('#id').target.value
* const parasite = useRef();
* < composant ref = {parasite} />
* parasite.current.value
</pre>

## gestion des erreurs

### dans le state avec un tableau ou objet

<pre>
const [errors, setErrors] = useState([]);

</pre>

### TP

<pre>
* Attention : distinguer erreur remonter par Axios et celles remontées par Formik
</pre>

## Formik

<pre>
    * contexte : zone qui appartient à Formik
    * permet de faire des formulaires multi-composant qui accèdent au contexte
</pre>

## ImmutableJS

## Performances

<pre>
* mise à jour d'une variable JavaScript
    * timer
    * action utilisateur
    * api / network

* Phase de détection :
    * détecter les changements de variables
* Phase Compare:
    * comparer avec l'existant pour savoir si 
        noeud enfant/parent détecte ce qui change    
        les enfants et parent peuvent devoir se mettre à jour
        si la variable a été mise  à jour.
        Il sont donc par défaut réinterprété pour checker
        - customHook
        - store
        - context

* Différence : 
    * interprétation : étape compare 
    * réaffichage : étape render / change
        - rerendu si uniquement un changement est constaté

* Mémo :
    * plus d'interpréation hormis les variables en props.
    * me réinterprété qui si une ptté du parent a changé

* un dump component ne doit jamais 
    - être abonné au store
    - jamais appelé un custom hook
    - être consummer d'un provider
    car rien ne garantit que ds un autre projet
    - redux soit utilisé
    - provider implémenté
    - custom hook présent

* tous les dumps component peuvent être memoisés

* minimsé les smarts components : pas de memoisation sur ces composants

</pre>

## REDUX

<pre>
* FLUX : principe la donnée transite toujours du haut vers le bas
    ==> API Context : idem

* Container : 
    * HOC : un composant passe par le container pour communiquer avec le store
    * s'applique sur un smart component
    
* store : un objet javascript
</pre>
