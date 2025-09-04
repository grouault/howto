## Formulaire

[retour](../../index-react.md)

## Event => e

### e.target / e.currentTarget
<pre>
* target:  c'est l'élement du DOM qui a lancé l'évènement qui va déclencher
le traitement associé.

* currentTarget: valeur donné à un instant t.
L'event supprime le currentTarget dès que la fonction est terminé.
<i>Dans le cas d'une hiérarchie d'élément DOM, la currentTarget peut être 
différente de la target</i>

<b>Bouton Submit vs Bouton onClick</b>:
* Bouton Submit : trigger l'event submit du formulaire.
   e.target/currentTarget vaut alors le FORM et non le bouton submit
* Bouton onClick: trigger le traitement associé.
	e.target/currentTarget vaut alors le bouton.

<b>IMPORTANT</b>
en REACT, la valeur du target dans le cas d'un Input est égale à
la valeur future (du prochaine render).
Composant contrôlé: setState(e.target.value)
</pre>
### e.type
<pre>
* vaut le type d'évènement déclencheur
</pre>

### e.preventDefault
<pre>
* annule le comportement par défaut du formulaire qui par défaut est d'envoyer des données.
</pre>

## bouton de soumission

<pre>
* la soumission peut se faire via un bouton et un evènement click
</pre>
```jsx
    < Bouton
        cssClass="btn btn-primary"
        handleClick={this.handleValidationForm}
```
<pre>
> Dans cet exemple, event est passé implicitement.
> Même sans bouton submit, le comportment standard est actif, dû au formulaire
</pre>

<pre>
* la soumission peut se faire avec un bouton <b>non typé</b> qui déclenche
  la méthode onSumbit du formulaire
</pre>

```jsx
<form
    ref={formRef}
    className="sign-up-form"
    onSubmit={handleForm}
>
<input type="submit" className="btn btn-primary">Submit</input>
<button className="btn btn-primary">Submit</button>
```
## Formulaire classique
<pre>
* validation du fomulaire via un bouton de type submit
* récupération des valeurs avec l'attribut <b>element</b> du current target 
</pre>
### e.target.elements

<pre>
* permet de récupérer les éléments du formulaire
e.currentTarget.elements: Tableau bizarre dans lequel les éléments sont nommés
</pre>
```js
	1. HTMLFormControlsCollection(3) [input#name, input#password, input, 
	name: input#name, password: input#password]				
```

```jsx
const onSubmitUser = (data) => {
	console.log(JSON.stringify(data));
}

const UserForm = ({ onSubmitUser }) => {
	const handleSubmit = (event) => {
	    event.preventDefault();
	    const name = event.currentTarget.elements.name.value;
	    const passwd =event.currentTarget.elements.password.value;
		onSubmitUser({name, password});
	  }
	  return (
	    <form className="vertical-stack form" onSubmit={e => handleSubmit(e)} >
	      <label htmlFor="name">
	        Name
	        <input id="name" type="text" name="name" />
	      </label>
	      <label htmlFor="password">
	        Passwords
	        <input id="password" type="password" name="password" />
	      </label>
	      <input type="submit" value="Submit" />
	    </form>
	  );
};
```




## Formulaire avec useRef
<pre>
L'idée est ici d'utiliser des refs pour accéder aux champs
du formulaire.
Il n'y a donc pas de gestion de state.
</pre>
```jsx
import { useState } from "react";
import { useRef } from "react";

const UserForm = ({ onSubmitUser }) => {

  // gestion erreurs en STATE
  const [isError, setIsError] = useState(false);
  // gestion des elements du formulaire en REFs
  const usernameRef = useRef(null);
  const passwordRef = useRef(null);

  const handleSubmit = (event) => {
    event.preventDefault();
    const user = usernameRef.current.value;
    const password = passwordRef.current.value;
    if (!password.length || password.length < 8) {
      setIsError(true);
      return;
    }
    onSubmitUser({user, password})
  }

  const resetError = () => setIsError(false);

  return (
    <form className="vertical-stack form" onSubmit={e => handleSubmit(e)} >
      <label htmlFor="name">
        Name
        <input ref={usernameRef} id="name" type="text" name="name" />
      </label>
      <label htmlFor="password">
        Passwords
        <input onChange={resetError} ref={passwordRef} id="password" 
        type="password" name="password" />
      </label>
      {isError ? <div style={{color: 'red'}}>Password must be at least 8 characters</div>: null}
      <input type="submit" value="Submit" />
    </form>
  );
};

const Form = () => {
  const onSubmitUser = (data) => {
    alert('Form submitted: ' + JSON.stringify(data));
  };
  return <UserForm onSubmitUser={onSubmitUser} />;
};

export default Form;
```

