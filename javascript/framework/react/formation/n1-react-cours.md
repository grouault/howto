
[retour](../index-react.md)

### Commande pour lancer la création d'un projet REACT
* npx create-react-app projet0

### Structure-Projet
* folder node_modules : ensemble des modules à dispo pour réaliser l'application REACT
* folder public : 
    - index.html, seul fichier html du site
    - robot.txt : https://developers.google.com/search/docs/advanced/robots/create-robots-txt?hl=fr&visit_id=637459098710031895-641018878&rd=1
    - manifest.json : config de la partie public
* folder src : application REACT
* package.json : gestion des modules de l'application

### Lancer l'application
* npm start ==> http://localhost:3000/

### index.js
> index.js fait le lien avec le fichier index.html du fichier public.
> le contenu de index.js est basculé directement dans le fichier index.html
> index.js appelle l'application App présente dans le fichier App.js
index.html : structure standard d'une page web.
* possibilité d'enrichir ce fichier : meta, css, des parties script (bootstrap).
* index.js : permet de prendre toute l'application REACT et la positonne dans la balise id="root"

### Fichier js
<pre>
* Récupération des libraires REACT 

    <b>import React from 'react';</b> 
        * récupération de la librairie REACT et ses fonctionnalités

* Insertion des éléments dans le DOM
 
    <b>import ReactDom from 'react-dom'</b>; 
        * manipulation du dom avec REACT

</pre>

## JSX

### Principe

* permet de facilité l'implémentation d'élément du DOM ; nécessite l'import de la librairie REACT
* génère en fait un code javascript (géré par REACT)
```
React.createElement('h1', null, 'coucou') <==> <h1>coucou</h1>
```

### JSX et Ecriture JavaScript

https://medium.com/javascript-in-plain-english/curly-braces-versus-parenthesis-in-reactjs-4d3ffd33128f

* {} : permet d'exécuter du code JS
```
    props: <Personne nom={this.state.personnes[0].nom} .../> 
    style avec backstick: <div className={`${classes.monTitre} horloge`}> ...
```
* Test
> dans le return on renvoit du code JSX et on ne peut faire de test sinon qu'entre les accolades (ternaire)
> sinon faire du code avant le return.
* Itération pour afficher une liste : utilisation de la fonction map
> retourne un tableau que le JSX est capable d'afficher dirctement
> Exemple :
``
    <FRAGMENT>
    {this.state.personnes.map((personne, index) => {
        return <Personne key={index} {...personne} clic={this.anniversaireHandler.bind(this, index)}>
            <AgePersonne age={personne.age} />
        </Personne>
    })}
    </FRAGMENT>    
``
équivant à un tableau d'élément :
``
    return (
        [<Personne>, <Personne>, ...]
    ); 
``

## Composant

### défintion
* C'est du code JSX
    - Simple fonction qui retourn du code JSX
    - Classe qui implément méthode Render()
* Ce que renvoit un composant :
    - un bloc <div>
    - un tableau d'élément (jsx = javascript) : 
        exemple:
        ```
        [
            <h1>Coucou</h1>,
            <p>Mon prénom est Matthieu</p>
        ]
        ```
    - auxiliares : ??
    - <Fragment></Fragment>
    - <></>

### Création des composants - définition

#### A base de fonction
<pre>
La création des composants dans React se fait :

* 1- soit sous forme d'une <b>définition de  fonction</b> qui renvoit du JSX
    - à utiliser pour composant qui ne fait que le l'affichage : <b>stateless</b>
   
    Syntaxe : nom de fonction en minuscule.
    - Définition :  function app () { ... }; 
    - Intance : composant <App /> : permet d'utiliser le composant portant le nom App 
    - Norme pour une fonction : minuscule ou majuscule pour l'instance du composant.

</pre>

```
function app() {
    return <h1 className="test">Coucou</h1>;
}
export default app;
```

#### A base de classe
<pre>
* 2- soit sous forme de <b>classe</b>
    * composant avec logique : 
        * datas(state) + traitement(fonction) + composants(affichage) : <b>statefull</b>
    
    - Syntaxe : nom de classe avec une majuscule
    - étend un élément spécifique de React : Component.
    - implémenter de manière obligatoire la fonction Render.

    - Norme pour une classe : majuscule pour le nom/instance du composant. 
</pre> 
```
// Composant de type class.
class App extends Component{
    render() {
        return <h1 className="test">Coucou</h1>;
    }   
}
export default App;
```

