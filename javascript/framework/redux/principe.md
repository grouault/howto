# REDUX

[home](../../index-js.md)

## Definition
<pre>
* Librairie qui implémente un certains nombre de patterns
* au niveau SPA :
    * state container
    * but : ne pas tous faire dans la vue
    * permet de centraliser l'<b>état/contexte</b> de l'application dans un seul objet
    * permet de faire le <b>management du state</b>

* Reactive State Management
    * <b>Programmation réactive</b> pour pouvoir faire la gestion du state
    * <b>Réactive</b> : subscribre / publish
    * logique de <b>programmation asynchrone</b>
    * chaque composant qui veut des données s'abonnent au state (subscribe)
</pre>

## Composant - Redux

### Store
<pre>
* le store est un <b>service</b> qui permet de <b>gérer</b> le <b>state</b> de l'application
* store de redux = state de l'application
* le store permet de <b>dispatcher</b> les <b>actions</b> dont il est destinataire
</pre>
<pre>
* un composant émet une action
    * Les interactions utilisateurs sont gérés par les composants
    * Quand un evenement intervient dans le composant, une <b>action</b> est émise

* le store est alors mis en jeu
    * <b>recoit</b> et <b>dispatche</b> les actions
    * <b>dispatcheur</b> : redirige l'action vers les composant qui écoutent

</pre>

### Action
<pre>
* C'est un évènement émis par un composant à destination du store
* structure composé d'un <b>label</b> et <b>payload</b>
    * label : type d'évènement
    * payload : données associé à l'évènement
</pre>

### Reducer

#### définition
<pre>
* composant faisant partie du store
* chaque morceau du store est le résultat d'une fonction que l'on nomme reducer
* reducers : sont la source de données du state de l'application
* composant qui se présent sous la forme d'une fonction pure qui est appelée par le store,
    à chaque fois qu'une action est dispatchée aux reducers

* c'est un <b>écouteur d'évenement</b> :
    * qui est à l'écoute des évènements à destination du store (qui se produisent dans le store)
    * quand une action est dispatchée par le store, le reducer reçoit cette action
    * <i>Résumé</i> : une <b>action</b> émise par le <b>composant</b>, est reçu et tra  ité par le <b>reducer</b>

* c'est le <b>seul</b> composant qui a le droit de <b>modifier</b> le <b>state</b>
</pre>

#### principe
<pre>
* En <b>entrée</b>, le reducer reçoit le <b>state</b> et l'<b>action</b>
* En <b>sortie</b>, le reducer retourne soit :
    * un <b>nouveau state</b>
    * un <b>objet</b> qui est une partie du state de l'application,
        qui est alors mappé dans une variable du state

* le <b>state</b> est un objet <b>immutable</b>
    * quand une action est émise, l'action a pour but d'agir sur l'état de l'application
    * le reducer reçoit le state, en fait une <b>copie</b> et retourne un <b>nouvel objet</b>
    * le reducer <b>publie</b> alors le nouvel objet dans le <b>store</b>
</pre>

### Effects

#### défintion
<pre>
* permet de répondre à la question suivante :
    * Comment faire appel à un service pour exécuter un traitement métier applicatif backend ?

* C'est aussi un <b>écouteur d'action</b>
* C'est un composant qui a fait un subscribe au niveau du store, qui écoute les évènements
</pre>

#### principe 
<pre>
* Reducer et Effects écoutent les évènements du store et les traite différements

<i>Scénario : chargement de la liste des produits </i>
* 1- action reçu par le reducer et effect
    * reducer : retourne un nouveau state : données en cours de chargement
    * effect : appelle le service métier
        * les services sont injectés dans les effects

* 2- effect : 
    * <b>récupére</b> des <b>données</b> du service        
    * <b>émet</b> une nouvelle <b>action</b>

* 3- reducer:
    * reçoit le nouvel évènement/message
    * <b>récupère</b> les données dans le <b>payload</b> de l'action
    * retourne alors un nouveau <b>state</b>

* 4- composants applicatifs
    * ceux ayant souscrit aux stores, dès que le state change,
        ils reçoivent les nouvelles données
</pre>

### Selector
<pre>
* composant faisant partie de NgRx
* permet à un composant d'écouter une partie du state au lieu d'observer tout le state
* manière de filtrer les données que le store pousse aux composants
* si non utilisé, les composants font la souscription aux states et dès que le state change
    ils reçoivent toutes les données du store
</pre>


## Angular NgRx
<pre>
* Implementation Redux pour Angular
* vient en complément des solutions standards pour angular
    * @input/@ouptut : partage de données synchone
    * Sub/Pub avec Subject : partage de données asynchrone
</pre>