## Formulaire contrôlé
<a href="https://react.dev/reference/react-dom/components/input#controlling-an-input-with-a-state-variable" target="_blank">à éviter</a>
* il faut avoir besoin de modifier le state à chaque changement de l'input

<pre>
<b>Principe : </b>
* placer les informations de chacun des champs dans des 'state' et les relier aux inputs.
* Si le formulaire a 3 informations, chacune des infos aura une valeur dans les states (3 states)

Notion de <b>composant contrôlé</b> :
* input: utilisation de la propriété 'value' pour référencer la valeur des state
* onChange : pour mettre à jour le state quand on change la valeur de l'input

<b>Note</b>:
useState et initialisation: Sans valeur par défaut, cela peut provoquer une erreur sur un Input.
La valeur par défaut vaut undefined et React part sur le principe que c'est un
uncontrolled Input


</pre>
```jsx
import { useState } from "react";

const UserForm = ({ onSubmitUser }) => {


  const [name, setName] = useState('');
  const [password, setPassword] = useState('');
  const [isError, setIsError] = useState(false);


  const handleSubmit = (event) => {
    event.preventDefault();
    if (!password.length || password.length < 8) {
      setIsError(true);
      return;
    }
    onSubmitUser({name, password})
  }

  const resetError = () => setIsError(false);

  return (
    // ?? ajoute onSubmit en passant la fonction handleSubmit
    <form className="vertical-stack form" onSubmit={e => handleSubmit(e)} >
      <label htmlFor="name">
        Name
        <input id="name" type="text" name="name" 
        value={name} 
        onChange={e => setName(e.target.value)} />
      </label>
      <label htmlFor="password">
        Passwords
        <input id="password" type="password" name="password" 
	        value={password} 
	        onChange={e => {setPassword(e.target.value); resetError();}} />
      </label>
      {isError ? <div style={{color: 'red'}}>Password must be at least 8 characters</div>: null}
      <input type="submit" value="Submit" />
    </form>
  );
};

const Form = () => {
  const onSubmitUser = (data) => {
    alert('Form submitted: ' + JSON.stringify(data));
  };
  return <UserForm onSubmitUser={onSubmitUser} />;
};

export default Form;
```
## FormData
<a href="https://developer.mozilla.org/fr/docs/Web/API/FormData/append" target="_blank">FormData</a>

<a href="https://react.dev/reference/react-dom/components/input#reading-the-input-values-when-submitting-a-form" target="_blank">utile pour lire les valeurs</a>

```jsx
export default function App() {
  const onSubmit = e => {
    e.preventDefault()
    const formData = new FormData(e.target)

    console.log(formData.get('name'))
  }

  return (
    <form onSubmit={onSubmit}>
      <input name="name" />
      <button type="submit">Submit</button>
    </form>
  )
}
```

## React Hook-Form

### principe
<pre>
* Performant par le fait qu'il n'y ait pas de rendu
* se brancher sur les évènement pour garder en mémoire les différentes valeurs 
sans avoir besoin de faire un changement d'état.
</pre>

### formState
<pre>
 Permet de connaître l'état du formulaire à tout moment
{isSubmitting} = formState
</pre>

## Cas d'utilisation
<pre>
Il faut privilégier les uncrontrolled input.

Pourquoi aller vers les controlled input ?
* pour des éléments où tu veux contrôler la valeur
* utiliser un input contrôlé sur un texte qui dépend de la valeur 
d'un autre input par exemple.
</pre>

## ---------------------------------------



### gestion des datas du formulaire

#### useState par champs

<pre>
Pour le stockage des données du formulaire :
- soit il faut utiliser plusieurs useState()
  il en faut un par champs à gérer.