<pre>
<i>Note:</i>
* Un composant de type 'fonction' correspond à la méthode 'render' d'une compoant de type 'class'.
* L'avantage des composants est donc leur réutilisabilité pour créer des objets à la volée. 
</pre>

### Import / Export
* import App from './app'
    - './': indique le répertoire courant  'src'
    - pour les fichier '.js', pas besoin de l'extension

### props (propriété)
* Passage d'information à des composants
* IMPORTANT : Props ne permettent pas de metttre à jour l'info ; il est impossible de modifier des props.
* ecmascript 7 : 
* Dans un container, plus besoin d'initialiser les props dans constructor dans un composant
    - Cela se fait directement : this.props.
    - Avant ecmascript 7 : 
``` 
    constructor(props){
        super(props);
    }
```

* Dans un composant déclaré par fonction, on passe les props en paramètre.
```
    const personne = (props) = { ... }
```

* Passage des props à un composant
> Passer de manière unitaire
```
<Personne nom={this.state.personnes[1].nom} age={this.state.personnes[1].age} sexe={this.state.personnes[1].sexe} />
```
> Passer de manière globale:
```
 <Personne {... this.state.personnes[0]} />
```

### state
#### Définition
* Moyen pour conserver une information : stocker, manipuler, véhiculer et mettre à jour de l'information au travers des composants.
* React transfert les données aux composants via les 'states'
* 'state' est un objet qui sert à stocker des objets (datas = données) que l'on souhaite gérer pour mise à jour.
* Pour ce faire, on stocke l'information 'new Date()' au niveau d'un attribut de la classe Horloge 'date', dans l'attribut state, attribut spécifique de la classe Component.
* La mise à jour du state engendre la mise à jour de l'affichage, tous les composants utilisant l'informations mise à jour sont impactés et rafraichis.
* L'application réagit en fonction des données et les données sont les 'state' ( ou stockée dans le state).
* création du state:
1- via le constructeur:
```
    constructor(props){
        super(props);
        this.state = {
            date: new Date().toLocaleTimeString()
        }
    }
```
2- directement:
```
    this.state = {
        date: new Date().toLocaleTimeString()
    }
```

#### setState()
* permet de mettre à jour les données du composant pour réafficher celui-ci.
* fonction obligatoire qui permet de fusionner les données dans le state avec les données nouvellement transmises.
* > ** Important ** : ne pas utiliser le code suivant car il ne déclenche pas la méthode Render(); 
    ```
    this.state.attribut = ... ; 
    ```


#### immutabilité
* Consiste à faire en sorte de créer de nouvelle variables / constantes pour modifier la valeur d'un state
    * passer par une copie des informations des states | ne pas utiliser les précédentes valeurs
    > La mise à jour du state est faite de manière asynchrone   
    > il peut y avoir une incohérence dans le state dés lors que l'on veut modifier une valeur du state en utilisant la précédente valeur du state pour un attribut donné.
    > Comme l'appel setState est asynchone, on est pas certains que les opérations se déroulent dans le bon ordre.
    * Pour garantir l'immutabilité, il faut privilégier le passage par une fonction pour la mise à jour du state:
    ```
        this.setState((oldState, props) => {
            return {
                date: new Date().toLocaleTimeString(),
                cpt: oldState.cpt + 1
            }
        });    
    ```
    * Pour annuler l'opération de mise à jour du state:
    ```
    this.setState((oldState, props) => {
        if (...) { return null; }
        ...
        let newState = { ... };
        return newState;
    ```
    
#### Fusion dans les states
* On peut faire un 'setState' en remplaçant qu'une seule propriété du state, les autres propriétés ne sont pas modifiés. Dans ce cas, c'est une fusion qui est réalisée.
    ```
    handleChangeImage = (getNewImage) => {

        this.setState((oldState,props) => {
        
            const newPersonnage = {...oldState.personnage};
            newPersonnage.image = getNewImage(oldState.personnage.image);
            // fusion dans les states
            return {
                personnage: newPersonnage
            }

        });

    }    
    ```


### Cycle de vie dans REACT
* Montage d'un composant : 
    > constructor : construction du composant
        * on peut ici initialiser le state avec les props du composant.
    > render : le composant est affiché dans le navigateur
    > Mise à jour du Dom et les références des différents composants
    > componentDidMount : après le montage du composant
        * permet de réaliser une action après le premier chargement du composant, une fois qu'il a fait son premier affichage.
* Mise à jour du composant: new props | setState() | forceUpdate()
    > render
    > Mise à jour du Dom et les références des différents composants
    > componentDidUpdate
