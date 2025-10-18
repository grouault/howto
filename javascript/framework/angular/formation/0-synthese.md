# Application

[home](../angular.md)

## Principe
<pre>
* application qui permet de g�rer des produits
</pre>

![application](./img/synthese/0-application.PNG)

## Technique
<pre>
* bootstrap
* concurrently : 
	* permet de lancer des applications de mani�re concurrente c'est � dire en parrall�le
	* permet de lancer des commandes en parall�le (ligne de commande)
* font-awesome: pour les ic�nes
* jquery : templating
* json-server : partie back-end (serveur node.js | cr�ation base de donn�es au format json 'db.json')
</pre>

![application](./img/synthese/1-dependance.PNG)

## Composants

![application](./img/synthese/2-composants.PNG)

### installation

### Cr�ation
<pre>
$ ng new web-cat-app
</pre>

#### dependances
<pre>
* npm install --save json-server
* npm install --save concurrently
* npm install --save bootstrap
* npm install --save jquery
* npm install --save font-awesome

</pre>

#### base de donn�es

##### db.json
<pre>
* cr�er un fichier db.json � la racine du projet
* permet de d�marrer une API Rest
	* localhost:3000/products
	* localhost:3000/products/2
	* localhost:3000/products?selected=true
	* localhost:3000/products?name=computer
	* localhost:3000/products?name_like=c
</pre>

<pre>
* possible d'envoyer des requ�tes avec Post | Put | Delete
* POST: 
	header: content-type : application/json
	body : {
	 "name":"aaaa", 
	 "price":9999,
	 "quantity":123,
	 "available": true,
	 "selected": true
	}
</pre>

###### exemple
```
{
  "products": [
    {
      "id": 1,
      "name": "computer",
      "price": 4300,
      "quantity": 600,
      "selected": true,
      "available": true
    },
    {
      "id": 2,
      "name": "printer",
      "price": 300,
      "quantity": 100,
      "selected": true,
      "available": true
    },
    {
      "id": 3,
      "name": "smartphone",
      "price": 1200,
      "quantity": 100,
      "selected": false,
      "available": true
    }
  ]
}
```

##### db.routes.json
<pre>
* Permet de faire une configuration sur les routes.
* On veut faire une configuration pour pr�fixer toutes les routes par /api/
* Prendre en compte ces nouvelles routes au d�marrage du serveur
</pre>
```
{
  "/api/*": "/$1"
}
```

[doc](https://www.positronx.io/handle-cors-in-angular-with-proxy-configuration/)

#### package.json
<pre>
... "start": "concurrently \"ng serve\" \"json-server --nc --routes db.routes.json --watch db.json\"",
</pre>

## Application

### cors
<pre>
* Le serveur angular d�marre sur : http://localhost:4200/
* Le serveur back d�marre sur : http://localhost:3000/
<b>Cela provoque une erreur CORS car les deux serveurs travaillent sur des domoines et port diff�rents.</b>
</pre>

#### configuration Proxy
<pre>
* il faut dire au serveur angular de transmettre toutes les urls(<b>source</b>) que l'on veut r�aiguiller vers une autre <b>cible</b>
* ainsi il faut configurer un proxy avec :
	* source : http://localhost:4200/api
	* cible: http://localhost:3000/api
* <i>important:</i> c'est le <b>serveur angular</b> qui fait la <b>redirection</b>
</pre>

* g�n�rer un fichier src/proxy.conf.json
```
{
    "/api/*": {
        "target": "http://localhost:3000",
        "secure": false,
        "logLevel": "debug"
    }
}
```

* D�finir le proxy dans le fichier angular.json
```
"architect": {
    "serve": {
            "builder": "@angular-devkit/build-angular:dev-server",
            "options": {
                "browserTarget": "project-name:build",
                "proxyConfig": "src/proxy.conf.json"
            },
          }
}
```

### Initialisation

#### environnement
<pre>
* <b>envrionnement.ts</b>: ce fichier permet de faire des configuration par environnement
	* � utiliser donc pour les variables d'environnement
	* la variable <b>host</b> pour la confifuration du serveur backend a �t� d�fnit.
		* pose un probl�me <b>cors</b>, du coup, il faut passer par un <b>proxy</b> sur le <b>serveur Angular</b>.
		* <i>cf. plus haut</i>
</pre>

#### bootstrap | JQuery 
<pre>
* integration bootstrap | jquery ==> int�gr� dans package.json
</pre>

<pre>
"styles": [
  "./node_modules/bootstrap/dist/css/bootstrap.min.css"
  "src/styles.css"
],
"scripts": [
  "./node_modules/jquery/dist/jquery.min.js",
  "./node_modules/bootstrap/dist/js/bootstrap.min.js"
]
</pre>


      "styles": [

        "node_modules/bootstrap/dist/css/bootstrap.min.css",

        "src/styles.css"

      ],

      "scripts": [

          "node_modules/jquery/dist/jquery.min.js",

          "node_modules/bootstrap/dist/js/bootstrap.min.js"

      ]

#### font-awesome
<pre>
* font-awesome ==> int�gr� dans styles.css
</pre>

<pre>
@import "../node_modules/font-awesome/css/font-awesome.min.css";	
ou
@import "~font-awesome/css/font-awesome.min.css";
</pre>

#### Cr�ation des composants
<pre>
$ ng g c components/products
$ ng g c components/home
</pre>

#### Routes

* app/app-routing.modules.ts
```
const routes: Routes = [
  {path: "products", component: ProductsComponent},
  {path: "", component: HomeComponent}
];
```

* app.component.html
```
<router-outlet></router-outlet>
```

* nav-bar.component.html
```
<li class="nav-item">
<a class="nav-link" routerLink="/">Home</a>
</li>
<li class="nav-item">
<a class="nav-link" routerLink="/products">Products</a>
</li>
```

#### Cr�ation Modele, state, actions
![modele-state-actions](./img/synthese/3-enum-modele-state-action.PNG)

#### Cr�ation des services

### Formulaire

#### R�active Forms
<pre>
Erreur � la mise en place :
error TS2322: Type 'string | undefined' is not assignable to type 'string'.
  Type 'undefined' is not assignable to type 'string'.
  N�cessite la correction suivante dans le fichier tslint.json
  "angularCompilerOptions": {
    "enableI18nLegacyMessageIdFormat": false,
    "strictInjectionParameters": true,
    "strictInputAccessModifiers": true,
    "strictTemplates": false
  }
</pre>