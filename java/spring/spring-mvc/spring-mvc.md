## Spring-Mvc [Boîte à outils]

### SpringBoot

#### 1- Spring Boot librairie
Les librairies maven à installer :
```
	* Spring-web
	* Spring Data Jpa (sql)
	* H2 Database
	* lombok
	* SpringBootDevTools
```

####  2- Config Spring
* Le dispatcher-servlet est déployé automatiquement
* Il y a juste à créer des contrôleurs et des roots qui vont bien

####  3- ThymeLeaf

##### 1- Tableau de présentation
* th:each : pour itérer sur les éléments du tableau

```
	<tr th:each="p:${pageProduits.content}">
		<td th:text="${p.id}"></td>
		<td th:text="${p.designation}"></td>
		<td th:text="${p.prix}"></td>
		<td th:text="${p.quantite}"></td>
	</tr>
```

##### 2- Pagination
* status: objet qui permet de récupérer des infos sur le tableau
* th:href: permet de construire un lien dynamique avec paramètres
* th:class: permet de faire de l'affichage de classe css conditionnel

```
	<ul class="nav nav-pills">
		<li th:each="page,status:${pages}">
			<a th:class="${status.index==currentPage ? 'btn btn-primary' : 'btn'}" 
				th:href="@{products(page=${status.index}, size=${size})}" 
				th:text="${status.index + 1}"></a>
		</li>
	</ul>
```