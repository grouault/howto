# Modal d'authenfication - FireBase

[retour](../../index-react.md)

## Descriptif

### principe

<pre>
Projet qui permet de gérer une autentification.
Ce projet met en place
- une modale d'inscription
- une modale de connexion
- un process de déconnexion
- une barre de navigation permmettant d'accéder 
  à tous ces mécanismes de connexion.
</pre>

### Connexion

<pre>
La connexion se fait via Firebase.
Les données de connexion sont gérées dans un context React,
pour être accessible aux différent composants:
- navbar
- les deux modales
- les routes
- les pages de l'application
</pre>

### Contexte

<pre>
Le contexte va contenir:
1/ la gestion d'affichage des modales
* l'affichage des modales est piloté par les boutons de la navbar.
* la navbar va ainsi mettre à jour le contexte
* les modales sont abonnées au contexte pour pouvoir savoir si 
  elles s'affichent ou non

2/ les fonctions de gestion de connexion
* ces fonctions sont basées sur l'api firebase
* ces fonctions sont utilisés :
  - par la modal signUp pour l'inscription
  - par la modal signIn pour la connexion
  - par la barre de navigation pour se déconnecter
  - par le provider pour observer l'état de la connexion  
</pre>

### loadingdata

<pre>
Au chargement de l'application (ou à son rafraichissement),
il est important de ne pas afficher l'app tant que l'observer n'a 
pas récupérer l'état de la connexion.
Cet appel est asynchrone, et conditionne l'affichage des composants.
</pre>

## FireBase

### créer un projet

<pre>
<a href="https://console.firebase.google.com/?pli=1" target="_blank">firebase console</a> 
Créer un projet: react-auth-rrv6
créer un projet authentification : username/password
genérer et récupérer les crédentials pour pourvoir se connecter:
caractéristiques pour se connecter avec clé d'api, domaine
</pre>

### installer firebase au niveau de l'appli

```
- installer npm install firebase
```

### méthode firebase

<a href="https://firebase.google.com/docs/auth/web/password-auth?hl=fr&authuser=0" target="_blanl">doc firebase</A>

#### général

<pre>
* Méthode FireBase qui permette d'inscrire une personne

import {
  signInWithEmailAndPassword
  createUserWithEmailAndPassword
  onAuthStateChanged (c'est une fonction observateur qui regarde le changement d'état)
} from "firebase/auth"
import {auth} from "../firebase-config"

Principe: une fois inscrit, firebase:
- génère un token utilisateur.
- renvoit un objet user qui contient le token
- stocker l'API_KEY dans la table indexdb côté client
</pre>

#### onAuthStateChanged - Observer

##### principe

<pre>
- permet d'observer les changements liés à Firebase.
- est-ce que je suis connecté, logout, inscrit.
==> agit comme un EventListener (mis sur un élément du dom),
l'observer est une sorte de composant qui écoute.
</pre>

##### Unsubscribe

<pre>
<b>important </b>: 
onAuthStateChanged renvoit une méthode qui permet de se désabonner.
Principe : quand le composant est détruit, il faut retourner cette méthode
qui permet de se désabonner.
==> équivalent à RemoveEventListener
On retire l'élément qui nous a permis de nous abonner.
Ca nous désabonne.
</pre>

### Configuration App:

#### firebase-config.js - getAuth

<pre>

- faire une fichier : firebase-config.js dans /src
  y copier la conf firebase
  créer la méthode getAuth
  Cette méthode est nécessaire car elle permet de montrer
  qui on est quand on appele une des api de firebase.
</pre>

```
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
import { getAuth } from "firebase/auth";

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyDYIYvU7vahs1GjWGuDmlrr4o7laIaCApI",
  authDomain: "react-auth-rrv6-bbbf2.firebaseapp.com",
  projectId: "react-auth-rrv6-bbbf2",
  storageBucket: "react-auth-rrv6-bbbf2.appspot.com",
  messagingSenderId: "805720004413",
  appId: "1:805720004413:web:4d21ba69441b21e9651754",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
```

#### env.local

</pre>
Attention la clé d'API est visible aux yeux de tous.
On a pas envie
- d'envoyer en ligne côté front
- pas envie de le mettre dans un repo local (github)

Pour cacher ça, on utilise un fichier qui s'appelle env.local
variable d'environnement qui permet de cacher des clés API

créer le fichier en dehors de /src
REACT_APP_nom_de_la_cle = value

Quand on déploie le projet sur un serveur, ce dernière repère le fichier env.local
et ca va éviter d'envoyer les clés d'api au niveau du client côté Front.

Pour utiliser la conf. dans les fichier de config:
process.env.REACT_APP_nom_de_la_clé

</pre>

```
process.env permet de retrouver les variables d'environnement.
```

## structure

<pre>
- installer boostrap
src/pages: page avec plusieurs composants
src/components: un bout d'UI qu'on peut réutiliser
</pre>

## css

<pre>
Le css est géré par bootstrap, on peut virer App.css
</pre>

## React-Router v6

<pre>
Plus d'utilisation de switch...
</pre>

### installation

<pre>
install : npm install react-router-dom
il faut entourer l'application par un browserRouter pour accéder
au fonctionnalité de react-router
</pre>

### index.js

```
import {BrowserRouter} from "react-router-dom"
<BrowerRouter>
<UserContextProvider>
  <App />
</UserContextProvider>
</BrowserRouter>
```

### app.js

```
import {Routes, Route} from "react-router-dom"
import Home from './page/Home'
import NavBar from './components/Navbar'

return (
  <Navbar />
  <SignUpModal />
  <Routes>
    <Route path="/" element={<Home />}>
  </Routes>
)

```

### composant navbar

<pre>
composant de navigation
on import Link car on veut un lien qui amène à la racine du site
</pre>

```
import {Link} from 'react-router-dom'

<nav className="navbar navbar-light bg-light px-4">
  <Link to="/" className="navbar-brand">
    AuthJS
  </Link>

  <div>
    <button className="btn btn-primary">Sign Up</button>
    <button className="btn btn-primary" ms-2>Sign In</button>
    <button className="btn btn-danger" ms-2>Log Out</button>
  </div>
</nav>
```

### Modal

<pre>
SignUpModal.js
On veut l'avoir à disposition donc on le met au niveau de l'App.js
Pour le code voir le composant BootStrap Modal.
</pre>

### Context

<pre>
src/context/userContext.js

context pour gérer 
* la connexion avec FireBase
* la modale

</pre>
