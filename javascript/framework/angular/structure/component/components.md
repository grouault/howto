[structure](../structure.md)
[home](../../angular.md)

# composant / component
Les composants sont les blocs de construction d'une application Angular.
Un composant se concentre sur son rôle de contrôleur.
Il est en relation avec la vue et les services.

# Structure
Association d'une vue (template), feuille de style, classe
Classe (Typescript) : contrôleur qui pilote la vue, interagit avec les services
Template : fichier html associé à la feuille de style pour définir l'ui.

# @Component
Transforme la classe en composant Angular

# Déclarer le composant au niveau d'angular
Modifier le module principale 'app-module' et référencer le composant.

# variable du composant : 
public : visible de l'extérieur, de la vue
Exemple:
public display: Boolean = true;
public list: String[] = ['A', 'B', 'C','D','E'];
public title: String = 'Mon composant';

# méthode du composant :
- permettent d'agir sur les variables du composant.
- peuvent être associer à des éléments de la vue.

Syntaxe:
afficher() {
    this.display = !this.display;
}


# Cycle de vie

# constructeur
Il est appelé à l'instanciation de l'objet ; objet est instancié par angular de manière à être injecter.

# ngOnInit
Le composant est prêt à être présenter ; toutes les infos, tout l'écosystème qui est déjà initialisé.