## Formulaire

[retour](../../index-react.md)

### Formulaire Ref

<pre>
L'idée est ici d'utiliser des refs pour accéder aux champs
du formulaire.
Il n'y a donc pas de gestion de state.
</pre>

### Formulaire contrôlé

#### Principe

<pre>
* Objectif :
>  placer les informations de chacun des champs dans des 'state' et les relier aux inputs.
> Si le formulaire a 3 informations, chacune des infos aura une valeur dans les states (3 states)
* Notion de <b>composant contrôlé</b> :
> input: utilisation de la propriété 'value' pour référencer la valeur des state
> onChange : pour mettre à jour le state quand on change la valeur de l'input
> Le composant à utiliser devra être un composant de type 'Class'

    < input 
        type="text" 
        className="form-control" 
        id="nomPersonnage" 
        placeholder="nom du personnage" 
        value={this.state.personnage.nom} 
        onChange={(e) => {this.setState((oldState) => {
            const newPersonnage = oldState.personnage;
            newPersonnage.nom = e.target.value;
            return {personnage: newPersonnage};
            })}
        }   
    / >

</pre>

### Soumission

#### preventDefault

<pre>
> Attention, le comportement par défaut est d'envoyer des données.
> Pour empêcher le comportement standard du bouton, il faut appeler 'preventDefault' sur l'event 
  du bouton surlequel on a clické.

    handleValidationForm = (event) => {
        // eviter la validation du formulaire
        event.preventDefault();
        ...
    }
</pre>

#### bouton de soumission

<pre>
* la soumission peut se faire via un bouton et un evènement click
</pre>

<pre>
    < Bouton
        cssClass="btn btn-primary"
        handleClick={this.handleValidationForm}

> Dans cet exemple, event est passé implicitement.
> Même sans bouton submit, le comportment standard est actif, dû au formulaire
</pre>

<pre>
* la soumission peut se faire avec un bouton <b>non typé</b> qui déclenche
  la méthode onSumbit du formulaire
</pre>

```
<form
    ref={formRef}
    className="sign-up-form"
    onSubmit={handleForm}
>

<input type="submit" className="btn btn-primary">Submit</input>
<button className="btn btn-primary">Submit</button>
```

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

<pre>

</pre>

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
