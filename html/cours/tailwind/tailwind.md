[retour](./../../index-html.md)

 ## Principe
<pre>
* utility-first: classes qui définissent de petites utilités
* css-framework: tw définit un design system avec configuration et plugin
* directement dans le markup (on écrit pas de css, juste des classes dans le html)
</pre>

### Installation
<pre>
<a href="https://tailwindcss.com/docs/guides/vite" target="_blank">react + tailwind + typescript</a>
<a href="https://www.npmjs.com/package/eslint-plugin-tailwindcss" target="_blank">pluggin eslint tailwind</a>
</pre>

## Configuration: tailwind.config.ts

<pre>
* content : endroit ou est le code qui utiliser Tailwind
</pre>

```ts
import type { Config } from "tailwindcss";  
  
const config: Config = {  
  content: [  
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",  
    "./components/**/*.{js,ts,jsx,tsx,mdx}",  
    "./app/**/*.{js,ts,jsx,tsx,mdx}",  
  ],  
  theme: {  
    extend: {  
      backgroundImage: {  
        "gradient-radial": "radial-gradient(var(--tw-gradient-stops))",  
        "gradient-conic":  
          "conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))",  
      },  
    },  
  },  
  plugins: [],  
};  
export default config;
```

### Directives

```css
@tailwind base;  
@tailwind components;  
@tailwind utilities;
```

<pre>
A installer dans le fichier style.css
</pre>

#### @tailwind base
<pre>
* ajoute un CSS Reset
* permet d'avoir le même CSS pour tout les frameworks, OS, navigateur
</pre>

#### @tailwind components
<pre>
* permet d'ajouter des layers
* permet de customiser ses propres classes tailwind   
</pre>

```css
  @Layer Component {
	  .btn-primary {
		  @apply py-2 px-5
	  }
  }
```

#### @tailwind utilities
<pre>
* tw: fichier css énorme avec bcp de classes
* mais styles.css ne contient que les classes que l'on utilise dans le bundle finale
* ajoute uniquement les classes utilisées dans le code

tw utilise 
	* postcss qui permet de tranformer et d'utiliser pas des features modernes
	oklch sera remplacé par rgb si navigateur ancien
	* compatibilité: sélecteur spécifique des navigateurs gérés par tw (autoprefixer)
		* fullscreen : 
			* -webkit-full-screnn / -ms-fullscreen
	* optimisation CSS (squish class
</pre>

### Principe

#### Couleur et Theme
<pre>
série de couleur avec spectre de 50 à 950
plus on va dans les hauts, plus c'est foncé
</pre>

#### Police
<pre>
* de même la police suit un ordre de grandeur
xs =>  sm => md(base) => lg => xl =>  2xl 3xl ... 9xl
</pre>

### Espacement
<pre>
padding 
margin
gap
</pre>

### Modifier
<pre>
Il s'agit de prefixe pouvant être utilisé sur les classes :
hover / hocus / active / first / last / even / odd / required 
/ invalid / disabled
</pre>
```css
hover:bg-violet-600
active:bg-violet-700
focus:outline-none
```

### Responsive

<pre>
* tw est mobile first
* les styles sont définit pour mobile et on étend (point de rupture) en desktop
</pre>

#### breakpoints

<pre>
Reponsive breakpoint
XS => SM => MD => LG

breakpoint:classe ==> lire à partir
max-breakpoint: classes ==> Jusqu'au breakpoint
</pre>

```css
max-w-sm => définit une max-width sm par défaut
lg:max-w-m => breakpoint md, on étend la max width
affichage des ul li
class="grid gap-2 grid-cols-1 md:grids-cols-2 lg:grids-cols-3"
```

#### astuce pour connaître les breakpoints:
```jsx
<div class="absolute bottom-4 left-4">
	<span class="sm:hidden">XS</span>
	<span class="hidden sm:block md:hidden">SM</span> (lire à partir)
	<span class="hidden md:block lg:hidden">MD</span>
	<span class="hidden lg:block xl:hidden">LG</span>
</div>
```
### Classe CSS

#### Centré
```css
w-full h-screen flex justify-center items-center
h-screen: 100 viewheight
```

#### Ring
<pre>
* Permet de gérer un offset
</pre>
```css
focus:ring-2 ring-purpe-300 ring-offset-2
active:bg-purple-600/90
```