</pre>

#### FormData

<pre>
L'autre solution est d'utiliser un useState qui gère un objet global
qui gère les données du formulaire.

Exemple :
  const [bookForm, setBookForm] = useState({
    title: "",
    author: "",
    category: 2,
  }); 
</pre>

##### Simple Form

<pre>
Avec la gestion avec simple formulaire dans la page, l'idée est la suivante:
- mapper les attributs du FormData sur les éléments du formulaire
- créer une méthode handleForm(e) 
  - méthode à brancher sur la méthode <b>onChange</b> des éléments du formulaire
- le principe est de récupérer les infos de l'élement du fomulaire via l'event passé en paramètre

Exemple :
  const handleBookForm = (e) => {
    let newData = { ...bookForm };
    newData[e.target.name] = e.target.value;
    setBookForm(newData);
    // Note 1
    console.log("bookForm", bookForm);
  };

Note 1: voir le code ci-dessus:
<b>Attention</b>: quand on print bookForm, on voit la valeur de bookForm au moment
où la fonction est déclenchée. 
Faire le test : 
setTimeout(() => {
  console.log("timetout : bookForm ", bookForm);
}, 2000); 
==> La valeur affichée sera celle obtenue au déclenchement de la fonction

</pre>

##### Multiple Form

### Validation

#### message

<pre>
* Mettre dans le state des champs de compte-rendu
* utiliser le mot clé return pour empêcher la fonction de
  validation de continuer son traitement
</pre>

```
if (
    inputPwd.current.value.length < 6 ||
    inputRepeatPwd.current.value.length < 6
) {
    setMessageValidation("Longueur trop petite");
    return;
}
```

#### try / catch

<pre>
* penser à ce mécanisme pour traiter les erreurs.
* Ce mécanisme est à utiliser pour traiter les erreurs serveurs.
  Voir traitement des erreurs dans axios.
  <a href="axios.md#gestion-des-erreurs">axios erreur</a>
</pre>

```
    try {
      const cred = await signUp(mail.current.value, inputPwd.current.value);
      console.log("inscription ok, cred = ", cred);
      formRef.current.reset();
      closeModal();
      navigate("/private/private-home");
    } catch (err) {
      console.dir(err);
      if (err.code === "auth/invalid-email") {
        setMessageValidation("Email invalide");
      }
      if (err.code === "auth/email-already-in-use") {
        setMessageValidation("Email déjà utilisé");
      }
    }
```

### Reset

<pre>
* faire une ref sur le form:
formRef.current.reset();
</pre>

## Element Formulaire

### bouton-radio

#### sans état

<pre>
<b>Important </b>: tous les input portent le même nom.
Permet de n'avoir qu'une seule valeur pour le bouton radio.
</pre>

```
  const handleRadio = (e) => {
    setDiet(e.target.value);
  };

<p>
    <input
    type="radio"
    id="nodiet"
    name="diet"
    value="nodiet"
    onChange={handleRadio}
    ></input>
    <label htmlFor="nodiet">Pas de régime particulier</label>
</p>
```

#### avec état

<pre>
- on met une variable dans le state
- on fait une fonction de mise à jour de l'état:
 - sur le onchange
 - eventulement sur un un div englobant qui permet
    d'inclure toute la zone
</pre>

```

// state
const [diet, setDiet] = useState("nodiet");
const checkNoDiet = () => setDiet("nodiet");

// validation du form
const handleForm = (e) => {
e.preventDefault();
modifyIndex(3, { diet: diet });
};

<div className="radio-btn" onClick={checkNoDiet}>
    <input
    type="radio"
    id="nodiet"
    name="diet"
    value={diet}
    checked={diet === "nodiet"}
    onChange={checkNoDiet}
    ></input>
    <label htmlFor="nodiet">Pas de régime particulier</label>
</div>
```

### liste déroulante

```
<select
  className="form-select"
  id="category"
  name="category"
  onChange={handleBookForm}
  value={bookForm.category}
>
  {categories.map((category) => (
    <option key={category.id} value={category.id}>
      {category.name}
    </option>
  ))}
</select>
```

## Formik

