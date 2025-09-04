[retour](../../index-js.md)

## Installation

### require vs import

<pre>
Express peut s'utilisser avec les modules et on l'utilisation de require.
Pour cela à la création du projet, avant d'installer les libs, il faut 
préciser type="module", dans le package.json
</pre>

```bash
> npm i -y
> npm i nodemon
> npm i express
```

```js
{
  "name": "pdc-server",
  "version": "1.0.0",
  "main": "index.js",
  "type": "module",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "nodemon index.mjs"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "description": "",
  "devDependencies": {
    "nodemon": "^3.1.4"
  },
  "dependencies": {
    "express": "^4.19.2"
  }
}
```

### liens
<a href="https://baguilar6174.medium.com/boilerplate-for-your-node-projects-with-express-add98ea89c9f" target="_blank"># Boilerplate for your **Node** projects with Express</a>

## <a href="https://developer.mozilla.org/fr/docs/Web/JavaScript/Guide/Modules#commen%C3%A7ons_par_un_exemple" target="_blank">module</a>

<a href="https://medium.com/@surajkpcool/cannot-redeclare-block-scoped-variable-in-typescript-b92454f2f81f" target="_blank"># **Cannot redeclare block-scoped variable in TypeScript**</a>

## Fichier JSon

<a href="https://www.stefanjudis.com/snippets/how-to-import-json-files-in-es-modules-node-js/" target="_blank">lire un fichier JSon</a>
 
<a href="https://pawelgrzybek.com/all-you-need-to-know-to-move-from-commonjs-to-ecmascript-modules-esm-in-node-js/#importing-json" target="blank">use require with import<a>

```js
import { createRequire } from 'module'
const require = createRequire(import.meta.url)

export const mapProducts = {
  "0000433": require('./433/0000433.json')
}
```

## request

### queryString vs params
```js
app.get('/pricing/v0/customers/:customer/products/:product/pricing', (req, res) => {  
  const branch = req.query.branch; // queryString 
  const subsidiary = req.query.subsidiary; // queryString
  const customer = req.params.customer; // params
  const product = req.params.product; // param
  const deliveryDate = req.query.delivery; // queryString
```
