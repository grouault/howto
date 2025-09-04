
## Introduction
### Test: Context
Arugment: Tiltle, Body
Title:
* doit contenir les test actions et les tests expectations
* dit exactement ce que le test doit faire et tester
Test Body: implementation where we write our test logic

Ecriture d'un test: 3A principles 
* Arrange: playwright configure et prépare beaucoup de chose en amont au niveau du web browser
	* start a web browser pour la page web
	* créer un context isolé pour la page web
	* créer un onglet à l'intérieur du browser qui est prêt pour visiter la page web
	
	
* Act : actions que l'on fait sur la page
* Assert: vérifier que les choses attendues de sont passées

Un test prend en paramètre un context qui contient toutes les caractéristiques que proposent le browser, informations concernant toutes les données disponibles à l'intérieur du navigateur.

### Test Fixtures
Dans les cadres des test Playwright et autres framework, « fixture » décrit une logique d’installation/démontage réutilisable qui fournit un environnement cohérent pour les tests à exécuter. Le terme est emprunté à cette idée de composants fixes ou préparés nécessaires pour des tests fiables

### Async / Await

## Locators

### HTML and DOM elements
HTML Tags : are elements used to structure and format content on web page
HTML Attributes (id / class) : provide additional information about HTML elements
Arial-roles: créés avec l'utilisabilité à l'esprit
	- on ne cherche pas (avec playwright) les éléments structurant mais les éléments utiles à l'utilisateur : link, button,  text, textarea

### GetByRoles
 * recheche par utilisabilité : page.getByRoles()
	 * recherche un texte heading
	 * recherche d'une liste
	 * recherche des items d'une liste
 * possibilité de filtrer en ajoutant un objet qui contient les filtres.
 * possibilité de chainer les locators
 * négation : .not.toBeVisible

### GetByText
* la principale différence c'est que GetByText permet de faire des tests sur des éléments cachés (hidden), ce que ne permet pas de faire GetByRoles.

### GetByLabel
* permet de travailler sur des élements d'un formulaire
* permet de récupérer directement le input lié au label et de faire des opérations dessus comme (fill / clear ...)

### GetByTestId

Nécsessite dans le code de mettre un attribut particulier : data-testid="...."
Cet attribut peut être customiser.

Avantage:
* simple à implémenter
* robuste
* les éléments sont faciles à localiser
Incovénient:
 * n'a pas pour but d'utiliser l'expérience utilisateur

### Locate by CSS
* non recommandé

### Children, parents and index Locators : Navigating DOM Hierachies

### Locator Tools: the inspector, codegen and debugger


## Interacting with elements

### fill
* Important : fill action triggered an event
### Auto-Waiting

### handle Cookies
addCookie
* permet de stocker des cookies à la déclaration du test

### Managing Local Storage

### Handling pop ups

### Handling events

## Hands on practice

### Testing project
### Refactoring tests