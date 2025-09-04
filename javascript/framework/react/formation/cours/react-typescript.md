
## React avec TypeScript

[home](../../index-react.md)

### Props

#### Objet Props
LEs `props` représente un objet de toutes les propriétés passées 
par le composant parent
Quand on console.log(props), elles sont définies dans un objet.
Il va donc falloir typer les props pour restreindre les possibilités.

* L'utilisation des props définies pourront selon leur définition 
être utilisé ou pas dans le composant.
* cela restreint la liste mais n'empêche pas l'ajout d'une nouvelle props.
Si cette dernière n'est pas typé, TypeScript va juste afficher une erreur
mais le code va fonctionner.

```js
type AvatarProps = {
  username: string;
  avatarUrl: string;
}

// composant avec typage des props
const Avatar = ({ username, avatarUrl }: AvatarProps) => {
  return (
    <div className="avatar">
      <img src={avatarUrl} alt={username} />
      <span>{username}</span>
    </div>
  );
};
```

#### React.FC
<pre>
* interface Functional Component
* C'est un type générique qui prend en paramètres le type des props de notre composant
</pre>

```js
import { FC } from 'react';
// username et avatarUrl sont automatiquement typés !
const Avatar: FC<AvatarProps> = ({ username, avatarUrl }) => {
  return <div className="avatar">{/*...*/}</div>;
};
```

#### optionnelle
```tsx
type AvatarVariant = 'primary' | 'secondary';
type AvatarProps = {
  username: string;
  avatarUrl: string;
  variant?: AvatarVariant;
};
```
#### valeur par défaut
```tsx
const Avatar = ({ variant = 'primary', ... }: AvatarProps) => {
  return <div className={`avatar ${variant}`}>{/*...*/}</div>;
};
```

### Children 
#### ReactNode
```js
import { ReactNode } from "react"
type AvatarProps = {
  username: string;
  avatarUrl: string;
  children: ReactNode
};
```
Voici ce que peut être une `ReactNode` :
- `ReactElement` : une `div`, un composant, etc.
- `string`
- `number`
- `ReactFragment` : `<></>` ou `<Fragment></Fragment>`
- `ReactPortal` : [portals react doc](https://reactjs.org/docs/portals.html)
- `boolean` : true ou false
- `null`
- `undefined`
Soit toutes les valeurs que React accepte dans [`React.createElement`](https://reactjs.org/docs/react-api.html#createelement) !

#### PropsWithChildren

* Utilitaire générique pour ajouter des childrens à nos composants
* Ce type permet d'ajouter le type `children` au composant 
* sans avoir besoin de le définir dans le type

```tsx
import { PropsWithChildren } from 'react';

type AvatarProps = {
  username: string;
  avatarUrl: string;
  }
  
const Avatar = ({
  username,
  avatarUrl,
  children,
}: PropsWithChildren<AvatarProps>) => {
  return (
    <div className="avatar">
      <img src={avatarUrl} alt={username} />
      <span>{children}</span>
    </div>
  );
};
```

Il est possible d'ajouter d'autres children
```tsx
type AvatarProps = PropsWithChildren<{
	username: string;
	avatarUrl: string;
	topChildren: ReactNode;
}>
```

### Props du DOM

#### ComponentPropsWithoutRef<'DomElement'>
`ComponentPropsWithoutRef<"button">` va aussi contenir le `children` !
Car il possède _toutes les propriétés_ d'un `button`, dont le `children`.
```tsx
import { ComponentPropsWithoutRef } from 'react';
type ButtonProps = ComponentPropsWithoutRef<'button'>
type AvatarProps = {
  username: string;
  avatarUrl: string;
  className?: string;
} & ComponentPropsWithoutRef<'button'>;
```

## Hooks et TS

### types génériques
* Les hooks, c'est les données de notre application,
* le but de TypeScript est justement de clarifier les données.

Les fonctions comme `useState`, `useRef` et `useContext` utilisent les types génériques.
### inférence de type
Si le type inféré est correct, alors tu n'as pas besoin de le définir.
```ts
const [value, setValue] = useState(""); // value est de type string
const ref = useRef(0); // ref est de type RefObject<number>
```

Par contre si tu souhaites pouvoir, par exemple, définir value comme `null` ou `string` il te faudra le définir
```ts
// value est de type string | null
const [value, setValue] = useState<string | null>(null);

setValue("2"); // ok
setValue(null); // ok
setValue(2); // erreur TS, on accepte que `string` ou `null`
```
### Refs
Pour les `refs` on utilise souvent les types génériques quand tu souhaites lier ta référence à un élément du DOM.

```ts
export default function App() {
  // Par défaut c'est null, mais on va le définir comme un button
  const ref = useRef<HTMLButtonElement>(null);

  const onClick = () => {
    // TS sait que ref.current peut être null
    if (!ref.current) return;
    // TS sait que ref.current est un button et qu'il peut être disabled
    ref.current.disabled = true; 
  }

  return (
    <button ref={ref} onClick={onClick}>Click</button>
  )
}
```

Son type change en fonction de la valeur par défaut.
Effectivement, TypeScript part sur le principe que si aucune valeur par défaut n'est donnée (`undefined`), ce type va pouvoir être modifié. De même si tu passes un nombre, une string etc... TypeScript définira la ref comme une `mutable ref object`.

Mais dans le cas où tu veux utiliser cette ref avec un élément du DOM, comme un `input`, il faut définir `null` pour dire à TypeScript "Ceci est une référence à un élément du DOM". TypeScript rendera cette `ref` readonly ce qui empêchera les développeurs de la modifier.

Le seul moment où cette ref peut être définie c'est dans la props `ref` de notre `input` ou tout autre élément.

```ts
// React.RefObject<HTMLInputElement>
const userXRef = useRef<HTMLInputElement>(null);

// React.MutableRefObject<HTMLInputElement | undefined>
const userORef = useRef<HTMLInputElement>();
```