- contrôle + vérification
- npm install --save formik
- formik doit s'utiliser à l'emplacement où se trouver le formulaire
- PRINCIPE :
- Formik agit comme un wrapper sur le composant

```
    import {withFormik} from 'formik';
        ...
    export default withFormik()(FormulaireAjout)
```

- Le composant gère les données (values => fait office de state pour le composant)
- Le composant accède aux données et fonction sur les données via les props.
-

```
    <input type="text" placeholder="saisir un auteur"
        className="form-control"
        id="auteur"
        name="auteur"
        value={this.props.values.auteur}
        onChange={this.props.handleChange}
    />
```

- il faut renseigner un objet à Formik pour lui indiquer les actions qu'il devra faire:
- 3 parties sont à renseigner dans l'objet :

* 1- mapPropsToValues: () => ({ ... })
  > Fonction qui retourne un objet : stock ce que l'on aurait stocké dans les states (= values pour Formik)

```
    mapPropsToValues: () => ({
        titre: '',
        auteur: '',
        nbPages:''
    }),
```

> Fonction qui réaliser la liaison enhtre les valeurs des inputs et les données qu'utilise Formik (ses props).
> Pour faire la liaison avec les 'inputs', le name des 'inputs' doit porter le même nom que les props de Formik
> values : stocke les valeurs des inputs (équivalent au states)
> handleChange : sert à modifier les valeurs des inputs (=> équivalent au setState() déclenché par le onChange())
> Cette partie là permet de supprimer/remplacer la partie state du composant
> withFormik s'exécute avant le formulaire d'ajout
> Formik met à disposition des informations dans les props du composant emballé
> => dont les 'props' de Formik et la fonction 'handleSumbit'

- 2- validate: values => {} :
  > permet de lancer les actions de validation ; récupère les 'values' (valeur des inputs) et procéde aux validations
  > La gestion de la validation se fait avec l'objet 'errors'
  > Il faut alimenter ce champs et le retourner

> handleBlur: permet de savoir si on a sélectionner / touché un élément (perte du focus)
> ==> permet d'afficher un message que si on clické / touché un des champs
> ==> la propriété 'touched' dans les props est alors mis à jour.
> Quand 'errors' contient des données, la propriété 'isValid' des props vaut 'false'

- 3- handleSubmit: (values: Values, formikBag: FormikBag) => void | Promise<any>

* Exemple : handleSubmit : (values, {props}) => { ... }
  > permet de lancer les actions à la soumission du formulaires
  > props : ensemble des propriétés transférés depuis le composant d'origine
  > props = somme (Composant d'origine > Formik > Formulaire)

### Module 'YUP'

> Fournit des fonctions qui permettent de tester les valeurs

- Installation
  > npm install --save yup
- Récupérer directement l'ensemble des fonctions disponible par le module placé dans la propriété Yup
  > import \* as Yup from 'yup'
- utilisation de validationSchema:
  > fonctionne avec un schéma (générer par Yup), structure particulière, récupérer dans un objet.
  > cet objet va récupérer plusieurs propriétés qui seront sur l'ensemble des champs

```
    validationSchema: Yup.object().shape({
        titre: Yup.string()
                    .min(3, 'le titre doit avoir plus de 3 caractères')
                    .max(15,'le titre doit avoir moins de 30 caractèes')
                    .required('le titre est obligatoire'),
        auteur: Yup.string()
                    .min(3, 'Ce champ doit avoir plus de 3 caractères')
                    .required('Ce champ est obligatoire'),
        nbPages: Yup.number()
                    .lessThan(1000, 'Nombre de pages < 1000')
                    .moreThan(50, 'Nombre de pages > 50')
    }),
```

- Pour tracker un champ entier:
  > avec Formik remplacer le onChange par :

```
    <input type="number" placeholder="saisir un nombre de page"
        className="form-control"
        id="nbPages"
        name="nbPages"
        value={this.props.values.nbPages}
        onChange={(e) => this.props.setFieldValue('nbPages', parseInt(e.target.value))}
        onBlur={this.props.handleBlur}
    />
```

> Attention : ce n'est pas parce que input=number que l'on récupère un 'number'
> Dans un formulaire, la valeur récupérée est une chaine de caractère qui doit être transformé en entier
