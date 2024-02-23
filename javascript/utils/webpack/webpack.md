## Webpack

[retour](../../index-js.md)


### Créer un projet webpack + typescript
<pre>
<a href="https://gist.github.com/rupeshtiwari/e7235addd5f52dc3e449672c4d8b88d5" target="_blank">link</a>


npm i -D wepack-cli webpack typescript ts-loader declaration-bundler-webpack-plugin copy-webpack-plugin clean-webpack-plugin @types/node @types/webpack
</pre>

### 


Pour utiliser les features ES6, il faut les dépendances babel:
    "@babel/core": "^7.22.9",
    "@babel/preset-env": "^7.22.9",
	"babel-loader": "^9.1.3",

servir du contenu static
yarn add serve
yarn serve

equivalent yarn npm
npm --save-dev
yarn add --dev

Attention : ne pas avoir le server de webpack installer.

WEBPACK
npm install webpack-cli webpack webpack-dev-server

npx webpack-cli init
yarn webpack-cli init 
 
* Ajouter dépendance plugin :
    "html-webpack-plugin": "^5.5.3",
    "mini-css-extract-plugin": "^2.7.6",

==> ?
- declaration-bundler-webpack-plugin copy-webpack-plugin clean-webpack-plugin

REACT
react react-dom
@babel/preset-react
@babel/preset-env
@babel/core



TYPESCRIPT
* typescript: typescript

* the type definitions for all the libraries you already use
@types/node @types/react @types/react-dom @types/jest --save-dev
yarn add @types/react @types/react-dom

* For Webpack to be able to process Typescript files, we will first need to install a custom loader

* ts-loader

* configure webpack.config.js to process TS files
==> ts
==> tsx

## images:
pour que les images soient traités via import
* créer un fichier custom.d.ts à la racine
declare module "*.png" {
  const value: any;
  export default value;
}
* modifier le fichier ts.config
  "include": ["src", "custom.d.ts"]
  
* dans webpack.config.js
  => assetModuleFilename : 
    permet de définir le folder output dans le livrable
    assetModuleFilename: 'images/[hash][ext][query]'

## export

### export default
à utiliser de manière unique.
Fait l'export sous form d'objet
Faire l'import avec une variable qui stockera l'objet
import titi from '...'

### export
soit plusieurs export
import {titi, toto} from ...
import * as obj pour exporter dans un objet