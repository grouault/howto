# AXIOS

[retour](../../index-react.md)

## Principe

<pre>
- module permettant de faire la liaison avec la partie back-end
- librairie qui permet d'envoyer des requêtes à un serveur et de traiter 
    des demandes/réponse grâce au fonctionnement des promesses JavaScript
</pre>

## chargement des données dans un composant

<pre>
- utilisation du cycle de vie du composant pour charger les données
- initialement, les données ne sont pas chargées, 
  et le composant ne doit rien afficher par rapport à ces données

- charger les données via axios quand le composant est monté : 
    * componentDidMount (se lance quand le composant est monté)
    * useEffect() sur un composant fonctionnel

- une fois les données chargées, rafraichier le composant
</pre>

## Liens / Doc

<a href="https://axios-http.com/fr/docs/intro" target="blank">doc</a>
<a href="https://github.com/axios/axios" target="blank">github</a>

## Installation

```
npm install axios --save
ou
yarn add axios
```

## instance / méthodes

<pre>
Axios permet de créer une instance et de la configurer

const instance = axios.create({
  baseURL: 'https://some-domain.com/api/',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});

Les méthodes utilisables sur l’instance sont listées ci-dessous. 
La configuration passée sera combinée à celle qui a été utilisée pour créer l’instance.

</pre>

## Méthodes

### GET : Récupération des datas:

#### principe

<pre>
- informations json récupérées
- récupération des infos de la requête dans un paramètre de fonction (reponse par exemple)
- traitement associé à la suite de la récupération dans la fonction associé.
- traitement d'erreur dans le catch.
</pre>

#### méthode

<pre>
Exemple : service de récupération des armes
</pre>

```
import axios from 'axios'
// appel axios
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

    Les datas sont récupérées sous la forme d'un objet.
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

### POST : création de données

<pre>
- permet de créer les données en base
- si la table n'existe pas, elle est créer automatiquement à la création du premier objet
- Exemple
</pre>

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

## Interceptor

### principe

<pre>
Les intercepteurs sont des listeners qui peuvent/doivent être retirer après coup.
L'intercpeteur intervient :
- request: quand la requête envoyée 
    * pour positionner des headers par exemple
    * pour retravailler les datas
- response : quand la réponse est reçue
    * pour faire un traitement avant la réponse de la promesse
    * exemple redirection
</pre>

### composant: AxiosInterceptor

#### principe

<pre>
L'idée est de créer un composant pour gérer les intercepteurs sur une instance Axios
L'instance est gérer au niveau global de l'application et ne fait pas partir du composant.
Le composant gère les intercpteurs de cette instance

Au chargement de l'application, l'intercepteur est ajouté sur l'instance.
L'intercepteur se déclenchera pour chaque requête de l'instance.
Exemple : pour mettre le token JWT dans les headers de la requêtre,
     si ce dernier est présent dans le storage
</pre>

#### exemple

```
import axios from "axios";
import React, { useEffect } from "react";

export const AUTH_TOKEN_KEY = "jhi-authenticationToken";

const headersInterceptor = (config) => {
  console.log("headersInteceptor : config: ", config.url);
  const jwtToken = localStorage.getItem(AUTH_TOKEN_KEY);
  if (jwtToken && config.headers) {
    if (!config.url === "/login") {
      config.headers.Authorization = `Bearer ${jwtToken}` ?? "";
    }
  } else {
    console.log("TODO: LOGOUT");
  }
  return config;
};

let axiosServer = axios.create({
  baseURL: "http://localhost:8080/",
});

const AxiosInterceptor = ({ children }) => {
  useEffect(() => {
    const reqInteceptor =
      axiosServer.interceptors.request.use(headersInterceptor);

    return () => {
      axiosServer.interceptors.request.eject(reqInteceptor);
    };
  }, []);

  return children;
};

export { AxiosInterceptor };
export default axiosServer;
```

## Gestion des erreurs

### Principe

<pre>
Il s'agit ici de voir comment on traite les erreurs remontées
lors d'un appel API.

<b>1- Appel Axios</b>
au niveau de l'appel Axios on ne traite pas l'erreur 
mais on la laisse remontée jusqu'à l'intercepteur de reponse.

<b>2- Interceptor</b>
L'erreur peut être intercepter à ce niveau.
On récupère un objet AxiosError.
On peut retravailler cet objet et la remonter au 
composant.

<b>3- Traitement et affichage</b> 
Au niveau du composant, on attrape l'erreur
avec un try / catch.
L'erreur peut être :
- retravailler si nécessaire
- afficher si nécessaire avec une notif par exemple
</pre>

### Objet AxiosError

<pre>
TODO
</pre>