* Démontage:
    > componentWillUnmount : avant le démontage du composant

### Structuration du folder SRC
* créer un folder Component pour les composants Stateless
* créer un folder Container pour les composants Statefull

### CSS
* FICHIER GLOBAL:
> dans App.js : utiliser le système d'import.
```
import './App.css'
```

* FICHIER CSS pour un composant
> Ex: pour le composant : 'src\components\Personne\Personne.js'
> Créer un fichier Personne.css dans le folder et faire l'import
```
import './Personne.css'
```
> Pb: les classes CSS sont disponibles pour tous les composants.

* FICHIER CSS SPECIFIQUE à un composant : Module (disponible depuis version récente de React)
> Ex: pour le composant : 'src\components\Personne\Personne.js'
> Créer un fichier Personne.module.css dans le folder et faire l'import
```
import classes from './Personne.module.css'
```
> permet récupérer dans la variable 'classes' mon module que l'on peut utiliser comme un objet.
> Ex JSX ==> <div className={`${classes.monTitre} horloge`}>

* STYLE INLINE
```
const monStyle = {backgroundColor: 'green', color:'white'}
 Ex JSX ==> <div style={monStyle}>
```
> INTERET : créer du CSS dynammique: monStyle.fontSize = '12px'

## Evènement

### Gestion des évnènements dans REACT

### Principe REACT
* 1- définir les les évènements au niveau d'un container sous forme de fonctions de classe.
>  xxxxHandler
> handleXxxxxx
* 2- Transmission de la fonction à un composant fils 
> en transmettant la référence par l'intermédiaire d'une props.
> pour les paramètres, utlisations des fonctions fléchées ou de la fonction bind

### Evenement en jsx : ajout du code javascript sur onClick

#### Cas 1
```
    <button onClick={alert('coucou')}>Anniversaire</button>
```
* page affiche 'coucou' au démarrage.

#### Cas 2a
```
    <button onClick={function(){alert('coucou'); console.log(this);}.bind(this)}>
```
* this existe dans la fonction car binding explicite
*  execute la fonction au click.

#### Cas 2b
```
    <button onClick={() => alert('coucou')}>Anniversaire</button>
```
* this existe dans la fonction car utilisation d'une fonction fléchée.
* execute la fonction au click.

#### Cas 3
```
    ditBonjour() {
        ....
    }
    <button onClick={this.ditBonjour}>Anniversaire</button>
```
* On passe la référence de la fonction, sans les parenthèses pour ne pas l'exécuter
* **attention**: this n'existe pas dans la fonction

#### Cas 4
```
    ditBonjour() {
        ....
    }
    <button onClick={this.ditBonjour.bind(this)}>Anniversaire</button>
```
* this existe dans la fonction, car utlisation de la fonction 'bind' sur this
* pas de paramètre passé à la fonction
* pas besoin de passer event en paramètre : passé implicitement en dernier paramètre


#### Cas 5
```
    ditBonjour = () => {
        ....
    }
    <button onClick={this.ditBonjour}>Anniversaire</button>
```
* this existe dans la fonction car la fonction est définit avec une fonction flèchée.

#### Cas 6
```
    ditBonjour(args, e) {
        // console.log('Bonjour ' + nom);
        console.log('event = ', e);
        console.log('dit Bonjour : this = ', this);
        console.log('dit Bonjour : args = ', args);
    }
    <button onClick={this.ditBonjour.bind(this, ['param1','param2'])}>Anniversaire</button>
```
* this existe dans la fonction, car utlisation de la fonction 'bind' sur this
* les paramètres sont passés sous la forme d'un tableau
* Dans cet appel, e(event) est passé implicitement en tant que dernier paramètre.

#### Cas 7 
* à privilégier
```
    ditBonjour = (event, args) => {
        // console.log('Bonjour ' + nom);
        console.log('event = ', event);
        console.log('dit Bonjour : this = ', this);
        console.log('dit Bonjour : args = ', args);
    }
    <button onClick={(event) => this.ditBonjour(event, 'toto1')}>Anniversaire</button>
```
* fonction fléchée pour déclarer la fonction
* fonction fléchée pour appeler la fonction

### Children ou composition
* Système d'emballage de REACT ou composition : permet de manipuler des composants par des composants via la proprité children
* permet d'indiquer que l'on aura un composant 'enfant' qui sera affiché à cet endroit, peut-import ce que sait.
* Information définit à l'intérieur d'un composant
* Elle peut être exploitée par le compsants via la fonctionalité children : {this.props.children}
* L'intérêt d'utiliser ces composants fils, c'est de transmettre des informations au composant sans savoir ce que l'on va récupérer
* IMPORTANT : l'info transmises peut-être un composant, on parle de composant fils.
> exemple : composant d'erreur ou d'alerte | modale : "tu n'as pas à savoir ce que j'affichage mais juste tu dois de le mettre à cette place".

