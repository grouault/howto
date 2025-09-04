[retour](../../index-react.md)
## forwardRef
### principe
<pre>
Le composant fonctionnel 
* n'a pas sa propre instance 
* ne fait que rendre du html. 
Une référence doit être associée à un élément du DOM 
et non au composant fonctionnel lui même. 
On utilise forwardRef pour que la ref soit passé au composant enfant 
qui affiche l'élément du DOM auquel la REF doit être passée.
</pre>
### Cas d'utilisation:
<pre>
* Typiquement quand on créer un composant fonctionnel personnalisé
pour enrichir un composant de base
</pre>
```jsx
const Input = forwardRef((props, ref) => {
  return (
    <input
      ref={ref}
      {...props}
      className="w-full px-3 py-2 border rounded-md 
      outline-none focus:ring-2 focus:ring-blue-500"
    />
  );
});
```



