## Spring-Mvc [Bo�te � outils]

### SpringBoot

#### 1- Spring Boot librairie
Les librairies maven � installer :
```
	* Spring-web
	* Spring Data Jpa (sql)
	* H2 Database
	* lombok
	* SpringBootDevTools
```

####  2- Config Spring
* Le dispatcher-servlet est d�ploy� automatiquement
* Il y a juste � cr�er des contr�leurs et des roots qui vont bien

####  3- ThymeLeaf

##### 1- Tableau de pr�sentation
* th:each : pour it�rer sur les �l�ments du tableau

```
	<tr th:each="p:${pageProduits.content}">
		<td th:text="${p.id}"></td>
		<td th:text="${p.designation}"></td>
		<td th:text="${p.prix}"></td>
		<td th:text="${p.quantite}"></td>
	</tr>
```

##### 2- Pagination
* status: objet qui permet de r�cup�rer des infos sur le tableau
* th:href: permet de construire un lien dynamique avec param�tres
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