### Liste et fonction map()
* Dans le JSX, l'idée est souvent de parcourir le state qui dispose de données sous-forme de tableau
* La fonction map permet alors de traiter ce tableau de données et de le 'retourner/transformmer' en  'un tableau / une liste' de composants.
* La propriété 'key' est alors à définir pour chaque composant quand une liste de composants est ainsi générée
* La clé de la fonction map doit être présente sur le composant de plus haut niveau.
```
        <div className="row no-gutters">{
            armes.map((arme) => {
                return (
                    <div key={arme.key} className="col-3 text-center align-items-center">
                    <Arme label={arme.label} img={arme.img} />
                    </div>
                )
            })
        }
        </div>
```

## Formulaire
### Principe
* Objectif :
>  placer les informations de chacun des champs dans des 'state' et les relier aux inputs.
> Si le formulaire a 3 informations, chacune des infos aura une valeur dans les states (3 states)
* Notion de **composant contrôlé** :
> input: utilisation de la propriété 'value' pour référencer la valeur des state
> onChange : pour mettre à jour le state quand on change la valeur de l'input
> Le composant à utiliser devra être un composant de type 'Class'
```
<input 
    type="text" 
    className="form-control" 
    id="nomPersonnage" 
    placeholder="nom du personnage" 
    value={this.state.personnage.nom} 
    onChange={(e) => {this.setState((oldState) => {
        const newPersonnage = oldState.personnage;
        newPersonnage.nom = e.target.value;
        return {personnage: newPersonnage};
        })}
    }   
/>
```


### Soumission des formualaire
> Attention, le bouton dans la balise <form> peut déclencher la soumission du formulaire.
> Pour empêcher le comportement standard du bouton, il faut appeler 'preventDefault' sur l'event du bouton surlequel on a clické.
``` 
    handleValidationForm = (event) => {
        // eviter la validation du formulaire
        event.preventDefault();
        ...
    }

    <Bouton 
        cssClass="btn btn-primary" 
        handleClick={this.handleValidationForm}
```
> Dans cet exemple, event est passé implicitement.
> Même sans bouton submit, le comportment standard être actif, dû au formulaire

### Validation du formulaire avec 'Formik'
* contrôle + vérification
* npm install --save formik
* formik doit s'utiliser à l'emplacement où se trouver le formulaire
* PRINCIPE :
* Formik agit comme un wrapper sur le composant
```
    import {withFormik} from 'formik';
        ...
    export default withFormik()(FormulaireAjout)
```
* Le composant gère les données (values => fait office de state pour le composant)
* Le composant accède aux données et fonction sur les données via les props.
*
``` 
    <input type="text" placeholder="saisir un auteur"
        className="form-control" 
        id="auteur"
        name="auteur" 
        value={this.props.values.auteur} 
        onChange={this.props.handleChange}
    />
```
* il faut renseigner un objet à Formik pour lui indiquer les actions qu'il devra faire:
* 3 parties sont à renseigner dans l'objet :
- 1-  mapPropsToValues: () => ({ ... }) 
> Fonction qui retourne un objet : stock ce que l'on aurait stocké dans les states (= values pour Formik)
```
    mapPropsToValues: () => ({ 
        titre: '',
        auteur: '',
        nbPages:''
    }),
```
> Fonction qui réaliser la liaison enhtre les valeurs des inputs et les données qu'utilise Formik (ses props).
> Pour faire la liaison avec les 'inputs', le name des 'inputs' doit porter le même nom que les props de Formik
> values : stocke les valeurs des inputs (équivalent au states)
> handleChange : sert à modifier les valeurs des inputs (=> équivalent au setState() déclenché par le onChange())
> Cette partie là permet de supprimer/remplacer la partie state du composant
> withFormik s'exécute avant le formulaire d'ajout
> Formik met à disposition des informations dans les props du composant emballé
> => dont les 'props' de Formik et la fonction 'handleSumbit'

- 2- validate: values => {} :
> permet de lancer les actions de validation ; récupère les 'values' (valeur des inputs) et procéde aux validations
> La gestion de la validation se fait avec l'objet 'errors' 
> Il faut alimenter ce champs et le retourner

