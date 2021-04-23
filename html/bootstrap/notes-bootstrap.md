## marge

* mb-5: margin-bottom 5

## padding

* p-1: padding 1


## Grid

#### Système de 'grid' de bootstrap avec des row et des colonnes

##### Alignement des boutons.
* row
* col-6
* no-gutters : permet d'afficher les marges
```
    <div className='row no-gutters'>
        <Bouton cssClass="btn-danger col-6" 
            handleClick={() => console.log('réinitialiation')}>Réinitialiser</Bouton>
        <Bouton cssClass="btn-success col-6" 
            handleClick={() => console.log('Création')}>Créer</Bouton>
    </div>
```

##### grid : alignement vertical et horizontal
* text-center
* align-items-center
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