
[retour](./../index-js.md)

## Setup Vite, React
<a href="https://mitrich.medium.com/vite-react-eslint-vitest-typescript-project-setup-95f1923bba36" target="_blank">Vite, React, Eslint, Vitest, TypeScript project setup</a>

## ESLint

### Principe
<pre>
Le fichier eslint-config.cjs est utilisé pour définir des configurations partagées d'ESLint qui peuvent
être réutilisées dans plusieurs projets. Il permet de regrouper des règles ESLint spécifiques dans un
ensemble cohérent et de les partager entre différents projets sans avoir à redéfinir les mêmes
règles à chaque fois.
D'autre part, le fichier eslintrc.cjs (ou .eslintrc.js) est un fichier de configuration ESLint spécifique à
un projet donné. Il définit les règles ESLint spécifiques à ce projet, telles que les règles à appliquer,
les environnements de code, les plugins à utiliser, etc.
En résumé, eslint-config.cjs est utilisé pour définir des configurations partagées réutilisables
, tandis que eslintrc.cjs est utilisé pour configurer ESLint pour un projet spécifique en utilisant ou
en étendant ces configurations partagées.

Oui, les fichiers eslint-config.cjs et eslintrc.cjs (ou .eslintrc.js) sont compatibles et peuvent être
utilisés ensemble dans le même projet.
Vous pouvez définir un fichier eslintrc.cjs pour configurer ESLint spécifiquement pour votre projet,
en incluant des règles spécifiques à votre code, des environnements, des plugins, etc. Ensuite, vous
pouvez créer un fichier eslint-config.cjs pour regrouper des configurations partagées que vous
souhaitez réutiliser dans plusieurs projets.
En utilisant les deux ensemble, vous pouvez bénéficier à la fois de configurations spécifiques à
votre projet et de configurations partagées entre plusieurs projets, ce qui permet une gestion
efficace des règles ESLint dans votre code.

Lorsque deux règles identiques sont présentes à la fois dans le fichier eslintrc.cjs (ou .eslintrc.js)
spécifique au projet et dans le fichier eslint-config.cjs contenant des configurations partagées, la
règle définie dans le fichier eslintrc.cjs spécifique au projet aura priorité.
Cela signifie que les règles définies directement dans le fichier de configuration du projet auront
préséance sur les règles définies dans les configurations partagées. Ainsi, les règles spécifiques au
projet auront la priorité en cas de conflit avec les règles partagées.

Pour que les règles de Prettier prennent le dessus sur ESLint
</pre>

## <a href="https://prettier.io/docs/en/install" target="_blank">Prettier</a>

<a href="https://javascript.plainenglish.io/exploring-the-core-a-series-on-understanding-the-root-of-a-node-project-prettier-2e199c9350f5" target="_blank">Prettier</a>

<pre>
* Prettier permet de formatter le code
</pre>
### installation
<pre>
* Il faut installer la librairie via le gestionnaire de paquets
* il faut ajouter un fichier: prettierrc avec les règles
</pre>


```
> npm install --save-dev --save-exact prettier
```

### Prettierrc
```js
{  
  "semi": true,  
  "bracketSpacing": true,  
  "singleQuote": true,  
  "jsxSingleQuote": true,  
  "jsxBracketSameLine": true,  
  "trailingComma": "all",  
  "arrowParens": "avoid",  
  "printWidth": 80,  
  "tabWidth": 2,  
  "bracketSameLine": true,  
  "endOfLine": "auto",  
  "useTabs": false,  
  "htmlWhitespaceSensitivity": "css",  
  "quoteProps": "preserve",  
  "proseWrap": "always"  
}
```

### Editor
<a href="https://www.jetbrains.com/help/idea/prettier.html#ws_prettier_apply_code_style" target="_blank">intelliJ</a>

## Installation
### Installation projet-react-ts

#### initialisation
```terminal
> npm create vite@latest react-ts-tailwind --template react-ts
> npm add sass
> npm i -D tailwindcss postcss autoprefixer
> npx tailwindcss init -p --esm --ts
```
####  Config eslint
<pre>
Par défaut eslint est configuré
</pre>
```ts
// tsconfig.json
And add “.eslintrc.cjs” to include prop of tsconfig.json:
“include”: [“src”, “.eslintrc.cjs”]

// Modification de tailwindconfig.ts
tailwindconfig.ts
content: [  
  './index.html',  
  './src/**/*.{js,ts,jsx,tsx}',  
],
```

#### Config tailwind
<a href="https://www.npmjs.com/package/eslint-plugin-tailwindcss">plugin eslint tailwind</a>
```
> npm i -D eslint-plugin-tailwindcss
```

```jsx
mettre à jour le fichier eslintrc
["plugin:tailwindcss/recommended"]
```

#### Config Prettier
```
Prettier
npm i -D prettier 
creer le fichier .prettierrc

pour dire à ESLint d'exécuter Prettier
> npm i -D eslint-config-prettier eslint-plugin-prettier

```

```jsx
Add ‘prettier’ to plugins and ‘plugin:prettier/recommended’ 
to extends to .eslintrc.cjs
  extends: [  
    ...  
    'plugin:prettier/recommended'  
  ],  
plugins: ['react', 'prettier'],
```

#### Config CSLX

#### Config CVA