> handleBlur: permet de savoir si on a sélectionner / touché un élément (perte du focus)
> ==> permet d'afficher un message que si on clické / touché un des champs
> ==> la propriété 'touched' dans les props est alors mis à jour.
> Quand 'errors' contient des données, la propriété 'isValid' des props vaut 'false'

- 3- handleSubmit: (values: Values, formikBag: FormikBag) => void | Promise<any>
* Exemple : handleSubmit : (values, {props}) => { ... } 
> permet de lancer les actions à la soumission du formulaires
> props : ensemble des propriétés transférés depuis le composant d'origine
props = somme (Composant d'origine > Formik > Formulaire) 

### Module 'YUP'
> Fournit des fonctions qui permettent de tester les valeurs
* Installation
> npm install --save yup
* Récupérer directement l'ensemble des fonctions disponible par le module placé dans la propriété Yup
> import * as Yup from 'yup'
* utilisation de validationSchema: 
> fonctionne avec un schéma (générer par Yup), structure particulière, récupérer dans un objet.
> cet objet va récupérer plusieurs propriétés qui seront sur l'ensemble des champs
```
    validationSchema: Yup.object().shape({
        titre: Yup.string()
                    .min(3, 'le titre doit avoir plus de 3 caractères')
                    .max(15,'le titre doit avoir moins de 30 caractèes')
                    .required('le titre est obligatoire'),
        auteur: Yup.string()
                    .min(3, 'Ce champ doit avoir plus de 3 caractères')
                    .required('Ce champ est obligatoire'),
        nbPages: Yup.number()
                    .lessThan(1000, 'Nombre de pages < 1000')
                    .moreThan(50, 'Nombre de pages > 50')
    }),
```
* Pour tracker un champ entier:
> avec Formik remplacer le onChange par :
```
    <input type="number" placeholder="saisir un nombre de page"
        className="form-control" 
        id="nbPages"
        name="nbPages" 
        value={this.props.values.nbPages} 
        onChange={(e) => this.props.setFieldValue('nbPages', parseInt(e.target.value))}
        onBlur={this.props.handleBlur}
    />
```
> Attention : ce n'est pas parce que input=number que l'on récupère un 'number'
> Dans un formulaire, la valeur récupérée est une chaine de caractère qui doit être transformé en entier


## FIREBASE

## AXIOS
### Principe
* module permettant de faire la liaison avec la partie back-end
* librairie qui permet d'envoyer des requêtes à un serveur et de traiter des demandes/réponse grâce au fonctionnement des promesses JavaScript

### utilisation du cycle de vie du composant pour charger les données
* initalement, les données ne sont pas chargées, le composant ne doit rien afficher par rapport à ces données
* charger les données via axios quand le composant est monté : componentDidMount (se lance quand le composant est monté)
* une fois les données chargées, rafraichier le composant

### Doc

#### Liens
```
    https://github.com/axios/axios
```

#### Installation
```
    npm install axios --save
```
#### GET : Récupération des datas:
* informations json récupérées
* récupération des infos de la requête dans un paramètre de fonction (reponse par exemple)
* traitement associé à la suite de la récupération dans la fonction associé.
* traitement d'erreur dans le catch.


* Exemple : service de récupération des armes
```
    import axios from 'axios'
    // appel axiox
    axios
        .get('https://createurpersonnage-default-rtdb.firebaseio.com/armes.json')
        .then((reponse) => {
            // traitement de la réponse
            console.log('reponse = ', reponse);
        })
        .catch(error => {
            // taitement erreurs
            console.log('error = ', error);
        })
```

* Les datas sont récupérées sous la forme d'un objet.
```
// recuperation sous la forme d'un objet
reponse.data = {
arme1: "fleau"
arme2: "arc"
arme3: "epee"
arme4: "hache"
}
// transformations en tableau de valeurs
cont armesArray = Object.values(reponse.data); 
```

#### POST : création de données
* permet de créer les données en base
* si la table n'existe pas, elle est créer automatiquement à la création du premier objet
* Exemple
```
    handleAddPersonnage = () => {
        this.setState({loading: true});
        const player = {
            perso: {...this.state.personnage},
            createdUser: 'gildas'  
        };
        axios
            .post('https://createurpersonnage-default-rtdb.firebaseio.com/personnages.json', player)
            .then(reponse => {
                console.log(reponse);
                this.setState({loading: false});
                this.handleReinitialisation();
            })
            .catch(error => {
                console.log(error)
                this.setState({loading: false});
                this.handleReinitialisation();
            });
    };
```