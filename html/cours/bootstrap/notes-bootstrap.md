# Bootstrap

[retour](../index-html.md)

## Notes

<pre>
Bootstrap v5, le text s'aggrandit / rétrécit
</pre>

## background

<pre>
bg-dark
bg-light
</pre>

```
<body class="bg-dark">
```

## text

<pre>
text-light
text-danger : en rouge
</pre>

## display

<pre>
permet de styliser
</pre>

```
<h1 className="display-2 text-light">
</h1>
```

## position

### margin

<pre>
* ms-2: margin-start ==> margin left
* mb-5: margin-bottom 5
</pre>

### padding

<pre>
* p-1: padding 1
* px-4: mettre du padding à gauche et à droite
</pre>

## Composants

### container

<pre>
créer un container qui va centrer le contenu
rend le composant responive
</pre>

```
<div className="container">
</div>
```

### button

<pre>
btn : permet de styliser le bouton
btn-primary
btn-danger
</pre>

### navbar

<pre>
.navbar : classe navbar : met de base un space-between sur la flex-box
navbar-light
</pre>

### Modal

#### principe

<pre>
Créer une modal:
- en position fixe
- avec un overlay
- clique sur la modal pour la fermer

Parent:
position fixé à top-0 et 100% viewport with et height

overlay:
doit occuper tout l'espace du parent avec opacité
w-100 : 100% du parent

position de la modale:
- position-absolute top-50 start-50 translate-middle
</pre>

#### Code

```
<div className="position-fixed top-0 vw-100 vh-100">
  <!-- overlay -->
	<div className="w-100 h-100 bg-dark bg-opacity-75">
		<!-- modal -->
		<div className="position-absolute top-50 start-50 translate-middle"
			style={{minWidth:"400px"}}
		>
			<div className="modal-dialog">
				<div className="modal-content">
					<div className="modal-header">
						<h5 className="modal-title">Sign-Up</h5>
						<button className="btn-close"></button>
					</div>
					<div className="modal-body">
						<form className="sign-up-form">
							<div className="mb-3">
								<label className="form-label" htmlFor="signUpEmail">Email adress</label>
								<input type="email" required name="email" className="form-control" id="signUpEmail" />
							</div>
							<div className="mb-3">
								<label className="form-label" htmlFor="signUpPwd">Password</label>
								<input type="password" required name="pwd" className="form-control" id="signUpPwd" />
							</div>
							<div className="mb-3">
								<label className="form-label" htmlFor="repeatPwd">Repeat password</label>
								<input type="password" required name="repeatPwd" className="form-control" id="repeatPwd" />
								<p className="text-danger mt-1">Validtion</p>
							</div>

							<button className="btn btn-primary">Submit</button>

						</form>
					</div>

				</div>
		</div>
	</div>

</div>

```

## Grid

#### Systéme de 'grid' de bootstrap avec des row et des colonnes

##### Alignement des boutons.

<pre>
* row
* col-6
* no-gutters : permet d'afficher les marges
</pre>

```
    <div className='row no-gutters'>
        <Bouton cssClass="btn-danger col-6"
            handleClick={() => console.log('r�initialiation')}>R�initialiser</Bouton>
        <Bouton cssClass="btn-success col-6"
            handleClick={() => console.log('Cr�ation')}>Cr�er</Bouton>
    </div>
```

##### grid : alignement vertical et horizontal

<pre>
* text-center
* align-items-center
</pre>

```
    <div class="row no-gutters text-center align-items-center">
        <div className={`col-1 ${classes.fleche} ${classes.gauche}`}></div>
        <div className="col">
            <img src={srcImage} alt="perso" />
        </div>
        <div className={`col-1 ${classes.fleche} ${classes.droite}`}></div>
    </div>
```

## utils

#### bloc avec titre

```
		<div class="card">
			<div class="card-header">Liste des produits</div>
			<div class="card-body">

				<!-- Formulaire -->

				<!-- tableau -->

				<!-- Pagination -->

			</div>
		</div>
```

#### badge

```
 <span className="badge badge-success">{restePts}</span>
```

#### pagination - inline

```
	<ul class="nav nav-pills">
		<li th:each="page,status:${pages}">
			<a th:class="${status.index==currentPage ? 'btn btn-primary' : 'btn'}"
				th:href="@{products(page=${status.index}, size=${size})}"
				th:text="${status.index + 1}"></a>
		</li>
	</ul>
```
