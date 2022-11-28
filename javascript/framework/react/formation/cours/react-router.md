# REACT-ROUTER

[retour](../../index-react.md)

## principe

<pre>
mapper une route, chemin dans l'url à un composant REACT.
</pre>

## BrowserRouter

<pre>
* il faut entourer l'application par un browserRouter pour accéder au fonctionnalité de react-router
* permet de définir un contexte Route autour du composant principal
Cette initialisation permet :
- définir les routes
- naviguer entre les pages
</pre>

```
import {BrowserRouter} from "react-router-dom"
<BrowerRouter>
  <App />
</BrowserRouter>
```

## Routes et Route

<pre>
< Routes >: composant permmettant de définir les < route >
< Route > : permet d'associer un chemin à un composant

Chaque route est un composant.
Chaque page est un composant.
</pre>

```
<Routes>
    <Route path="/" element={<Home />} />
    <Route path="/private" element={<Private />}>
        <Route path="/private/private-home" element={<PrivateHome />} />
        <Route path="/private/private-food" element={<PrivateFood />} />
    </Route>
</Routes>
```

## routes imbriquées

### principe

<pre>
Une route imbriquée est composée:
- d'une route parente ou principale
- de route enfant
L'accès à une route imbriquée passe par l'accès à la route 
principale.

Intérêt :
- placer de l'intelligence dans la route parent.
==> Notamment vérifier que le user est connecté et sinon
renvoyé vers une page de connexion.
</pre>

### Outlet

<pre>
Il faut utilise la balise < Outlet > dans la route parente.
Cela permet d'indiquer ou sera affiché le contenu de la route imbriquée
ciblée par la route parente.
</pre>

```
  return (
    <div className="container">
      {console.log("render Private")}
      <Outlet />
    </div>
  );
```

## api

### Link

<pre>
* composant qui permet de naviguer au sein des pages
* équivalent du < a href >
</pre>

```
<Link to="/my-books">Mes livres</Link>
```

### Navigate

<pre>
Composant qui permet de naviguer quelque part.
A utiliser quand on doit retourner un composant.
Exemple: 
faire une redirection dans une route parente.
Ne pas oublier de mettre le return.
</pre>

```
  if (!curentUser) {
    return <Navigate to="/" />;
  }
```

### useLocation

### useNavigate

<pre>
* hook qui permet de naviguer vers route.
* hook qui doit être instancier
</pre>

```
const navigate = useNavigate();

navigate("/private/private-home");
```

### useParams

<pre>
permet de recuperer le paramètre d'une route
</pre>

```
// route
<Route path="/edit-book/:bookId" element={<EditBook />} />
// composant
const { bookId } = useParams();
```
